%  CORRESPONDENCE INFORMATION
%  This code is written by Gaofeng MENG 
%
%  Gaofeng MENG:  
%  National Laboratory of Pattern Recognition,
%  Institute of Automation, Academy of Sciences, Beijing 100190
%  Comments and bug reports are welcome.  Email to gfmeng@nlpr.ia.ac.cn
%
%  WORK SETTING:
%  This code has been compiled and tested by using MATLAB R2009a
%
%  For more detials, please see our paper:
%  Gaofeng MENG, Ying WANG, Jiangyong DUAN, Shiming XIANG, Chunhong PAN. 
%  Efficient Image Dehazing with Boundary Constraint and Contextual Regularization, 
%  ICCV, Sydney, Australia, pp.617-624, 3-6 Dec., 2013.
%
%  Last Modified: Feb. 14, 2014, By Gaofeng MENG
%  

clc;
close all;
clear all;

% input an image
filename = '.\examples\sam_6';
HazeImg = imread([filename, '.bmp']);
figure, imshow(HazeImg, []);

% estimating the global airlight
% method = 'our'; 
% method = 'he'; 
method = 'manual'; 
wsz = 15; % window size
A = Airlight(HazeImg, method, wsz); 

% calculating boundary constraints
wsz = 3; % window size
ts = Boundcon(HazeImg, A, 30, 300, wsz);

% refining the estimation of transmission
lambda = 2;  % regularization parameter, the more this parameter, the closer to the original patch-wise transmission
t = CalTransmission(HazeImg, ts, lambda, 0.5); % using contextual information

% dehazing
r = Dehazefun(HazeImg, t, A, 0.85); 

% show and save the results
figure, imshow(ts, []);
figure, imshow(1-t, []); colormap hot;
figure, imshow(r, []);

