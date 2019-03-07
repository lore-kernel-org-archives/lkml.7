Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5424C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F7220840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfCGWSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 17:18:22 -0500
Received: from ms.lwn.net ([45.79.88.28]:37086 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbfCGWSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 17:18:22 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4373A2D9;
        Thu,  7 Mar 2019 22:18:21 +0000 (UTC)
Date:   Thu, 7 Mar 2019 15:18:20 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation for 5.1
Message-ID: <20190307151820.1fdd73b7@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit
0358affb5cd8bbd685a6ab163a36dd28a818da73:

  Documentation: change linux-4.x references to 5.x (2019-02-17 15:41:05 -0700)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.1

for you to fetch changes up to 4064174becc09a5a2385a27c8a6fd40888b0e13c:

  docs: Bring some order to filesystem documentation (2019-03-06 09:46:10 -0700)

----------------------------------------------------------------
A fairly routine cycle for docs - lots of typo fixes, some new documents,
and more translations.  There's also some LICENSES adjustments from
Thomas.
----------------------------------------------------------------
Adam Borowski (1):
      doc: process: GPL -> GPL-compatible

Alexey Budankov (4):
      perf-security: document perf_events/Perf resource control
      perf-security: document collected perf_events/Perf data categories
      perf-security: elaborate on perf_events/Perf privileged users
      perf-security: wrap paragraphs on 72 columns

Aurélien Cedeyn (1):
      scripts/spdxcheck.py: fix C++ comment style detection

Bart Van Assche (1):
      Documentation/CodingStyle: Use directory-local variables for emacs settings

Chengguang Xu (1):
      doc: fix typo in Documentation/hwmon/f71882fg

Christian Brauner (2):
      Documentation/filesystems: add binderfs
      samples: add binderfs sample program

Christoph Hellwig (1):
      Documentation/DMA-ISA-LPC: fix an incorrect reference

Corentin Labbe (1):
      Documentation: DMA-API: fix two typos

Federico Vaga (10):
      doc:it_IT: translation for process/submitting-patches
      doc:process: remove note from 'stable api nonsense'
      doc:it_IT: documentation alignment
      doc:process: add missing internal link in stable-kernel-rules
      doc:it_IT: update coding-style - expectations around bool
      doc:it_IT: add translations in process/
      doc:dmaengine: clarify DMA desc. pointer after submission
      doc: translations: sync translations 'remove info about -git patches'
      doc: process: complete removal of info about -git patches
      doc: fix typos in license-rules.rst

Frank Rowand (3):
      docs: kernel-doc: update commands to generate man page
      docs: kernel-doc: typo "documentaion"
      docs: kernel-doc: typo "if ... if" -> "if ... is"

Geert Uytterhoeven (2):
      doc: rcu: Suspicious RCU usage is a warning
      Documentation/locking/lockdep: Drop last two chars of sample states

George Sofianos (1):
      Docs: Correct /proc/stat path

Greg Kroah-Hartman (1):
      stable-kernel-rules.rst: add link to networking patch queue

Jason Gunthorpe (1):
      coding-style: Clarify the expectations around bool

Jeremy Linton (1):
      Documentation: Document arm64 kpti control

Joel Nider (1):
      docs-rst: doc-guide: Minor grammar fixes

Jonathan Corbet (5):
      Merge branch 'thorsten' into docs-next
      docs: don't try to get comments from rcupdate_wait.h or rcutree.h
      kernel-doc: suppress 'not described' warnings for embedded struct fields
      Merge branch 'docs-5.0-fix' into docs-next
      docs: Bring some order to filesystem documentation

Jonathan Neuschäfer (2):
      doc: Change LXR references to elixir.bootlin.com
      docs: process: Remove outdated info about -git patches

Kamalesh Babulal (1):
      static_keys.txt: Fix trivial spelling mistake

Kees Cook (2):
      doc: sctp: Merge and clean up rst files
      doc: security: Add kern-doc for lsm_hooks.h

Laurent Gauthier (1):
      doc: fault-injection: fix macro name in example

Mike Rapoport (2):
      docs/core-api: memory-allocation: add mention of kmem_cache_create_userspace
      docs/core-api/mm: fix GFP combinations section name

Nicholas Mc Guire (1):
      sysfs.txt: add note on available attribute macros

Otto Sabart (6):
      doc: networking: prepare offload documents for conversion into RST
      doc: networking: convert offload files into RST and update references
      doc: networking: shorten the main title in offloads documents
      doc: networking: add offload documents into main index file
      doc: networking: integrate scaling document into doc tree
      doc: kernel-parameters.txt: fix documentation of elevator parameter

Randy Dunlap (5):
      Documentation/filesystems: fix title underline lengths in path-lookup.rst
      Documentation: fix coding-style.rst Sphinx warning
      Documentation: add ibmvmc to toctree(index) and fix warnings
      Documentation: fix lg-laptop.rst warnings
      Documentation: fix admin-guide/README.rst minimum gcc version requirement

Sean Christopherson (1):
      docs: Explicitly state that the 'Fixes:' tag shouldn't split lines

Sebastian Andrzej Siewior (1):
      Documentation/dev-tools: Use gcc version number instead svn revision number

SeongJae Park (5):
      Documentation/kr: Update Korean translation to delete reference to the kernel-mentors mailing list
      Documentation/process/howto/kr: Update Korean translation to remove outdated info about bugzilla mailing lists
      Documentation/process/howto.rst/kokr: Update Korean translation to add a missing cross-reference
      docs/kokr: Update Korean translation to tidy up TOCs and refs to license-rules.rst
      doc:process:kokr: Update Korean translation to add links where missing

Thomas Gleixner (3):
      LICENSES: Add GCC runtime library exception text
      scripts/spdxcheck.py: Handle special quotation mark comments
      module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity

Thorsten Leemhuis (2):
      tools: add a kernel-chktaint to tools/debugging
      docs: Revamp tainted-kernels.rst to make it more comprehensible

Tobin C. Harding (3):
      docs: Fix SLUB docs typo
      docs: Add missing colon
      docs: Use underscore not hyphen in label

Tomasz Duszynski (1):
      docs: driver-api: iio: fix errors in documentation

Vincent Whitchurch (1):
      Documentation/sysctl/vm.txt: Fix drop_caches bit number

Yang Shi (1):
      doc: memcontrol: fix the obsolete content about force empty

Zenghui Yu (1):
      Documentation/process/howto: Update for 4.x -> 5.x versioning

 Documentation/DMA-API.txt                          |   6 +-
 Documentation/DMA-ISA-LPC.txt                      |   4 +-
 Documentation/RCU/lockdep-splat.txt                |  12 +-
 Documentation/admin-guide/README.rst               |   2 +-
 Documentation/admin-guide/kernel-parameters.txt    |  13 +-
 Documentation/admin-guide/perf-security.rst        | 253 ++++--
 Documentation/admin-guide/tainted-kernels.rst      | 159 +++-
 Documentation/cgroup-v1/memory.txt                 |   7 +-
 Documentation/core-api/kernel-api.rst              |   4 -
 Documentation/core-api/memory-allocation.rst       |  10 +-
 Documentation/core-api/mm-api.rst                  |   2 +-
 Documentation/dev-tools/kcov.rst                   |   2 +-
 Documentation/doc-guide/kernel-doc.rst             |  17 +-
 Documentation/doc-guide/sphinx.rst                 |  12 +-
 Documentation/driver-api/dmaengine/client.rst      |   7 +
 Documentation/driver-api/iio/buffers.rst           |   2 +-
 Documentation/driver-api/iio/core.rst              |   6 +-
 Documentation/driver-api/iio/hw-consumer.rst       |   2 +-
 Documentation/driver-api/iio/triggers.rst          |   2 +-
 Documentation/fault-injection/fault-injection.txt  |   2 +-
 Documentation/filesystems/api-summary.rst          | 150 ++++
 Documentation/filesystems/binderfs.rst             |  68 ++
 Documentation/filesystems/index.rst                | 389 +---------
 Documentation/filesystems/journalling.rst          | 184 +++++
 Documentation/filesystems/path-lookup.rst          |  39 +-
 Documentation/filesystems/splice.rst               |  22 +
 Documentation/filesystems/sysfs.txt                |  21 +
 Documentation/hwmon/f71882fg                       |   2 +-
 Documentation/index.rst                            |   1 +
 Documentation/input/devices/xpad.rst               |   2 +-
 Documentation/laptops/lg-laptop.rst                |   4 +-
 Documentation/locking/lockdep-design.txt           |   4 +-
 Documentation/misc-devices/ibmvmc.rst              |   1 +
 Documentation/misc-devices/index.rst               |  17 +
 Documentation/networking/checksum-offloads.rst     | 143 ++++
 Documentation/networking/checksum-offloads.txt     | 122 ---
 Documentation/networking/index.rst                 |   3 +
 .../networking/{scaling.txt => scaling.rst}        | 131 ++--
 ...tion-offloads.txt => segmentation-offloads.rst} |  48 +-
 Documentation/process/coding-style.rst             |  97 ++-
 Documentation/process/howto.rst                    |  59 +-
 Documentation/process/kernel-docs.rst              |   2 +-
 Documentation/process/license-rules.rst            |  66 +-
 Documentation/process/stable-api-nonsense.rst      |  15 +-
 Documentation/process/stable-kernel-rules.rst      |   9 +-
 Documentation/process/submitting-patches.rst       |   6 +-
 Documentation/security/LSM.rst                     |   5 +-
 Documentation/security/{LSM-sctp.rst => SCTP.rst}  | 180 ++++-
 Documentation/security/SELinux-sctp.rst            | 158 ----
 Documentation/security/index.rst                   |   3 +-
 Documentation/static-keys.txt                      |   2 +-
 Documentation/sysctl/kernel.txt                    |  50 +-
 Documentation/sysctl/vm.txt                        |   2 +-
 Documentation/timers/highres.txt                   |   2 +-
 .../translations/it_IT/doc-guide/sphinx.rst        |   2 +
 .../it_IT/process/applying-patches.rst             |  12 +-
 .../translations/it_IT/process/changes.rst         | 487 +++++++++++-
 .../translations/it_IT/process/coding-style.rst    | 103 ++-
 Documentation/translations/it_IT/process/howto.rst |  13 +-
 .../it_IT/process/stable-api-nonsense.rst          | 202 ++++-
 .../it_IT/process/submit-checklist.rst             | 127 ++-
 .../it_IT/process/submitting-drivers.rst           |   8 +-
 .../it_IT/process/submitting-patches.rst           | 862 ++++++++++++++++++++-
 Documentation/translations/ja_JP/howto.rst         |  12 +-
 Documentation/translations/ko_KR/howto.rst         |  56 +-
 Documentation/translations/zh_CN/HOWTO             |   9 -
 Documentation/translations/zh_CN/coding-style.rst  |  57 +-
 Documentation/vm/index.rst                         |   2 +-
 Documentation/vm/slub.rst                          |   4 +-
 LICENSES/exceptions/GCC-exception-2.0              |  18 +
 include/linux/module.h                             |  18 +-
 include/linux/skbuff.h                             |   2 +-
 samples/Kconfig                                    |   7 +
 samples/Makefile                                   |   2 +-
 samples/binderfs/Makefile                          |   1 +
 samples/binderfs/binderfs_example.c                |  83 ++
 scripts/checkpatch.pl                              |  13 -
 scripts/kernel-doc                                 |   2 +-
 scripts/spdxcheck.py                               |   8 +-
 security/selinux/hooks.c                           |   2 +-
 tools/Makefile                                     |  14 +-
 tools/debugging/Makefile                           |  16 +
 tools/debugging/kernel-chktaint                    | 202 +++++
 83 files changed, 3741 insertions(+), 1134 deletions(-)
 create mode 100644 Documentation/filesystems/api-summary.rst
 create mode 100644 Documentation/filesystems/binderfs.rst
 create mode 100644 Documentation/filesystems/journalling.rst
 create mode 100644 Documentation/filesystems/splice.rst
 create mode 100644 Documentation/misc-devices/index.rst
 create mode 100644 Documentation/networking/checksum-offloads.rst
 delete mode 100644 Documentation/networking/checksum-offloads.txt
 rename Documentation/networking/{scaling.txt => scaling.rst} (92%)
 rename Documentation/networking/{segmentation-offloads.txt => segmentation-offloads.rst} (88%)
 rename Documentation/security/{LSM-sctp.rst => SCTP.rst} (52%)
 delete mode 100644 Documentation/security/SELinux-sctp.rst
 create mode 100644 LICENSES/exceptions/GCC-exception-2.0
 create mode 100644 samples/binderfs/Makefile
 create mode 100644 samples/binderfs/binderfs_example.c
 create mode 100644 tools/debugging/Makefile
 create mode 100755 tools/debugging/kernel-chktaint
