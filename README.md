# Calculator web-service

A service that works like a calculator using GET requests.

## Input
The service accepts an arithmetic expression added to the request: 
```
http://calculator?expression=3*4
```
## Output
The service responds in JSON as follows:
```
expression :[echo given expression]
```
```
result     :[computed result of given expression]
```