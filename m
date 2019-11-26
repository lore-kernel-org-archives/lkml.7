Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A94CC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 16:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A7F920722
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 16:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfKZQaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 11:30:06 -0500
Received: from ms.lwn.net ([45.79.88.28]:35984 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbfKZQaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 11:30:05 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CE72F2E7;
        Tue, 26 Nov 2019 16:30:03 +0000 (UTC)
Date:   Tue, 26 Nov 2019 09:30:02 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: [PULL] Documentation for 5.5
Message-ID: <20191126093002.06ece6dd@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit
7d194c2100ad2a6dded545887d02754948ca5241:

  Linux 5.4-rc4 (2019-10-20 15:56:22 -0400)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.5

for you to fetch changes up to 22abcd7569618271cc3609da24bbc0e7541248a4:

  Merge branch 'maintainer-profile' into docs-next (2019-11-25 08:43:28 -0700)

----------------------------------------------------------------
Here's the main documentation changes for 5.5:

 - Various kerneldoc script enhancements.

 - More RST conversions; those are slowing down as we run out of things to
   convert, but we're a ways from done still.

 - Dan's "maintainer profile entry" work landed at last.  Now we just need
   to get maintainers to fill in the profiles...

 - A reworking of the parallel build setup to work better with a variety of
   systems (and to not take over huge systems entirely in particular).

 - The MAINTAINERS file is now converted to RST during the build.
   Hopefully nobody ever tries to print this thing, or they will need to
   load a lot of paper.

 - A script and documentation making it easy for maintainers to add Link:
   tags at commit time.

----------------------------------------------------------------
Adam Zerella (1):
      docs: perf: Add imx-ddr to documentation index

Albert Vaca Cintora (1):
      Updated iostats docs

Andre Azevedo (1):
      Documentation/scheduler: fix links in sched-stats

André Almeida (2):
      kernel-doc: fix processing nested structs with attributes
      kernel-doc: add support for ____cacheline_aligned_in_smp attribute

Brendan Jackman (1):
      docs: security: fix section hyperlink

Bryan Gurney (1):
      dm dust: convert documentation to ReST

Changbin Du (1):
      kernel-doc: rename the kernel-doc directive 'functions' to 'identifiers'

Chester Lin (1):
      riscv-docs: correct the sequence of the magic number 2 since it's little endian

Chris Packham (4):
      docs: ioctl: fix typo
      docs/core-api: memory-allocation: fix typo
      docs/core-api: memory-allocation: remove uses of c:func:
      docs/core-api: memory-allocation: mention size helpers

Christian Kujau (1):
      docs: SafeSetID.rst: Remove spurious '???' characters

Christoph Hellwig (1):
      Documentation: document earlycon without options for more platforms

Dan Williams (3):
      MAINTAINERS: Reclaim the P: tag for Maintainer Entry Profile
      Maintainer Handbook: Maintainer Entry Profile
      libnvdimm, MAINTAINERS: Maintainer Entry Profile

Daniel W. S. Almeida (1):
      Documentation: security: core.rst: fix warnings

Derek Kiernan (1):
      docs: misc: xilinx_sdfec: Actually add documentation

Geert Uytterhoeven (1):
      Documentation: debugfs: Document debugfs helper for unsigned long values

Harald Seiler (1):
      docs: driver-api: Remove reference to sgi-ioc4

Jaskaran Singh (3):
      docs: filesystems: convert autofs.txt to reST
      docs: filesystems: Update code snippets in autofs.rst
      docs: filesystems: Add mount map description in Content

Jeff Layton (1):
      Documentation: atomic_open called with shared lock on non-O_CREAT open

Jeremy Cline (1):
      docs: kmemleak: DEBUG_KMEMLEAK_EARLY_LOG_SIZE changed names

Jeremy MAURO (2):
      scripts/sphinx-pre-install: allow checking for multiple missing files
      scripts/sphinx-pre-install: Add a new path for the debian package "fonts-noto-cjk"

Jon Haslam (1):
      docs: fix memory.low description in cgroup-v2.rst

Jonathan Corbet (16):
      Merge branch 'dump-struct' into docs-next
      docs: No structured comments in kernel/dma/coherent.c
      docs: remove :c:func: from refcount-vs-atomic.rst
      docs: Catch up with the new location of get_user_pages_fast()
      genalloc: Fix a set of docs build warnings
      docs/driver-api: Catch up with dma_buf file-name changes
      docs: Fix "make help" suggestion for SPHINXDIR
      docs: move botching-up-ioctls.rst to the process guide
      docs: Move the user-space ioctl() docs to userspace-api
      docs: remove :c:func: from genalloc.rst
      docs: remove :c:func: from genericirq.rst
      Merge tag 'v5.4-rc4' into docs-next
      Revert "Documentation: admin-guide: add earlycon documentation for RISC-V"
      docs: Add request_irq() documentation
      docs: fix up the maintainer profile document
      Merge branch 'maintainer-profile' into docs-next

Jonathan Neuschäfer (12):
      docs: it_IT: maintainer-pgp-guide: Fix reference to "Nitrokey Pro 2"
      Documentation: networking: device drivers: Remove stray asterisks
      docs: networking: devlink-trap: Fix reference to other document
      docs: networking: phy: Improve phrasing
      docs: admin-guide: Sort the "unordered guides" to avoid merge conflicts
      docs: admin-guide: Move Dell RBU document from driver-api
      docs: admin-guide: dell_rbu: Rework the title
      docs: admin-guide: dell_rbu: Improve formatting and spelling
      docs: driver-api: pti_intel_mid: Enable syntax highlighting for C code block
      docs: i2c: Fix SPDX-License-Identifier syntax
      docs: w1: Fix SPDX-License-Identifier syntax
      scripts/kernel-doc: Add support for named variable macro arguments

Kees Cook (6):
      docs: Use make invocation's -j argument for parallelism
      doc-rst: Reduce CSS padding around Field
      doc-rst: Programmatically render MAINTAINERS into ReST
      docs, parallelism: Fix failure path and add comment
      docs, parallelism: Do not leak blocking mode to other readers
      docs, parallelism: Rearrange how jobserver reservations are made

Konstantin Ryabitsev (1):
      docs: process: Add base-commit trailer usage

Leonard Crestez (1):
      docs: Add initial documentation for devfreq

Linus Walleij (1):
      Documentation: Document how to get links with git am

Louis Taylor (2):
      docs: driver-api: make interconnect title quieter
      scripts/sphinx-pre-install: fix Arch latexmk dependency

Martin Kepplinger (2):
      mailmap: add new email address for Martin Kepplinger
      CREDITS: update email address for Martin Kepplinger

Masami Hiramatsu (1):
      Documentation: Remove bootmem_debug from kernel-parameters.txt

Masanari Iida (2):
      docs: admin-guide: Fix min value of threads-max in kernel.rst
      docs: admin-guide: Remove threads-max auto-tuning

Mauro Carvalho Chehab (3):
      docs: fix some broken references
      bindings: rename links to mason USB2/USB3 DT files
      bindings: MAINTAINERS: fix references to Allwinner LRADC

Mike Leach (4):
      coresight: etm4x: docs: Update ABI doc for new sysfs name scheme.
      coresight: etm4x: docs: Update ABI doc for new sysfs etm4 attributes
      coresight: docs: Create common sub-directory for coresight trace.
      coresight: etm4x: docs: Adds detailed document for programming etm4x.

Miles Chen (1):
      docs: printk-formats: add ptrdiff_t type to printk-formats

Oleksandr Natalenko (1):
      docs: admin-guide: fix printk_ratelimit explanation

Paul Walmsley (1):
      Documentation: admin-guide: add earlycon documentation for RISC-V

SeongJae Park (7):
      docs/memory-barriers.txt/kokr: Rewrite "KERNEL I/O BARRIER EFFECTS" section
      Documentation/kokr: Kill all references to mmiowb()
      docs/memory-barriers.txt/kokr: Fix style, spacing and grammar in I/O section
      docs/memory-barriers.txt/kokr: Update I/O section to be clearer about CPU vs thread
      docs/memory-barriers.txt: Remove remaining references to mmiowb()
      Documentation/translation: Use Korean for Korean translation title
      Documentation/process/howto/kokr: Update for 4.x -> 5.x versioning

Shuah Khan (1):
      scripts/sphinx-pre-install: add how to exit virtualenv usage message

Tom Lendacky (1):
      Documentation/process: Add AMD contact for embargoed hardware issues

 .mailmap                                           |   1 +
 CREDITS                                            |   3 +-
 .../ABI/testing/sysfs-bus-coresight-devices-etm4x  | 183 +++--
 Documentation/Makefile                             |   6 +-
 Documentation/admin-guide/LSM/SafeSetID.rst        |   4 +-
 Documentation/admin-guide/cgroup-v2.rst            |   7 +-
 .../{driver-api => admin-guide}/dell_rbu.rst       |  14 +-
 .../device-mapper/{dm-dust.txt => dm-dust.rst}     | 243 ++++---
 Documentation/admin-guide/device-mapper/index.rst  |   1 +
 Documentation/admin-guide/index.rst                |  65 +-
 Documentation/admin-guide/iostats.rst              |  47 +-
 Documentation/admin-guide/kernel-parameters.txt    |  12 +-
 Documentation/admin-guide/perf/imx-ddr.rst         |  35 +-
 Documentation/admin-guide/perf/index.rst           |   1 +
 Documentation/admin-guide/sysctl/kernel.rst        |  12 +-
 Documentation/conf.py                              |   3 +-
 Documentation/core-api/genalloc.rst                |  26 +-
 Documentation/core-api/genericirq.rst              |  52 +-
 Documentation/core-api/memory-allocation.rst       |  50 +-
 Documentation/core-api/mm-api.rst                  |   2 +-
 Documentation/core-api/printk-formats.rst          |  14 +
 Documentation/core-api/refcount-vs-atomic.rst      |  36 +-
 Documentation/dev-tools/kmemleak.rst               |   2 +-
 .../devicetree/bindings/cpu/cpu-topology.txt       |   2 +-
 .../devicetree/bindings/timer/ingenic,tcu.txt      |   2 +-
 Documentation/doc-guide/kernel-doc.rst             |  29 +-
 Documentation/driver-api/devfreq.rst               |  30 +
 Documentation/driver-api/dma-buf.rst               |   6 +-
 Documentation/driver-api/gpio/driver.rst           |   2 +-
 Documentation/driver-api/index.rst                 |   3 +-
 Documentation/driver-api/infrastructure.rst        |   3 -
 Documentation/driver-api/interconnect.rst          |   2 +-
 Documentation/driver-api/pti_intel_mid.rst         |   4 +-
 .../filesystems/{autofs.txt => autofs.rst}         | 263 +++----
 Documentation/filesystems/debugfs.txt              |  10 +-
 Documentation/filesystems/index.rst                |   1 +
 Documentation/filesystems/locking.rst              |   2 +-
 Documentation/hwmon/inspur-ipsps1.rst              |   2 +-
 Documentation/i2c/busses/index.rst                 |   2 +-
 Documentation/i2c/index.rst                        |   2 +-
 Documentation/index.rst                            |   1 -
 Documentation/maintainer/configure-git.rst         |  30 +
 Documentation/maintainer/index.rst                 |   1 +
 .../maintainer/maintainer-entry-profile.rst        | 102 +++
 Documentation/memory-barriers.txt                  |  11 +-
 Documentation/mips/ingenic-tcu.rst                 |   2 +-
 Documentation/misc-devices/xilinx_sdfec.rst        | 291 ++++++++
 .../networking/device_drivers/intel/e100.rst       |  14 +-
 .../networking/device_drivers/intel/e1000.rst      |  12 +-
 .../networking/device_drivers/intel/e1000e.rst     |  14 +-
 .../networking/device_drivers/intel/fm10k.rst      |  10 +-
 .../networking/device_drivers/intel/i40e.rst       |   8 +-
 .../networking/device_drivers/intel/iavf.rst       |   8 +-
 .../networking/device_drivers/intel/ice.rst        |   6 +-
 .../networking/device_drivers/intel/igb.rst        |  12 +-
 .../networking/device_drivers/intel/igbvf.rst      |   6 +-
 .../networking/device_drivers/intel/ixgbe.rst      |  10 +-
 .../networking/device_drivers/intel/ixgbevf.rst    |   6 +-
 .../networking/device_drivers/mellanox/mlx5.rst    |   2 +-
 .../networking/device_drivers/pensando/ionic.rst   |   6 +-
 Documentation/networking/devlink-trap.rst          |   2 +-
 Documentation/networking/phy.rst                   |   2 +-
 Documentation/nvdimm/maintainer-entry-profile.rst  |  59 ++
 .../{ioctl => process}/botching-up-ioctls.rst      |   2 +-
 .../process/embargoed-hardware-issues.rst          |   2 +-
 Documentation/process/index.rst                    |   2 +
 Documentation/process/maintainers.rst              |   1 +
 Documentation/process/submitting-patches.rst       |  53 +-
 Documentation/riscv/boot-image-header.rst          |   2 +-
 Documentation/scheduler/sched-stats.rst            |   4 +-
 Documentation/security/keys/core.rst               |   2 +-
 Documentation/security/lsm.rst                     |   2 +-
 Documentation/sphinx-static/theme_overrides.css    |  10 +
 Documentation/sphinx/kerneldoc.py                  |  17 +-
 Documentation/sphinx/maintainers_include.py        | 197 +++++
 Documentation/sphinx/parallel-wrapper.sh           |  33 +
 .../trace/{ => coresight}/coresight-cpu-debug.rst  |   0
 .../trace/coresight/coresight-etm4x-reference.rst  | 798 +++++++++++++++++++++
 Documentation/trace/{ => coresight}/coresight.rst  |   2 +-
 Documentation/trace/coresight/index.rst            |   9 +
 Documentation/trace/index.rst                      |   3 +-
 .../it_IT/process/maintainer-pgp-guide.rst         |   2 +-
 Documentation/translations/ko_KR/howto.rst         |  56 +-
 Documentation/translations/ko_KR/index.rst         |   4 +-
 .../translations/ko_KR/memory-barriers.txt         | 227 +++---
 Documentation/userspace-api/index.rst              |   1 +
 Documentation/{ => userspace-api}/ioctl/cdrom.rst  |   0
 Documentation/{ => userspace-api}/ioctl/hdio.rst   |   0
 Documentation/{ => userspace-api}/ioctl/index.rst  |   1 -
 .../{ => userspace-api}/ioctl/ioctl-decoding.rst   |   0
 .../{ => userspace-api}/ioctl/ioctl-number.rst     |   0
 Documentation/w1/index.rst                         |   2 +-
 MAINTAINERS                                        |  88 +--
 drivers/net/ethernet/faraday/ftgmac100.c           |   2 +-
 drivers/net/ethernet/pensando/ionic/ionic_if.h     |   4 +-
 drivers/platform/x86/Kconfig                       |   2 +-
 drivers/platform/x86/dell_rbu.c                    |   2 +-
 fs/cifs/cifsfs.c                                   |   2 +-
 include/linux/interrupt.h                          |  13 +
 lib/genalloc.c                                     |   2 +-
 scripts/jobserver-exec                             |  66 ++
 scripts/kernel-doc                                 |  27 +-
 scripts/sphinx-pre-install                         |  30 +-
 103 files changed, 2627 insertions(+), 842 deletions(-)
 rename Documentation/{driver-api => admin-guide}/dell_rbu.rst (94%)
 rename Documentation/admin-guide/device-mapper/{dm-dust.txt => dm-dust.rst} (51%)
 create mode 100644 Documentation/driver-api/devfreq.rst
 rename Documentation/filesystems/{autofs.txt => autofs.rst} (77%)
 create mode 100644 Documentation/maintainer/maintainer-entry-profile.rst
 create mode 100644 Documentation/misc-devices/xilinx_sdfec.rst
 create mode 100644 Documentation/nvdimm/maintainer-entry-profile.rst
 rename Documentation/{ioctl => process}/botching-up-ioctls.rst (99%)
 create mode 100644 Documentation/process/maintainers.rst
 create mode 100755 Documentation/sphinx/maintainers_include.py
 create mode 100644 Documentation/sphinx/parallel-wrapper.sh
 rename Documentation/trace/{ => coresight}/coresight-cpu-debug.rst (100%)
 create mode 100644 Documentation/trace/coresight/coresight-etm4x-reference.rst
 rename Documentation/trace/{ => coresight}/coresight.rst (99%)
 create mode 100644 Documentation/trace/coresight/index.rst
 rename Documentation/{ => userspace-api}/ioctl/cdrom.rst (100%)
 rename Documentation/{ => userspace-api}/ioctl/hdio.rst (100%)
 rename Documentation/{ => userspace-api}/ioctl/index.rst (86%)
 rename Documentation/{ => userspace-api}/ioctl/ioctl-decoding.rst (100%)
 rename Documentation/{ => userspace-api}/ioctl/ioctl-number.rst (100%)
 create mode 100755 scripts/jobserver-exec
