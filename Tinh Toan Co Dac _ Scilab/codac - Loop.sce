disp("//TÍNH TOÁN CÔ ĐẶC HAI NỒI XUÔI CHIỀU//")
// Nhập dữ liệu từ file data.sce//
exec('data.sce',-1);
// Giả thiết phân bố áp suất và phân bố hơi thứ.//
b=2.81; //deltaP1=b*deltaP2
a=1.07;//w2=a*w2
//--------------------------------------------------------------------//
//--------------LẶP XÁC ĐỊNH PHÂN BỐ ÁP SUẤT--------------------------//
//sst1=100;sst2=100;
//while sst1>1|sst2>1,
//    b=b+0.005
//--------------------------------------------------------------------//
//-TÍNH THIẾT BỊ CHÍNH -//
// 1.Xác định lượng hơi thứ ra khỏi hệ thống://
w=Gd*(1-xd/xc)//(kg/s)
// 2.Tính sơ bộ hơi thứ mỗi nồi dựa vào phân bố hơi thứ://
//--------------------------------------------------------------------//
//------------LẶP XÁC ĐỊNH PHÂN BỐ HƠI THỨ----------------------------//
//a=1.08;
//ss1=100;ss2=100
//while (ss1>1)|(ss2>1),
//a=a-0.005
//--------------------------------------------------------------------//
w1=w/(1+a)
w2=a*w/(1+a)
// 3.Tính nồng độ cuối ở mỗi nồi://
x1=Gd*xd/(Gd-w1)
x2=Gd*xd/(Gd-w1-w2)
// 4.Tính chênh lệch áp suất chung://
deltaP=P1-Png
// 5.Tính thông số hơi đốt của mỗi nồi://
// Hiệu số áp suất://
deltaP1=b*deltaP/(1+b)
deltaP2=deltaP/(1+b)
// Áp suất hơi đốt://
P2=P1-deltaP1
// Nội suy (tra theo 3-315)//
T1=interp1(ph2o,th2o,P1)
T2=interp1(ph2o,th2o,P2)
i1=interp1(ph2o,ih2o,P1)
i2=interp1(ph2o,ih2o,P2)
r1=interp1(ph2o,rh2o,P1)
r2=interp1(ph2o,rh2o,P2)
// 6.Tính thông số hơi thứ mỗi nồi://
th1=T2+delta31
Tn=interp1(ph2o,th2o,Png)
th2=Tn+delta32
// Nội suy (theo 3-315)//
ph1=interp1(th2o,ph2o,th1)
ph2=interp1(th2o,ph2o,th2)
ih1=interp1(th2o,ih2o,th1)
ih2=interp1(th2o,ih2o,th2)
rh1=interp1(th2o,rh2o,th1)
rh2=interp1(th2o,rh2o,th2)
// 7.Tính tổn thất nhiệt độ://
// 7.1 Tổn thất do áp suất thuỷ tĩnh Delta2'://
// Tính Ptb//
ros1=(linear_interpn(th1,x1,tdd,xdd,rodd,"natural")) //(kg/l)
ros2=(linear_interpn(th2,x2,tdd,xdd,rodd,"natural")) //(kg /l)
ptb1=ph1+(h1+H/2)*ros1*(g/2)/98100//(at) 1at=98100 pa
ptb2=ph2+(h1+H/2)*ros2*(g/2)/98100//(at) 
// Nội suy Tstb (tra theo 3-315)//
tstb1=interp1(ph2o,th2o,ptb1)
tstb2=interp1(ph2o,th2o,ptb2)
// Tính Delta2'//
delta21=tstb1-th1
delta22=tstb2-th2
// 7.2 Tổn thất do nồng độ pp.Tysenco Delta1'//
delta01=interp1(xtt,delta0,x1)
delta02=interp1(xtt,delta0,x2)
delta11=16.2*((273+tstb1)^2)*delta01/(rh1)//(oC) 
delta12=16.2*((273+tstb2)^2)*delta02/(rh2)//(oC) 
// 7.3 Tồng tổn thất nhiệt độ://
sumdelta=delta11+delta12+delta21+delta22+delta31+delta32
// 8.Tính hiệu số nhiệt độ://
//Của toàn hệ thống//
sumdeltaT=T1-Tn-sumdelta
//Của mỗi nồi//
deltaT1=T1-th1-delta11-delta21
deltaT2=T2-th2-delta12-delta22
//**Nhiệt độ sôi của dung dịch**//
ts1=T1-deltaT1
ts2=T2-deltaT2
// 9.Cân bằng nhiệt lượng://
//Nhiệt dung riêng dd(theo sổ tay qttb1 tr 152. vs x<0.2)//
c0=4186*(1-xd/100)
c1=4186*(1-x1/100)
c2=4186*(1-x2/100)
//Nhiệt dung riêng của nước nguyên chất//
ch2o1=interp1(tn,cn,ts1)
ch2o2=interp1(tn,cn,ts2)
//Tính lại lượng hơi thứ//
w1moi=(w*ih2+(Gd-w)*c2*ts2-Gd*c1*ts1)/(0.95*r2+ih2-c1*ts1)
w2moi=w-w1moi
//Lượng hơi đốt//
D1=(w1*ih1+(Gd-w1)*c1*ts1-Gd*c0*ts1)/(0.9*r1)
//Sai số//
ss1=abs(w1-w1moi)*100/w1
ss2=abs(w2-w2moi)*100/w2
//--------------------------------------------------------------------//
//------------LẶP XÁC ĐỊNH PHÂN BỐ HƠI THỨ----------------------------//
//end
//--------------------------------------------------------------------//
// 10. Tính toán truyền nhiệt://
//Giả thiết chênh lệch nhiệt độ giữa hơi đốt và thành ống//
deltat11=5;
deltat12=5;
//--------------------------------------------------------------------//
//-----------------------LẶP XÁC ĐỊNH Deltat11------------------------//
ssq1=100;ssq2=100;
while ssq1>1,
   deltat11=deltat11+0.005
//--------------------------------------------------------------------//
// NỒI I.//
//10.1.Tính hệ số cấp nhiệt alpha1://
tm1=T1-deltat11/2
A1=interp1(tm,A,tm1)
alpha11=2.04*A1*(r1/(deltat11*H))^0.25 //(w/m^2*K)
//10.2.Tính nhiệt tải riêng về phía hơi ngưng tụ://
q11=alpha11*deltat11 //(w/m^2)
//10.3.Tính hệ số cấp nhiệt alpha2 từ bề mặt đốt đến chất lỏng sôi://
rodd1=(linear_interpn(ts1,x1,tdd,xdd,rodd,"natural"))
muy1=0.29e-3
//Xác định lambda của dung dịch//
m1=(m*(((x1/100)/m)/((x1/100)/m+(1-(x1/100))/18))+18*(1-(((x1/100)/m)/((x1/100)/m+(1-(x1/100))/18))))
lambda1=(3.58e-8)*c1*rodd1*(rodd1/m1)^(1/3)
//Hiệu số nhiệt độ deltat2 đến chất lỏng sôi//
deltat21=deltaT1-q11*(rt1+rt2+deltatuong/lambda)-deltat11
//Các thông số của nước nguyên chất//
roh2o1=interp1(tn,ron,ts1)
muyh2o1=interp1(tn,muyn,ts1)
lambdah2o1=interp1(tn,lambdan,ts1)
psi1=((lambda1/lambdah2o1)^0.565)*(((rodd1/roh2o1)^2)*(c1/ch2o1)*(muyh2o1/muy1))^0.435
alpha21=45.3*(ph1^0.5)*((deltat21)^2.33)*psi1
//10.4.Tính nhiệt tải riêng về dung dịch://
q21=alpha21*deltat21
//Sai số//
ssq1=100*abs(q11-q21)/q21
//--------------------------------------------------------------------//
//-----------------------LẶP XÁC ĐỊNH Deltat11------------------------//
end
//--------------------------------------------------------------------//
//--------------------------------------------------------------------//
//-----------------------LẶP XÁC ĐỊNH Deltat12------------------------//
while ssq2>1,
    deltat12=deltat12+0.005
//--------------------------------------------------------------------//
// NỒI II.//
//10.1.Tính hệ số cấp nhiệt alpha1://
tt12=T2-deltat12
tm2=T2-deltat12/2
A2=interp1(tm,A,tm2)
alpha12=2.04*A2*(r2/(deltat12*H))^0.25 //(w/m^2*K)
//10.2.Tính nhiệt tải riêng về phía hơi ngưng tụ://
q12=alpha12*deltat12 //(w/m^2)
//10.3.Tính hệ số cấp nhiệt alpha2 từ bề mặt đốt đến chất lỏng sôi://
rodd2=(linear_interpn(ts2,x2,tdd,xdd,rodd,"natural"))
muy2=(linear_interpn(ts2,x2,tmdd,xmdd,muy,"natural"))
//Xác định lambda của dung dịch//
m2=(m*(((x2/100)/m)/((x2/100)/m+(1-(x2/100))/18))+18*(1-(((x2/100)/m)/((x2/100)/m+(1-(x2/100))/18))))
lambda2=(3.58e-8)*c2*rodd2*(rodd2/m2)^(1/3)
//Hiệu số nhiệt độ deltat2 đến chất lỏng sôi//
deltat22=deltaT2-q12*(rt1+rt2+deltatuong/lambda)-deltat12
//Các thông số của nước nguyên chất//
roh2o2=interp1(tn,ron,ts2)
muyh2o2=interp1(tn,muyn,ts2)
lambdah2o2=interp1(tn,lambdan,ts2)
psi2=((lambda2/lambdah2o2)^0.565)*(((rodd2/roh2o2)^2)*(c2/ch2o2)*(muyh2o2/muy2))^0.435
alpha22=45.3*(ph2^0.5)*(deltat22)^2.33*psi2
//10.4.Tính nhiệt tải riêng về dung dịch://
q22=alpha22*deltat22
//Sai số//
ssq2=100*abs(q12-q22)/q22
//--------------------------------------------------------------------//
//-----------------------LẶP XÁC ĐỊNH Deltat12------------------------//
end
//--------------------------------------------------------------------//
// 11.Xác định hệ số truyền nhiệt từng nồi://
//K1=1/(rt1+rt2+1/alpha11+1/alpha21+deltatuong/lambda)
//K2=1/(rt1+rt2+1/alpha12+1/alpha22+deltatuong/lambda)
qtb1=(q11+q21)/2
qtb2=(q12+q22)/2
K1=qtb1/deltaT1
K2=qtb2/deltaT2
//Nhiệt tiêu tốn từng nồi//
Q1=D1*r1
Q2=w1*r2
// 12. Tính hiệu số nhiệt độ hữu ích từng nồi(Tính lại)://
tiso1=Q1/K1
tiso2=Q2/K2
deltaTsao1=(deltaT1+deltaT2)*tiso1/(tiso1+tiso2)
deltaTsao2=(deltaT1+deltaT2)*tiso2/(tiso1+tiso2)
// 13. So sánh DeltaT* và DeltaT://
sst1=100*abs(deltaTsao1-deltaT1)/deltaTsao1
sst2=100*abs(deltaTsao2-deltaT2)/deltaTsao2
//--------------------------------------------------------------------//
//--------------LẶP XÁC ĐỊNH PHÂN BỐ ÁP SUẤT--------------------------//
//end
//--------------------------------------------------------------------//
// 14. Tính bề mặt truyền nhiệt://
F1=Q1/(K1*deltaTsao1)
F2=Q2/(K2*deltaTsao2)
//HIỆN CÁC BẢNG SỐ LIỆU//
disp([P1 T1 i1 r1 ph1 th1 ih1 rh1 x1],["Bảng số liệu 1 nồi 1:"])
disp([P2 T2 i2 r2 ph2 th2 ih2 rh2 x2],["Bảng số liệu 1 nồi 2:"])
disp([delta12 delta22 delta32 deltaT2 ts2],[delta11 delta21 delta31 deltaT1 ts1],["Bảng số liệu 2"])
disp([c2 ch2o2 T2 w2 w2moi ss2],[c1 ch2o1 T1 w1 w1moi ss1],["Bảng số liệu 3"])
disp([deltat12 tm2 A2 alpha12 q12],[deltat11 tm1 A1 alpha11 q11],["Bảng số liệu 4"])
disp([rodd2 roh2o2 m2 lambda2 lambdah2o2 muy2 muyh2o2],[rodd1 roh2o1 m1 lambda1 lambdah2o1 muy1 muyh2o1],["Bảng số liệu 5"])
disp([deltat22 psi2 alpha22 q22 ssq2],[deltat21 psi1 alpha21 q21 ssq1],["Bảng số liệu 6"])
disp([K2 Q2 deltaT2 deltaTsao2 sst2],[K1 Q1 deltaT1 deltaTsao1 sst1],["Bảng số liệu 7:"])
disp([F1 F2],["Bề mặt truyền nhiệt:"])
mprintf('Lượng hơi đốt: %f',D1)
