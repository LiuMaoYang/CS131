function y=DoG(x,k,sigma)
%input x:1-D vector,sigma:scalar,k:scalar
%output y: DoG of y
%k~=1
%size=5
%x=[-(size-1):size-1];

if ~exist('sigma','var')
    sigma=1;
end

if ~exist('k','var')
    k=1.2;
end

if k==1
    error('k is wronf');
end

y=(gaussian(x,k*sigma)-gaussian(x,sigma))/(k*sigma-sigma);

function y=gaussian(x,sigma)
arg=-x.^2/(2*sigma^2);
y=1/(sqrt(2*pi)*sigma)*exp(arg);
