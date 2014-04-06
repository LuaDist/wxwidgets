set ( sizes
#"char"
"wchar_t"
"int"
"long"
"long long"
"short"
"size_t"
)

foreach(size ${sizes})
	string(TOUPPER ${size} A)
	string(REPLACE " " "_" B  ${A} )
	CHECK_TYPE_SIZE(${size}  SIZEOF_${B})
endforeach(size)

