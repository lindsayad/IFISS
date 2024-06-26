function [bcx,bcy] = specific_flow(xbd,ybd)
%quad_flow   channel flow boundary condition for 4:1 quadrilateral domain
%   [bcx,bcy] = specific_flow(xbd,ybd);
%   input
%          xbd          x coordinate vector
%          ybd          y coordinate vector 
%
%   specifies Poiseille flow boundary condition in quad cavity
%   IFISS function: DJS; 6 March 2005.
% Copyright (c) 2005 D.J. Silvester, H.C. Elman, A. Ramage 
bcx=0*xbd; bcy=0*xbd;
k=find(xbd==0); bcx(k)=4*ybd(k).*(1-ybd(k));
return