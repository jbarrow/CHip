while true do
	local n1, n2, n3 = io.read("*number", "*number",
                                 "*number")
	if not n1 then break end
	print(math.max(n1, n2, n3))
end