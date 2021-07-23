#!/bin/bash

if [ $# -eq 0 ]; then
    echo "No arguments given"
    echo "To get a list of all currencies, run ./currency.sh --list"
    echo "For an example table, run ./currency.sh USD JPY EUR MXN CAD"
    exit 1
fi

# Checks if the user just wants to see the list of available currencies
if [ "$1" == "--list" ]; then
    currencies=$(curl -s "https://api.exchangerate.host/symbols?format=csv")
    echo "$currencies" | sed 's/"//g' | column -t -s "," | tail -n +2
    exit 0
fi

# Joins the array of arguments into a comma seperated string
delim=""
joined=""
for item in "$@"; do
  joined="$joined$delim$item"
  delim=","
done

# Checks that all of the given currencies really exist
num_records=$(curl -s "https://api.exchangerate.host/latest?base=USD&format=csv&places=2&symbols=${joined}" | wc -l)
if [ $((num_records - 1)) -ne $# ]; then
    echo "Invalid currency provided as a argument"
    exit 1
fi

# Creates the header of the table. The vertical bar is used as a delimiter for the column command
table=" |"
for var in "$@"; do
    table+="$var|"
done
table=$(echo "$table" | sed 's/.$/\\n/g')

# Loop through all the currencies and get the conversion rates to the other currency
for base in "$@"; do
    conversions=$(curl -s "https://api.exchangerate.host/latest?base=${base}&format=tsv&places=3&symbols=${joined}")
    row="$base|"
    for col in "$@"; do
        if [ "$base" != "$col" ]; then
            val=$(echo -e "$conversions" | grep "$col" | cut -f 2 | tr "," ".")
            row+="$val|"
        else
            val="1|"
            row+="$val|"
        fi
    done
    row=$(echo "$row" | sed 's/.$/\\n/g')
    table+="$row"
done

echo -e "$table" | column -t -s "|"