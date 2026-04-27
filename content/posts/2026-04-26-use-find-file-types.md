+++
title = "Techlet: Find how much space certain file types take up"
author = ["Cody Edwards"]
date = 2026-04-26T21:39:00-06:00
tags = ["techlet", "linux"]
draft = false
+++

I am pretty sloppy with my file organization. Usually, I just store
things where I think they would be useful at that point in time, not
necessarily where they logically belong. Eventually, I get curious of
how many of a particular file type I have and how much space they are
taking up. Below is a convoluted shell command that searches the home
directory for every file with a particular extension and displays how
many of that type there are and how much space they're taking up.

```shell
find ~ -type f -name "*.epub" -print0 \
| xargs -0 -r du -k \
| awk '{
      total+=$1
    }

    END {
      printf("\nTotal files: %d\nTotal Size: %.1f MB\n", NR, total/1024)
    }
  '
```

1.  Find searches the home directory recursively for files ending with,
    in this example, the .epub extension.
2.  xargs then passes the results from find to the disk usage utility,
    which calculates the size of each file in kilobytes.
3.  Finally, awk sums the size of each file and outputs a nicely
    formatted table with the total size presented in megabytes.

<!--listend-->

```text
Total files: 5
Total Size: 11.9 MB
```

Like I said, it's a bit much. I suppose this could be dumped into a
shell script with the file extension as a positional parameter,
e.g. `./find-ext.sh epub`.
