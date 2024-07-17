import numpy as np
import  librosa 
import matplotlib.pyplot as plt
import soundfile as sf
import scipy.fftpack as fft
from scipy.signal import medfilt

y, sr = librosa.load(path:'sound.wav', sr=None)

S_full, phase = librosa.magphase(librosa.stft(y))

noise_power = np.mean(S_full[:, :int(sr*0.1)], axis=1)

mask = S_full > noise_power[:, None]

mask = mask.astype(float)

mask = medfilt(mask, kernel_size=(1,5))

S_clean = S_full * mask

y_clean = librosa.istft(S_clean * phase)

sf.write(file:'clean.wav', y_clean, sr)

# Create a visualization for the change in frequency domains

n = len(y)
yf = fft.fft(y)
yf_clean = fft.fft(y_clean)
xf = np.linspace(start:0.0, st / 2.0, n // 2)

difference = np.abs(yf[:n // 2]) - np.abs(yf_clean[:n // 2])

plt.figure(figsize=(12, 9))

plt.subplot(*args:3, 1, 1)
plt.plot(*args:xf, 2.0 / n * np.abs(yf[:n // 2]))
plt.title('FFT of Original Audio')
plt.xlabel('Frequency (Hz)')
plt.ylabel('Amplitude')
plt.grid()

plt.subplot(*args:3, 1, 2)
plt.plot(*args:xf, 2.0 / n * np.abs(yf_clean[:n // 2]))
plt.title('FFT of Cleaned Audio')
plt.xlabel('Frequency (Hz)')
plt.ylabel('Amplitude')
plt.grid()

plt.subplot(*args:3, 1, 3)
plt.plot(*args:xf, 2.0 / n * difference, color='red')
plt.title('Difference Between Original Audio and Cleaned Audio')
plt.xlabel('Frequency (Hz)')
plt.ylabel('Amplitude')
plt.grid()