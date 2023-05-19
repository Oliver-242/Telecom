Additional MATLAB examples
Communication Systems Principles using MATLAB
John Leis

These extra examples are an adjunct to the book material. All
should run as-is, with no additional toolboxes required.

All example code listed below was developed with version 2017a/2017b.
No additional "toolboxes" are required. 
---------------------------------------------------------------------------


---------------------------------------------------------------------------
Chapter 1
genwave.m    simple wave generation
maxpower.m   maximum power transfer
fscalelin.m  frequency response - linear
fscalelog.m  frequency response - logarithmic

Chapter 2
WaveAddition.m          addition of waves of various phases (used in teaching slides, not book)
FourierSynth.m          Synthesize a Fourier Series interactively (not discussed in book)
CalcFourierSpectrum.m   calculate the Fourier spectrum o a time function
TestFourierSpectrum.m   calls CalcFourierSpectrum to show spectra
sincplot.m              plot a sinc function
fbreg.m                 feedback register
dipole.m                dipole example (see also DipoleImage.mp4 and DipoleSurface.mp4)


Chapter 3
SimpleAM.m            simple AM wave generation
BesselExamp.m         Bessel function examples
FMTheory.m            determining the integrals for computing the FM spectrum
SimpleFMDemod.m       simple example of FM demodulation
PLLTest.m             Phase-Locked Loop (PLL) example
SimpleQuadDemodAM.m   Quadrature demodulation of AM
SimpleQuadDemodPM.m   Quadrature demodulation of PM
SimpleQuadDemodFM.m   Quadrature demodulation of FM
TestArctan.m          test atan and atan2 functions
TestConv.m            test convolution of sequences
OFDMifft.m            OFDM using IFFT
PseudoNoise.m         Pseudo-Random Binary Sequence / Pseudo-Noise

Chapter 4
structs.m       example of how to declare structures (and cell arrays)
PacketClass.m   declaring a data object of a certain class
TestValRef.m    testing by-value and by-reference (handle) declared objects
IntValue.m      declaring a class with by-value
IntHandle.m     declaring a class with by-reference (handle)
checksum.m      calculating checksums with big- and little-endian ordering
TestPatriciaTrie.m   test the PATRICIA trie structure
PatriciaTrie.m       PATRICIA trie object declaration
PatriciaTrieNode.m   node object declaration for PATRICIA trie
dijkstra.m           Dijkstra shortest-path routing

Chapter 5
DiffEqFilter.n      difference equations using the filter() function
AvCodeLen.m         average codeword length
AvCodeLenHuffman.m  average codeword length using Huffman code sibling/no sibling
TestHuffmanTree.m   test Huffman tree class
HuffmanTree.m       Huffman code tree class
HuffmanNode.m       Huffman code node class
LinPred.m           linear prediction
DCTexamp.m          DCT example
mdct.m              modified DCT
imdct.m             inverse modified DCT
mdctcalcs.m         modified DCT and inverse MDCT calculation examples

Chapter 6
CommonFactors.m     exhaustive search to find factors, and common factors
GaussArea.m         area under a Gaussian curve and the erfc function
ModCalc.m           calculate using modulo arithmetic
BERprod.m           product of individual blocks and bit error rate
BERplots.m          bit error rate calculations and plots

TestCTrellis.m      test the convolutional code trellis
CTrellis.m          class for trellis for convolutional coding
CNode.m             node class for convolutional coding
StateTable.m        defining the state table for a Viterbi encoder/decoder

ModCalcOverflow.m   modulo calculations and overflow
expmod.m            exponentiation modulo N
ModCalcRemainder.m  modulo calculation remainders
---------------------------------------------------------------------------
