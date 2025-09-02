import streamlit as st
import pandas as pd
import re
from io import StringIO


# Helper function to reformat dates
def clean_date(date_str):
    # 01/02/2012 or 01-02-2012
    m = re.match(r"(\d{2})[/-](\d{2})[/-](\d{4})", date_str)
    if m:
        return f"{m.group(3)}-{m.group(1)}-{m.group(2)}"
    # 10/5/2012 or 10-5-2012
    m = re.match(r"(\d{2})[/-](\d{1})[/-](\d{4})", date_str)
    if m:
        return f"{m.group(3)}-{m.group(1)}-0{m.group(2)}"
    # 5/10/2012 or 5-10-2012
    m = re.match(r"(\d{1})[/-](\d{2})[/-](\d{4})", date_str)
    if m:
        return f"{m.group(3)}-0{m.group(1)}-{m.group(2)}"
    # 5/1/2012 or 5-1-2012
    m = re.match(r"(\d{1})[/-](\d{1})[/-](\d{4})", date_str)
    if m:
        return f"{m.group(3)}-0{m.group(1)}-0{m.group(2)}"
    # 01/02/12 or 01-02-12
    m = re.match(r"(\d{2})[/-](\d{2})[/-](\d{2})", date_str)
    if m:
        return f"20{m.group(3)}-{m.group(1)}-{m.group(2)}"
    # 10/5/12 or 10-5-12
    m = re.match(r"(\d{2})[/-](\d{1})[/-](\d{2})", date_str)
    if m:
        return f"20{m.group(3)}-{m.group(1)}-0{m.group(2)}"
    # 5/10/12 or 5-10-12
    m = re.match(r"(\d{1})[/-](\d{2})[/-](\d{2})", date_str)
    if m:
        return f"20{m.group(3)}-0{m.group(1)}-{m.group(2)}"
    # 5/1/12 or 5-1-12
    m = re.match(r"(\d{1})[/-](\d{1})[/-](\d{2})", date_str)
    if m:
        return f"20{m.group(3)}-0{m.group(1)}-0{m.group(2)}"
    # 10-Apr-12 or 10/Apr/12
    m = re.match(r"(\d{2})[/-]([A-Za-z]{3})[/-](\d{2})", date_str)
    if m:
        months = {
            "jan": "01",
            "feb": "02",
            "mar": "03",
            "apr": "04",
            "may": "05",
            "jun": "06",
            "jul": "07",
            "aug": "08",
            "sep": "09",
            "oct": "10",
            "nov": "11",
            "dec": "12",
        }
        mm = months.get(m.group(2).lower(), m.group(2))
        return f"20{m.group(3)}-{mm}-{m.group(1)}"
    # 1-Apr-12 or 1/Apr/12
    m = re.match(r"(\d{1})[/-]([A-Za-z]{3})[/-](\d{2})", date_str)
    if m:
        months = {
            "jan": "01",
            "feb": "02",
            "mar": "03",
            "apr": "04",
            "may": "05",
            "jun": "06",
            "jul": "07",
            "aug": "08",
            "sep": "09",
            "oct": "10",
            "nov": "11",
            "dec": "12",
        }
        mm = months.get(m.group(2).lower(), m.group(2))
        return f"20{m.group(3)}-{mm}-0{m.group(1)}"
    # 2020/07/11 or 2020-07-11
    m = re.match(r"(\d{4})[/-](\d{2})[/-](\d{2})", date_str)
    if m:
        return f"{m.group(1)}-{m.group(2)}-{m.group(3)}"
    # Not matched
    return date_str


st.title("Date Cleaner: Standardize Dates in CSV")

uploaded_file = st.file_uploader("Drop your CSV file here", type=["csv", "txt"])

if uploaded_file:
    stringio = StringIO(uploaded_file.getvalue().decode("utf-8"))
    data = []
    for line in stringio:
        items = [clean_date(item.strip()) for item in line.strip().split(",")]
        data.append(items)
    df = pd.DataFrame(data)
    st.dataframe(df)
    csv = df.to_csv(index=False, header=False)
    st.download_button("Download cleaned file", csv, "dates_fixed.csv", "text/csv")
