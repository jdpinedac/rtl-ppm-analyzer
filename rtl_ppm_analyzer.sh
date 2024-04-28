#!/usr/bin/env bash
# Script to execute rtl_test -p with a timeout, save the output, and calculate the trimmed mean of 'cumulative PPM'

export LC_NUMERIC="C"
export LC_ALL="C"

# Verify that rtl_test is installed
if ! command -v rtl_test &> /dev/null; then
    echo "Error: rtl-sdr is not installed. Please install rtl-sdr and try again."
    exit 1
fi

# Check if the timeout duration parameter has been provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <timeout_seconds>"
    exit 1
fi

# Validate that the timeout duration is an integer
if ! [[ "$1" =~ ^[0-9]+$ ]]; then
    echo "Error: The timeout duration must be an integer."
    exit 1
fi

timeout_seconds=$1

# Name of the output file with a timestamp
output_file="outputsdr_$(date +%Y%m%d%H%M%S).txt"

# Execute the command with the timeout and save the output
timeout -s SIGTERM "${timeout_seconds}" stdbuf -o0 rtl_test -p | tee "${output_file}"

# Extract cumulative PPM values from the file
mapfile -t ppm_values < <(awk '/cumulative PPM:/ {print $NF}' "${output_file}")

# Sort the values and calculate the trimmed mean
mapfile -t sorted_values < <(printf "%s\n" "${ppm_values[@]}" | sort -n)

total_values=${#sorted_values[@]}
trim_percent=10 # percentage to trim at each end
trim_count=$((total_values * trim_percent / 100))

# Ensure there are enough data to trim
if [ $trim_count -eq 0 ]; then
    echo "Not enough data to apply a $trim_percent% trim."
    exit 1
fi

# Trim the extreme values
trimmed_values=("${sorted_values[@]:$trim_count:$((total_values - 2 * trim_count))}")

# Calculate the average
total=0
for v in "${trimmed_values[@]}"; do
    total=$((total + v))
done

average=$(echo "scale=2; $total / ${#trimmed_values[@]}" | bc)
rounded_average=$(printf "%.0f" "$average")  # Round to the nearest integer

echo "The trimmed mean of 'cumulative PPM' is: $average"
echo "The trimmed mean of 'cumulative PPM' as an integer is: $rounded_average"
