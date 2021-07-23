# Currency Conversion Rates
This project is a Bash script that generates a table of currency conversions. The script uses the [exchangerate.host](https://exchangerate.host/) API to get the data. To use the script, simply pass in the desired currencies as arguments to the script. Below is an example of how it works.
~~~
./currency.sh USD JPY EUR MXN CAD
     USD    JPY      EUR    MXN     CAD
USD  1      110.272  0.85   20.099  1.257
JPY  0.009  1        0.008  0.182   0.011
EUR  1.177  129.79   1      23.656  1.48
MXN  0.05   5.487    0.042  1       0.063
CAD  0.795  87.696   0.676  15.984  1
~~~
Each row in the table represents the conversions from that row's base currency (the first column of the row) to the currencies of the other columns. To get a list of supported currencies, type the following:
~~~
./currency.sh --list
United Arab Emirates Dirham             AED
Afghan Afghani                          AFN
Albanian Lek                            ALL
Armenian Dram                           AMD
Netherlands Antillean Guilder           ANG
. . .                                   . .
Platinum Ounce                          XPT
Yemeni Rial                             YER
South African Rand                      ZAR
Zambian Kwacha                          ZMW
Zimbabwean Dollar                       ZWL
~~~

If `currency.sh` can not be run, it is possible the file is not set to executable. To fix this, do the following in a terminal:

`chmod +x currency.sh`