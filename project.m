%Creating a simple acoustic signal with noises
Fs=100e3; %Sampling Frequency (At least twice the input frequency)
Ts=1/Fs; %Sampling Period
dt=0:Ts:5e-3-Ts; %Signal duration of 5ms
f1=1e3;
f2=20e3;
f3=30e3;
y=5*sin(2*pi*f1*dt)+5*sin(2*pi*f2*dt)+20*sin(2*pi*f3*dt);
figure(1);plot(dt,y);title('Time domain plot of Orignal signal');

%Apply FFT to the signal to get frequency components of the signal
nfft=length(y); %Length of signal in frequency domain
nfft2=2.^nextpow2(nfft); %Length of signal in frequency domain, using base 2
fy=fft(y,nfft2);
fy=fy(1:nfft2/2); %nfft/2 to only get the LHS of the freq value
xfft=Fs*(0:nfft2/2-1)/nfft2; %Assign x-axis of frequency domain signal
%fft returns complex number, abs function is used to get the absolute value
figure(2);plot(xfft,abs(fy/max(fy)));title('Frequency domain plot of original signal');

%Create low-pass filter
fc=1.5e3/Fs/2; %Normalizing Cut-off frequency to Nyquist Frequency 
order=45;
h=fir1(order,fc);
fh=fft(h,nfft2); %Transform filter from time domain to frequency domain
fh=fh(1:nfft2/2); %Taking only the positive side of the function
output=fh.*fy;
figure(3);plot(abs(output/max(output)));title('Frequency domain plot of filtered signal')

%Use Inverse FFt to get output in time domain
toutput=ifft(output,'symmetric');
figure(4);plot(toutput);title('Time domain plot of filtered signal')

