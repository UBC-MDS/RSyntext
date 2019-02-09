# RSyntext

Team Members

|Name | Github |
|---|---|
| Harjyot Kaur |[harjyotkaur](https://github.com/HarjyotKaur)  |
| Alexander Pak | [pak-alex](https://github.com/pak-alex) |
| Yenan Zhang |[YenanZ](https://github.com/YenanZ)  |

### Summary

There are many packages that cover summary statistics for numerical data. However, when it comes to text data, there is a lack of selection for packages of similar functionality. Our group would like to tackle this problem by creating `RySyntext`. This package will allow users to input passages and receive summary information and sentiment analysis on the text, giving the user valuable information on how best to proceed with their data.

Sample functionality included in this package for a given text passage:

* Most common word
* Most frequent n-gram
* Sentiment (Positive, Negative, Neutral)
* Number of spelling mistakes
* ...etc.


### Function 1: `text_summarize`

`text_summarize` function of class `PySyntext` takes in `string` as an input and produces `DataFrame` as an output containing a quantitative summary of the input. The quantitative summary entails the following:

- Number of Words
- Number of Sentences
- Most Common Word/Words
- Least Common Word/Words
- Average Word Length
- Average Sentence Length

<br>

| Name | Type |
|---|---|
| Input | character |
| Output | data.frame |

<br>

#### Output: Dataframe
<br>

| Column Name | word_count | sentence_count | most_common|least_common | avg_word_len |avg_sentence_len|
|---|---|---|---|---|---|---|
|Type| int |int | list of strings |list of strings | int | int |

<br>

The function takes in the following arguments:

<br>

| Name | Type | Default|
|---|---|---|
| text | character | NA |  
| stopwords_remove | boolean | True |
| lemmatize | boolean | False |
| remove_punctuation | boolean | True |
| remove_numbers |  boolean | True |
| case_sensitive |  boolean | False |
| gibberish_remove |  boolean | True  |

<br>

### Function 2: `text_grams`

`text_grams` function of class `PySyntext` takes in `string` as an input and produces `DataFrame` as an output containing lists of top 5 ngrams. The top `k` ngrams and `n` are user based inputs with default values (k=5 and n=(2,3))

<br>

| Name | Type |
|---|---|
| Input | character |
| Output | data.frame |

<br>

#### Output: Dataframe

<br>

| Column Name | ngrams |
|---|---|
|Type| list of strings |

<br>

`For Example: k=1, n=(2,3)`

| Column Name | bigrams | trigrams |
|---|---|---|
|0| ("hello world") | ("hello world program")

*Number of rows are dependent on the input  `n` of the user*
*Size of the list is dependent on the input `k` of the user*

The function takes in the following arguments:
<br>

| Name | Type | Default|
|---|---|---|
| text | character | NA |
| k | int | 5 |
| n | int,list | (2,3) |
| stopwords_remove | boolean | True |
| lemitize | boolean | False |
| remove_punctuation | boolean | True |
| remove_numbers |  boolean | True |
| case_sensitive |  boolean | False |
| gibberish_remove |  boolean | True  |

<br>

### Function 3: `text_quality`

`text_quality` function of class `PySyntext` takes in `string` as an input and produces `DataFrame` as an output a qualitative summary of the input. The qualitative summary would include the following:

- Spelling Mistakes: Words spelt wrong/Total words
- Toxicity: Abusive or Slang words used/ Total Words
<br>

| Name | Type |
|---|---|
| Input | character |
| Output | data.frame |

<br>

#### Output: Dataframe

<br>

|Column Name| spell_error | toxicity |
|---|---|---|
| Type| float | float |

<br>

The function takes in the following arguments:
<br>

| Name | Type | Default|
|---|---|---|
| text | character | NA |

<br>


### R Ecosystem

It seems as if [OpenNLP](https://cran.r-project.org/web/packages/openNLP/openNLP.pdf) is the most popular Natural Language Processing package that exists in the R landscape. It provides the framework for general machine learning models, and includes functions for text analysis.

Although OpenNLP provides the framework for tokenizing and fitting models to text data, it is difficult to create a quick-and-dirty summary of your data using these packages. By using RSyntext, summary and sentiment of text data is quickly achievable, allowing users to determine the worth of their dataset.
