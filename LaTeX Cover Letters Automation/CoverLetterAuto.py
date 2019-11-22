'''
Purpose: Replace placeholds in TeX tables from a provided data file for writing cover letters for different organizations.

Date Started: November 16, 2019

Data Inputs:
- CSV file containing placeholders as column names with the
values being the result that gets subtituted into TeX file

Notes:
'''

import os
import sys
import pandas as pd
import numpy as np
import subprocess

# Change directory
os.chdir("/Users/hammadshaikh/Documents/GitHub/Tools-and-Documents-for-Researchers/LaTeX Cover Letters Automation/")


# Load CSV
jobs_csv = pd.read_csv("CoverJobInfo.csv")

# Number of students
n_jobs = jobs_csv.shape[0]

# Specify path to pdflatex (executes .tex in terminal)
pdflatex_path = "/Library/TeX/texbin/pdflatex"

# Loop over jobs
for job in range(n_jobs):

    # Column names
    col_names = list(jobs_csv)

    # Read LaTeX template as string
    with open ("CoverLetterTemplate.tex", "r") as cover_file:
        cover_lines = cover_file.read()

    # Loop over variables to replace in template
    for col in col_names:
        cover_lines = cover_lines.replace(col,str(jobs_csv[col][job]))

    # Job organization name (strip space and apostraphe)
    org_name = "".join((jobs_csv["UNIVERSITY"][job].replace("'", "")).split())

    # Output completed cover letter
    cover_name = str(org_name)
    cover_save_path = os.getcwd() + "/"
    cover_file_path = cover_save_path + cover_name + ".tex"

    # Write completed cover letter with the substituted placeholders
    with open (cover_file_path, "w") as output_file:
        output_file.write(cover_lines)

    # Execute latex from command line using python (use command line to execute)
    os.system(pdflatex_path + " " + cover_name)

    # Move PDF files to specified folder
    os.system("mv " + cover_name + ".pdf"+ " Completed")




    

    
    
