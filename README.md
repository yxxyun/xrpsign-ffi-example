# xrpsign-ffi-example

go build -o xrpsign.dll -buildmode=c-shared xrpsign.go

output a standard shared object binary file (.so .dll) exposing the XRPL Sign functions as a C-style APIs, then other language (dartlang in this example) can call through FFI.



