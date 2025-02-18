# RF-fingerprint-signal-processing-of-actual-Wi-Fi-RF-signals  

The D-Link Wi-Fi 802.11b network adapter is set to Ad-hoc mode, and the short preamble keeps appearing. The preamble RF signal is acquired with an RF oscilloscope at a sample volume of 20 Gigabits per second, and the saved signal data is processed with these MATLAB programs in a PC to obtain an RF fingerprint for wireless physical-layer security.

RF signals are decoded into I and Q channels by low-pass filtering, downconversion, and soft Phase Locked Loop (PLL), with the I channel decoded to compare standard preambles. For details, see two published papers [1-3]:

[1] Honglin Yuan, Aiqun Hu. Preamble-based detection of Wi-Fi transmitter RF fingerprints[J]. IET Electronics Letters, 2010, 46(16): 1165-1167.  
[2] Honglin Yuan, Zhihua Bao, Aiqun Hu. Power Ramped-up Preamble RF Fingerprints of Wireless Transmitters[J]. Radioengineering, 2011, 20(3): 703-709.   
[3] Honglin Yuan. RESEARCH ON PHYSICAL-LAYER AUTHENTICATION OF WIRELESS NETWORK BASED ON RF FINGERPRINTS, A Dissertation Submitted to Southeast University For the Academic Degree of Doctor of Engineering. Supervised by Professor HU Ai-qun.

The entry of the programs is wifiB00main.m.

The main results of the programs      
Figure 1 the acquired RF signal: 
![image](https://github.com/user-attachments/assets/1a30f43d-25b1-46fd-af9f-82e2b99da1d2)
 
Figure 2 the power spectrum of the acquired RF signal:    
![image](https://github.com/user-attachments/assets/81b98bb7-6726-4d51-9411-04df68671a79)
 
Figure 3 the used LPF:   
![image](https://github.com/user-attachments/assets/e2395277-5175-4469-a567-3469fee09536)

Figure 4 the soft PLL for the IF signal:   
![image](https://github.com/user-attachments/assets/806e092b-0372-4f67-9cb9-34a23d6e9e59)
 
Figure 5 the decoded signal and the IF signal:   
![image](https://github.com/user-attachments/assets/c6679c16-2915-42d5-81d4-1f60dd08593a)
 
Figure 6 the scrutinize of the signals:   
![image](https://github.com/user-attachments/assets/de7ffd03-21d8-4462-8e94-306d32ba9867)

Figure 7 the decoded symbol and the IF signal:   
![image](https://github.com/user-attachments/assets/ddc7e11c-a0b2-4693-8add-629e077a1b36)
。
