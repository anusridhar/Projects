# Read the file and get the DNA string
#import webbrowser
dna = input("DNA sequence: ")
print("Given DNA sequence " + dna + ".")
#f = open('DNAseq1.html','w')


#file = open('dna1.txt', 'r') #dna of mus musculus obtained from NCBI
#dna = file.read()

#print (" Your DNA Sequence given: ", dna)

# DNA codon table
protein = {"TTT" : "F", "CTT" : "L", "ATT" : "I", "GTT" : "V",
           "TTC" : "F", "CTC" : "L", "ATC" : "I", "GTC" : "V",
           "TTA" : "L", "CTA" : "L", "ATA" : "I", "GTA" : "V",
           "TTG" : "L", "CTG" : "L", "ATG" : "M", "GTG" : "V",
           "TCT" : "S", "CCT" : "P", "ACT" : "T", "GCT" : "A",
           "TCC" : "S", "CCC" : "P", "ACC" : "T", "GCC" : "A",
           "TCA" : "S", "CCA" : "P", "ACA" : "T", "GCA" : "A",
           "TCG" : "S", "CCG" : "P", "ACG" : "T", "GCG" : "A",
           "TAT" : "Y", "CAT" : "H", "AAT" : "N", "GAT" : "D",
           "TAC" : "Y", "CAC" : "H", "AAC" : "N", "GAC" : "D",
           "TAA" : "STOP", "CAA" : "Q", "AAA" : "K", "GAA" : "E",
           "TAG" : "STOP", "CAG" : "Q", "AAG" : "K", "GAG" : "E",
           "TGT" : "C", "CGT" : "R", "AGT" : "S", "GGT" : "G",
           "TGC" : "C", "CGC" : "R", "AGC" : "S", "GGC" : "G",
           "TGA" : "STOP", "CGA" : "R", "AGA" : "R", "GGA" : "G",
           "TGG" : "W", "CGG" : "R", "AGG" : "R", "GGG" : "G" 
           }

protein_sequence = ""

# Generation of protein sequence
for i in range(0, len(dna)-(3+len(dna)%3), 3):
    if protein[dna[i:i+3]] == "STOP" :
        break
    protein_sequence += protein[dna[i:i+3]]

# Print the protein sequence

print ("Corresponding Protein Sequence: ", protein_sequence)
#webbrowser.open("protein_sequence")



#webbrowser.open_new_tab('untitled0.html')

#PART 2
# protein information from PDB




