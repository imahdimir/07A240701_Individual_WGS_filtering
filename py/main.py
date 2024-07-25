"""


"""


import pandas as pd


def main():
    pass

    ##

    # Load data
    df = pd.read_csv('snps.lifted', sep='\t', header=None)

    ##
    df = df.iloc[:7000]

    ##
    df.to_csv('snps_7K.lifted', sep='\t', header=None, index=None)

    ##
