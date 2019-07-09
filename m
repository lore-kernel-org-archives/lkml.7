Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EC8C73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 15:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69935214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 15:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfGIPGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 11:06:15 -0400
Received: from ms.lwn.net ([45.79.88.28]:58710 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfGIPGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 11:06:15 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E5CBF737;
        Tue,  9 Jul 2019 15:06:12 +0000 (UTC)
Date:   Tue, 9 Jul 2019 09:06:11 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation for 5.3
Message-ID: <20190709090611.66911ed5@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit
d1fdb6d8f6a4109a4263176c84b899076a5f8008:

  Linux 5.2-rc4 (2019-06-08 20:24:46 -0700)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.3

for you to fetch changes up to 454f96f2b738374da4b0a703b1e2e7aed82c4486:

  docs: automarkup.py: ignore exceptions when seeking for xrefs (2019-07-08 14:35:47 -0600)

----------------------------------------------------------------
It's been a relatively busy cycle for docs:

 - A fair pile of RST conversions, many from Mauro.  These tend to
   reach beyond Documentation/ (mostly to adjust file paths in
   comments) and create more than the usual number of simple but annoying
   merge conflicts with other trees, unfortunately. He has a lot more of
   these waiting on the wings that, I think, will go to you directly later
   on.

 - A new document on how to use merges and rebases in kernel repos, and one
   on Spectre vulnerabilities.

 - Various improvements to the build system, including automatic markup of
   function() references because some people, for reasons I will never
   understand, were of the opinion that :c:func:``function()`` is
   unattractive and not fun to type.

 - We now recommend using sphinx 1.7, but still support back to 1.4.

 - Lots of smaller improvements, warning fixes, typo fixes, etc.

----------------------------------------------------------------
André Almeida (1):
      sphinx.rst: Add note about code snippets embedded in the text

Andy Shevchenko (2):
      docs/core-api: Add string helpers API to the list
      docs/core-api: Add integer power functions to the list

Aurelien Thierry (1):
      Documentation: fix typo CLOCK_MONONOTNIC_COARSE

Bhupesh Sharma (1):
      Documentation/stackprotector: powerpc supports stack protector

Bjorn Helgaas (1):
      scripts/sphinx-pre-install: fix "dependenties" typo

Federico Vaga (2):
      doc:it_IT: fix file references
      doc:it_IT: documentation alignment

Geert Uytterhoeven (4):
      Documentation: tee: Grammar s/the its/its/
      Documentation: net: dsa: Grammar s/the its/its/
      KVM: arm/arm64: Always capitalize ITS
      doc-rst: Add missing newline at end of file

George G. Davis (1):
      treewide: trivial: fix s/poped/popped/ typo

Helen Koike (1):
      Documentation/dm-init: fix multi device example

James Morse (4):
      Documentation: x86: Contiguous cbm isn't all X86
      Documentation: x86: Remove cdpl2 unspported statement and fix capitalisation
      Documentation: x86: Clarify MBA takes MB as referring to mba_sc
      Documentation: x86: fix some typos

Jiunn Chang (6):
      Documentation: RCU: Convert RCU basic concepts to reST
      Documentation: RCU: Convert RCU linked list to reST
      Documentation: RCU: Convert RCU UP systems to reST
      Documentation: RCU: Rename txt files to rst
      Documentation: RCU: Add TOC tree hooks
      doc: RCU callback locks need only _bh, not necessarily _irq

Jonathan Corbet (18):
      docs: Do not seek comments in kernel/rcu/tree_plugin.h
      docs: Fix a misdirected kerneldoc directive
      docs: Do not seek kerneldoc comments in hw-consumer.h
      docs: No structured comments in target_core_device.c
      docs: no structured comments in fs/file_table.c
      docs: No structured comments in include/linux/interconnect.h
      kernel-doc: always name missing kerneldoc sections
      docs: look for sphinx-pre-install in the source tree
      docs: Completely fix the remote build tree case
      Merge branch 'vfs' into docs-next
      Merge tag 'v5.2-rc4' into mauro
      docs: Add a document on repository management
      Docs: An initial automarkup extension for sphinx
      docs: remove :c:func: annotations from xarray.rst
      kernel-doc: Don't try to mark up function names
      docs: Note that :c:func: should no longer be used
      Add the RCU docs to the core-api manual
      Merge branch 'automarkup' into docs-next

Konstantin Khlebnikov (1):
      block: document iostat changes for disk busy time accounting

Konstantin Ryabitsev (1):
      Documentation: PGP: update for newer HW devices

Lecopzer Chen (1):
      Documentation: {u,k}probes: add tracing_on before tracing

Luca Ceresoli (1):
      docs: clk: fix struct syntax

Masanari Iida (1):
      docs: tracing: Fix typos in histogram.rst

Matthew Wilcox (Oracle) (1):
      docs: Move binderfs to admin-guide

Mauro Carvalho Chehab (59):
      docs: cdomain.py: get rid of a warning since version 1.8
      scripts/sphinx-pre-install: make activate hint smarter
      scripts/sphinx-pre-install: get rid of RHEL7 explicity check
      scripts/sphinx-pre-install: always check if version is compatible with build
      scripts/documentation-file-ref-check: better handle translations
      scripts/documentation-file-ref-check: exclude false-positives
      scripts/documentation-file-ref-check: improve tools ref handling
      scripts/documentation-file-ref-check: teach about .txt -> .yaml renames
      docs: by default, build docs a lot faster with Sphinx >= 1.7
      docs: requirements.txt: recommend Sphinx 1.7.9
      docs: Kbuild/Makefile: allow check for missing docs at build time
      ABI: sysfs-devices-system-cpu: point to the right docs
      isdn: mISDN: remove a bogus reference to a non-existing doc
      docs: zh_CN: get rid of basic_profiling.txt
      docs: mm: numaperf.rst: get rid of a build warning
      docs: bpf: get rid of two warnings
      docs: mark orphan documents as such
      docs: amd-memory-encryption.rst get rid of warnings
      docs: zh_CN: avoid duplicate citation references
      docs: it: license-rules.rst: get rid of warnings
      docs: security: trusted-encrypted.rst: fix code-block tag
      docs: security: core.rst: Fix several warnings
      docs: net: sja1105.rst: fix table format
      docs: net: dpio-driver.rst: fix two codeblock warnings
      docs: move protection-keys.rst to the core-api book
      docs: fix broken documentation links
      docs: isdn: remove hisax references from kernel-parameters.txt
      docs: fs: fix broken links to vfs.txt with was renamed to vfs.rst
      docs: pci: fix broken links due to conversion from pci.txt to pci.rst
      docs: aoe: convert docs to ReST and rename to *.rst
      docs: arm64: convert docs to ReST and rename to .rst
      docs: cdrom-standard.tex: convert from LaTeX to ReST
      docs: cdrom: convert docs to ReST and rename to *.rst
      docs: convert docs to ReST and rename to *.rst
      docs: fault-injection: convert docs to ReST and rename to *.rst
      docs: fb: convert docs to ReST and rename to *.rst
      docs: fpga: convert docs to ReST and rename to *.rst
      docs: ide: convert docs to ReST and rename to *.rst
      docs: kbuild: convert docs to ReST and rename to *.rst
      docs: kdump: convert docs to ReST and rename to *.rst
      docs: mic: convert docs to ReST and rename to *.rst
      docs: netlabel: convert docs to ReST and rename to *.rst
      docs: pcmcia: convert docs to ReST and rename to *.rst
      docs: pps.txt: convert to ReST and rename to pps.rst
      docs: ptp.txt: convert to ReST and move to driver-api
      docs: riscv: convert docs to ReST and rename to *.rst
      docs: target: convert docs to ReST and rename to *.rst
      docs: timers: convert docs to ReST and rename to *.rst
      docs: watchdog: convert docs to ReST and rename to *.rst
      docs: xilinx: convert eemi.txt to eemi.rst
      docs: scheduler: convert docs to ReST and rename to *.rst
      docs: EDID/HOWTO.txt: convert it and rename to howto.rst
      scripts/documentation-file-ref-check: ignore output dir
      docs: trace: add a missing blank line
      lib: list_sort.c: add a blank line to avoid kernel-doc warnings
      docs: zh_CN: submitting-drivers.rst: Remove a duplicated Documentation/
      docs: filesystems: Remove uneeded .rst extension on toctables
      platform: x86: get rid of a non-existent document
      docs: automarkup.py: ignore exceptions when seeking for xrefs

Mike Rapoport (1):
      scripts/sphinx-pre-install: fix out-of-tree build

Puranjay Mohan (1):
      Documentation: platform: Delete x86-laptop-drivers.txt

Sheriff Esseson (1):
      Doc : doc-guide : Fix a typo

Shiyang Ruan (2):
      Documentation: nvdimm: Fix typo
      Documentation: xfs: Fix typo

Stephen Kitt (3):
      docs: stop suggesting strlcpy
      docs: format kernel-parameters -- as code
      Disable Sphinx SmartyPants in HTML output

Suzuki K Poulose (1):
      Documentation: coresight: Update the generic device names

Takashi Iwai (1):
      docs: fb: Add TER16x32 to the available font names

Thomas Gleixner (1):
      Documentation: Remove duplicate x86 index entry

Tim Chen (1):
      Documentation: Add section about CPU vulnerabilities for Spectre

Tobin C. Harding (10):
      docs: filesystems: vfs: Remove space before tab
      docs: filesystems: vfs: Use uniform space after period.
      docs: filesystems: vfs: Use 72 character column width
      docs: filesystems: vfs: Use uniform spacing around headings
      docs: filesystems: vfs: Use correct initial heading
      docs: filesystems: vfs: Use SPDX identifier
      docs: filesystems: vfs: Fix pre-amble indentation
      docs: filesystems: vfs: Convert spaces to tabs
      docs: filesystems: vfs: Convert vfs.txt to RST
      docs: filesystems: vfs: Render method descriptions

Valentin Schneider (1):
      docs/vm: hwpoison.rst: Fix quote formatting

Yoshihiro Shimoda (1):
      Documentation: DMA-API: fix a function name of max_mapping_size

Zhenzhong Duan (1):
      doc: kernel-parameters.txt: fix documentation of nmi_watchdog parameter

 Documentation/ABI/testing/sysfs-devices-system-cpu |    3 +-
 Documentation/ABI/testing/sysfs-kernel-uids        |    2 +-
 Documentation/DMA-API.txt                          |    2 +-
 Documentation/EDID/{HOWTO.txt => howto.rst}        |   35 +-
 Documentation/Kconfig                              |   13 +
 Documentation/Makefile                             |   14 +-
 Documentation/RCU/{UP.txt => UP.rst}               |   50 +-
 Documentation/RCU/index.rst                        |   19 +
 Documentation/RCU/{listRCU.txt => listRCU.rst}     |   38 +-
 Documentation/RCU/rcu.rst                          |   92 ++
 Documentation/RCU/rcu.txt                          |   89 --
 Documentation/accelerators/ocxl.rst                |    2 +
 Documentation/acpi/dsd/leds.txt                    |    2 +-
 Documentation/admin-guide/README.rst               |    2 +-
 .../{filesystems => admin-guide}/binderfs.rst      |    0
 Documentation/admin-guide/bug-hunting.rst          |    2 +-
 Documentation/admin-guide/hw-vuln/index.rst        |    1 +
 Documentation/admin-guide/hw-vuln/spectre.rst      |  697 ++++++++++
 Documentation/admin-guide/index.rst                |    1 +
 Documentation/admin-guide/kernel-parameters.rst    |   10 +-
 Documentation/admin-guide/kernel-parameters.txt    |   38 +-
 Documentation/admin-guide/mm/numaperf.rst          |    5 +-
 Documentation/admin-guide/ras.rst                  |    2 +-
 Documentation/aoe/{aoe.txt => aoe.rst}             |   65 +-
 Documentation/aoe/examples.rst                     |   23 +
 Documentation/aoe/index.rst                        |   19 +
 Documentation/aoe/{todo.txt => todo.rst}           |    3 +
 Documentation/aoe/udev.txt                         |    2 +-
 Documentation/arm/mem_alignment                    |    2 +-
 Documentation/arm/stm32/overview.rst               |    2 +
 Documentation/arm/stm32/stm32f429-overview.rst     |    2 +
 Documentation/arm/stm32/stm32f746-overview.rst     |    2 +
 Documentation/arm/stm32/stm32f769-overview.rst     |    2 +
 Documentation/arm/stm32/stm32h743-overview.rst     |    2 +
 Documentation/arm/stm32/stm32mp157-overview.rst    |    2 +
 ...acpi_object_usage.txt => acpi_object_usage.rst} |  288 ++--
 Documentation/arm64/{arm-acpi.txt => arm-acpi.rst} |  163 +--
 Documentation/arm64/{booting.txt => booting.rst}   |   91 +-
 ...ure-registers.txt => cpu-feature-registers.rst} |  210 +--
 .../arm64/{elf_hwcaps.txt => elf_hwcaps.rst}       |   56 +-
 .../arm64/{hugetlbpage.txt => hugetlbpage.rst}     |    7 +-
 Documentation/arm64/index.rst                      |   28 +
 ...cy_instructions.txt => legacy_instructions.rst} |   43 +-
 Documentation/arm64/memory.rst                     |   98 ++
 Documentation/arm64/memory.txt                     |   97 --
 ...thentication.txt => pointer-authentication.rst} |    2 +
 .../{silicon-errata.txt => silicon-errata.rst}     |   65 +-
 Documentation/arm64/{sve.txt => sve.rst}           |   12 +-
 .../{tagged-pointers.txt => tagged-pointers.rst}   |    6 +-
 Documentation/bpf/btf.rst                          |    2 +
 Documentation/cdrom/Makefile                       |   21 -
 Documentation/cdrom/cdrom-standard.rst             | 1063 +++++++++++++++
 Documentation/cdrom/cdrom-standard.tex             | 1026 --------------
 Documentation/cdrom/{ide-cd => ide-cd.rst}         |  202 +--
 Documentation/cdrom/index.rst                      |   19 +
 .../{packet-writing.txt => packet-writing.rst}     |   27 +-
 Documentation/conf.py                              |    5 +-
 Documentation/core-api/index.rst                   |    2 +
 Documentation/core-api/kernel-api.rst              |   14 +-
 .../{x86 => core-api}/protection-keys.rst          |    0
 Documentation/core-api/timekeeping.rst             |    2 +-
 Documentation/core-api/xarray.rst                  |  270 ++--
 .../{cache-policies.txt => cache-policies.rst}     |   24 +-
 .../device-mapper/{cache.txt => cache.rst}         |  214 +--
 .../device-mapper/{delay.txt => delay.rst}         |   29 +-
 .../device-mapper/{dm-crypt.txt => dm-crypt.rst}   |   61 +-
 .../device-mapper/{dm-flakey.txt => dm-flakey.rst} |   45 +-
 .../device-mapper/{dm-init.txt => dm-init.rst}     |   89 +-
 .../{dm-integrity.txt => dm-integrity.rst}         |   62 +-
 .../device-mapper/{dm-io.txt => dm-io.rst}         |   14 +-
 .../device-mapper/{dm-log.txt => dm-log.rst}       |    5 +-
 .../{dm-queue-length.txt => dm-queue-length.rst}   |   25 +-
 .../device-mapper/{dm-raid.txt => dm-raid.rst}     |  225 +--
 .../{dm-service-time.txt => dm-service-time.rst}   |   76 +-
 Documentation/device-mapper/dm-uevent.rst          |  110 ++
 Documentation/device-mapper/dm-uevent.txt          |   97 --
 .../device-mapper/{dm-zoned.txt => dm-zoned.rst}   |   10 +-
 Documentation/device-mapper/{era.txt => era.rst}   |   36 +-
 Documentation/device-mapper/index.rst              |   44 +
 .../device-mapper/{kcopyd.txt => kcopyd.rst}       |   10 +-
 Documentation/device-mapper/linear.rst             |   63 +
 Documentation/device-mapper/linear.txt             |   61 -
 .../{log-writes.txt => log-writes.rst}             |  105 +-
 .../{persistent-data.txt => persistent-data.rst}   |    4 +
 .../device-mapper/{snapshot.txt => snapshot.rst}   |  116 +-
 .../{statistics.txt => statistics.rst}             |   62 +-
 Documentation/device-mapper/striped.rst            |   61 +
 Documentation/device-mapper/striped.txt            |   57 -
 .../device-mapper/{switch.txt => switch.rst}       |   47 +-
 ...thin-provisioning.txt => thin-provisioning.rst} |   68 +-
 .../device-mapper/{unstriped.txt => unstriped.rst} |   93 +-
 .../device-mapper/{verity.txt => verity.rst}       |   20 +-
 .../{writecache.txt => writecache.rst}             |   13 +-
 Documentation/device-mapper/{zero.txt => zero.rst} |   14 +-
 .../devicetree/bindings/net/fsl-enetc.txt          |    7 +-
 .../devicetree/bindings/pci/amlogic,meson-pcie.txt |    2 +-
 .../bindings/regulator/qcom,rpmh-regulator.txt     |    2 +-
 Documentation/devicetree/booting-without-of.txt    |    2 +-
 Documentation/doc-guide/kernel-doc.rst             |    2 +-
 Documentation/doc-guide/sphinx.rst                 |   32 +-
 Documentation/docutils.conf                        |    2 +-
 Documentation/driver-api/basics.rst                |    3 -
 Documentation/driver-api/clk.rst                   |    6 +-
 .../driver-api/firmware/other_interfaces.rst       |    2 +-
 Documentation/driver-api/gpio/board.rst            |    2 +-
 Documentation/driver-api/gpio/consumer.rst         |    2 +-
 Documentation/driver-api/iio/hw-consumer.rst       |    1 -
 Documentation/{pps/pps.txt => driver-api/pps.rst}  |   67 +-
 Documentation/{ptp/ptp.txt => driver-api/ptp.rst}  |   26 +-
 Documentation/driver-api/target.rst                |    4 +-
 .../{fault-injection.txt => fault-injection.rst}   |  281 ++--
 Documentation/fault-injection/index.rst            |   20 +
 ...-error-inject.txt => notifier-error-inject.rst} |   18 +-
 .../fault-injection/nvme-fault-injection.rst       |  120 ++
 .../fault-injection/nvme-fault-injection.txt       |  116 --
 Documentation/fault-injection/provoke-crashes.rst  |   48 +
 Documentation/fault-injection/provoke-crashes.txt  |   38 -
 Documentation/fb/{api.txt => api.rst}              |   29 +-
 Documentation/fb/{arkfb.txt => arkfb.rst}          |    8 +-
 Documentation/fb/{aty128fb.txt => aty128fb.rst}    |   35 +-
 Documentation/fb/{cirrusfb.txt => cirrusfb.rst}    |   47 +-
 .../fb/{cmap_xfbdev.txt => cmap_xfbdev.rst}        |   57 +-
 .../fb/{deferred_io.txt => deferred_io.rst}        |   28 +-
 Documentation/fb/{efifb.txt => efifb.rst}          |   18 +-
 Documentation/fb/{ep93xx-fb.txt => ep93xx-fb.rst}  |   27 +-
 Documentation/fb/{fbcon.txt => fbcon.rst}          |  179 +--
 .../fb/{framebuffer.txt => framebuffer.rst}        |   80 +-
 Documentation/fb/{gxfb.txt => gxfb.rst}            |   24 +-
 Documentation/fb/index.rst                         |   50 +
 Documentation/fb/{intel810.txt => intel810.rst}    |   79 +-
 Documentation/fb/{intelfb.txt => intelfb.rst}      |   62 +-
 Documentation/fb/{internals.txt => internals.rst}  |   24 +-
 Documentation/fb/{lxfb.txt => lxfb.rst}            |   25 +-
 Documentation/fb/matroxfb.rst                      |  443 ++++++
 Documentation/fb/matroxfb.txt                      |  413 ------
 .../fb/{metronomefb.txt => metronomefb.rst}        |    8 +-
 Documentation/fb/{modedb.txt => modedb.rst}        |   44 +-
 Documentation/fb/pvr2fb.rst                        |   66 +
 Documentation/fb/pvr2fb.txt                        |   65 -
 Documentation/fb/{pxafb.txt => pxafb.rst}          |   81 +-
 Documentation/fb/{s3fb.txt => s3fb.rst}            |    8 +-
 Documentation/fb/{sa1100fb.txt => sa1100fb.rst}    |   23 +-
 Documentation/fb/sh7760fb.rst                      |  130 ++
 Documentation/fb/sh7760fb.txt                      |  131 --
 Documentation/fb/{sisfb.txt => sisfb.rst}          |   40 +-
 Documentation/fb/{sm501.txt => sm501.rst}          |    7 +-
 Documentation/fb/{sm712fb.txt => sm712fb.rst}      |   18 +-
 Documentation/fb/sstfb.rst                         |  207 +++
 Documentation/fb/sstfb.txt                         |  174 ---
 Documentation/fb/{tgafb.txt => tgafb.rst}          |   30 +-
 Documentation/fb/{tridentfb.txt => tridentfb.rst}  |   36 +-
 Documentation/fb/{udlfb.txt => udlfb.rst}          |   55 +-
 Documentation/fb/{uvesafb.txt => uvesafb.rst}      |  142 +-
 Documentation/fb/{vesafb.txt => vesafb.rst}        |  121 +-
 Documentation/fb/viafb.rst                         |  297 ++++
 Documentation/fb/viafb.txt                         |  252 ----
 Documentation/fb/{vt8623fb.txt => vt8623fb.rst}    |   10 +-
 .../features/debug/stackprotector/arch-support.txt |    2 +-
 Documentation/filesystems/api-summary.rst          |    3 -
 Documentation/filesystems/ext4/index.rst           |    8 +-
 Documentation/filesystems/index.rst                |   13 +-
 Documentation/filesystems/porting                  |   10 +-
 Documentation/filesystems/ubifs-authentication.md  |    4 +-
 Documentation/filesystems/vfs.rst                  | 1428 ++++++++++++++++++++
 Documentation/filesystems/vfs.txt                  | 1268 -----------------
 .../filesystems/xfs-delayed-logging-design.txt     |    2 +-
 Documentation/firmware-guide/acpi/enumeration.rst  |    2 +-
 .../firmware-guide/acpi/method-tracing.rst         |    2 +-
 Documentation/fpga/{dfl.txt => dfl.rst}            |   58 +-
 Documentation/fpga/index.rst                       |   17 +
 Documentation/gpu/msm-crash-dump.rst               |    2 +
 Documentation/hid/hid-transport.txt                |    6 +-
 Documentation/i2c/instantiating-devices            |    4 +-
 Documentation/i2c/upgrading-clients                |    4 +-
 Documentation/ide/changelogs.rst                   |   17 +
 Documentation/ide/{ide-tape.txt => ide-tape.rst}   |   23 +-
 Documentation/ide/{ide.txt => ide.rst}             |  147 +-
 Documentation/ide/index.rst                        |   21 +
 .../{warm-plug-howto.txt => warm-plug-howto.rst}   |   10 +-
 Documentation/index.rst                            |    1 -
 Documentation/interconnect/interconnect.rst        |    7 +-
 Documentation/iostats.txt                          |    4 +
 .../{headers_install.txt => headers_install.rst}   |    5 +-
 Documentation/kbuild/index.rst                     |   27 +
 Documentation/kbuild/issues.rst                    |   11 +
 Documentation/kbuild/{kbuild.txt => kbuild.rst}    |  119 +-
 .../{kconfig-language.txt => kconfig-language.rst} |  242 ++--
 ...cro-language.txt => kconfig-macro-language.rst} |   37 +-
 Documentation/kbuild/{kconfig.txt => kconfig.rst}  |  136 +-
 .../kbuild/{makefiles.txt => makefiles.rst}        |  530 +++++---
 Documentation/kbuild/{modules.txt => modules.rst}  |  170 ++-
 Documentation/kdump/index.rst                      |   21 +
 Documentation/kdump/{kdump.txt => kdump.rst}       |  131 +-
 .../kdump/{vmcoreinfo.txt => vmcoreinfo.rst}       |   59 +-
 Documentation/kernel-hacking/hacking.rst           |    4 +-
 Documentation/kernel-hacking/locking.rst           |    6 +-
 Documentation/kernel-per-CPU-kthreads.txt          |    2 +-
 Documentation/laptops/lg-laptop.rst                |    2 +
 Documentation/maintainer/index.rst                 |    1 +
 Documentation/maintainer/rebasing-and-merging.rst  |  226 ++++
 Documentation/memory-barriers.txt                  |    2 +-
 Documentation/mic/index.rst                        |   18 +
 .../mic/{mic_overview.txt => mic_overview.rst}     |    6 +-
 .../mic/{scif_overview.txt => scif_overview.rst}   |   58 +-
 .../netlabel/{cipso_ipv4.txt => cipso_ipv4.rst}    |   19 +-
 Documentation/netlabel/draft_ietf.rst              |    5 +
 Documentation/netlabel/index.rst                   |   21 +
 .../{introduction.txt => introduction.rst}         |   16 +-
 .../{lsm_interface.txt => lsm_interface.rst}       |   16 +-
 .../device_drivers/freescale/dpaa2/dpio-driver.rst |    4 +-
 Documentation/networking/dsa/dsa.rst               |    4 +-
 Documentation/networking/dsa/sja1105.rst           |    6 +-
 Documentation/networking/timestamping.txt          |    2 +-
 Documentation/nvdimm/nvdimm.txt                    |    4 +-
 .../pcmcia/{devicetable.txt => devicetable.rst}    |    4 +
 .../{driver-changes.txt => driver-changes.rst}     |   35 +-
 Documentation/pcmcia/{driver.txt => driver.rst}    |   18 +-
 Documentation/pcmcia/index.rst                     |   20 +
 Documentation/pcmcia/{locking.txt => locking.rst}  |   39 +-
 Documentation/platform/x86-laptop-drivers.txt      |   18 -
 Documentation/powerpc/firmware-assisted-dump.txt   |    2 +-
 Documentation/powerpc/isa-versions.rst             |    2 +
 Documentation/process/4.Coding.rst                 |    2 +-
 Documentation/process/coding-style.rst             |    2 +-
 Documentation/process/maintainer-pgp-guide.rst     |   31 +-
 Documentation/process/submit-checklist.rst         |    2 +-
 Documentation/riscv/index.rst                      |   17 +
 Documentation/riscv/{pmu.txt => pmu.rst}           |   98 +-
 .../scheduler/{completion.txt => completion.rst}   |   38 +-
 Documentation/scheduler/index.rst                  |   29 +
 .../scheduler/{sched-arch.txt => sched-arch.rst}   |   18 +-
 .../scheduler/{sched-bwc.txt => sched-bwc.rst}     |   30 +-
 .../{sched-deadline.txt => sched-deadline.rst}     |  311 +++--
 .../{sched-design-CFS.txt => sched-design-CFS.rst} |   15 +-
 .../{sched-domains.txt => sched-domains.rst}       |    8 +-
 .../{sched-energy.txt => sched-energy.rst}         |   47 +-
 ...sched-nice-design.txt => sched-nice-design.rst} |    6 +-
 .../{sched-rt-group.txt => sched-rt-group.rst}     |   28 +-
 .../scheduler/{sched-stats.txt => sched-stats.rst} |   35 +-
 Documentation/scheduler/text_files.rst             |    5 +
 Documentation/security/keys/core.rst               |   16 +-
 Documentation/security/keys/trusted-encrypted.rst  |    4 +-
 Documentation/sphinx/automarkup.py                 |  101 ++
 Documentation/sphinx/cdomain.py                    |    5 +-
 Documentation/sphinx/requirements.txt              |    4 +-
 Documentation/sysctl/kernel.txt                    |    4 +-
 Documentation/target/index.rst                     |   19 +
 Documentation/target/scripts.rst                   |   11 +
 Documentation/target/tcm_mod_builder.rst           |  149 ++
 Documentation/target/tcm_mod_builder.txt           |  145 --
 .../target/{tcmu-design.txt => tcmu-design.rst}    |  272 ++--
 Documentation/tee.txt                              |    2 +-
 Documentation/timers/{highres.txt => highres.rst}  |   13 +-
 Documentation/timers/{hpet.txt => hpet.rst}        |    4 +-
 .../timers/{hrtimers.txt => hrtimers.rst}          |    6 +-
 Documentation/timers/index.rst                     |   22 +
 Documentation/timers/{NO_HZ.txt => no_hz.rst}      |   40 +-
 .../timers/{timekeeping.txt => timekeeping.rst}    |    3 +-
 .../timers/{timers-howto.txt => timers-howto.rst}  |   15 +-
 Documentation/trace/coresight.txt                  |   82 +-
 Documentation/trace/histogram.rst                  |   10 +-
 Documentation/trace/kprobetrace.rst                |    7 +
 Documentation/trace/uprobetracer.rst               |    7 +-
 .../it_IT/admin-guide/kernel-parameters.rst        |   12 +
 .../translations/it_IT/doc-guide/sphinx.rst        |   17 +-
 .../translations/it_IT/kernel-hacking/hacking.rst  |    4 +-
 .../translations/it_IT/kernel-hacking/locking.rst  |    6 +-
 .../translations/it_IT/process/4.Coding.rst        |    2 +-
 .../translations/it_IT/process/adding-syscalls.rst |    2 +-
 .../translations/it_IT/process/coding-style.rst    |    2 +-
 Documentation/translations/it_IT/process/howto.rst |    2 +-
 .../translations/it_IT/process/license-rules.rst   |   28 +-
 .../translations/it_IT/process/magic-number.rst    |    2 +-
 .../it_IT/process/stable-kernel-rules.rst          |    4 +-
 .../it_IT/process/submit-checklist.rst             |    2 +-
 .../translations/ko_KR/memory-barriers.txt         |    2 +-
 Documentation/translations/zh_CN/arm64/booting.txt |    4 +-
 .../zh_CN/arm64/legacy_instructions.txt            |    4 +-
 Documentation/translations/zh_CN/arm64/memory.txt  |    4 +-
 .../translations/zh_CN/arm64/silicon-errata.txt    |    4 +-
 .../translations/zh_CN/arm64/tagged-pointers.txt   |    4 +-
 .../translations/zh_CN/basic_profiling.txt         |   71 -
 Documentation/translations/zh_CN/oops-tracing.txt  |    2 +-
 .../translations/zh_CN/process/4.Coding.rst        |    4 +-
 .../translations/zh_CN/process/coding-style.rst    |    2 +-
 .../zh_CN/process/management-style.rst             |    4 +-
 .../zh_CN/process/programming-language.rst         |   59 +-
 .../zh_CN/process/submit-checklist.rst             |    2 +-
 .../zh_CN/process/submitting-drivers.rst           |    2 +-
 Documentation/userspace-api/spec_ctrl.rst          |    2 +
 .../virtual/kvm/amd-memory-encryption.rst          |    3 +
 Documentation/virtual/kvm/api.txt                  |    2 +-
 Documentation/virtual/kvm/devices/arm-vgic-its.txt |    2 +-
 Documentation/vm/hwpoison.rst                      |   52 +-
 Documentation/vm/numa.rst                          |    2 +-
 ...l_api.txt => convert_drivers_to_kernel_api.rst} |  109 +-
 Documentation/watchdog/{hpwdt.txt => hpwdt.rst}    |   27 +-
 Documentation/watchdog/index.rst                   |   25 +
 .../watchdog/{mlx-wdt.txt => mlx-wdt.rst}          |   24 +-
 .../{pcwd-watchdog.txt => pcwd-watchdog.rst}       |   13 +-
 .../{watchdog-api.txt => watchdog-api.rst}         |   76 +-
 ...hdog-kernel-api.txt => watchdog-kernel-api.rst} |   91 +-
 Documentation/watchdog/watchdog-parameters.rst     |  736 ++++++++++
 Documentation/watchdog/watchdog-parameters.txt     |  410 ------
 .../watchdog/{watchdog-pm.txt => watchdog-pm.rst}  |    3 +
 Documentation/watchdog/{wdt.txt => wdt.rst}        |   31 +-
 Documentation/x86/index.rst                        |    1 -
 Documentation/x86/resctrl_ui.rst                   |   30 +-
 Documentation/x86/x86_64/5level-paging.rst         |    2 +-
 Documentation/x86/x86_64/boot-options.rst          |    4 +-
 Documentation/x86/x86_64/fake-numa-for-cpusets.rst |    2 +-
 Documentation/xilinx/{eemi.txt => eemi.rst}        |    8 +-
 Documentation/xilinx/index.rst                     |   17 +
 Kconfig                                            |    4 +-
 MAINTAINERS                                        |   26 +-
 arch/arc/plat-eznps/Kconfig                        |    2 +-
 arch/arm/Kconfig                                   |    4 +-
 arch/arm64/Kconfig                                 |    2 +-
 arch/arm64/include/asm/efi.h                       |    2 +-
 arch/arm64/include/asm/image.h                     |    2 +-
 arch/arm64/include/uapi/asm/sigcontext.h           |    2 +-
 arch/arm64/kernel/kexec_image.c                    |    2 +-
 arch/c6x/Kconfig                                   |    2 +-
 arch/m68k/q40/README                               |    2 +-
 arch/microblaze/Kconfig.debug                      |    2 +-
 arch/microblaze/Kconfig.platform                   |    2 +-
 arch/nds32/Kconfig                                 |    2 +-
 arch/openrisc/Kconfig                              |    2 +-
 arch/powerpc/Kconfig                               |    2 +-
 arch/powerpc/sysdev/Kconfig                        |    2 +-
 arch/riscv/Kconfig                                 |    2 +-
 arch/sh/Kconfig                                    |    2 +-
 arch/x86/Kconfig                                   |   20 +-
 arch/x86/Kconfig.debug                             |    2 +-
 arch/x86/boot/header.S                             |    2 +-
 arch/x86/entry/entry_64.S                          |    2 +-
 arch/x86/include/asm/bootparam_utils.h             |    2 +-
 arch/x86/include/asm/page_64_types.h               |    2 +-
 arch/x86/include/asm/pgtable_64_types.h            |    2 +-
 arch/x86/kernel/cpu/microcode/amd.c                |    2 +-
 arch/x86/kernel/kexec-bzimage64.c                  |    2 +-
 arch/x86/kernel/kprobes/core.c                     |    2 +-
 arch/x86/kernel/pci-dma.c                          |    2 +-
 arch/x86/mm/tlb.c                                  |    2 +-
 arch/x86/platform/pvh/enlighten.c                  |    2 +-
 drivers/acpi/Kconfig                               |   10 +-
 drivers/auxdisplay/Kconfig                         |    2 +-
 drivers/block/Kconfig                              |    2 +-
 drivers/cdrom/cdrom.c                              |    2 +-
 drivers/firmware/Kconfig                           |    2 +-
 drivers/gpu/drm/Kconfig                            |    2 +-
 drivers/ide/Kconfig                                |   20 +-
 drivers/ide/ide-cd.c                               |    2 +-
 drivers/isdn/mISDN/dsp_core.c                      |    2 -
 drivers/md/Kconfig                                 |    2 +-
 drivers/md/dm-init.c                               |    2 +-
 drivers/md/dm-raid.c                               |    2 +-
 drivers/media/usb/dvb-usb-v2/anysee.c              |    2 +-
 drivers/misc/lkdtm/core.c                          |    2 +-
 drivers/mtd/devices/Kconfig                        |    2 +-
 drivers/net/ethernet/faraday/ftgmac100.c           |    2 +-
 drivers/net/ethernet/smsc/Kconfig                  |    6 +-
 drivers/net/wireless/intel/iwlegacy/Kconfig        |    4 +-
 drivers/net/wireless/intel/iwlwifi/Kconfig         |    2 +-
 drivers/parport/Kconfig                            |    2 +-
 drivers/pcmcia/ds.c                                |    2 +-
 drivers/platform/x86/Kconfig                       |    3 -
 drivers/regulator/core.c                           |    2 +-
 drivers/scsi/Kconfig                               |    4 +-
 drivers/scsi/hpsa.c                                |    4 +-
 .../fieldbus/Documentation/fieldbus_dev.txt        |    4 +-
 drivers/staging/sm750fb/Kconfig                    |    2 +-
 drivers/tty/Kconfig                                |    2 +-
 drivers/usb/misc/Kconfig                           |    4 +-
 drivers/vhost/vhost.c                              |    2 +-
 drivers/video/fbdev/Kconfig                        |   38 +-
 drivers/video/fbdev/matrox/matroxfb_base.c         |    2 +-
 drivers/video/fbdev/pxafb.c                        |    2 +-
 drivers/video/fbdev/sh7760fb.c                     |    2 +-
 drivers/watchdog/Kconfig                           |    6 +-
 drivers/watchdog/smsc37b787_wdt.c                  |    2 +-
 include/acpi/acpi_drivers.h                        |    2 +-
 include/linux/dcache.h                             |    4 +-
 include/linux/fault-inject.h                       |    2 +-
 include/linux/fs.h                                 |    2 +-
 include/linux/fs_context.h                         |    2 +-
 include/linux/iopoll.h                             |    4 +-
 include/linux/lsm_hooks.h                          |    2 +-
 include/linux/regmap.h                             |    4 +-
 include/pcmcia/ds.h                                |    2 +-
 include/pcmcia/ss.h                                |    2 +-
 init/Kconfig                                       |    6 +-
 kernel/sched/deadline.c                            |    2 +-
 lib/Kconfig.debug                                  |    2 +-
 lib/list_sort.c                                    |    2 +
 mm/Kconfig                                         |    2 +-
 net/bridge/netfilter/Kconfig                       |    2 +-
 net/ipv4/netfilter/Kconfig                         |    2 +-
 net/ipv6/netfilter/Kconfig                         |    2 +-
 net/netfilter/Kconfig                              |   16 +-
 net/tipc/Kconfig                                   |    2 +-
 scripts/Kbuild.include                             |    4 +-
 scripts/Makefile.host                              |    2 +-
 scripts/checkpatch.pl                              |    8 +-
 scripts/documentation-file-ref-check               |   58 +-
 scripts/kconfig/symbol.c                           |    2 +-
 .../tests/err_recursive_dep/expected_stderr        |   14 +-
 scripts/kernel-doc                                 |   18 +-
 scripts/sphinx-pre-install                         |   76 +-
 security/Kconfig                                   |    2 +-
 sound/oss/dmasound/Kconfig                         |    6 +-
 sound/soc/sof/ops.h                                |    2 +-
 tools/include/linux/err.h                          |    2 +-
 tools/objtool/Documentation/stack-validation.txt   |    4 +-
 tools/testing/fault-injection/failcmd.sh           |    2 +-
 tools/testing/selftests/x86/protection_keys.c      |    2 +-
 416 files changed, 12101 insertions(+), 8525 deletions(-)
 rename Documentation/EDID/{HOWTO.txt => howto.rst} (83%)
 create mode 100644 Documentation/Kconfig
 rename Documentation/RCU/{UP.txt => UP.rst} (78%)
 create mode 100644 Documentation/RCU/index.rst
 rename Documentation/RCU/{listRCU.txt => listRCU.rst} (92%)
 create mode 100644 Documentation/RCU/rcu.rst
 delete mode 100644 Documentation/RCU/rcu.txt
 rename Documentation/{filesystems => admin-guide}/binderfs.rst (100%)
 create mode 100644 Documentation/admin-guide/hw-vuln/spectre.rst
 rename Documentation/aoe/{aoe.txt => aoe.rst} (79%)
 create mode 100644 Documentation/aoe/examples.rst
 create mode 100644 Documentation/aoe/index.rst
 rename Documentation/aoe/{todo.txt => todo.rst} (98%)
 rename Documentation/arm64/{acpi_object_usage.txt => acpi_object_usage.rst} (84%)
 rename Documentation/arm64/{arm-acpi.txt => arm-acpi.rst} (86%)
 rename Documentation/arm64/{booting.txt => booting.rst} (86%)
 rename Documentation/arm64/{cpu-feature-registers.txt => cpu-feature-registers.rst} (65%)
 rename Documentation/arm64/{elf_hwcaps.txt => elf_hwcaps.rst} (92%)
 rename Documentation/arm64/{hugetlbpage.txt => hugetlbpage.rst} (86%)
 create mode 100644 Documentation/arm64/index.rst
 rename Documentation/arm64/{legacy_instructions.txt => legacy_instructions.rst} (73%)
 create mode 100644 Documentation/arm64/memory.rst
 delete mode 100644 Documentation/arm64/memory.txt
 rename Documentation/arm64/{pointer-authentication.txt => pointer-authentication.rst} (99%)
 rename Documentation/arm64/{silicon-errata.txt => silicon-errata.rst} (55%)
 rename Documentation/arm64/{sve.txt => sve.rst} (98%)
 rename Documentation/arm64/{tagged-pointers.txt => tagged-pointers.rst} (94%)
 delete mode 100644 Documentation/cdrom/Makefile
 create mode 100644 Documentation/cdrom/cdrom-standard.rst
 delete mode 100644 Documentation/cdrom/cdrom-standard.tex
 rename Documentation/cdrom/{ide-cd => ide-cd.rst} (82%)
 create mode 100644 Documentation/cdrom/index.rst
 rename Documentation/cdrom/{packet-writing.txt => packet-writing.rst} (91%)
 rename Documentation/{x86 => core-api}/protection-keys.rst (100%)
 rename Documentation/device-mapper/{cache-policies.txt => cache-policies.rst} (94%)
 rename Documentation/device-mapper/{cache.txt => cache.rst} (61%)
 rename Documentation/device-mapper/{delay.txt => delay.rst} (53%)
 rename Documentation/device-mapper/{dm-crypt.txt => dm-crypt.rst} (87%)
 rename Documentation/device-mapper/{dm-flakey.txt => dm-flakey.rst} (60%)
 rename Documentation/device-mapper/{dm-init.txt => dm-init.rst} (62%)
 rename Documentation/device-mapper/{dm-integrity.txt => dm-integrity.rst} (90%)
 rename Documentation/device-mapper/{dm-io.txt => dm-io.rst} (92%)
 rename Documentation/device-mapper/{dm-log.txt => dm-log.rst} (90%)
 rename Documentation/device-mapper/{dm-queue-length.txt => dm-queue-length.rst} (76%)
 rename Documentation/device-mapper/{dm-raid.txt => dm-raid.rst} (71%)
 rename Documentation/device-mapper/{dm-service-time.txt => dm-service-time.rst} (60%)
 create mode 100644 Documentation/device-mapper/dm-uevent.rst
 delete mode 100644 Documentation/device-mapper/dm-uevent.txt
 rename Documentation/device-mapper/{dm-zoned.txt => dm-zoned.rst} (97%)
 rename Documentation/device-mapper/{era.txt => era.rst} (70%)
 create mode 100644 Documentation/device-mapper/index.rst
 rename Documentation/device-mapper/{kcopyd.txt => kcopyd.rst} (93%)
 create mode 100644 Documentation/device-mapper/linear.rst
 delete mode 100644 Documentation/device-mapper/linear.txt
 rename Documentation/device-mapper/{log-writes.txt => log-writes.rst} (61%)
 rename Documentation/device-mapper/{persistent-data.txt => persistent-data.rst} (98%)
 rename Documentation/device-mapper/{snapshot.txt => snapshot.rst} (62%)
 rename Documentation/device-mapper/{statistics.txt => statistics.rst} (87%)
 create mode 100644 Documentation/device-mapper/striped.rst
 delete mode 100644 Documentation/device-mapper/striped.txt
 rename Documentation/device-mapper/{switch.txt => switch.rst} (84%)
 rename Documentation/device-mapper/{thin-provisioning.txt => thin-provisioning.rst} (92%)
 rename Documentation/device-mapper/{unstriped.txt => unstriped.rst} (60%)
 rename Documentation/device-mapper/{verity.txt => verity.rst} (98%)
 rename Documentation/device-mapper/{writecache.txt => writecache.rst} (96%)
 rename Documentation/device-mapper/{zero.txt => zero.rst} (83%)
 rename Documentation/{pps/pps.txt => driver-api/pps.rst} (89%)
 rename Documentation/{ptp/ptp.txt => driver-api/ptp.rst} (88%)
 rename Documentation/fault-injection/{fault-injection.txt => fault-injection.rst} (68%)
 create mode 100644 Documentation/fault-injection/index.rst
 rename Documentation/fault-injection/{notifier-error-inject.txt => notifier-error-inject.rst} (83%)
 create mode 100644 Documentation/fault-injection/nvme-fault-injection.rst
 delete mode 100644 Documentation/fault-injection/nvme-fault-injection.txt
 create mode 100644 Documentation/fault-injection/provoke-crashes.rst
 delete mode 100644 Documentation/fault-injection/provoke-crashes.txt
 rename Documentation/fb/{api.txt => api.rst} (97%)
 rename Documentation/fb/{arkfb.txt => arkfb.rst} (92%)
 rename Documentation/fb/{aty128fb.txt => aty128fb.rst} (61%)
 rename Documentation/fb/{cirrusfb.txt => cirrusfb.rst} (75%)
 rename Documentation/fb/{cmap_xfbdev.txt => cmap_xfbdev.rst} (50%)
 rename Documentation/fb/{deferred_io.txt => deferred_io.rst} (86%)
 rename Documentation/fb/{efifb.txt => efifb.rst} (75%)
 rename Documentation/fb/{ep93xx-fb.txt => ep93xx-fb.rst} (85%)
 rename Documentation/fb/{fbcon.txt => fbcon.rst} (69%)
 rename Documentation/fb/{framebuffer.txt => framebuffer.rst} (92%)
 rename Documentation/fb/{gxfb.txt => gxfb.rst} (60%)
 create mode 100644 Documentation/fb/index.rst
 rename Documentation/fb/{intel810.txt => intel810.rst} (83%)
 rename Documentation/fb/{intelfb.txt => intelfb.rst} (73%)
 rename Documentation/fb/{internals.txt => internals.rst} (82%)
 rename Documentation/fb/{lxfb.txt => lxfb.rst} (60%)
 create mode 100644 Documentation/fb/matroxfb.rst
 delete mode 100644 Documentation/fb/matroxfb.txt
 rename Documentation/fb/{metronomefb.txt => metronomefb.rst} (98%)
 rename Documentation/fb/{modedb.txt => modedb.rst} (87%)
 create mode 100644 Documentation/fb/pvr2fb.rst
 delete mode 100644 Documentation/fb/pvr2fb.txt
 rename Documentation/fb/{pxafb.txt => pxafb.rst} (78%)
 rename Documentation/fb/{s3fb.txt => s3fb.rst} (94%)
 rename Documentation/fb/{sa1100fb.txt => sa1100fb.rst} (64%)
 create mode 100644 Documentation/fb/sh7760fb.rst
 delete mode 100644 Documentation/fb/sh7760fb.txt
 rename Documentation/fb/{sisfb.txt => sisfb.rst} (85%)
 rename Documentation/fb/{sm501.txt => sm501.rst} (65%)
 rename Documentation/fb/{sm712fb.txt => sm712fb.rst} (59%)
 create mode 100644 Documentation/fb/sstfb.rst
 delete mode 100644 Documentation/fb/sstfb.txt
 rename Documentation/fb/{tgafb.txt => tgafb.rst} (71%)
 rename Documentation/fb/{tridentfb.txt => tridentfb.rst} (70%)
 rename Documentation/fb/{udlfb.txt => udlfb.rst} (77%)
 rename Documentation/fb/{uvesafb.txt => uvesafb.rst} (52%)
 rename Documentation/fb/{vesafb.txt => vesafb.rst} (57%)
 create mode 100644 Documentation/fb/viafb.rst
 delete mode 100644 Documentation/fb/viafb.txt
 rename Documentation/fb/{vt8623fb.txt => vt8623fb.rst} (85%)
 create mode 100644 Documentation/filesystems/vfs.rst
 delete mode 100644 Documentation/filesystems/vfs.txt
 rename Documentation/fpga/{dfl.txt => dfl.rst} (89%)
 create mode 100644 Documentation/fpga/index.rst
 create mode 100644 Documentation/ide/changelogs.rst
 rename Documentation/ide/{ide-tape.txt => ide-tape.rst} (83%)
 rename Documentation/ide/{ide.txt => ide.rst} (72%)
 create mode 100644 Documentation/ide/index.rst
 rename Documentation/ide/{warm-plug-howto.txt => warm-plug-howto.rst} (61%)
 rename Documentation/kbuild/{headers_install.txt => headers_install.rst} (96%)
 create mode 100644 Documentation/kbuild/index.rst
 create mode 100644 Documentation/kbuild/issues.rst
 rename Documentation/kbuild/{kbuild.txt => kbuild.rst} (72%)
 rename Documentation/kbuild/{kconfig-language.txt => kconfig-language.rst} (85%)
 rename Documentation/kbuild/{kconfig-macro-language.txt => kconfig-macro-language.rst} (94%)
 rename Documentation/kbuild/{kconfig.txt => kconfig.rst} (80%)
 rename Documentation/kbuild/{makefiles.txt => makefiles.rst} (83%)
 rename Documentation/kbuild/{modules.txt => modules.rst} (84%)
 create mode 100644 Documentation/kdump/index.rst
 rename Documentation/kdump/{kdump.txt => kdump.rst} (91%)
 rename Documentation/kdump/{vmcoreinfo.txt => vmcoreinfo.rst} (95%)
 create mode 100644 Documentation/maintainer/rebasing-and-merging.rst
 create mode 100644 Documentation/mic/index.rst
 rename Documentation/mic/{mic_overview.txt => mic_overview.rst} (96%)
 rename Documentation/mic/{scif_overview.txt => scif_overview.rst} (76%)
 rename Documentation/netlabel/{cipso_ipv4.txt => cipso_ipv4.rst} (87%)
 create mode 100644 Documentation/netlabel/draft_ietf.rst
 create mode 100644 Documentation/netlabel/index.rst
 rename Documentation/netlabel/{introduction.txt => introduction.rst} (91%)
 rename Documentation/netlabel/{lsm_interface.txt => lsm_interface.rst} (88%)
 rename Documentation/pcmcia/{devicetable.txt => devicetable.rst} (97%)
 rename Documentation/pcmcia/{driver-changes.txt => driver-changes.rst} (90%)
 rename Documentation/pcmcia/{driver.txt => driver.rst} (66%)
 create mode 100644 Documentation/pcmcia/index.rst
 rename Documentation/pcmcia/{locking.txt => locking.rst} (81%)
 delete mode 100644 Documentation/platform/x86-laptop-drivers.txt
 create mode 100644 Documentation/riscv/index.rst
 rename Documentation/riscv/{pmu.txt => pmu.rst} (77%)
 rename Documentation/scheduler/{completion.txt => completion.rst} (94%)
 create mode 100644 Documentation/scheduler/index.rst
 rename Documentation/scheduler/{sched-arch.txt => sched-arch.rst} (81%)
 rename Documentation/scheduler/{sched-bwc.txt => sched-bwc.rst} (90%)
 rename Documentation/scheduler/{sched-deadline.txt => sched-deadline.rst} (88%)
 rename Documentation/scheduler/{sched-design-CFS.txt => sched-design-CFS.rst} (97%)
 rename Documentation/scheduler/{sched-domains.txt => sched-domains.rst} (97%)
 rename Documentation/scheduler/{sched-energy.txt => sched-energy.rst} (96%)
 rename Documentation/scheduler/{sched-nice-design.txt => sched-nice-design.rst} (98%)
 rename Documentation/scheduler/{sched-rt-group.txt => sched-rt-group.rst} (95%)
 rename Documentation/scheduler/{sched-stats.txt => sched-stats.rst} (91%)
 create mode 100644 Documentation/scheduler/text_files.rst
 create mode 100644 Documentation/sphinx/automarkup.py
 create mode 100644 Documentation/target/index.rst
 create mode 100644 Documentation/target/scripts.rst
 create mode 100644 Documentation/target/tcm_mod_builder.rst
 delete mode 100644 Documentation/target/tcm_mod_builder.txt
 rename Documentation/target/{tcmu-design.txt => tcmu-design.rst} (69%)
 rename Documentation/timers/{highres.txt => highres.rst} (98%)
 rename Documentation/timers/{hpet.txt => hpet.rst} (91%)
 rename Documentation/timers/{hrtimers.txt => hrtimers.rst} (98%)
 create mode 100644 Documentation/timers/index.rst
 rename Documentation/timers/{NO_HZ.txt => no_hz.rst} (93%)
 rename Documentation/timers/{timekeeping.txt => timekeeping.rst} (98%)
 rename Documentation/timers/{timers-howto.txt => timers-howto.rst} (93%)
 create mode 100644 Documentation/translations/it_IT/admin-guide/kernel-parameters.rst
 delete mode 100644 Documentation/translations/zh_CN/basic_profiling.txt
 rename Documentation/watchdog/{convert_drivers_to_kernel_api.txt => convert_drivers_to_kernel_api.rst} (75%)
 rename Documentation/watchdog/{hpwdt.txt => hpwdt.rst} (78%)
 create mode 100644 Documentation/watchdog/index.rst
 rename Documentation/watchdog/{mlx-wdt.txt => mlx-wdt.rst} (78%)
 rename Documentation/watchdog/{pcwd-watchdog.txt => pcwd-watchdog.rst} (89%)
 rename Documentation/watchdog/{watchdog-api.txt => watchdog-api.rst} (80%)
 rename Documentation/watchdog/{watchdog-kernel-api.txt => watchdog-kernel-api.rst} (90%)
 create mode 100644 Documentation/watchdog/watchdog-parameters.rst
 delete mode 100644 Documentation/watchdog/watchdog-parameters.txt
 rename Documentation/watchdog/{watchdog-pm.txt => watchdog-pm.rst} (92%)
 rename Documentation/watchdog/{wdt.txt => wdt.rst} (68%)
 rename Documentation/xilinx/{eemi.txt => eemi.rst} (92%)
 create mode 100644 Documentation/xilinx/index.rst
