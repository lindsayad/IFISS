%OBSTACLE_STOKES set up flow problem in domain with square obstacle
%   IFISS scriptfile: HCE; DJS; 27 May 2012. 
% Copyright (c) 2009 D.J. Silvester, H.C. Elman, A. Ramage 
% Code written by M. Wu, 2009

clear variables
%% define geometry
pde=3; enclosed=0;
%% define geometry
obstacle_domain;
domain=4;
load obstacle_grid.mat
%
%% set up matrices
q_in=default('Q1-Q1/Q1-P0/Q2-Q1/Q2-P1: 1/2/3/4? (default Q1-P0)',2);
qmethod=q_in-1;
if qmethod==2,
   [x,y,xy,xyp,mp,map] = q2q1gridx(x,y,xy,mv,bound);
   [A,B,Q,G,Bx,By,f,g] = stokes_q2q1(xy,xyp,mv,mp);
elseif qmethod==3,
   [x,y,xy,xyp,ee] = q2p1grid(x,y,xy,mv,bound);
   [A,B,Q,G,Bx,By,f,g] = stokes_q2p1(xy,xyp,mv);
 elseif qmethod==0 
   [ev,ee,ebound,xyp] = q1q1grid(x,y,xy,mv,bound,mbound);
   [A,B,Q,C,G,Bx,By,f,g] = stokes_q1q1(xy,ev);
elseif qmethod==1 
   [ev,ee,ebound,xyp] = q1p0grid(x,y,xy,mv,bound,mbound);
   [A,B,Q,C,G,Bx,By,f,g] = stokes_q1p0(xy,xyp,mv,ev);
end
gohome
cd datafiles 
save obstacle_stokes_nobc.mat pde domain qmethod  A B Q f g xy xyp mbound bound x y 
save obstacle_stokes_nobc.mat pde domain Bx By bndxy bnde obs -append
if qmethod==1 
   save obstacle_stokes_nobc.mat C G ev ee ebound -append
elseif qmethod==0 
   save obstacle_stokes_nobc.mat C G ev ee ebound mv enclosed -append
elseif qmethod==2
   save obstacle_stokes_nobc.mat G mv mp map -append
else
   save obstacle_stokes_nobc.mat G ee mv  -append
end
fprintf('system matrices saved in obstacle_stokes_nobc.mat ...\n')
