# rtl-ppm-analyzer

`rtl-ppm-analyzer` is a Bash script designed to execute `rtl_test -p` with a timeout, save the output, and calculate the trimmed mean of 'cumulative PPM' from an RTL-SDR device. This script provides a straightforward way to manage SDR tests and analyze the performance and calibration of the SDR hardware.

## Dependencies

To run this script, you will need:

- `rtl-sdr`: This is a driver and toolset for RTL-SDR dongles which allows you to receive RF signals. You can install `rtl-sdr` from most package managers or compile it from source. Visit [RTL-SDR](https://osmocom.org/projects/rtl-sdr/wiki) for more information.

## Hardware Requirements

This script is specifically designed for use with RTL-SDR receivers that contain the RTL2832U chipset paired with the R820T2 tuner. An example of such a device is the RTL-SDR 820T2, which can be found at [Hacker Warehouse](https://hackerwarehouse.com/product/rtlsdr/). This combination is well-regarded for its sensitivity and stability, making it ideal for a wide range of radio frequency applications.

- **Recommended Model**: RTL-SDR 820T2
- **Chipset**: RTL2838 DVB-T

## Installation

Clone this repository using git:

```bash
git clone https://github.com/yourusername/rtl-ppm-analyzer.git
```

Navigate into the project directory:

```bash
cd rtl-ppm-analyzer
```

Make sure the script is executable:

```bash
chmod +x rtl_ppm_analyzer.sh
```

## Usage

Run the script with the required timeout period (in seconds) as an argument:

```bash
./rtl_ppm_analyzer.sh 120
```

## References

This project was inspired by and utilizes concepts described in the following publications:

- Laufer, C. (2015). *The Hobbyist’s Guide to the RTL-SDR: Really Cheap Software Defined Radio*. CreateSpace Independent Publishing Platform.
- Donat, W. (2020). *Explore Software Defined Radio: Use SDR to Receive Satellite Images and Space Signals*. Pragmatic Programmers.
- Contributions and insights have also been incorporated from OpenAI's ChatGPT.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

Special thanks to the RTL-SDR community and developers of the RTL-SDR software for making accessible SDR technology available to hobbyists and researchers alike.
