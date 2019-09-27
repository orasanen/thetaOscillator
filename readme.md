This package contains codes for sonority-based syllabification of speech signals.

Version 0.21 (5.10.2017)

(please see https://github.com/speech-utcluj/thetaOscillator-syllable-segmentation for Adriana Stan's Python implementation of
the syllabifier)

------------
Basic pipeline:
    1) compute gammatone-envelopes for speech signals with 1000 Hz sampling rate
    2) call thetaOscillator.m with the Gammatone envelopes as input
    3) Syllable boundaries are in the "bounds" and "bounds_t" output variables
	(in 1000 Hz frames and seconds, respectively).

Adjust threshold parameter of thetaOscillator for sensitivity adjustments.

See SylSegDemo.m for an example.

------------
(c) Okko Rasanen, okko.rasanen@aalto.fi , 2016.

If you use this algorithm in publications, please cite:

Rasanen, O., Doyle, G. & Frank, M. C. (in press). Pre-linguistic segmentation of
speech into syllable-like units. Cognition.

------------

Note that the package uses Gammatone-filterbank front-end by Ning Ma
(http://staffwww.dcs.shef.ac.uk/people/N.Ma/resources/gammatone/).
If you are not using 64-bit OS X environment, compile the function first with
"mex gammatone_c.c". Also, re-compiling might be required for newer versions of 64-bit OS X
is the computation freezes without an apparent reason.

Also uses peakdet.m from Eli Billauer (see the file for license).
