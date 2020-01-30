#!/user/bin/bash
## Getting difficult region overlaps for benchmark compliments

## Input compliment bed sorted prior to analysis
# sort -k1,1 -k2,2n 
#    HG002_GRCh37_1_22_v4.1_draft_benchmark_complement_intersect_GRCh37_Mandelker_COSMIC_ENSEMBLE_IDs_and_geneName_primary_assembly_only_slop20000.bed \
#    > HG002_GRCh37_bench_med_complement.bed

compliment_bed=data/HG002_GRCh37_bench_med_complement.bed

difficult_bed_dir=data/difficult_beds

for diff_bed in ${difficult_bed_dir}/*bed*; do
    echo "Processing ${diff_bed}"
    diff_name=$(basename ${diff_bed})
    cov_bed=intermediate/complement_coverage/comp_cov_${diff_name}

    bedtools coverage \
        -a ${compliment_bed} \
        -b ${diff_bed} \
        > ${cov_bed}
done


## Filtered sites compliment
#bedtools coverage \
# -a data/HG002_GRCh37_1_22_v4.1_draft_benchmark_complement_intersect_GRCh37_Mandelker_COSMIC_ENSEMBLE_IDs_and_geneName_primary_assembly_only_slop20000.bed \
# -b data/HG002_GRCh37_1_22_v4.1_python_filteredsites.bed.txt > intermediate/complement_coverage/comp_cov_HG002_GRCh37_filteredsites.bed

## Tier1 SV overlap bed generation - Code from JZ
#(base) PN105860:bioinfo jzook$ gunzip -c /Users/jzook/Documents/AJTrio/SVs/triounion_171212/NIST_SVs_Integration_v0.6/HG002_SVs_Tier1_v0.6.vcf.gz | awk '$1 ~ /^#/ || $7=="PASS"' | /Applications/bioinfo/bedtools2.26.0/bin/intersectBed -wa -a /Users/jzook/Downloads/expanded_150_HG002_SVs_Tier1plusTier2_v0.6.1.bed -b stdin >  /Users/jzook/Downloads/expanded_150_HG002_SVs_Tier1plusTier2_v0.6.1_Tier1overlap.bed
#(base) PN105860:bioinfo jzook$  gunzip -c /Users/jzook/Documents/AJTrio/SVs/triounion_171212/NIST_SVs_Integration_v0.6/HG002_SVs_Tier1_v0.6.vcf.gz | awk '$1 ~ /^#/ || $7=="PASS"' | /Applications/bioinfo/bedtools2.26.0/bin/intersectBed -v -a /Users/jzook/Downloads/expanded_150_HG002_SVs_Tier1plusTier2_v0.6.1.bed -b stdin >  /Users/jzook/Downloads/expanded_150_HG002_SVs_Tier1plusTier2_v0.6.1_noTier1overlap.bed
 