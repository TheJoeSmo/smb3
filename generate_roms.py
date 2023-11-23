import os
import subprocess
from shutil import move
import argparse

def read_original_config():
    original_content = ""
    with open("config.asm", "r") as f:
        original_content = f.read()
    return original_content

def write_updated_config(config):
    with open("config.asm", "w") as f:
        f.write(config)

def extract_include_options(original_content):
    include_options = {}
    for line in original_content.split("\n"):
        if line.startswith("INCLUDE"):
            key, value = line.strip().split("=")
            include_options[key.strip()] = int(value.strip())
    return include_options

def generate_configurations(include_test_levels, include_demo_levels):
    original_content = read_original_config()
    include_options = extract_include_options(original_content)
    
    # Do not consider additional levels as options.
    options = list(include_options.keys())
    options.remove('INCLUDE_TEST_LEVELS')
    options.remove('INCLUDE_DEMO_LEVELS')

    for i in range(2 ** len(options)):
        configuration = {option: (i >> j) & 1 for j, option in enumerate(options)}
        configuration['INCLUDE_TEST_LEVELS'] = include_test_levels
        configuration['INCLUDE_DEMO_LEVELS'] = include_demo_levels

        # Update the configuration in the original content
        for key, value in configuration.items():
            original_content = original_content.replace(f"{key} = {include_options[key]}", f"{key} = {value}")

        # Write the updated content to the file
        write_updated_config(original_content)

        yield configuration

def create_rom_filename(config):
    enabled_options = [key[8:].lower() for key, value in config.items() if value]
    return "_".join(enabled_options) + ".nes" if enabled_options else "smb3.nes"

def parse_command_line_args():
    parser = argparse.ArgumentParser(description="Generate ROM files with different configurations.")
    parser.add_argument('--include_test_levels', type=int, help="Set INCLUDE_TEST_LEVELS (0 or 1)")
    parser.add_argument('--include_demo_levels', type=int, help="Set INCLUDE_DEMO_LEVELS (0 or 1)")
    return parser.parse_args()

def main():
    args = parse_command_line_args()

    # Set INCLUDE_TEST_LEVELS and INCLUDE_DEMO_LEVELS based on command line arguments
    include_test_levels = args.include_test_levels if args.include_test_levels is not None else 0
    include_demo_levels = args.include_demo_levels if args.include_demo_levels is not None else 0

    for config in generate_configurations(include_test_levels, include_demo_levels):
        # Run the 'make' command with the working directory set to './'
        try:
            subprocess.run(["make"], check=True, cwd="./")
        except subprocess.CalledProcessError as e:
            print(f"Error: {e}")
            break  # Stop the script if 'make' command returns an error

        # Move the generated smb3.nes file to the ROMS folder
        if os.path.exists("smb3.nes"):
            filename = create_rom_filename(config)
            move("smb3.nes", os.path.join("ROMS", filename))
    print("Finished!")

if __name__ == "__main__":
    main()
