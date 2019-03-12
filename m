Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105B8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B61E4214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552356137;
	bh=Q42WnZa0+Ym3hIvw1+Zy+dK6RECEMaGkAipEinhO42Q=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=NXg5UyNo6pntynR1J4+ykVJu1eWJhihqIuQVZqQVnUoNY6/Ndz/2BnwiOIlslZPXN
	 3N7pRt3Ip+w3S2PV+FQJunUWqMHUj/1qTPWF0iQbCUgGuZzDE2tXZR0ZzVu6F18NF6
	 x1CyWpnbbF5T8Rt0ax/icthU8UzrfP9HWf8vnsoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfCLCCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 22:02:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbfCLCCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 22:02:15 -0400
Received: from quaco.meukeo.local (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99800214AE;
        Tue, 12 Mar 2019 02:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552356133;
        bh=Q42WnZa0+Ym3hIvw1+Zy+dK6RECEMaGkAipEinhO42Q=;
        h=From:To:Cc:Subject:Date:From;
        b=GVYFy4MvMYzkQ8hzgk9H94F2beKfJADT7jFhHWHxpZ6ZeFV4GbF3FkRdM1GYIRAcv
         1MvS5L0uka+MgAwRznHxyrf6h7a8bQVXeibQUJGaxHIprSYumj3r43ymS+EbL1eZSi
         90cxEpULuAiSEDK7BOneWBUNaw5jmvdDyfJD1/yM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Tony Jones <tonyj@suse.de>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL 00/30] perf/core improvements and fixes
Date:   Mon, 11 Mar 2019 23:01:34 -0300
Message-Id: <20190312020204.22092-1-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

	Please consider pulling,

Best regards,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit b339da480315505aa28a723a983217ebcff95c86:

  Merge tag 'perf-core-for-mingo-5.1-20190307' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2019-03-09 17:00:17 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.1-20190311

for you to fetch changes up to dfcbc2f2994b8a3af3605a26dc29c07ad7378bf4:

  tools lib bpf: Fix the build by adding a missing stdarg.h include (2019-03-11 17:14:31 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

kernel:

  Stephane Eranian :

  - Restore mmap record type correctly when handling PERF_RECORD_MMAP2
    events, as the same template is used for all the threads interested
    in mmap events, some may want just PERF_RECORD_MMAP, while some
    may want the extra info in MMAP2 records.

perf probe:

  Adrian Hunter:

  - Fix getting the kernel map, because since changes related to x86 PTI
    entry trampolines handling, there are more than one kernel map.

perf script:

  Andi Kleen:

  - Support insn output for normal samples, i.e.:

    perf script -F ip,sym,insn --xed

    Will fetch the sample IP from the thread address space and feed it
    to Intel's XED disassembler, producing lines such as:

      ffffffffa4068804 native_write_msr            wrmsr
      ffffffffa415b95e __hrtimer_next_event_base   movq  0x18(%rax), %rdx

    That match 'perf annotate's output.

  - Make the --cpu filter apply to  PERF_RECORD_COMM/FORK/... events, in
    addition to PERF_RECORD_SAMPLE.

perf report:

  - Add a new --samples option to save a small random number of samples
    per hist entry, using a reservoir technique to select a representative
    number of samples.

    Then allow browsing the samples using 'perf script' as part of the hist
    entry context menu. This automatically adds the right filters, so only
    the thread or CPU of the sample is displayed. Then we use less' search
    functionality to directly jump to the time stamp of the selected sample.

    It uses different menus for assembler and source display.  Assembler
    needs xed installed and source needs debuginfo.

  - Fix the UI browser scripts pop up menu when there are many scripts
    available.

perf report:

  Andi Kleen:

  - Add 'time' sort option. E.g.:

    % perf report --sort time,overhead,symbol --time-quantum 1ms --stdio
    ...
         0.67%  277061.87300  [.] _dl_start
         0.50%  277061.87300  [.] f1
         0.50%  277061.87300  [.] f2
         0.33%  277061.87300  [.] main
         0.29%  277061.87300  [.] _dl_lookup_symbol_x
         0.29%  277061.87300  [.] dl_main
         0.29%  277061.87300  [.] do_lookup_x
         0.17%  277061.87300  [.] _dl_debug_initialize
         0.17%  277061.87300  [.] _dl_init_paths
         0.08%  277061.87300  [.] check_match
         0.04%  277061.87300  [.] _dl_count_modids
         1.33%  277061.87400  [.] f1
         1.33%  277061.87400  [.] f2
         1.33%  277061.87400  [.] main
         1.17%  277061.87500  [.] main
         1.08%  277061.87500  [.] f1
         1.08%  277061.87500  [.] f2
         1.00%  277061.87600  [.] main
         0.83%  277061.87600  [.] f1
         0.83%  277061.87600  [.] f2
         1.00%  277061.87700  [.] main

tools headers:

  Arnaldo Carvalho de Melo:

  - Update x86's syscall_64.tbl, no change in tools/perf behaviour.

  -  Sync copies asm-generic/unistd.h and linux/in with the kernel sources.

perf data:

  Jiri Olsa:

  - Prep work to support having perf.data stored as a directory, with one
    file per CPU, that ultimately will allow having one ring buffer reading
    thread per CPU.

Vendor events:

  Martin Liška:

  - perf PMU events for AMD Family 17h.

perf script python:

  Tony Jones:

  - Add python3 support for the remaining Intel PT related scripts, with
    these we should have a clean build of perf with python3 while still
    supporting the build with python2.

libbpf:

  Arnaldo Carvalho de Melo:

  - Fix the build on uCLibc, adding the missing stdarg.h since we use
    va_list in one typedef.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (1):
      perf probe: Fix getting the kernel map

Andi Kleen (14):
      perf script: Support insn output for normal samples
      perf report: Support output in nanoseconds
      perf time-utils: Add utility function to print time stamps in nanoseconds
      perf report: Parse time quantum
      perf report: Use less for scripts output
      perf script: Filter COMM/FORK/.. events by CPU
      perf report: Support time sort key
      perf report: Support running scripts for current time range
      perf report: Support builtin perf script in scripts menu
      perf report: Implement browsing of individual samples
      perf tools: Add some new tips describing the new options
      perf script: Add array bound checking to list_scripts
      perf ui browser: Fix ui popup argv browser for many entries
      perf tools report: Add custom scripts to script menu

Arnaldo Carvalho de Melo (4):
      perf tools: Update x86's syscall_64.tbl, no change in tools/perf behaviour
      tools headers uapi: Sync copy of asm-generic/unistd.h with the kernel sources
      tools headers uapi: Update linux/in.h copy
      tools lib bpf: Fix the build by adding a missing stdarg.h include

Jiri Olsa (6):
      perf data: Support having perf.data stored as a directory
      perf data: Don't store auxtrace index for directory data file
      perf data: Add perf_data__update_dir() function
      perf data: Make perf_data__size() work over directory
      perf header: Add DIR_FORMAT feature to describe directory data
      perf session: Add process callback to reader object

Martin Liška (1):
      perf vendor events amd: perf PMU events for AMD Family 17h

Stephane Eranian (1):
      perf/core: Restore mmap record type correctly

Tony Jones (4):
      perf script python: Add Python3 support to exported-sql-viewer.py
      perf script python: Add Python3 support to export-to-postgresql.py
      perf script python: Add Python3 support to export-to-sqlite.py
      perf script python: Add printdate function to SQL exporters

 kernel/events/core.c                               |   2 +
 tools/arch/arm64/include/uapi/asm/unistd.h         |   2 +
 tools/include/uapi/asm-generic/unistd.h            | 149 ++++++++---
 tools/include/uapi/linux/in.h                      |   9 +-
 tools/lib/bpf/libbpf.h                             |   1 +
 tools/perf/Documentation/perf-config.txt           |  14 +
 tools/perf/Documentation/perf-report.txt           |  13 +
 tools/perf/Documentation/tips.txt                  |   7 +
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |   6 +-
 tools/perf/arch/x86/util/Build                     |   1 +
 tools/perf/arch/x86/util/archinsn.c                |  26 ++
 tools/perf/builtin-record.c                        |   4 +-
 tools/perf/builtin-report.c                        |  45 ++++
 tools/perf/builtin-script.c                        | 111 +++++---
 tools/perf/builtin.h                               |   3 +-
 .../perf/pmu-events/arch/x86/amdfam17h/branch.json |  12 +
 .../perf/pmu-events/arch/x86/amdfam17h/cache.json  | 287 +++++++++++++++++++++
 tools/perf/pmu-events/arch/x86/amdfam17h/core.json | 134 ++++++++++
 .../arch/x86/amdfam17h/floating-point.json         | 168 ++++++++++++
 .../perf/pmu-events/arch/x86/amdfam17h/memory.json | 162 ++++++++++++
 .../perf/pmu-events/arch/x86/amdfam17h/other.json  |  65 +++++
 tools/perf/pmu-events/arch/x86/mapfile.csv         |   1 +
 tools/perf/scripts/python/export-to-postgresql.py  |  61 +++--
 tools/perf/scripts/python/export-to-sqlite.py      |  26 +-
 tools/perf/scripts/python/exported-sql-viewer.py   |  42 ++-
 tools/perf/ui/browser.c                            |  10 +-
 tools/perf/ui/browsers/Build                       |   1 +
 tools/perf/ui/browsers/annotate.c                  |   2 +-
 tools/perf/ui/browsers/hists.c                     | 141 ++++++++--
 tools/perf/ui/browsers/res_sample.c                |  91 +++++++
 tools/perf/ui/browsers/scripts.c                   | 274 ++++++++++----------
 tools/perf/util/archinsn.h                         |  12 +
 tools/perf/util/data.c                             |  96 ++++++-
 tools/perf/util/data.h                             |  12 +-
 tools/perf/util/header.c                           |  44 +++-
 tools/perf/util/header.h                           |   5 +
 tools/perf/util/hist.c                             |  50 ++++
 tools/perf/util/hist.h                             |  31 ++-
 tools/perf/util/probe-event.c                      |   6 +-
 tools/perf/util/session.c                          |  27 +-
 tools/perf/util/sort.c                             |  39 +++
 tools/perf/util/sort.h                             |  10 +
 tools/perf/util/symbol.c                           |   4 +
 tools/perf/util/symbol_conf.h                      |   3 +
 tools/perf/util/time-utils.c                       |   8 +
 tools/perf/util/time-utils.h                       |   1 +
 46 files changed, 1931 insertions(+), 287 deletions(-)
 create mode 100644 tools/perf/arch/x86/util/archinsn.c
 create mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/branch.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/core.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/other.json
 create mode 100644 tools/perf/ui/browsers/res_sample.c
 create mode 100644 tools/perf/util/archinsn.h

Test results:

The first ones are container based builds of tools/perf with and without libelf
support.  Where clang is available, it is also used to build perf with/without
libelf, and building with LIBCLANGLLVM=1 (built-in clang) with gcc and clang
when clang and its devel libraries are installed.

The objtool and samples/bpf/ builds are disabled now that I'm switching from
using the sources in a local volume to fetching them from a http server to
build it inside the container, to make it easier to build in a container cluster.
Those will come back later.

Several are cross builds, the ones with -x-ARCH and the android one, and those
may not have all the features built, due to lack of multi-arch devel packages,
available and being used so far on just a few, like
debian:experimental-x-{arm64,mipsel}.

The 'perf test' one will perform a variety of tests exercising
tools/perf/util/, tools/lib/{bpf,traceevent,etc}, as well as run perf commands
with a variety of command line event specifications to then intercept the
sys_perf_event syscall to check that the perf_event_attr fields are set up as
expected, among a variety of other unit tests.

Then there is the 'make -C tools/perf build-test' ones, that build tools/perf/
with a variety of feature sets, exercising the build with an incomplete set of
features as well as with a complete one. It is planned to have it run on each
of the containers mentioned above, using some container orchestration
infrastructure. Get in contact if interested in helping having this in place.

  # export PERF_TARBALL=http://192.168.124.1/perf/perf-5.0.0.tar.xz
   1 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0
   2 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822
   3 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0
   4 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0
   5 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0
   6 alpine:3.9                    : Ok   gcc (Alpine 8.2.0) 8.2.0
   7 alpine:edge                   : Ok   gcc (Alpine 8.2.0) 8.2.0
   8 amazonlinux:1                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28)
   9 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
  10 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  11 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  12 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  13 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
  14 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36)
  15 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 8.2.1 20180502
  16 debian:7                      : Ok   gcc (Debian 4.7.2-5) 4.7.2
  17 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2
  18 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
  19 debian:experimental           : Ok   gcc (Debian 8.2.0-17) 8.2.1 20190204
  20 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.2.0-11) 8.2.0
  21 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 8.2.0-11) 8.2.0
  22 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 8.2.0-16) 8.2.0
  23 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  24 fedora:21                     : Ok   gcc (GCC) 4.9.2 20150212 (Red Hat 4.9.2-6)
  25 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  26 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  27 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
  28 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  29 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
  30 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2)
  31 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6)
  32 fedora:28                     : Ok   gcc (GCC) 8.2.1 20181215 (Red Hat 8.2.1-6)
  33 fedora:29                     : Ok   gcc (GCC) 8.2.1 20181215 (Red Hat 8.2.1-6)
  34 fedora:30                     : Ok   gcc (GCC) 9.0.1 20190203 (Red Hat 9.0.1-0.3)
  35 fedora:rawhide                : Ok   gcc (GCC) 9.0.1 20190209 (Red Hat 9.0.1-0.4)
  36 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 7.3.0-r3 p1.4) 7.3.0
  37 mageia:5                      : Ok   gcc (GCC) 4.9.2
  38 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0
  39 opensuse:13.2                 : Ok   gcc (SUSE Linux) 4.8.3 20140627 [gcc-4_8-branch revision 212064]
  40 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.3.1 20180323 [gcc-7-branch revision 258812]
  41 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.4.0
  42 opensuse:42.1                 : Ok   gcc (SUSE Linux) 4.8.5
  43 opensuse:42.2                 : Ok   gcc (SUSE Linux) 4.8.5
  44 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5
  45 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 8.2.1 20190103 [gcc-8-branch revision 267549]
  46 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
  47 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36.0.1)
  48 ubuntu:12.04.5                : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
  49 ubuntu:14.04.4                : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.4) 4.8.4
  50 ubuntu:14.04.4-x-linaro-arm64 : Ok   aarch64-linux-gnu-gcc (Linaro GCC 5.5-2017.10) 5.5.0
  51 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.11) 5.4.0 20160609
  52 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  53 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  54 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  55 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  56 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  57 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  58 ubuntu:17.10                  : Ok   gcc (Ubuntu 7.2.0-8ubuntu3.2) 7.2.0
  59 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  60 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.3.0-27ubuntu1~18.04) 7.3.0
  61 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.3.0-27ubuntu1~18.04) 7.3.0
  62 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  63 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  64 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  65 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  66 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  67 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  68 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  69 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  70 ubuntu:18.10                  : Ok   gcc (Ubuntu 8.2.0-7ubuntu1) 8.2.0
  71 ubuntu:19.04                  : Ok   gcc (Ubuntu 8.2.0-20ubuntu1) 8.2.0
  72 ubuntu:19.04-x-alpha          : Ok   alpha-linux-gnu-gcc (Ubuntu 8.2.0-20ubuntu1) 8.2.0
  73 ubuntu:19.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 8.2.0-20ubuntu1) 8.2.0
  74 ubuntu:19.04-x-hppa           : Ok   hppa-linux-gnu-gcc (Ubuntu 8.2.0-20ubuntu1) 8.2.0
  #
  # uname -a
  Linux quaco 5.0.0+ #1 SMP Thu Mar 7 10:32:55 -03 2019 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  dfcbc2f2994b tools lib bpf: Fix the build by adding a missing stdarg.h include
  # perf version --build-options
  perf version 5.0.gdfcbc2
                   dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
      dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
                   glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
                    gtk2: [ on  ]  # HAVE_GTK2_SUPPORT
           syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
                  libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
                  libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
                 libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
  numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
                 libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
               libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
                libslang: [ on  ]  # HAVE_SLANG_SUPPORT
               libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
               libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
      libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                    zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                    lzma: [ on  ]  # HAVE_LZMA_SUPPORT
               get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                     bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
  # perf test
   1: vmlinux symtab matches kallsyms                       : Ok
   2: Detect openat syscall event                           : Ok
   3: Detect openat syscall event on all cpus               : Ok
   4: Read samples using the mmap interface                 : Ok
   5: Test data source output                               : Ok
   6: Parse event definition strings                        : Ok
   7: Simple expression parser                              : Ok
   8: PERF_RECORD_* events & perf_sample fields             : Ok
   9: Parse perf pmu format                                 : Ok
  10: DSO data read                                         : Ok
  11: DSO data cache                                        : Ok
  12: DSO data reopen                                       : Ok
  13: Roundtrip evsel->name                                 : Ok
  14: Parse sched tracepoints fields                        : Ok
  15: syscalls:sys_enter_openat event fields                : Ok
  16: Setup struct perf_event_attr                          : Ok
  17: Match and link multiple hists                         : Ok
  18: 'import perf' in python                               : Ok
  19: Breakpoint overflow signal handler                    : Ok
  20: Breakpoint overflow sampling                          : Ok
  21: Breakpoint accounting                                 : Ok
  22: Watchpoint                                            :
  22.1: Read Only Watchpoint                                : Skip
  22.2: Write Only Watchpoint                               : Ok
  22.3: Read / Write Watchpoint                             : Ok
  22.4: Modify Watchpoint                                   : Ok
  23: Number of exit events of a simple workload            : Ok
  24: Software clock events period values                   : Ok
  25: Object code reading                                   : Ok
  26: Sample parsing                                        : Ok
  27: Use a dummy software event to keep tracking           : Ok
  28: Parse with no sample_id_all bit set                   : Ok
  29: Filter hist entries                                   : Ok
  30: Lookup mmap thread                                    : Ok
  31: Share thread mg                                       : Ok
  32: Sort output of hist entries                           : Ok
  33: Cumulate child hist entries                           : Ok
  34: Track with sched_switch                               : Ok
  35: Filter fds with revents mask in a fdarray             : Ok
  36: Add fd to a fdarray, making it autogrow               : Ok
  37: kmod_path__parse                                      : Ok
  38: Thread map                                            : Ok
  39: LLVM search and compile                               :
  39.1: Basic BPF llvm compile                              : Ok
  39.2: kbuild searching                                    : Ok
  39.3: Compile source for BPF prologue generation          : Ok
  39.4: Compile source for BPF relocation                   : Ok
  40: Session topology                                      : Ok
  41: BPF filter                                            :
  41.1: Basic BPF filtering                                 : Ok
  41.2: BPF pinning                                         : Ok
  41.3: BPF prologue generation                             : Ok
  41.4: BPF relocation checker                              : Ok
  42: Synthesize thread map                                 : Ok
  43: Remove thread map                                     : Ok
  44: Synthesize cpu map                                    : Ok
  45: Synthesize stat config                                : Ok
  46: Synthesize stat                                       : Ok
  47: Synthesize stat round                                 : Ok
  48: Synthesize attr update                                : Ok
  49: Event times                                           : Ok
  50: Read backward ring buffer                             : Ok
  51: Print cpu map                                         : Ok
  52: Probe SDT events                                      : Ok
  53: is_printable_array                                    : Ok
  54: Print bitmap                                          : Ok
  55: perf hooks                                            : Ok
  56: builtin clang support                                 : Skip (not compiled in)
  57: unit_number__scnprintf                                : Ok
  58: mem2node                                              : Ok
  59: x86 rdpmc                                             : Ok
  60: Convert perf time to TSC                              : Ok
  61: DWARF unwind                                          : Ok
  62: x86 instruction decoder - new instructions            : Ok
  63: x86 bp modify                                         : Ok
  64: probe libc's inet_pton & backtrace it with ping       : Ok
  65: Use vfs_getname probe to get syscall args filenames   : Ok
  66: Add vfs_getname probe to get syscall args filenames   : Ok
  67: Check open filename arg using perf trace + vfs_getname: Ok
  
  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
             make_no_libnuma_O: make NO_LIBNUMA=1
              make_clean_all_O: make clean all
            make_no_auxtrace_O: make NO_AUXTRACE=1
                make_no_newt_O: make NO_NEWT=1
           make_no_backtrace_O: make NO_BACKTRACE=1
                make_no_gtk2_O: make NO_GTK2=1
               make_no_slang_O: make NO_SLANG=1
                  make_debug_O: make DEBUG=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
            make_no_libaudit_O: make NO_LIBAUDIT=1
         make_install_prefix_O: make install prefix=/tmp/krava
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
              make_no_libelf_O: make NO_LIBELF=1
                   make_help_O: make help
                   make_pure_O: make
                 make_static_O: make LDFLAGS=-static
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
         make_with_clangllvm_O: make LIBCLANGLLVM=1
            make_install_bin_O: make install-bin
           make_no_libunwind_O: make NO_LIBUNWIND=1
                 make_perf_o_O: make perf.o
              make_no_libbpf_O: make NO_LIBBPF=1
             make_no_libperl_O: make NO_LIBPERL=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
                   make_tags_O: make tags
                make_install_O: make install
           make_no_libbionic_O: make NO_LIBBIONIC=1
             make_util_map_o_O: make util/map.o
           make_no_libpython_O: make NO_LIBPYTHON=1
                    make_doc_O: make doc
                 make_cscope_O: make cscope
            make_no_demangle_O: make NO_DEMANGLE=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
