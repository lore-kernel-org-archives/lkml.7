Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D29C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0622F206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbfGZOV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:21:28 -0400
Received: from ms.lwn.net ([45.79.88.28]:50366 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbfGZOV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:21:27 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7FD822B7;
        Fri, 26 Jul 2019 14:21:26 +0000 (UTC)
Date:   Fri, 26 Jul 2019 08:21:25 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [GIT PULL] Documentation fixes for 5.3
Message-ID: <20190726082125.0c8467e9@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit
5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.3-1

for you to fetch changes up to d2eba640a4b96bc1bdc0f4a500b8b8d5e16725c8:

  docs: phy: Drop duplicate 'be made' (2019-07-26 08:15:26 -0600)

----------------------------------------------------------------
This is mostly a set of follow-on fixes from Mauro fixing various fallout
from the massive RST conversion; a few other small fixes as well.

----------------------------------------------------------------
Federico Vaga (3):
      doc:it_IT: align translation to mainline
      doc:it_IT: rephrase statement
      doc:it_IT: translations in process/

Guido Günther (1):
      docs: phy: Drop duplicate 'be made'

Jeremy Cline (1):
      docs/vm: transhuge: fix typo in madvise reference

Jonathan Corbet (2):
      Merge tag 'v5.3-rc1' into docs-next
      Merge branch 'pdf_fixes_v1' of https://git.linuxtv.org/mchehab/experimental into mauro

Marcus Folkesson (1):
      docs: driver-api: generic-counter: fix file path to ABI doc

Mauro Carvalho Chehab (15):
      docs: powerpc: convert docs to ReST and rename to *.rst
      docs: power: add it to to the main documentation index
      docs: fix broken doc references due to renames
      docs: pdf: add all Documentation/*/index.rst to PDF output
      docs: conf.py: add CJK package needed by translations
      docs: conf.py: only use CJK if the font is available
      scripts/sphinx-pre-install: fix script for RHEL/CentOS
      scripts/sphinx-pre-install: don't use LaTeX with CentOS 7
      scripts/sphinx-pre-install: fix latexmk dependencies
      scripts/sphinx-pre-install: cleanup Gentoo checks
      scripts/sphinx-pre-install: seek for Noto CJK fonts for pdf output
      docs: load_config.py: avoid needing a conf.py just due to LaTeX docs
      docs: remove extra conf.py files
      docs: virtual: add it to the documentation body
      docs: load_config.py: ensure subdirs end with "/"

 Documentation/PCI/pci-error-recovery.rst           |   5 +-
 Documentation/RCU/rculist_nulls.txt                |   2 +-
 Documentation/admin-guide/conf.py                  |  10 --
 Documentation/admin-guide/mm/transhuge.rst         |   2 +-
 Documentation/conf.py                              |  30 +++-
 Documentation/core-api/conf.py                     |  10 --
 Documentation/crypto/conf.py                       |  10 --
 Documentation/dev-tools/conf.py                    |  10 --
 .../devicetree/bindings/arm/idle-states.txt        |   2 +-
 Documentation/doc-guide/conf.py                    |  10 --
 Documentation/driver-api/80211/conf.py             |  10 --
 Documentation/driver-api/conf.py                   |  10 --
 Documentation/driver-api/generic-counter.rst       |   4 +-
 Documentation/driver-api/phy/phy.rst               |   4 +-
 Documentation/driver-api/pm/conf.py                |  10 --
 Documentation/filesystems/conf.py                  |  10 --
 Documentation/gpu/conf.py                          |  10 --
 Documentation/index.rst                            |   3 +
 Documentation/input/conf.py                        |  10 --
 Documentation/kernel-hacking/conf.py               |  10 --
 Documentation/locking/spinlocks.rst                |   4 +-
 Documentation/maintainer/conf.py                   |  10 --
 Documentation/media/conf.py                        |  12 --
 Documentation/memory-barriers.txt                  |   2 +-
 Documentation/networking/conf.py                   |  10 --
 Documentation/power/index.rst                      |   2 +-
 .../powerpc/{bootwrapper.txt => bootwrapper.rst}   |  28 +++-
 .../powerpc/{cpu_families.txt => cpu_families.rst} |  23 +--
 .../powerpc/{cpu_features.txt => cpu_features.rst} |   6 +-
 Documentation/powerpc/{cxl.txt => cxl.rst}         |  46 ++++--
 .../powerpc/{cxlflash.txt => cxlflash.rst}         |  10 +-
 .../powerpc/{DAWR-POWER9.txt => dawr-power9.rst}   |  15 +-
 Documentation/powerpc/{dscr.txt => dscr.rst}       |  18 ++-
 ...ror-recovery.txt => eeh-pci-error-recovery.rst} | 108 +++++++-------
 ...ssisted-dump.txt => firmware-assisted-dump.rst} | 117 +++++++++-------
 Documentation/powerpc/{hvcs.txt => hvcs.rst}       | 108 +++++++-------
 Documentation/powerpc/index.rst                    |  34 +++++
 Documentation/powerpc/isa-versions.rst             |  15 +-
 Documentation/powerpc/{mpc52xx.txt => mpc52xx.rst} |  12 +-
 ...powernv.txt => pci_iov_resource_on_powernv.rst} |  15 +-
 Documentation/powerpc/{pmu-ebb.txt => pmu-ebb.rst} |   1 +
 Documentation/powerpc/ptrace.rst                   | 156 +++++++++++++++++++++
 Documentation/powerpc/ptrace.txt                   | 151 --------------------
 .../powerpc/{qe_firmware.txt => qe_firmware.rst}   |  37 ++---
 .../{syscall64-abi.txt => syscall64-abi.rst}       |  29 ++--
 ...ctional_memory.txt => transactional_memory.rst} |  45 +++---
 Documentation/process/conf.py                      |  10 --
 Documentation/sh/conf.py                           |  10 --
 Documentation/sound/conf.py                        |  10 --
 Documentation/sphinx/load_config.py                |  27 +++-
 .../translations/it_IT/doc-guide/sphinx.rst        |  19 +--
 Documentation/translations/it_IT/process/index.rst |   1 +
 .../translations/it_IT/process/kernel-docs.rst     |  11 +-
 .../it_IT/process/maintainer-pgp-guide.rst         |  25 ++--
 .../it_IT/process/programming-language.rst         |  51 +++++++
 .../translations/ko_KR/memory-barriers.txt         |   2 +-
 Documentation/userspace-api/conf.py                |  10 --
 Documentation/virtual/kvm/index.rst                |   1 +
 Documentation/vm/conf.py                           |  10 --
 Documentation/watchdog/hpwdt.rst                   |   2 +-
 Documentation/x86/conf.py                          |  10 --
 MAINTAINERS                                        |  14 +-
 arch/powerpc/kernel/exceptions-64s.S               |   2 +-
 drivers/gpu/drm/drm_modes.c                        |   2 +-
 drivers/i2c/busses/i2c-nvidia-gpu.c                |   2 +-
 drivers/scsi/hpsa.c                                |   4 +-
 drivers/soc/fsl/qe/qe.c                            |   2 +-
 drivers/tty/hvc/hvcs.c                             |   2 +-
 include/soc/fsl/qe/qe.h                            |   2 +-
 scripts/sphinx-pre-install                         | 118 +++++++++++++---
 70 files changed, 830 insertions(+), 703 deletions(-)
 delete mode 100644 Documentation/admin-guide/conf.py
 delete mode 100644 Documentation/core-api/conf.py
 delete mode 100644 Documentation/crypto/conf.py
 delete mode 100644 Documentation/dev-tools/conf.py
 delete mode 100644 Documentation/doc-guide/conf.py
 delete mode 100644 Documentation/driver-api/80211/conf.py
 delete mode 100644 Documentation/driver-api/conf.py
 delete mode 100644 Documentation/driver-api/pm/conf.py
 delete mode 100644 Documentation/filesystems/conf.py
 delete mode 100644 Documentation/gpu/conf.py
 delete mode 100644 Documentation/input/conf.py
 delete mode 100644 Documentation/kernel-hacking/conf.py
 delete mode 100644 Documentation/maintainer/conf.py
 delete mode 100644 Documentation/media/conf.py
 delete mode 100644 Documentation/networking/conf.py
 rename Documentation/powerpc/{bootwrapper.txt => bootwrapper.rst} (93%)
 rename Documentation/powerpc/{cpu_families.txt => cpu_families.rst} (95%)
 rename Documentation/powerpc/{cpu_features.txt => cpu_features.rst} (97%)
 rename Documentation/powerpc/{cxl.txt => cxl.rst} (95%)
 rename Documentation/powerpc/{cxlflash.txt => cxlflash.rst} (98%)
 rename Documentation/powerpc/{DAWR-POWER9.txt => dawr-power9.rst} (95%)
 rename Documentation/powerpc/{dscr.txt => dscr.rst} (91%)
 rename Documentation/powerpc/{eeh-pci-error-recovery.txt => eeh-pci-error-recovery.rst} (82%)
 rename Documentation/powerpc/{firmware-assisted-dump.txt => firmware-assisted-dump.rst} (80%)
 rename Documentation/powerpc/{hvcs.txt => hvcs.rst} (91%)
 create mode 100644 Documentation/powerpc/index.rst
 rename Documentation/powerpc/{mpc52xx.txt => mpc52xx.rst} (91%)
 rename Documentation/powerpc/{pci_iov_resource_on_powernv.txt => pci_iov_resource_on_powernv.rst} (97%)
 rename Documentation/powerpc/{pmu-ebb.txt => pmu-ebb.rst} (99%)
 create mode 100644 Documentation/powerpc/ptrace.rst
 delete mode 100644 Documentation/powerpc/ptrace.txt
 rename Documentation/powerpc/{qe_firmware.txt => qe_firmware.rst} (95%)
 rename Documentation/powerpc/{syscall64-abi.txt => syscall64-abi.rst} (82%)
 rename Documentation/powerpc/{transactional_memory.txt => transactional_memory.rst} (93%)
 delete mode 100644 Documentation/process/conf.py
 delete mode 100644 Documentation/sh/conf.py
 delete mode 100644 Documentation/sound/conf.py
 create mode 100644 Documentation/translations/it_IT/process/programming-language.rst
 delete mode 100644 Documentation/userspace-api/conf.py
 delete mode 100644 Documentation/vm/conf.py
 delete mode 100644 Documentation/x86/conf.py
