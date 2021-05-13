# Evolutionary Genomics: studying population structure using *Fst*

In this activity, we'll analyze single nucleotide polymorphism (SNP) variants called from populations of rattlesnake species. We'll compare levels of relative differentiation, measured using *Fst*, between populations and different genomic regions.

The input data in variant call format (VCF) have been generated for two chromosomes in the prairie rattlesnake (*Crotalus viridis*) genome, based on mapping reads from individuals from two species in the western rattlesnake species complex (*Crotalus viridis* and *Crotalus oreganus*). The dataset also contains information for more distantly related species, *Crotalus atrox* and *Crotalus ruber*.

## Important files:

* VCF files:
	* rattlesnake.chr5.vcf.gz - SNP variants across chromosome 5
	* rattlesnake.chrZ.vcf.gz - SNP variants across the Z chromosome (sex chromosome)

* Population 'map' files - these are simple lists of individuals in the dataset belonging to different populations to compare
	* pop.list.co.california
	* pop.list.co.idaho
	* pop.list.cv.colorado
	* pop.list.cv.montana
	* pop.list.ca
	* pop.list.cr
	

## Activity: Estimating pairwise *Fst* between populations

VCFtools is a handy software program designed to manipulate and analyze VCF datasets. We can use it to estimate *Fst* between pairs of populations.

We need to tell the program where it can find the input data, and which two populations to compare. For example, try running the command below to measure *Fst* between the two *Crotalus viridis* populations:

```
vcftools --gzvcf rattlesnake.chr5.vcf.gz --weir-fst-pop pop.list.cv.colorado --weir-fst-pop pop.list.cv.montana
```

_Note_: you can also add a '--out' option to specify an output file name. For example:

```
vcftools --gzvcf rattlesnake.chr5.vcf.gz --weir-fst-pop pop.list.cv.colorado --weir-fst-pop pop.list.cv.montana --out CO_vs_MT_chr5
```

### Questions

* What is the mean *Fst* estimate between these populations?

* How many sites did we analyze to derive this estimate?

* The program wrote an output file ending in '.weir.fst' - what information is in this file?

* Now try changing the populations to see how *Fst* differs between different pairs - which pair of populations have the highest *Fst*? Lowest?


## Activity: Comparing *Fst* on different chromosomes

Now let's compare mean *Fst* estimates on chromosome 5 to the Z chromosome. All we need to do is swap the input file in our command above:

```
vcftools --gzvcf rattlesnake.chrZ.vcf.gz --weir-fst-pop pop.list.cv.colorado --weir-fst-pop pop.list.cv.montana --out CO_vs_MT_chrZ
```

### Questions

* Which chromosome has higher *Fst* between populations? What might cause this difference?


## Activity: Exploring variation in population differentiation across chromosomes

We can also measure *Fst* estimates in specific genomic regions, and examine how differentiation changes across chromosomes. To do this, we'll use a *sliding window* approach, which just means that we're focusing in on one interval at a time, then moving onto the next.

To run *Fst* analyses in sliding windows, we just need to add a couple of additional flags to our commands above:
* --fst-window-size
* --fst-window-step

These tell the program how large of a window (in base pairs) we want to consider at a time, and how far to move up for the next window. For example, try running the command below on chromosome 5, which will output *Fst* estimates in non-overlapping 100 kilobase windows:

```
vcftools --gzvcf rattlesnake.chr5.vcf.gz --weir-fst-pop pop.list.cv.colorado --weir-fst-pop pop.list.cv.montana --fst-window-size 100000 --fst-window-step 100000 --out CO_vs_MT_chr5.100kb
``` 

Now try doing the same thing for both chromosomes between *Crotalus viridis* and *Crotalus oreganus*:

```
vcftools --gzvcf rattlesnake.chr5.vcf.gz --weir-fst-pop pop.list.cv.colorado --weir-fst-pop pop.list.co.california --fst-window-size 100000 --fst-window-step 100000 --out viridis_vs_oreganus_chr5.100kb
vcftools --gzvcf rattlesnake.chrZ.vcf.gz --weir-fst-pop pop.list.cv.colorado --weir-fst-pop pop.list.co.california --fst-window-size 100000 --fst-window-step 100000 --out viridis_vs_oreganus_chrZ.100kb
```

Let's open up the output files to see the variation in *Fst* estimates:

```
less CO_vs_MT_chr5.100kb.windowed.weir.fst
less CO_vs_MT_chrZ.100kb.windowed.weir.fst 
```

_Note_: press 'q' on your keyboard to quit reading the file.

To interpret the results visually, check out the PDF of the sliding window results in the 'plots' folder.

### Questions

* Do certain parts of the chromosomes appear to have high/low *Fst*? What might cause this? (hint: think major structures of chromosomes).

* Is one chromosome more variable than the other?