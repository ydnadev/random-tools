# Random Tools

## Description

This is a collection of common scripts used for various projects.

## Index

- XML_clean.pl - used for removing tagged elements from XML
- dates_fix.pl - used for converting dates to ISO 8601 format
- columns_align.pl - used to find missing columns from headers of 2 files
 
## Example
### XML_clean.pl
'perl XML_clean.pl'  

- Run in folder with parameters defined in 'parametersRemoved.txt' file  
one parameter per line.  
- Save all XML to the same root folder as script.  

### columns_align.pl
'perl columns_align.pl file1 file2'  
  
Enter column separator: ,  
  
Fields missing from file1  
    found in file2  
field_1  
field_2  
  
Fields missing from file2  
    found in file1  
field_4  

### dates_fix.pl
'perl dates_fix.pl file1'

- Saves 'dates_fixed-file1' output.
