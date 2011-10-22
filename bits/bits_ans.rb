#! /usr/bin/ruby
# -*- coding: utf-8 -*-

## bits count
def bits(num, table) 
  max = 0

  i_max = num / 2
  for i in 0..i_max
    cand = table[i] + table[num-i]
    if max < cand
      max = cand
    end
  end

  return max
end

## input
txt = ARGV[0]
th = open(txt, "r")

table = Hash.new
while line = th.gets
  num, cnt = split(" ")
  table[num.to_i] = cnt.to_i
end

## 問題ファイル
f = ARGV[1]
fh = open(f, "r")

## 問題数
t = fh.gets.chomp

## 解答
cnt = 1
while cnt <= t.to_i
  n = fh.gets.chomp.to_i
  c = bits(n, table)

  print 'Case #', cnt, ': ', c, "\n"
  
  cnt = cnt + 1
end
