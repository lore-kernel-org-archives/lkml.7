Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D398C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E5FA222D9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578326840;
	bh=9LMPFXqeAw7TZwnn8yJ16zh9MYSS9YCYZwPQ8LG9uV8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=QM7/3UvIKAb7Y1y5w1tb4Rjf3JpQjKhL7GfCGr0au+eBWzAB5NdTaEGFIUrIG8EiB
	 g0rnT1wQLBYadkUeNE+u1HOcPIREkIPzzter11r8zX63o4GhjlClwpvUYJGVMJ1cc6
	 Cj+Fyw51QafH59cNMEX8HKMnO+goNQlMICq53yCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgAFQHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 11:07:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:44570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbgAFQHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 11:07:18 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5ECBD207FF;
        Mon,  6 Jan 2020 16:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578326837;
        bh=9LMPFXqeAw7TZwnn8yJ16zh9MYSS9YCYZwPQ8LG9uV8=;
        h=From:To:Cc:Subject:Date:From;
        b=NU3HoidSPATTZ83OItULS8OHlQ2qtWZyYCecq1nwOCIx7cuAM4X6iyPK8IQzSfGjh
         yAWU8GibO1H9RelCWgAR7yZ4XlA5w+Evt5mgWlzjD07gOxa0H1IqIFjISfeU7xCp7R
         KYHqGT0e8+l9knys5dNR6XIYfq94C2ouu4/uTu/U=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        David Ahern <dsahern@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vitaly Chikunov <vt@altlinux.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf/core improvements and fixes
Date:   Mon,  6 Jan 2020 13:06:45 -0300
Message-Id: <20200106160705.10899-1-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo/Thomas,

	Please consider pulling,

Best regards,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit b9fb2de0115bbacab36da31fd10483ea66d9cfab:

  Merge tag 'perf-urgent-for-mingo-5.5-20191223' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2019-12-23 22:27:44 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.6-20200106

for you to fetch changes up to 6c4798d3f08b81c2c52936b10e0fa872590c96ae:

  tools lib: Fix builds when glibc contains strlcpy() (2020-01-06 11:46:10 -0300)

----------------------------------------------------------------
perf/core improvements and fixes.

perf record:

  Alexey Budankov:

  - Adapt affinity for machines with #CPUs > 1K to overcome current 1024 CPUs
    mask size limitation of cpu_set_t type.

perf report/top TUI:

  Arnaldo Carvalho de Melo:

  - Make ENTER consistently present the pop up menu with and without call
    chains, to eliminate confusion. The menu continues available at all times
    use 'm' and '+' can be used to toggle just one call chain level, 'e' for all
    the call chains for a top level histogram entry and 'E' to expand all call
    chains in all top level entries. Extra info about these options was added to
    the pop up menu entries. Pressing 'k' serves as special hotkey to go straight
    to the main vmlinux entries, to avoid having to press enter and then select
    "Zoom into the kernel DSO".

perf sched timehist:

  David Ahern:

  - Add support for filtering on CPU.

perf tests:

  Arnaldo Carvalho de Melo:

  - Show expected versus obtained values in bp_signal test.

libperf:

  Jiri Olsa:

  - Move to tools/lib/perf.

  - Add man pages.

libapi:

  Andrey Zhizhikin:

  - Fix gcc9 stringop-truncation compilation error.

tools lib:

  Vitaly Chikunov:

  - Fix builds when glibc contains strlcpy(), which is the case for ALT Linux.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Alexey Budankov (3):
      tools bitmap: Implement bitmap_equal() operation at bitmap API
      perf mmap: Declare type for cpu mask of arbitrary length
      perf record: Adapt affinity to machines with #CPUs > 1K

Andrey Zhizhikin (1):
      tools lib api fs: Fix gcc9 stringop-truncation compilation error

Arnaldo Carvalho de Melo (12):
      perf tests bp_signal: Show expected versus obtained values
      perf hists browser: Restore ESC as "Zoom out" of DSO/thread/etc
      perf report/top: Make ENTER consistently bring up menu
      perf report/top: Add menu entry for toggling callchain expansion
      perf report/top: Improve toggle callchain menu option
      perf hists browser: Generalize the do_zoom_dso() function
      perf report/top: Add 'k' hotkey to zoom directly into the kernel map
      perf hists browser: Allow passing an initial hotkey
      tools ui popup: Allow returning hotkeys
      perf report/top: Allow pressing hotkeys in the options popup menu
      perf report/top: Do not offer annotation for symbols without samples
      perf report/top: Make 'e' visible in the help and make it toggle showing callchains

David Ahern (1):
      perf sched timehist: Add support for filtering on CPU

Jiri Olsa (2):
      libperf: Move to tools/lib/perf
      libperf: Add man pages

Vitaly Chikunov (1):
      tools lib: Fix builds when glibc contains strlcpy()

 tools/include/linux/bitmap.h                       |  30 +++
 tools/include/linux/string.h                       |   8 +
 tools/lib/api/fs/fs.c                              |   4 +-
 tools/lib/bitmap.c                                 |  15 ++
 tools/{perf/lib => lib/perf}/Build                 |   0
 tools/lib/perf/Documentation/Makefile              | 156 ++++++++++++
 tools/lib/perf/Documentation/asciidoc.conf         | 120 +++++++++
 tools/lib/perf/Documentation/examples/sampling.c   | 119 +++++++++
 tools/lib/perf/Documentation/libperf-counting.txt  | 211 ++++++++++++++++
 tools/lib/perf/Documentation/libperf-sampling.txt  | 243 ++++++++++++++++++
 tools/lib/perf/Documentation/libperf.txt           | 246 ++++++++++++++++++
 tools/lib/perf/Documentation/manpage-1.72.xsl      |  14 ++
 tools/lib/perf/Documentation/manpage-base.xsl      |  35 +++
 .../perf/Documentation/manpage-bold-literal.xsl    |  17 ++
 tools/lib/perf/Documentation/manpage-normal.xsl    |  13 +
 .../lib/perf/Documentation/manpage-suppress-sp.xsl |  21 ++
 tools/{perf/lib => lib/perf}/Makefile              |   7 +-
 tools/{perf/lib => lib/perf}/core.c                |   0
 tools/{perf/lib => lib/perf}/cpumap.c              |   0
 tools/{perf/lib => lib/perf}/evlist.c              |   0
 tools/{perf/lib => lib/perf}/evsel.c               |   0
 .../lib => lib/perf}/include/internal/cpumap.h     |   0
 .../lib => lib/perf}/include/internal/evlist.h     |   0
 .../lib => lib/perf}/include/internal/evsel.h      |   0
 .../{perf/lib => lib/perf}/include/internal/lib.h  |   0
 .../{perf/lib => lib/perf}/include/internal/mmap.h |   0
 .../lib => lib/perf}/include/internal/tests.h      |   0
 .../lib => lib/perf}/include/internal/threadmap.h  |   0
 .../lib => lib/perf}/include/internal/xyarray.h    |   0
 tools/{perf/lib => lib/perf}/include/perf/core.h   |   0
 tools/{perf/lib => lib/perf}/include/perf/cpumap.h |   0
 tools/{perf/lib => lib/perf}/include/perf/event.h  |   0
 tools/{perf/lib => lib/perf}/include/perf/evlist.h |   0
 tools/{perf/lib => lib/perf}/include/perf/evsel.h  |   0
 tools/{perf/lib => lib/perf}/include/perf/mmap.h   |   0
 .../lib => lib/perf}/include/perf/threadmap.h      |   0
 tools/{perf/lib => lib/perf}/internal.h            |   0
 tools/{perf/lib => lib/perf}/lib.c                 |   0
 tools/{perf/lib => lib/perf}/libperf.map           |   0
 tools/{perf/lib => lib/perf}/libperf.pc.template   |   0
 tools/{perf/lib => lib/perf}/mmap.c                |   0
 tools/{perf/lib => lib/perf}/tests/Makefile        |   2 +-
 tools/{perf/lib => lib/perf}/tests/test-cpumap.c   |   0
 tools/{perf/lib => lib/perf}/tests/test-evlist.c   |   0
 tools/{perf/lib => lib/perf}/tests/test-evsel.c    |   0
 .../{perf/lib => lib/perf}/tests/test-threadmap.c  |   0
 tools/{perf/lib => lib/perf}/threadmap.c           |   0
 tools/{perf/lib => lib/perf}/xyarray.c             |   0
 tools/lib/string.c                                 |   7 +
 tools/perf/Documentation/perf-sched.txt            |   4 +
 tools/perf/MANIFEST                                |   1 +
 tools/perf/Makefile.config                         |   2 +-
 tools/perf/Makefile.perf                           |   2 +-
 tools/perf/builtin-c2c.c                           |   4 +-
 tools/perf/builtin-record.c                        |  28 ++-
 tools/perf/builtin-sched.c                         |  13 +
 tools/perf/lib/Documentation/Makefile              |   7 -
 tools/perf/lib/Documentation/man/libperf.rst       | 100 --------
 tools/perf/lib/Documentation/tutorial/tutorial.rst | 123 ---------
 tools/perf/tests/bp_signal.c                       |  10 +-
 tools/perf/ui/browsers/hists.c                     | 277 ++++++++++++++-------
 tools/perf/ui/browsers/hists.h                     |   2 +-
 tools/perf/ui/browsers/res_sample.c                |   2 +-
 tools/perf/ui/browsers/scripts.c                   |   2 +-
 tools/perf/ui/tui/util.c                           |  12 +-
 tools/perf/ui/util.h                               |   2 +-
 tools/perf/util/mmap.c                             |  40 ++-
 tools/perf/util/mmap.h                             |  13 +-
 tools/perf/util/sort.c                             |   3 +-
 tools/perf/util/sort.h                             |   2 +
 70 files changed, 1565 insertions(+), 352 deletions(-)
 rename tools/{perf/lib => lib/perf}/Build (100%)
 create mode 100644 tools/lib/perf/Documentation/Makefile
 create mode 100644 tools/lib/perf/Documentation/asciidoc.conf
 create mode 100644 tools/lib/perf/Documentation/examples/sampling.c
 create mode 100644 tools/lib/perf/Documentation/libperf-counting.txt
 create mode 100644 tools/lib/perf/Documentation/libperf-sampling.txt
 create mode 100644 tools/lib/perf/Documentation/libperf.txt
 create mode 100644 tools/lib/perf/Documentation/manpage-1.72.xsl
 create mode 100644 tools/lib/perf/Documentation/manpage-base.xsl
 create mode 100644 tools/lib/perf/Documentation/manpage-bold-literal.xsl
 create mode 100644 tools/lib/perf/Documentation/manpage-normal.xsl
 create mode 100644 tools/lib/perf/Documentation/manpage-suppress-sp.xsl
 rename tools/{perf/lib => lib/perf}/Makefile (96%)
 rename tools/{perf/lib => lib/perf}/core.c (100%)
 rename tools/{perf/lib => lib/perf}/cpumap.c (100%)
 rename tools/{perf/lib => lib/perf}/evlist.c (100%)
 rename tools/{perf/lib => lib/perf}/evsel.c (100%)
 rename tools/{perf/lib => lib/perf}/include/internal/cpumap.h (100%)
 rename tools/{perf/lib => lib/perf}/include/internal/evlist.h (100%)
 rename tools/{perf/lib => lib/perf}/include/internal/evsel.h (100%)
 rename tools/{perf/lib => lib/perf}/include/internal/lib.h (100%)
 rename tools/{perf/lib => lib/perf}/include/internal/mmap.h (100%)
 rename tools/{perf/lib => lib/perf}/include/internal/tests.h (100%)
 rename tools/{perf/lib => lib/perf}/include/internal/threadmap.h (100%)
 rename tools/{perf/lib => lib/perf}/include/internal/xyarray.h (100%)
 rename tools/{perf/lib => lib/perf}/include/perf/core.h (100%)
 rename tools/{perf/lib => lib/perf}/include/perf/cpumap.h (100%)
 rename tools/{perf/lib => lib/perf}/include/perf/event.h (100%)
 rename tools/{perf/lib => lib/perf}/include/perf/evlist.h (100%)
 rename tools/{perf/lib => lib/perf}/include/perf/evsel.h (100%)
 rename tools/{perf/lib => lib/perf}/include/perf/mmap.h (100%)
 rename tools/{perf/lib => lib/perf}/include/perf/threadmap.h (100%)
 rename tools/{perf/lib => lib/perf}/internal.h (100%)
 rename tools/{perf/lib => lib/perf}/lib.c (100%)
 rename tools/{perf/lib => lib/perf}/libperf.map (100%)
 rename tools/{perf/lib => lib/perf}/libperf.pc.template (100%)
 rename tools/{perf/lib => lib/perf}/mmap.c (100%)
 rename tools/{perf/lib => lib/perf}/tests/Makefile (93%)
 rename tools/{perf/lib => lib/perf}/tests/test-cpumap.c (100%)
 rename tools/{perf/lib => lib/perf}/tests/test-evlist.c (100%)
 rename tools/{perf/lib => lib/perf}/tests/test-evsel.c (100%)
 rename tools/{perf/lib => lib/perf}/tests/test-threadmap.c (100%)
 rename tools/{perf/lib => lib/perf}/threadmap.c (100%)
 rename tools/{perf/lib => lib/perf}/xyarray.c (100%)
 delete mode 100644 tools/perf/lib/Documentation/Makefile
 delete mode 100644 tools/perf/lib/Documentation/man/libperf.rst
 delete mode 100644 tools/perf/lib/Documentation/tutorial/tutorial.rst

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

Clearlinux is failing when due to:

  `.gnu.debuglto_.debug_macro' referenced in section `.gnu.debuglto_.debug_macro' of /tmp/build/perf/util/scripting-engines/perf-in.o: defined in discarded section `.gnu.debuglto_.debug_macro[wm4.stdcpredef.h.19.8dc41bed5d9037ff9622e015fb5f0ce3]' of /tmp/build/perf/util/scripting-engines/perf-in.o

OpenMandriva Cooker works well with gcc, uncovers a bug where we have to
get compiler-clang.h from the kernel sources, will be fixed soon.

With the update of linux/linkage.h to move from ENTRY()/ENDPROC() to
SYM_FUNC_START()/etc some of the older containers can't be used with clang,
as the minimum version for the constructs used in the new linkage.h is 3.5,
older versions (3.4, 3.4.2, etc) end up with:

  bench/../../arch/x86/lib/memcpy_64.S:44:14: error: unexpected token in '.type' directive
  .type MEMCPY STT_FUNC ; .size MEMCPY, .-MEMCPY
               ^

  # export PERF_TARBALL=http://192.168.124.1/perf/perf-5.5.0-rc3.tar.xz
  # dm 
   1 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0, clang version 3.8.0 (tags/RELEASE_380/final)
   2 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822, clang version 3.8.1 (tags/RELEASE_381/final)
   3 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0, clang version 4.0.0 (tags/RELEASE_400/final)
   4 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
   5 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
   6 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
   7 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
   8 alpine:3.11                   : Ok   gcc (Alpine 9.2.0) 9.2.0, Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
   9 alpine:edge                   : Ok   gcc (Alpine 9.2.0) 9.2.0, Alpine clang version 9.0.0 (git://git.alpinelinux.org/aports 25c73ae7b95bdb42ae5f0ceac3b703e766582527) (based on LLVM 9.0.0)
  10 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1), clang version 3.8.0 (tags/RELEASE_380/final)
  11 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.3.1 20190507 (ALT p9 8.3.1-alt5), clang version 7.0.1 
  12 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 9.2.1 20190827 (ALT Sisyphus 9.2.1-alt2), clang version 7.0.1 
  13 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2), clang version 3.6.2 (tags/RELEASE_362/final)
  14 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6), clang version 7.0.1 (Amazon Linux 2 7.0.1-1.amzn2.0.2)
  15 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  16 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  17 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  18 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
  19 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-39)
  20 centos:8                      : Ok   gcc (GCC) 8.2.1 20180905 (Red Hat 8.2.1-3), clang version 7.0.1 (tags/RELEASE_701/final)
  21 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 9.2.1 20191210 gcc-9-branch@279166, clang version 9.0.0 (tags/RELEASE_900/final)
  22 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2, Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (based on LLVM 3.5.0)
  23 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516, clang version 3.8.1-24 (tags/RELEASE_381/final)
  24 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0, clang version 7.0.1-8 (tags/RELEASE_701/final)
  25 debian:experimental           : Ok   gcc (Debian 9.2.1-19) 9.2.1 20191109, clang version 8.0.1-4 (tags/RELEASE_801/final)
  26 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.3.0-19) 8.3.0
  27 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 8.3.0-19) 8.3.0
  28 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 9.2.1-8) 9.2.1 20190909
  29 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 9.2.1-8) 9.2.1 20190909
  30 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  31 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6), clang version 3.5.0 (tags/RELEASE_350/final)
  32 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6), clang version 3.7.0 (tags/RELEASE_370/final)
  33 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1), clang version 3.8.1 (tags/RELEASE_381/final)
  34 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  35 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1), clang version 3.9.1 (tags/RELEASE_391/final)
  36 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2), clang version 4.0.1 (tags/RELEASE_401/final)
  37 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6), clang version 5.0.2 (tags/RELEASE_502/final)
  38 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2), clang version 6.0.1 (tags/RELEASE_601/final)
  39 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2), clang version 7.0.1 (Fedora 7.0.1-6.fc29)
  40 fedora:30                     : Ok   gcc (GCC) 9.2.1 20190827 (Red Hat 9.2.1-1), clang version 8.0.0 (Fedora 8.0.0-3.fc30)
  41 fedora:30-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225
  42 fedora:30-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225
  43 fedora:31                     : Ok   gcc (GCC) 9.2.1 20190827 (Red Hat 9.2.1-1), clang version 9.0.0 (Fedora 9.0.0-1.fc31)
  44 fedora:32                     : Ok   gcc (GCC) 9.2.1 20190827 (Red Hat 9.2.1-1), clang version 9.0.0 (Fedora 9.0.0-1.fc32)
  45 fedora:rawhide                : Ok   gcc (GCC) 9.2.1 20190827 (Red Hat 9.2.1-1), clang version 9.0.0 (Fedora 9.0.0-1.fc32)
  46 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 9.2.0-r2 p3) 9.2.0
  47 mageia:5                      : Ok   gcc (GCC) 4.9.2, clang version 3.5.2 (tags/RELEASE_352/final)
  48 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0, clang version 3.9.1 (tags/RELEASE_391/final)
  49 mageia:7                      : Ok   gcc (Mageia 8.3.1-0.20190524.1.mga7) 8.3.1 20190524, clang version 8.0.0 (Mageia 8.0.0-1.mga7)
  50 manjaro:latest                : Ok   gcc (GCC) 9.2.0, clang version 9.0.0 (tags/RELEASE_900/final)
  51 openmandriva:cooker           : Ok   gcc (GCC) 9.2.1 20191123 (OpenMandriva)
  52 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190424 [gcc-7-branch revision 270538], clang version 5.0.1 (tags/RELEASE_501/final 312548)
  53 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407], clang version 7.0.1 (tags/RELEASE_701/final 349238)
  54 opensuse:15.2                 : Ok   gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407], clang version 7.0.1 (tags/RELEASE_701/final 349238)
  55 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5, clang version 3.8.0 (tags/RELEASE_380/final 262553)
  56 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 9.2.1 20190903 [gcc-9-branch revision 275330], clang version 9.0.0 (tags/RELEASE_900/final 372316)
  57 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
  58 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-39.0.3)
  59 oraclelinux:8                 : Ok   gcc (GCC) 8.2.1 20180905 (Red Hat 8.2.1-3.0.1), clang version 7.0.1 (tags/RELEASE_701/final)
  60 ubuntu:12.04                  : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3, Ubuntu clang version 3.0-6ubuntu3 (tags/RELEASE_30/final) (based on LLVM 3.0)
  61 ubuntu:14.04                  : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.4) 4.8.4
  62 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609, clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
  63 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  64 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  65 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  66 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  67 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  68 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  69 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0, clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
  70 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04.1) 7.4.0
  71 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04.1) 7.4.0
  72 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  73 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  74 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  75 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  76 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  77 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  78 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  79 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  80 ubuntu:18.10                  : Ok   gcc (Ubuntu 8.3.0-6ubuntu1~18.10.1) 8.3.0, clang version 7.0.0-3 (tags/RELEASE_700/final)
  81 ubuntu:19.04                  : Ok   gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0, clang version 8.0.0-3 (tags/RELEASE_800/final)
  82 ubuntu:19.04-x-alpha          : Ok   alpha-linux-gnu-gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
  83 ubuntu:19.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 8.3.0-6ubuntu1) 8.3.0
  84 ubuntu:19.04-x-hppa           : Ok   hppa-linux-gnu-gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
  85 ubuntu:19.10                  : Ok   gcc (Ubuntu 9.2.1-9ubuntu2) 9.2.1 20191008, clang version 9.0.0-2 (tags/RELEASE_900/final)
  #

  # uname -a
  Linux quaco 5.5.0-rc4+ #2 SMP Thu Jan 2 11:17:21 -03 2020 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  6c4798d3f08b tools lib: Fix builds when glibc contains strlcpy()
  # perf version --build-options
  perf version 5.5.rc3.g6c4798d3f08b
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
                     aio: [ on  ]  # HAVE_AIO_SUPPORT
                    zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
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
  31: Share thread maps                                     : Ok
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
  52: Merge cpu map                                         : Ok
  53: Probe SDT events                                      : Ok
  54: is_printable_array                                    : Ok
  55: Print bitmap                                          : Ok
  56: perf hooks                                            : Ok
  57: builtin clang support                                 : Skip (not compiled in)
  58: unit_number__scnprintf                                : Ok
  59: mem2node                                              : Ok
  60: time utils                                            : Ok
  61: Test jit_write_elf                                    : Ok
  62: maps__merge_in                                        : Ok
  63: x86 rdpmc                                             : Ok
  64: Convert perf time to TSC                              : Ok
  65: DWARF unwind                                          : Ok
  66: x86 instruction decoder - new instructions            : Ok
  67: Intel PT packet decoder                               : Ok
  68: x86 bp modify                                         : Ok
  69: probe libc's inet_pton & backtrace it with ping       : Ok
  70: Use vfs_getname probe to get syscall args filenames   : Ok
  71: Add vfs_getname probe to get syscall args filenames   : Ok
  72: Check open filename arg using perf trace + vfs_getname: Ok
  73: Zstd perf.data compression/decompression              : Ok

  $ time make -C tools/perf build-test 
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
       make_util_pmu_bison_o_O: make util/pmu-bison.o
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1
                    make_doc_O: make doc
           make_no_libbionic_O: make NO_LIBBIONIC=1
              make_no_libbpf_O: make NO_LIBBPF=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
                 make_cscope_O: make cscope
              make_clean_all_O: make clean all
            make_install_bin_O: make install-bin
           make_no_libpython_O: make NO_LIBPYTHON=1
                 make_static_O: make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1
             make_util_map_o_O: make util/map.o
                 make_perf_o_O: make perf.o
        make_with_babeltrace_O: make LIBBABELTRACE=1
                make_no_newt_O: make NO_NEWT=1
                  make_debug_O: make DEBUG=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
           make_no_backtrace_O: make NO_BACKTRACE=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
                make_install_O: make install
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
                   make_help_O: make help
             make_no_libnuma_O: make NO_LIBNUMA=1
               make_no_slang_O: make NO_SLANG=1
            make_no_demangle_O: make NO_DEMANGLE=1
             make_no_libperl_O: make NO_LIBPERL=1
                make_no_gtk2_O: make NO_GTK2=1
                   make_tags_O: make tags
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
                   make_pure_O: make
              make_no_libelf_O: make NO_LIBELF=1
         make_install_prefix_O: make install prefix=/tmp/krava
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
