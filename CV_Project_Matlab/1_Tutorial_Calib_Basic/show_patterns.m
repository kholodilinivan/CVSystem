function [Mcc_,Mcc1_] = show_patterns(x,y,z,i,RRfin_,RRfin1_,calib_data)
a=i+1;
b=1;
calib_data.RRfin(:,:,i+1)= RRfin_;
calib_data.RRfin(:,:,i+2)= RRfin1_;
ddX=16;
ddY=16;
colors = 'brgkcm';
figure;
for a=i+1:i+2
    
    M=[calib_data.Xt';calib_data.Yt';ones(size(calib_data.Xt'))];
    Mc=compose_rotation(x, y, -z)*calib_data.RRfin(:,:,a)*M;
    if b==1
        Mcc_=Mc;
    else
        Mcc1_=Mc;
    end
    %Show extrinsic    
  	      uu = [-ddX;-ddY;1];
	      uu = calib_data.RRfin(:,:,a) * uu;
		  YYx = zeros(calib_data.n_sq_x+1,calib_data.n_sq_y+1);
		  YYy = zeros(calib_data.n_sq_x+1,calib_data.n_sq_y+1);
		  YYz = zeros(calib_data.n_sq_x+1,calib_data.n_sq_y+1);
		  
		  YYx=reshape(Mc(1,:),calib_data.n_sq_y+1,calib_data.n_sq_x+1)';
		  YYy=reshape(Mc(2,:),calib_data.n_sq_y+1,calib_data.n_sq_x+1)';
		  YYz=reshape(Mc(3,:),calib_data.n_sq_y+1,calib_data.n_sq_x+1)';

          hold on;
		  hhh= mesh(YYx,YYy,YYz); 
          % axis equal;
		  set(hhh,'edgecolor',colors(rem(a-1,6)+1),'linewidth',1); ...
              %,'facecolor','none');
		  text(uu(1),uu(2),uu(3),num2str(a),'fontsize',14,'color',...
              colors(rem(a-1,6)+1)); 
          b=b+1;
end
hold off
end