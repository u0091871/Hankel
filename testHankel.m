clear all
close all
clc

load s0471_rem
[ch,samp] = size(val);
signal = val;
clear val

hearbeat = signal(:,55:570);

