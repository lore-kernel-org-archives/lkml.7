Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874FEC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 18:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 517D5216C4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 18:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfEHSEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 14:04:53 -0400
Received: from ms.lwn.net ([45.79.88.28]:54146 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726883AbfEHSEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 14:04:53 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D39302C5;
        Wed,  8 May 2019 18:04:51 +0000 (UTC)
Date:   Wed, 8 May 2019 12:04:50 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: [GIT PULL] Docs for 5.2
Message-ID: <20190508120450.197d4e8e@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit
9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.2

for you to fetch changes up to d9defe448f4c7b88ca2ae636a321ef8970fa718d:

  docs/livepatch: Unify style of livepatch documentation in the ReST format (2019-05-07 16:06:28 -0600)

----------------------------------------------------------------
A reasonably busy cycle for docs, including:

 - Lots of work on the Chinese and Italian translations
 - Some license-rules clarifications from Christoph
 - Various build-script fixes
 - A new document on memory models
 - RST conversion of the live-patching docs
 - The usual collection of typo fixes and corrections.

Expect a trivial conflict in the .mailmap file due to the modification
of two adjacent entries.
----------------------------------------------------------------
Alessia Mantegazza (1):
      doc:it_IT: translation for maintainer-pgp-guide

Alex Shi (93):
      docs/zh_CN: add disclaimer file
      docs/zh_CN: move process related docs into process dir
      docs/zh_CN: change Chinese index to know process dir
      docs/zh_CN: add index file into process dir
      docs/zh_CN: rename HOWTO into process directory
      docs/zh_CN: howto format changes
      docs/zh_CN: rename SubmittingPatches for html links
      docs/zh_CN: format the submitting-patches doc to rst
      docs/zh_CN: rename stable_kernel_rules doc
      docs/zh_CN: rst format change for stable-kernel-rules
      docs/zh_CN: rename email-clients.txt as email-clients.rst
      docs/zh_CN: do rst format for email-clients.rst
      docs/zh_CN: rename volatile-consider-harmful doc
      docs/zh_CN: volatile doc format changes
      docs/zh_CN: rename SubmittingDrivers
      docs/zh_CN: format submitting drivers as rst
      docs/zh_CN: rename magic-numbers as rst doc
      docs/zh_CN: format the magic-number doc as rst
      docs/zh_CN: rename stable_api_nonsense.txt as stable-api-nonsense.rst
      docs/zh_CN: format stable-api-nonsense
      docs/zh_CN: update Li Yang's email address
      mailmap: update Li Yang's email address
      docs/zh_CN: update Zhang Wei's email address
      mailmap: update email address for Triplex
      docs/zh_CN: update TripleX chung's email address
      docs/zh_CN: fix indent issue in stable-api-nonsense file
      docs/zh_CN: fix indent issue in submitting-drivers
      docs/zh_CN: remove zh-kernel.org in MAINTAINERS
      mailmap: update my obsolete email address
      docs/zh_CN: fix rst format issue in submitting-patch
      docs/zh_CN: fix rst format errors in howto.rst
      docs/zh_CN: translate development-process into Chinese
      docs/zh_CN: add disclaimer and translator info in development-process
      docs/zh_CN: link development-process into process index
      docs/zh_CN: add Chinese 1.Intro file
      docs/zh_CN: add disclaimer and translator info into 1.Intro
      docs/zh_CN: add 2.Process.rst for development-process
      docs/zh_CN: add disclaimer and translator info in 2.Process
      docs/zh_CN: translate 3.Early-stage of development process
      docs/zh_CN: add disclaimer/translator info in 3.Early-stage
      docs/zh_CN: add 4.Coding.rst
      docs/zh_CN: add disclaimer and translator info in 4.Coding
      docs/zh_CN: add 5.Posting.rst into development-process
      docs/zh_CN: add disclaimer and translator info in 5.Posting
      docs/zh_CN: add the 6th doc 6.Followthrought.rst
      docs/zh_CN: add disclaimer and translator info in 6.Followthrough
      docs/zh_CN: translate 7.AdvanceTopics.rst
      docs/zh_CN: add disclaimer and translator info in 7.Advancedtopics
      docs/zh_CN: add 8.Conclusion.rst in development-process
      docs/zh_CN: add disclaimer and translator info in 8.Conclusion
      docs/zh_CN: add license-rules Chinese translation
      docs/zh_CN: fix links failure in license-rules
      docs/zh_CN: include Chinese translation header for license-rules
      docs/zh_CN: link the license-rules file into process index
      docs/zh_CN: add submit-checklist file
      docs/zh_CN: add disclaimer and transtlator info in submit-checklist
      docs/zh_CN: link the submit-checklist into process/index
      docs/zh_CN: add CoC doc
      docs/zh_CN: add disclaimer and translator info in CoC
      docs/zh_CN: link the CoC into process/index
      docs/zh_CN: add CoC interpretation
      docs/zh_CN: add disclaim and translator into CoC interp
      docs/zh_CN: link CoC interpretation into index
      docs/zh_CN: fix link issue in howto.rst
      docs/zh_CN: update howto.rst to latest version
      docs/zh_CN: update translator info and comments in howto
      docs/zh_CN: redirect license-rules to Chinese doc
      docs/zh_CN: redirect howto.rst link to Chinese version
      docs/zh_CN: update to latest submitting-patches.rst
      docs/zh_CN: update translator info in submitting-patches
      docs/zh_CN: redirect the submitting-patches to Chinese doc
      docs/zh_CN: redirect submit-checklist
      docs/zh_CN: update co-developed-by info after English version
      docs/zh_CN: add programming-language.rst
      docs/zh_CN: link programming-language into process/index
      docs/zh_CN: add disclaimer and translator info into programming-language
      docs/zh_CN: add git setting in email-clients
      docs/zh_CN: Update mutt setting info in email-clients
      docs/zh_CN: add Alex into translator in email-clients
      docs/zh_CN: redirect the email-clients link to Chinese version
      docs/zh_CN: add management-style.rst in Chinese
      docs/zh_CN: add disclaimer and translator info in management-style
      docs/zh_CN: link management-style into process/index
      docs/zh_CN: redirect management-style to Chinese one
      docs/zh_CN: Cleanup stable-api-nonscense in Chinese
      docs/zh_CN: redirect stable-api-nonsense to Chinese version
      docs/zh_CN: update coding-sytle.rst
      docs/zh_CN: redirect coding-sytle to Chinese version
      docs/zh_CN: correct the disclaimer file
      docs/zh_CN: add Alex Shi as Chinese documentation maintainer
      docs/zh_CN: correct a word in managment-style.
      docs/zh_CN: redirect CoC docs to Chinese version
      docs/zh_CN: fix typos in 1.Intro.rst file

Christoph Hellwig (3):
      docs: Don't reference the ZLib license in license-rules.rst
      LICENSES: Clearly mark dual license only licenses
      LICENSES: Rename other to deprecated

Federico Vaga (6):
      doc: add translation disclaimer
      doc:it_IT: translations for documents in process/
      doc: minor fixes to translation's disclaimer
      doc:it: alignement clarification about sign-off and Co-developed-by
      doc: fix typo in PGP guide
      doc:it_IT: translation alignment

Jakub Wilk (3):
      Documentation: seccomp: fix reST markup
      Documentation: seccomp: unify list indentation
      Documentation: fix core_pattern max length

Joe Perches (1):
      coding-style.rst: Generic alloc functions do not need OOM logging

Joel Stanley (1):
      Documentation: rtc: Correct location of rtctest.c

Jonathan Corbet (1):
      docs: Fix a build error in coding-style.rst

Jonathan Neuschäfer (3):
      docs: core-api: Drop reference to flexible-arrays
      Documentation: soundwire: Ensure that code is inside the code blocks
      Documentation: kernel-docs: Remove entry for vfs.txt

Juergen Gross (1):
      doc: add boot protocol 2.13 description to Documentation/x86/boot.txt

Masahiro Yamada (1):
      dontdiff: update with Kconfig build artifacts

Mauro Carvalho Chehab (15):
      docs: Makefile: use latexmk if available
      docs: scripts/sphinx-pre-install: suggest latexmk for building pdf
      docs: DMA-API-HOWTO: add a missing "="
      docs: atomic_bitops.txt: add a title for this document
      docs: clearing-warn-once.txt: add a title for this document
      docs: ntb.txt: use Sphinx notation for the two ascii figures
      docs: unaligned-memory-access.txt: use a lowercase title
      docs: video-output.txt: convert it to ReST format
      docs: ntb.txt: add blank lines to clean up some Sphinx warnings
      docs: speculation.txt: mark example blocks as such
      docs: trace: fix some Sphinx warnings
      docs: doc-guide: remove the extension from .rst files
      scripts/documentation-file-ref-check: don't parse Next/ dir
      scripts/documentation-file-ref-check: detect broken :doc:`foo`
      docs: livepatch: convert docs to ReST and rename to *.rst

Mike Rapoport (1):
      docs/vm: add documentation of memory models

Petr Mladek (1):
      docs/livepatch: Unify style of livepatch documentation in the ReST format

Ralph Campbell (1):
      docs/vm: Minor editorial changes in the THP and hugetlbfs

Sean Christopherson (2):
      docs: Clarify the usage and sign-off requirements for Co-developed-by
      checkpatch: Warn on improper usage of Co-developed-by

Shuah Khan (1):
      doc: kselftest: Fix KBUILD_OUTPUT usage instructions

Tobin C. Harding (3):
      docs: Fix spelling mistake
      docs: Add colon clearing sphinx warning
      docs: Use reference to link to rst file

Tom Levy (1):
      docs: remove spaces from shell variable assignment

Yang Shi (1):
      doc: mm: migration doesn't use FOLL_SPLIT anymore

 .mailmap                                           |   6 +
 Documentation/ABI/testing/sysfs-kernel-livepatch   |   2 +-
 Documentation/DMA-API-HOWTO.txt                    |   2 +-
 Documentation/Makefile                             |   9 +-
 Documentation/atomic_bitops.txt                    |   6 +-
 Documentation/clearing-warn-once.txt               |   2 +
 Documentation/core-api/index.rst                   |   1 -
 Documentation/dev-tools/kselftest.rst              |  42 +-
 Documentation/doc-guide/index.rst                  |   6 +-
 Documentation/dontdiff                             |   8 +-
 Documentation/driver-api/soundwire/stream.rst      |  16 +-
 .../livepatch/{callbacks.txt => callbacks.rst}     |  45 +-
 ...mulative-patches.txt => cumulative-patches.rst} |  14 +-
 Documentation/livepatch/index.rst                  |  21 +
 .../livepatch/{livepatch.txt => livepatch.rst}     |  62 +-
 ...module-elf-format.txt => module-elf-format.rst} | 353 ++++----
 .../livepatch/{shadow-vars.txt => shadow-vars.rst} |  65 +-
 Documentation/ntb.txt                              |  14 +-
 Documentation/process/5.Posting.rst                |  10 +-
 Documentation/process/coding-style.rst             |   6 +-
 Documentation/process/deprecated.rst               |   2 +
 Documentation/process/howto.rst                    |   2 +-
 Documentation/process/kernel-docs.rst              |  12 -
 Documentation/process/license-rules.rst            |  61 +-
 Documentation/process/maintainer-pgp-guide.rst     |   2 +-
 Documentation/process/submitting-patches.rst       |  46 +-
 Documentation/rtc.txt                              |   2 +-
 Documentation/speculation.txt                      |   8 +-
 Documentation/sysctl/kernel.txt                    |   2 +-
 Documentation/trace/ftrace.rst                     |   1 +
 Documentation/trace/histogram.rst                  |  94 ++-
 Documentation/translations/index.rst               |  40 +
 .../it_IT/core-api/memory-allocation.rst           |  13 +
 .../translations/it_IT/disclaimer-ita.rst          |  13 +-
 .../translations/it_IT/doc-guide/index.rst         |   6 +-
 Documentation/translations/it_IT/index.rst         |  65 +-
 .../translations/it_IT/networking/netdev-FAQ.rst   |  13 +
 .../translations/it_IT/process/5.Posting.rst       |  10 +-
 .../translations/it_IT/process/coding-style.rst    |   8 +-
 .../translations/it_IT/process/deprecated.rst      | 129 +++
 .../it_IT/process/kernel-enforcement-statement.rst | 168 +++-
 .../translations/it_IT/process/license-rules.rst   | 452 ++++++++++
 .../it_IT/process/maintainer-pgp-guide.rst         | 939 ++++++++++++++++++++-
 .../it_IT/process/stable-kernel-rules.rst          | 194 ++++-
 .../it_IT/process/submitting-patches.rst           |  47 +-
 Documentation/translations/ja_JP/SubmittingPatches |   6 +-
 Documentation/translations/zh_CN/SubmittingPatches | 412 ---------
 .../translations/zh_CN/disclaimer-zh_CN.rst        |   9 +
 Documentation/translations/zh_CN/index.rst         |  17 +-
 Documentation/translations/zh_CN/magic-number.txt  | 153 ----
 Documentation/translations/zh_CN/oops-tracing.txt  |   2 +-
 .../translations/zh_CN/process/1.Intro.rst         | 186 ++++
 .../translations/zh_CN/process/2.Process.rst       | 360 ++++++++
 .../translations/zh_CN/process/3.Early-stage.rst   | 161 ++++
 .../translations/zh_CN/process/4.Coding.rst        | 290 +++++++
 .../translations/zh_CN/process/5.Posting.rst       | 240 ++++++
 .../translations/zh_CN/process/6.Followthrough.rst | 145 ++++
 .../zh_CN/process/7.AdvancedTopics.rst             | 124 +++
 .../translations/zh_CN/process/8.Conclusion.rst    |  64 ++
 .../process/code-of-conduct-interpretation.rst     | 108 +++
 .../translations/zh_CN/process/code-of-conduct.rst |  72 ++
 .../zh_CN/{ => process}/coding-style.rst           |  21 +-
 .../zh_CN/process/development-process.rst          |  26 +
 .../email-clients.rst}                             | 104 ++-
 .../zh_CN/{HOWTO => process/howto.rst}             | 265 +++---
 Documentation/translations/zh_CN/process/index.rst |  60 ++
 .../translations/zh_CN/process/license-rules.rst   | 370 ++++++++
 .../translations/zh_CN/process/magic-number.rst    | 151 ++++
 .../zh_CN/process/management-style.rst             | 207 +++++
 .../zh_CN/process/programming-language.rst         |  41 +
 .../stable-api-nonsense.rst}                       |  68 +-
 .../stable-kernel-rules.rst}                       |  34 +-
 .../zh_CN/process/submit-checklist.rst             | 107 +++
 .../submitting-drivers.rst}                        |  36 +-
 .../zh_CN/process/submitting-patches.rst           | 682 +++++++++++++++
 .../volatile-considered-harmful.rst}               |  35 +-
 Documentation/translations/zh_CN/sparse.txt        |   6 +-
 Documentation/unaligned-memory-access.txt          |   2 +-
 Documentation/userspace-api/seccomp_filter.rst     |   8 +-
 Documentation/video-output.txt                     |  52 +-
 Documentation/vm/hugetlbfs_reserv.rst              |  17 +-
 Documentation/vm/index.rst                         |   1 +
 Documentation/vm/memory-model.rst                  | 183 ++++
 Documentation/vm/numa.rst                          |   4 +-
 Documentation/vm/transhuge.rst                     |  81 +-
 Documentation/x86/boot.txt                         |   4 +
 LICENSES/{other => deprecated}/GPL-1.0             |   0
 LICENSES/{other => deprecated}/ISC                 |   0
 LICENSES/{other => deprecated}/Linux-OpenIB        |   0
 LICENSES/{other => deprecated}/X11                 |   0
 LICENSES/{other => dual}/Apache-2.0                |   4 +
 LICENSES/{other => dual}/CDDL-1.0                  |   4 +-
 LICENSES/{other => dual}/MPL-1.1                   |   4 +
 MAINTAINERS                                        |   2 +-
 include/linux/wait.h                               |   2 +-
 scripts/checkpatch.pl                              |  18 +
 scripts/documentation-file-ref-check               |  32 +
 scripts/sphinx-pre-install                         |   1 +
 tools/objtool/Documentation/stack-validation.txt   |   2 +-
 99 files changed, 6606 insertions(+), 1396 deletions(-)
 rename Documentation/livepatch/{callbacks.txt => callbacks.rst} (87%)
 rename Documentation/livepatch/{cumulative-patches.txt => cumulative-patches.rst} (89%)
 create mode 100644 Documentation/livepatch/index.rst
 rename Documentation/livepatch/{livepatch.txt => livepatch.rst} (93%)
 rename Documentation/livepatch/{module-elf-format.txt => module-elf-format.rst} (55%)
 rename Documentation/livepatch/{shadow-vars.txt => shadow-vars.rst} (87%)
 create mode 100644 Documentation/translations/it_IT/core-api/memory-allocation.rst
 create mode 100644 Documentation/translations/it_IT/networking/netdev-FAQ.rst
 create mode 100644 Documentation/translations/it_IT/process/deprecated.rst
 create mode 100644 Documentation/translations/it_IT/process/license-rules.rst
 delete mode 100644 Documentation/translations/zh_CN/SubmittingPatches
 create mode 100644 Documentation/translations/zh_CN/disclaimer-zh_CN.rst
 delete mode 100644 Documentation/translations/zh_CN/magic-number.txt
 create mode 100644 Documentation/translations/zh_CN/process/1.Intro.rst
 create mode 100644 Documentation/translations/zh_CN/process/2.Process.rst
 create mode 100644 Documentation/translations/zh_CN/process/3.Early-stage.rst
 create mode 100644 Documentation/translations/zh_CN/process/4.Coding.rst
 create mode 100644 Documentation/translations/zh_CN/process/5.Posting.rst
 create mode 100644 Documentation/translations/zh_CN/process/6.Followthrough.rst
 create mode 100644 Documentation/translations/zh_CN/process/7.AdvancedTopics.rst
 create mode 100644 Documentation/translations/zh_CN/process/8.Conclusion.rst
 create mode 100644 Documentation/translations/zh_CN/process/code-of-conduct-interpretation.rst
 create mode 100644 Documentation/translations/zh_CN/process/code-of-conduct.rst
 rename Documentation/translations/zh_CN/{ => process}/coding-style.rst (97%)
 create mode 100644 Documentation/translations/zh_CN/process/development-process.rst
 rename Documentation/translations/zh_CN/{email-clients.txt => process/email-clients.rst} (74%)
 rename Documentation/translations/zh_CN/{HOWTO => process/howto.rst} (70%)
 create mode 100644 Documentation/translations/zh_CN/process/index.rst
 create mode 100644 Documentation/translations/zh_CN/process/license-rules.rst
 create mode 100644 Documentation/translations/zh_CN/process/magic-number.rst
 create mode 100644 Documentation/translations/zh_CN/process/management-style.rst
 create mode 100644 Documentation/translations/zh_CN/process/programming-language.rst
 rename Documentation/translations/zh_CN/{stable_api_nonsense.txt => process/stable-api-nonsense.rst} (78%)
 rename Documentation/translations/zh_CN/{stable_kernel_rules.txt => process/stable-kernel-rules.rst} (74%)
 create mode 100644 Documentation/translations/zh_CN/process/submit-checklist.rst
 rename Documentation/translations/zh_CN/{SubmittingDrivers => process/submitting-drivers.rst} (85%)
 create mode 100644 Documentation/translations/zh_CN/process/submitting-patches.rst
 rename Documentation/translations/zh_CN/{volatile-considered-harmful.txt => process/volatile-considered-harmful.rst} (81%)
 create mode 100644 Documentation/vm/memory-model.rst
 rename LICENSES/{other => deprecated}/GPL-1.0 (100%)
 rename LICENSES/{other => deprecated}/ISC (100%)
 rename LICENSES/{other => deprecated}/Linux-OpenIB (100%)
 rename LICENSES/{other => deprecated}/X11 (100%)
 rename LICENSES/{other => dual}/Apache-2.0 (97%)
 rename LICENSES/{other => dual}/CDDL-1.0 (99%)
 rename LICENSES/{other => dual}/MPL-1.1 (99%)
