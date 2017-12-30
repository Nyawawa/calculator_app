# Calculator web-service

The calculator_app is a service that works like a calculator using GET requests.

An expression forwarded as argument by a GET request is evaluated using the following grammar:
```
number     = {"0"|"1"|"2"|"3"|"4"|"5"|"6"|"7"|"8"|"9"}
factor     = (number | "(" expression ")" | "sqrt" factor) [{"^" factor}] 
component  = factor [{("*" | "/") factor}]
expression = component [{("+" | "-") component}]
```
Supported operators:
```
"/", "*", "mod", "+", "-", "^"

(mod is the replacement for the modulo operator %)
```
Supported functions:
```
Square root: "sqrt"
```


## Input
The service accepts an arithmetic expression added to the request as in the following example: 
```
http://calculator?expression=3*4
```
For usage of the Square root or exponentiation regard the following:

If there is only a number following you can use it like this and leave parenthesis aside
```
"8^2" or "sqrt4"
```
If you want an expression as exponent or to take the square root of an expression you need to use parenthesis
```
"8^(2*5-3)" or "sqrt(4*7-5)"
```

## Output
The service responds in JSON as follows:
```
{"expression":"[echo given expression]","result":"[computed result of given expression]"
```
If there occurs an error the responds looks as follows:
```
{"expression":"[echo given expression]","result":"Error: [short error message]"
```