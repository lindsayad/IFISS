function usquare_domain
%USQUARE_DOMAIN  (0,1)x(0,1) square domain Q2 grid generator
%   usquare_domain;
% 
% grid defining data is saved to the file: square_grid.mat
%   IFISS function: DJS; 1 April 2015.
% Copyright (c) 2005 D.J. Silvester, H.C. Elman, A. Ramage
fprintf('\n\nGrid generation for unit square  domain\n')
nc=default('grid parameter: 3 for underlying 8x8 grid (default is 16x16)',4);
if nc<2, error('illegal parameter choice, try again.'), end
grid_type=1; fprintf('Uniform grid ... no stretching possible\n')
n=2^nc; np=n/2; nq=n/4;
%
%% compute (x,y) coordinates of vertices
square_type=1;
y=[0:1/(2*np):1]'; left=0;
x=y; 
%
%% compute biquadratic element coordinates
nvtx=(n+1)*(n+1);
[X,Y]=meshgrid(x,y);
xx=reshape(X',nvtx,1);
yy=reshape(Y',nvtx,1);
xy=[xx(:),yy(:)];
%
kx = 1;
ky = 1;
mel=0;
for j=1:np
   for i=1:np
      mref=(n+1)*(ky-1)+kx;
      mel=mel+1;
      nvv(1) = mref;
      nvv(2) = mref+2;
      nvv(3) = mref+2*n+4;
      nvv(4) = mref+2*n+2;
      nvv(5) = mref+1;
      nvv(6) = mref+n+3; 
      nvv(7) = mref+2*n+3; 
      nvv(8)=  mref+n+1;
      nvv(9)=  mref+n+2; 
      mv(mel,1:9)=nvv(1:9);
      kx = kx + 2;
   end
   ky = ky + 2; 
   kx = 1;
end
%
%% compute boundary vertices and edges
% four boundary edges 
k1=find( xy(:,2)==left );
e1=[]; for k=1:mel, if any(mv(k,5)==k1), e1=[e1,k]; end, end
ef1=ones(size(e1));
%
k2=find( xy(:,1)==1  & xy(:,2)<=1   & xy(:,2) >left);
e2=[]; for k=1:mel, if any(mv(k,6)==k2), e2=[e2,k]; end, end
ef2=2*ones(size(e2));
%
k3=find( xy(:,2)==1  & xy(:,1)<1   & xy(:,1) >left);
e3=[]; for k=1:mel, if any(mv(k,7)==k3), e3=[e3,k]; end, end
ef3=3*ones(size(e3));
%
k4=find( xy(:,1)==left & xy(:,2)<=1   & xy(:,2) >left );
e4=[]; for k=1:mel, if any(mv(k,8)==k4), e4=[e4,k]; end, end
ef4=4*ones(size(e4));
%
bound=sort([k1;k2;k3;k4]);
mbound=[e1',ef1';e2',ef2';e3',ef3';e4',ef4'];
%
%
outbc=1;
gohome
cd datafiles
save square_grid.mat mv xy bound mbound grid_type outbc x y
return
