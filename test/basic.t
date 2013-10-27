#!/usr/bin/env ruby

$:.unshift "#{Dir.getwd}/lib"
require 'test/more'
include Test::More

# plan 'tests', 3

pass 'Yessss'
ok true, 'yup'
is 1, '1', 'one'

done_testing 3
