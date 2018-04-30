The riemann config has been changed and the disk metric has been set to 0.50; i.e. it will
send an alert when the disk partition / is used more than 50%. 
It is expected that the log file does not show any entries as 
the / partition is only 10% used at present.
Output of df -h is as follows :
Filesystem                     Size  Used Avail Use% Mounted on
/dev/mapper/riemanna--vg-root   32G  2.8G   27G  10% /