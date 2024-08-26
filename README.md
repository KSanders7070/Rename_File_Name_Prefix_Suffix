# Rename File Name Prefix/Suffix Batch Script

This batch script is designed to automate the process of adding or removing specific text from the beginning or end of file names in a specified directory. It allows for flexible string manipulation to adjust file names according to your needs.

## Features

- **Add Prefix/Suffix**: You can add a specified string to the beginning or end of the file names.
- **Remove Prefix/Suffix**: You can remove a specified string from the beginning or end of the file names.
- **Interactive Mode**: The script prompts you for the operation type (add/remove) and the string to be added or removed.
- **Case-Insensitive Input**: The script handles input operations in a case-insensitive manner.

## Example

- **Adding a Prefix**:
  - If you enter `A` when prompted for the operation and provide the string `Project_`, the script will add `Project_` to the beginning of each file name in the specified directory.

- **Removing a Suffix**:
  - If you enter `R` when prompted for the operation and provide the string `_backup`, the script will remove `_backup` from the end of each file name in the specified directory (if present).

## Notes

- Ensure that the directory path provided is accurate and that you have backup copies of your files, as this operation cannot be undone automatically.
- The script does not differentiate between prefix and suffix removal; it will remove the string wherever it appears.

