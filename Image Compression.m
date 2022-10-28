clear all


image1 = zeros(256,256);
image1(:,1:128) = 1;


image2 = zeros(256,256);
image2(:,1:64) = 1;
image2(:,193:256) = 1;
image2(1:64,:) = 1;
image2(193:256,:) = 1;


L = 64;
 image3 = image2;
for i = 0:L
  image3(i+64,64:(128-i))=1;
end
for i = 0:L
  image3(i+64,(128+i):192)=1;
end
for i = 0:L
  image3(i+128,64:(64+i))=1;
end
for i = 0:L
  image3(i+128,(192-i):192)=1;
end


figure(1);
imshow(image1);
figure(2);
imshow(image2);
figure(3);
imshow(image3);

figure(4);
IMG1 = fft2(image1);
max1 = max(IMG1(:));
IMG1_norm = (IMG1*256)/max1;
IMG1_norm = fftshift(IMG1_norm);
amp1 = abs(IMG1_norm);
subplot(3,1,1);
plot(amp1);
ylabel('|IMG1|');
title('frequency domain of image1');


IMG2 = fft2(image2);
max2 = max(IMG2(:));
IMG2_norm = (IMG2*256)/max2;
IMG2_norm = fftshift(IMG2_norm);
amp2 = abs(IMG2_norm);
subplot(3,1,2);
plot(amp2);
ylabel('|IMG2|');
title('frequency domain of image2');

IMG3 = fft2(image3);
max3 = max(IMG3(:));
IMG3_norm = (IMG3*256)/max1;
IMG3_norm = fftshift(IMG3_norm);
amp3 = abs(IMG3_norm);
subplot(3,1,3);
plot(amp3);
ylabel('|IMG3|');
title('frequency domain of image3');

tiger = imread('tiger.jpg');

tigerFFT = fft2(tiger);
tiger_sort = sort(abs(tigerFFT(:)));
keep = [0.045, 0.004];

for i=1:length(keep)
    thresh = tiger_sort(floor((1-keep(i))*length(tiger_sort)));
    ind = abs(tigerFFT)>thresh;
    atlow = tigerFFT.*ind;
    alow = uint8(ifft2(atlow));
    ImageName = sprintf('tiger%d.jpg',i);
    imwrite(alow,ImageName,'JPG');
    
end
    
    

 



