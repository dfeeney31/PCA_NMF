# PCA_NMF
Performs PCA and NMF of EMG signals in a time series with plots
This is an older project and is means to take the time series of EMG data and perform a PCA and NMF for each subject.
For example, all subjects may be put into a no.frames x no. muscles x subjects matrix. This assumes they have been time normalized, band pass filtered, and a linear envelope performed. An example preprocess is included.

Preprocess is a general preprocessing function for bandpass, rectify, linear envelope (10 Hz LP filter)
MakeCors allows you to plot the weights of muscles in various components from the output of PCA or NMF
MakeFigure allwos you to visualize a 16 channel EMG recording session.

at this time, no further development is being done on this code
