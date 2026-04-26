---
title: MKTLAPSE
section: 1
header: User Commands
date: April 2026
author: Mark Pitman <mark.pitman@gmail.com>
---

# NAME

mktlapse - convert timelapse JPEG sequences into MP4 videos

# SYNOPSIS

**mktlapse** [-n] [-r framerate] [-o output_dir] \<timelapse_dir\>

# DESCRIPTION

**mktlapse** scans each subdirectory of *timelapse_dir* as a separate job,
collects all JPEG files within it (sorted by name for chronological order), and
encodes them into an H.264 MP4 video using **ffmpeg**.

Each job produces a single video file named after the job directory. Jobs
containing no JPEG files are skipped with a warning.

Output videos are written to *output_dir*. If **-o** is not given, the default
is a **timelapse_videos** directory alongside *timelapse_dir*.

# OPTIONS

**-r** framerate

: Frames per second for the output video. Defaults to **24**.

**-o** output_dir

: Directory to write the generated MP4 files into. Created if it does not
  exist. Defaults to *\<timelapse_dir\>/../timelapse_videos*.

**-n**

: Dry run. Print what would be processed without creating any files.

**-h**

: Show usage help and exit.

# EXAMPLES

```bash
mktlapse ~/timelapse
mktlapse -r 30 ~/timelapse
mktlapse -o ~/videos ~/timelapse
mktlapse -n ~/timelapse
```

# EXIT STATUS

**0**

: All jobs completed (some may have been skipped).

**1**

: Invalid usage or a required dependency is missing.

# DEPENDENCIES

**ffmpeg**(1) must be installed and available on **$PATH**.

# SEE ALSO

**ffmpeg**(1)
