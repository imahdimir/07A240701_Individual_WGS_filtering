vcf_path="/mnt/project/Bulk/DRAGEN WGS/Whole genome variant call files (VCFs) (DRAGEN) [500k release]/13/1300308_24053_0_0.dragen.hard-filtered.vcf.gz"
snps="/mnt/project/data/snps.lifted"


pyenv activate dx
dx login
dx run swiss-army-knife
tabix -R /mnt/project/data/snps.lifted '/mnt/project/Bulk/DRAGEN WGS/Whole genome variant call files (VCFs) (DRAGEN) [500k release]/13/1300308_24053_0_0.dragen.hard-filtered.vcf.gz' > out.vcf
tabix -R /mnt/project/data/snps_7K.lifted '/mnt/project/Bulk/DRAGEN WGS/Whole genome variant call files (VCFs) (DRAGEN) [500k release]/13/1300308_24053_0_0.dragen.hard-filtered.vcf.gz' > out.vcf

dx run --instance-type mem1_ssd1_v2_x2 app-cloud_workstation

unset DX_WORKSPACE_ID
dx cd $DX_PROJECT_CONTEXT_ID:

dx select --level=VIEW


list of snps: /mnt/project/data/snps.lifted


project-Gjz9YXjJzVpj2P4v2vFpg4GP:/Bulk/DRAGEN WGS/Whole genome variant call files (VCFs) (DRAGEN) [500k release]/20/2000960_24053_0_0.dragen.hard-filtered.vcf.gz.tbi

dx download "/Bulk/DRAGEN WGS/Whole genome variant call files (VCFs) (DRAGEN) [500k release]/20/2000960_24053_0_0.dragen.hard-filtered.vcf.gz.tbi"


parallel --jobs 72 "tabix -h {} ~/snps.lifted > {.}.filtered.vcf" :::: ~/first_92_vcf_gz_4_tabix.txt

parallel --jobs 2 "tabix -h {} ~/snps.lifted > {.}.filtered.vcf" :::: ~/only_2.txt


cat "$HOME/1K_sibs_for_dx_download.txt" | parallel -j 72 dx download {}


parallel --jobs 2 "tabix -h {} $HOME/snps.lifted > {.}.filtered.vcf" :::: $HOME/gz_files.txt


cat "$HOME/filtered_files.txt" | parallel -j 72 dx upload {}

tar -czf filtered.tar.gz filtered


tar -xzf filtered.tar.gz -C filtered


plink2 --vcf 1093022_24053_0_0.dragen.hard-filtered.vcf.filtered.vcf --make-bed --out my_data


dx download "project-Gjz9YXjJzVpj2P4v2vFpg4GP:/Bulk/DRAGEN WGS/Whole genome variant call files (VCFs) (DRAGEN) [500k release]/10/1093022_24053_0_0.dragen.hard-filtered.vcf.gz"
dx download "project-Gjz9YXjJzVpj2P4v2vFpg4GP:/Bulk/DRAGEN WGS/Whole genome variant call files (VCFs) (DRAGEN) [500k release]/10/1093022_24053_0_0.dragen.hard-filtered.vcf.gz.tbi"

dx download snps.lifted


sudo apt-get install tabix -y
tabix -h -R snps.lifted 1093022_24053_0_0.dragen.hard-filtered.vcf.gz > out.vcf




wget https://s3.amazonaws.com/plink2-assets/plink2_linux_x86_64_latest.zip
unzip plink2_linux_x86_64_latest.zip
sudo mv plink2 /usr/local/bin/
plink2 --version


plink2 --max-alleles 2 --vcf out.vcf --make-bed --out my_data



import pandas as pd

# Specify the path to your BED file
bed_file = "path/to/your/file.bed"

# Read the BED file into a pandas DataFrame
# BED files usually have no header, but you can add column names if needed
bed_df = pd.read_csv("my_data.bed", sep='\t', header=None, names=['chrom', 'chromStart', 'chromEnd', 'name', 'score', 'strand'])

# Display the first few rows of the DataFrame
print(bed_df.head())


create a 72 core instance, just do for 72 individuals


dx run --instance-type mem1_ssd1_v2_x72 app-cloud_workstation

dx ssh job-

unset DX_WORKSPACE_ID
dx cd $DX_PROJECT_CONTEXT_ID:

dx select --level=VIEW


dx download pairs_72_for_dx_download.txt

mkdir org_files
cd org_files


cat "$HOME/pairs_72_for_dx_download.txt" | parallel -j 72 dx download {}


dx download snps.lifted
dx download pairs_72_4_tabix.txt


parallel --jobs 72 "tabix -h -R $HOME/snps.lifted {} > {.}.filtered.vcf" :::: $HOME/pairs_72_4_tabix.txt



plink2 --max-alleles 2 --vcf 5986255_24053_0_0.dragen.hard-filtered.vcf.filtered.vcf --make-bed --out $HOME/my_data


##

dx run --instance-type mem1_ssd1_v2_x72 app-cloud_workstation

dx ssh job-

unset DX_WORKSPACE_ID
dx cd $DX_PROJECT_CONTEXT_ID:
dx select --level=VIEW

sudo apt-get install tabix -y
sudo apt-get install parallel -y

dx download 1k_4_download.txt
dx download 1k_4_tabix.txt
dx download snps.lifted

mkdir org
cd org


cat "$HOME/1k_4_download.txt" | parallel -j 72 dx download {}
# check number of downloaded files
ls | wc -l 


parallel --jobs 72 "tabix -h -R $HOME/snps.lifted {} > {.}.filtered.vcf" :::: $HOME/1k_4_tabix.txt

mkdir filtered
mv *.filtered.vcf

tar -czf filtered.tar.gz filtered


parallel --jobs 72 "tabix -h -R $HOME/snps.lifted {} > {.}.filtered.vcf" :::: $HOME/1k_4_tabix.txt

mkdir plink_out

plink2 --max-alleles 2 --vcf 1093036_24053_0_0.dragen.hard-filtered.vcf.filtered.vcf --make-bed --out $HOME/plink_out/1093036_24053_0_0


parallel --jobs 72 "plink2 --max-alleles 2 --vcf {} --make-bed --out $HOME/plink_out/{/.}" :::: $HOME/filtered_list.txt

tar -czf plink_out.tar.gz plink_out


##
dx run --instance-type mem1_ssd1_v2_x2 app-cloud_workstation

dx ssh job-

unset DX_WORKSPACE_ID
dx cd $DX_PROJECT_CONTEXT_ID:
dx select --level=VIEW

dx download plink_out.tar.gz

mkdir plink_out

tar -xvzf plink_out.tar.gz plink_out/


##

plink2 --bfile 5968696_24053_0_0.dragen.hard-filtered.vcf.filtered --update-name 5968696_24053_0_0.dragen.hard-filtered.vcf.filtered.bim 2 1 --make-bed --out out


##

# on g03
pyenv activate dx
dx login

dx run --instance-type mem1_ssd1_v2_x2 app-cloud_workstation

# 5816418_24053_0_0.dragen.hard-filtered.vcf.filtered.vcf
# tabix example.vcf.gz 1:1000-2000

dx ssh job-GpVyVp0JzVpv2px8b359fB0y

unset DX_WORKSPACE_ID
dx cd $DX_PROJECT_CONTEXT_ID:
dx select --level=VIEW

# project-Gjz9YXjJzVpj2P4v2vFpg4GP:/Bulk/DRAGEN WGS/Whole genome variant call files (VCFs) (DRAGEN) [500k release]/58/5816418_24053_0_0.dragen.hard-filtered.vcf.gz

dx download "project-Gjz9YXjJzVpj2P4v2vFpg4GP:/Bulk/DRAGEN WGS/Whole genome variant call files (VCFs) (DRAGEN) [500k release]/58/5816418_24053_0_0.dragen.hard-filtered.vcf.gz"
dx download "project-Gjz9YXjJzVpj2P4v2vFpg4GP:/Bulk/DRAGEN WGS/Whole genome variant call files (VCFs) (DRAGEN) [500k release]/58/5816418_24053_0_0.dragen.hard-filtered.vcf.gz.tbi"


sudo apt install tabix

# tabix example.vcf.gz 1:1-200000 # 200K SNPs
# tabix "5816418_24053_0_0.dragen.hard-filtered.vcf.gz" 1:1-200000
tabix "5816418_24053_0_0.dragen.hard-filtered.vcf.gz" 1:1-200000 -h > out.vcf

mv out.vcf 5816418_filtered.vcf

dx upload 5816418_filtered.vcf

# on g01
dx download 5816418_filtered.vcf


##

# on g01
pyenv activate dx

dx run --instance-type mem1_ssd1_v2_x2 app-cloud_workstation

# 5816418_24053_0_0.dragen.hard-filtered.vcf.filtered.vcf
# tabix example.vcf.gz 1:1000-2000

dx ssh job-GpX2KkjJzVpgFKPZzjX45Z3j

unset DX_WORKSPACE_ID
dx cd $DX_PROJECT_CONTEXT_ID:
dx select --level=VIEW

# project-Gjz9YXjJzVpj2P4v2vFpg4GP:/Bulk/DRAGEN WGS/Whole genome variant call files (VCFs) (DRAGEN) [500k release]/58/5816418_24053_0_0.dragen.hard-filtered.vcf.gz

dx download "project-Gjz9YXjJzVpj2P4v2vFpg4GP:/Bulk/DRAGEN WGS/Whole genome variant call files (VCFs) (DRAGEN) [500k release]/58/5816418_24053_0_0.dragen.hard-filtered.vcf.gz"
dx download "project-Gjz9YXjJzVpj2P4v2vFpg4GP:/Bulk/DRAGEN WGS/Whole genome variant call files (VCFs) (DRAGEN) [500k release]/58/5816418_24053_0_0.dragen.hard-filtered.vcf.gz.tbi"


sudo apt install tabix

# tabix example.vcf.gz 1:1-200000 # 200K SNPs
# tabix "5816418_24053_0_0.dragen.hard-filtered.vcf.gz" 1:1-200000
tabix -h 5816418_24053_0_0.dragen.hard-filtered.vcf.gz 1:100-200 > 5816418_1.vcf

dx upload 5816418_1.vcf

# on g01
dx download 5816418_1.vcf

mv 5816418_1.vcf /var/genetics/ws/mahdimir/local/prj_data/40724_read_gt_from_VCF/inp/
