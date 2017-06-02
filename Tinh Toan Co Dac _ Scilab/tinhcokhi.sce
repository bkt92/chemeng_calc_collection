//-----------------------------------//
// Copyright (C) Bùi Khắc Tú
// <bkt92@yahoo.com.vn>
// Date of creation: Oct 14, 2013
//-----------------------------------//
//I.Buồng Đốt
//Tính số ống trong buồng đốt:
F=81;
n=F/(%pi*dtr*H)
n=439;
//** Ống tuần hoàn trung tâm.
Fo=(0.25*%pi*n*dtr^2)/4
dtro=sqrt(4*Fo/%pi)
//-->Quy chuẩn trng 360 stqttb 2.
dtho=0.360;
//Đường kính buồng đốt: 
betaD=1.315;
psiD=0.8;
L=H;
Sinalpha=sin(%pi/3);
Dtrpd=sqrt((0.4*(betaD^2)*dng*Sinalpha*F)/(psiD*L))+(dtho+2*betaD*dng)^2
//--> Quy chuẩn trng 360 stqttb 2.
Dtrpd=1.3;
//Xếp lại ống truyền nhiệt với ống tuần hoàn trung tâm:
t=betaD*dng
bo=dtho/t+1
//--> Quy chuan
bo=9;
//-->mất 61 ống;
nphay=n-61
Fphay=%pi*H*(nphay*dtr+dtho)
//Chiều dày buồng đốt
S=(Dtrpd*P1*98100)/(2*131.54e6*0.95)+0.00122
//==> dày 4mm
//kiểm tra
sigma=(Dtrpd+(0.004-0.00122))*(P1*98100*1.5)/(2*(0.004-0.00122)*0.95)
sigmac=240e6
sigma<sigmac/1.2
//Chiều dày đáy buồng đốt
k=1-0.08/1.3
S=
//Chiều dày lưới đỡ ống dtho=0.360;
Sphay=0.01;
C=0.0018;
S=Sphay+C;
// điều kiện 2
S=0.016
f=S*(t-dng)*10^6
fmin=(1000*4.4*dng+12)
f>fmin
// kiểm tra theo uốn
