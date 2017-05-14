%% Load the complex data of the tadpole
load('tadpolecpx.mat')

%% Display the linear image
depth_tadpole=linspace(1,size(tadpolecpx,1)-1,size(tadpolecpx,1))*2/512;
width_tadpole=linspace(1,size(tadpolecpx,2)-1,size(tadpolecpx,2))*2/1024;
imagesc(width_tadpole,depth_tadpole,abs(tadpolecpx))
xlabel('Length [mm]');ylabel('Depth [mm]');
colormap gray;

%% Display the logarithmically scaled image
imagesc(width_tadpole,depth_tadpole,abs(tadpolecpx))
xlabel('Length [mm]');ylabel('Depth [mm]');
colormap gray;


%% Load Complex Data of Tube
load('tubecomplex.mat');
%% Display Intensity M-Mode Image
imagesc(abs(tubecomplex));
colormap gray;

%% Drop Initial Data
tubecomplex=tubecomplex(:,97:end);

%% Rescale Image to Time and Distance
linerate=28000;
time=linspace(1,size(tubecomplex,2)-1,size(tubecomplex,2))/linerate;
depth=linspace(1,size(tubecomplex,1)-1,size(tubecomplex,1))*2/512;
imagesc(time,depth,abs(tubecomplex))
xlabel('Time [s]');ylabel('Depth [mm]');
colormap gray;
%% Doppler calculation by ?theta/? t
dopp_angle=diff(angle(tubecomplex),[],2);
imagesc(dopp_angle);colorbar

%% Pull single time series
line=180;
timeseries=tubecomplex(line,:);
plot(time,abs(timeseries))
xlabel('Time [s]');ylabel('Intensity');

%% Plot Complex trajectory of signal
plot(timeseries(100:150))
xlabel('Re[S(t)]');ylabel('Im[S(t)]');

%% Plot power spectrum
frequencybin=linspace(-linerate/2,linerate/2,length(timeseries));
plot(frequencybin,fftshift(10*log10(abs(fft(timeseries)))))
xlabel('Frequency [Hz]');ylabel('Power [dB]');
%% Calculate Doppler frequency based on peak of power spectrum
lambda=1.3*10^-3;
fd=1690;
dopp_ps=fd*lambda/2;
%% Plot autocorrelation function magnitude
ac=xcorr(timeseries)/(sum(timeseries.*conj(timeseries)));
ac=ac(length(timeseries):end);
plot(time,abs(ac))
xlabel('\tau [s]');ylabel('G(\tau)');
%% Plot complex autocorrelation function
plot(ac(1:30))
xlabel('Re[G(\tau)]');ylabel('Im[G(\tau)]')
%% Compute velocity estimate using Kasai estimator
dopp_kasai=angle(ac(2))/(4*pi/lambda/linerate);
disp(dopp_kasai)
%% Define Exponential function and fit the data
modelFun = @(b,time) b(1).*exp(-b(2)^2*time.^2);
start = [1 1000];
beta=nlinfit(time(1:50),abs(ac(2:51)),modelFun,start);

%% Plot Fitted Function
fittime=linspace(time(1),time(100),1000);
fitmodel=beta(1)*exp(-beta(2)^2*fittime.^2);
plot(time(1:100),abs(ac(2:101)),fittime,fitmodel)
%% Calculate DLS estimate of speed
wx=6.7*10^-3;
speed_DLS=beta(2)*wx;
disp(speed_DLS)
%% Go through the nonlinear fitting process for all positions in flow phantom tube
lstart=50;
lend=300;
speed=zeros(lend-lstart+1,1);
speeddop=zeros(lend-lstart+1,1);
for line1=lstart:lend
    ac1=xcorr(tubecomplex(line1,:))/(sum(tubecomplex(line1,:).*conj(tubecomplex(line1,:))));
    beta1=nlinfit(time(1:50),abs(ac1(4001:4050)),modelFun,start);
    speed(line1-lstart+1)=beta1(2);
    speeddop(line1-lstart+1)=angle(ac1(4001)); 
end
speed=speed*wx;
speeddop=speeddop*lambda/(4*pi/linerate);
%% Plot estimates
figure(1);plot(speed)
title('DLS Measurement');xlabel('Position in Tube [pix]');ylabel('DLS Speed [mm/s]');
figure(2);plot(speeddop)
title('Doppler Measurement');xlabel('Position in Tube [pix]');ylabel('Doppler Speed [mm/s]');

