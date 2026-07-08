function [V] = IHEP_spmtype(image, type)
%IHEP_SPMTYPE Summary of this function goes here
%   Detailed explanation goes here

% 对数据进行强制类型转换
if type == 2
    V = uint8(image);
end

if type == 4
    V = int16(image);
end

if type == 8
    V = int32(image);
end

if type == 16
    V = single(image);
end

if type == 64
    V = double(image);
end

if type == 256
    V = int8(image);
end

if type == 512
    V = uint16(image);
end

if type == 768
    V = uint32(image);
end
