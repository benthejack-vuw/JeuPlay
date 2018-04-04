import os
import sys

cwd = os.getcwd()
search_ext = ".wav"

if(len(sys.argv) > 1):
	cwd = sys.argv[1]
	search_ext = sys.argv[2]

for f in os.listdir(cwd):
	if(os.path.isfile(f) and os.path.splitext(f)[1] == search_ext):
		name, ext = os.path.splitext(f)
		pre_dash, post_dash  = name.split(" - ")
		newStr = pre_dash + "_" + post_dash

		pre_space1, pre_space2, post_space = newStr.split(" ")
		if(len(post_space) < 2):
			post_space = "0" + post_space
		new_file = pre_space1+ "_" +pre_space2 + "_" + post_space + ext
		os.rename(f, new_file)
