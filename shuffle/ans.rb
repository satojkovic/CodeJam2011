#! /usr/bin/ruby
# -*- coding: utf-8 -*-

f = ARGV[0]
fh = open(f, "r")

## problems
t = fh.gets

cnt = 1
while line = fh.gets
  # M, C, W
  m,c,w = line.split(" ")

  # cuts
  cuts = Array.new
  i = 0
  while i < c.to_i
    line = fh.gets
    a, b = line.split(" ")
    
    h = Hash.new
    h['A'] = a.to_i
    h['B'] = b.to_i
    cuts.push(h)

    i = i + 1
  end

  # reverse cut
  idx = w.to_i - 1
  cuts.reverse_each do |h|
    x = h['A'] - 1
    y = h['B']
    if idx < y
      idx = idx + x
    elsif idx < y + x
      idx = idx - y
    end
  end

  # answer
  print 'Case #', cnt, ': ', idx+1, "\n"

  cnt = cnt + 1
end
