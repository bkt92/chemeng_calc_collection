// TINH THIET BI PHU //
exec('data.sce',-1);
//thong so vao //
td=25//nhiet do dau nuoc lanh 25-30
tc=55//nhiet do cuoi nuoc lanh 45-60
Cn=interp1(tn,cn,(25+55)/2)//nhiet dung trung binh cua nuoc  
wh=35//van toc hoi ngung tu Png=0.2at (55-35 png=0.1-0.2)(35-15 png 0.2-0.4)
//1 Thiet bi ngung tu Baromet //
// luong nuoc lanh de ngung tu //
in=interp1(ph2o,ih2o,Png)
Gn=w2*(in-Cn*tc)/(Cn*(tc-td))
// duong kinh trong cua thiet bi //
rohn=interp1(ph2o,roh2o,Png)
Dtr=1.383*sqrt(w2/(rohn*wh))
// tinh kich thuoc tam ngan //
//chieu rong//
btn=Dtr/2+50
dlo=2 // duong kinh lo tam ngan: dlo=2mm (nuoc sach)
//chieu day tam ngan: delta=4mm//
// chieu cao go canh tam ngan: 40mm//
//Tong dien tich be mat lo trong toan bo mat cat ngang cua thiet bi//
wc=0.62// tốc độ cuối của tia nước khi chiều cao gờ của tấm ngăn 40mm
f=(Gn*1e-3)/(wc) // Vi Gn tinh theo kg/s, ron=1e3.
//Tính bước lỗ t xếp theo hình lục giác đều//
tsf=0.1//(tsf=f/ftb=0.025 - 1) Hỏi cách chọn
t=0.866*dlo*(tsf)^0.5 
//tính chiều cao thiết bị ngưng tụ//
betangung=(tc-td)/(Tn-td)
// Tra số bậc số ngăn, khoảng cách giữa các ngăn theo beta //
// Xác định chiều cau hữu ích của thiết bị ngưng tụ -- khoảng cách giữa các ngăn giảm dần theo hướng từ dưới lên trên khoảng 50mm cho mi ngăn//
// Tính kích thước ống baromet
whhn=0.5// tốc độ hỗn hợp ước và chất lỏng
dbrm=sqrt((0.004*(Gn+w2))/(3.14*whhn))
// chiều cao ống baromet 
h1=10.33*((760-735.6*Png))
Re=//
lambdancc=0.34164/(Re^0.25)
h2=((whhn^2)/(2*g))(2.5+lambdancc*(H/d))
H=h1+h2+0.5
// Tính lương hơi và khí không ngưng
// Lượng không khí cần hút
Gkk=0.000025*w2+0.000025*Gn+0.01*w2
// Thể tích không khí cần hút ra khỏi thiết bị ngưng tụ
tkk=//
Phk=interp1(th2o,ph2o,tkk)
Vkk=(288*Gkk*(273+tkk))/(Png-Phk)
// Tính toán bơm chân không
Nb=//
//-> chọm bơm theo quy chuẩn

