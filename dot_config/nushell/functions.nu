def dnav [input1: path, input2: path] {
    diff -u $input1 $input2 | diffnav
}
