Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C58C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 06:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85CCE2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 06:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbfIPGT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 02:19:27 -0400
Received: from ms.lwn.net ([45.79.88.28]:49884 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729398AbfIPGT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 02:19:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 915E1301;
        Mon, 16 Sep 2019 06:19:23 +0000 (UTC)
Date:   Mon, 16 Sep 2019 00:19:18 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation for 5.4
Message-ID: <20190916001918.7c9b69f7@lwn.net>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit
d2eba640a4b96bc1bdc0f4a500b8b8d5e16725c8:

  docs: phy: Drop duplicate 'be made' (2019-07-26 08:15:26 -0600)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.4

for you to fetch changes up to fe013f8bc160d79c6e33bb66d9bb0cd24949274c:

  Documentation: kbuild: Add document about reproducible builds (2019-09-15 01:14:41 -0600)

----------------------------------------------------------------
It's a somewhat calmer cycle for docs this time, as the churn of the mass
RST conversion is happily mostly behind us.

 - A new document on reproducible builds.

 - We finally got around to zapping the documentation for hardware support
   that was removed in 2004; one doesn't want to rush these things.

 - The usual assortment of fixes, typo corrections, etc.

You'll still find a handful of annoying conflicts against other trees,
mostly tied to the last RST conversions; resolutions are straightforward
and the linux-next ones are good.

----------------------------------------------------------------
Adam Borowski (1):
      Documentation: sysrq: don't recommend 'S' 'U' before 'B'

Alex Shi (1):
      docs/zh_CN: update Chinese howto.rst for latexdocs making

Andy Shevchenko (2):
      coda: Fix typo in the struct CodaCred documentation
      kernel-doc: Allow anonymous enum

Ben Hutchings (1):
      Documentation: kbuild: Add document about reproducible builds

Chao Yu (3):
      mailmap: add entry to connect my email addresses
      mailmap: add entry for Gao Xiang
      mailmap: add entry for Jaegeuk Kim

Colin Ian King (1):
      Input: docs: fix spelling mistake "potocol" -> "protocol"

Federico Vaga (3):
      doc:it_IT: align translation to mainline
      doc: email-clients miscellaneous fixes
      doc:lock: remove reference to clever use of read-write lock

Geert Uytterhoeven (1):
      docs: arm: Remove orphan sh-mobile directory

Ian Abbott (1):
      devices.txt: improve entry for comedi (char major 98)

Jacob Huisman (1):
      docs: process: fix broken link

Jarkko Sakkinen (1):
      tpm: Document UEFI event log quirks

Joe Perches (1):
      docs: printk-formats: Stop encouraging use of unnecessary %h[xudi] and %hh[xudi]

John Garry (1):
      docs: mtd: Update spi nor reference driver

Jonathan Neuschäfer (5):
      Documentation: sphinx: Add missing comma to list of strings
      Documentation: sphinx: Don't parse socket() as identifier reference
      Documentation/arm/sa1100: Remove some obsolete documentation
      Documentation/arm/sa1100/assabet: Fix 'make assabet_defconfig' command
      Documentation/arm/samsung-s3c24xx: Remove stray U+FEFF character to fix title

Marco Villegas (1):
      docs: Fix typo on pull requests guide

Mark Rutland (1):
      Documentation/features/locking: update lists

Mauro Carvalho Chehab (31):
      MAINTAINERS: add entries for some documentation scripts
      MAINTAINERS: fix broken ref for ABI sysfs-bus-counter-ftm-quaddec
      MAINTAINERS: fix reference to net phy ABI file
      MAINTAINERS: fix a renamed DT reference
      docs: cgroup-v1/blkio-controller.rst: remove a CFQ left over
      docs: zh_CN: howto.rst: fix a broken reference
      docs: riscv: convert boot-image-header.txt to ReST
      docs: thermal: add it to the driver API
      docs: ubifs-authentication.md: convert to ReST
      docs: i2c: convert to ReST and add to driver-api bookset
      docs: ipmb: place it at driver-api and convert to ReST
      docs: packing: move it to core-api book and adjust markups
      docs: admin-guide: add auxdisplay files to it after conversion to ReST
      docs: README.buddha: convert to ReST and add to m68k book
      docs: parisc: convert to ReST and add to documentation body
      docs: openrisc: convert to ReST and add to documentation body
      docs: isdn: convert to ReST and add to kAPI bookset
      docs: fs: convert docs without extension to ReST
      docs: fs: convert porting to ReST
      docs: index.rst: don't use genindex for pdf output
      docs: wimax: convert to ReST and add to admin-guide
      docs: mips: add to the documentation body as ReST
      docs: hwmon: pxe1610: convert to ReST format and add to the index
      docs: nios2: add it to the main Documentation body
      docs: net: convert two README files to ReST format
      docs: fix a couple of new broken references
      docs: writing-schema.md: convert from markdown to ReST
      spi: docs: convert to ReST and add it to the kABI bookset
      docs: fs: cifs: convert to ReST and add to admin-guide book
      docs: w1: convert to ReST and add to the kAPI group of docs
      docs: fs: porting.rst: fix a broken reference to another doc

Palmer Dabbelt (1):
      Documentation: Add "earlycon=sbi" to the admin guide

Peter Wu (1):
      docs: ftrace: clarify when tracing is disabled by the trace file

Phong Tran (1):
      Documentation: coresight: convert txt to rst

Quentin Perret (1):
      mailmap: Update email address for Quentin Perret

Randy Dunlap (1):
      kernel-doc: ignore __printf attribute

Sheriff Esseson (2):
      Documentation: filesystem: fix "Removed Sysctls" table
      Documentation: virt: Fix broken reference to virt tree's index

Shobhit Kukreti (2):
      Documentation: filesystems: Convert jfs.txt to
      Documentation: filesystems: Convert ufs.txt to reStructuredText format

Todor Tomov (1):
      mailmap: Add an entry for my email address

lixianfa (1):
      doc: arm64: fix grammar dtb placed in no attributes region

 .mailmap                                           |  19 +-
 Documentation/ABI/stable/sysfs-bus-w1              |   2 +-
 Documentation/ABI/stable/sysfs-driver-w1_ds28e04   |   4 +-
 Documentation/ABI/stable/sysfs-driver-w1_ds28ea00  |   2 +-
 .../admin-guide/auxdisplay/cfag12864b.rst          |  98 +++
 Documentation/admin-guide/auxdisplay/index.rst     |  16 +
 Documentation/admin-guide/auxdisplay/ks0108.rst    |  50 ++
 .../admin-guide/cgroup-v1/blkio-controller.rst     |   6 -
 .../cifs/AUTHORS => admin-guide/cifs/authors.rst}  |  64 +-
 .../cifs/CHANGES => admin-guide/cifs/changes.rst}  |   4 +
 Documentation/admin-guide/cifs/index.rst           |  21 +
 .../cifs.txt => admin-guide/cifs/introduction.rst} |   8 +
 .../cifs/TODO => admin-guide/cifs/todo.rst}        |  87 ++-
 .../cifs/README => admin-guide/cifs/usage.rst}     | 562 ++++++++------
 .../cifs/winucase_convert.pl                       |   0
 Documentation/admin-guide/devices.txt              |  11 +-
 Documentation/admin-guide/index.rst                |   5 +
 .../{filesystems/jfs.txt => admin-guide/jfs.rst}   |  44 +-
 Documentation/admin-guide/kernel-parameters.txt    |   4 +
 Documentation/admin-guide/sysrq.rst                |  20 +-
 .../{filesystems/ufs.txt => admin-guide/ufs.rst}   |  36 +-
 .../README.i2400m => admin-guide/wimax/i2400m.rst} | 145 ++--
 Documentation/admin-guide/wimax/index.rst          |  19 +
 .../README.wimax => admin-guide/wimax/wimax.rst}   |  38 +-
 Documentation/admin-guide/xfs.rst                  |   5 +-
 Documentation/arm/sa1100/adsbitsy.rst              |  51 --
 Documentation/arm/sa1100/assabet.rst               |   2 +-
 Documentation/arm/sa1100/brutus.rst                |  69 --
 Documentation/arm/sa1100/freebird.rst              |  25 -
 Documentation/arm/sa1100/graphicsclient.rst        | 102 ---
 Documentation/arm/sa1100/graphicsmaster.rst        |  60 --
 Documentation/arm/sa1100/huw_webpanel.rst          |  21 -
 Documentation/arm/sa1100/index.rst                 |  12 -
 Documentation/arm/sa1100/itsy.rst                  |  47 --
 Documentation/arm/sa1100/nanoengine.rst            |  11 -
 Documentation/arm/sa1100/pangolin.rst              |  29 -
 Documentation/arm/sa1100/pleb.rst                  |  13 -
 Documentation/arm/sa1100/tifon.rst                 |   7 -
 Documentation/arm/sa1100/yopy.rst                  |   5 -
 Documentation/arm/samsung-s3c24xx/index.rst        |   2 +-
 Documentation/arm/sh-mobile/.gitignore             |   1 -
 Documentation/auxdisplay/cfag12864b                | 105 ---
 Documentation/auxdisplay/ks0108                    |  55 --
 Documentation/core-api/index.rst                   |   3 +-
 .../{packing.txt => core-api/packing.rst}          |  81 +-
 Documentation/core-api/printk-formats.rst          |  16 +-
 .../devicetree/bindings/i2c/i2c-mux-gpmux.txt      |   2 +-
 .../devicetree/bindings/sound/sun8i-a33-codec.txt  |   2 +-
 Documentation/devicetree/writing-schema.md         | 130 ----
 Documentation/devicetree/writing-schema.rst        | 153 ++++
 Documentation/driver-api/dmaengine/index.rst       |   2 +-
 Documentation/driver-api/index.rst                 |   2 +
 Documentation/driver-api/ipmb.rst                  |   2 +-
 Documentation/driver-api/mtd/spi-nor.rst           |   2 +-
 Documentation/driver-api/soundwire/index.rst       |   2 +-
 .../{ => driver-api}/thermal/cpu-cooling-api.rst   |   0
 .../{ => driver-api}/thermal/exynos_thermal.rst    |   0
 .../thermal/exynos_thermal_emulation.rst           |   0
 Documentation/{ => driver-api}/thermal/index.rst   |   2 +-
 .../{ => driver-api}/thermal/intel_powerclamp.rst  |   0
 .../{ => driver-api}/thermal/nouveau_thermal.rst   |   0
 .../{ => driver-api}/thermal/power_allocator.rst   |   0
 .../{ => driver-api}/thermal/sysfs-api.rst         |  12 +-
 .../thermal/x86_pkg_temperature_thermal.rst        |   2 +-
 .../locking/queued-rwlocks/arch-support.txt        |   2 +-
 .../locking/queued-spinlocks/arch-support.txt      |   4 +-
 .../locking/rwsem-optimized/arch-support.txt       |  34 -
 Documentation/filesystems/coda.txt                 |   4 +-
 .../{directory-locking => directory-locking.rst}   |  40 +-
 Documentation/filesystems/index.rst                |   4 +
 Documentation/filesystems/{Locking => locking.rst} | 259 +++++--
 .../filesystems/nfs/{Exporting => exporting.rst}   |  31 +-
 Documentation/filesystems/porting                  | 686 -----------------
 Documentation/filesystems/porting.rst              | 852 +++++++++++++++++++++
 ...-authentication.md => ubifs-authentication.rst} |  70 +-
 Documentation/filesystems/vfs.rst                  |   2 +-
 Documentation/hwmon/adm1021.rst                    |   2 +-
 Documentation/hwmon/adm1275.rst                    |   2 +-
 Documentation/hwmon/hih6130.rst                    |   2 +-
 Documentation/hwmon/ibm-cffps.rst                  |   2 +-
 Documentation/hwmon/index.rst                      |   1 +
 Documentation/hwmon/lm25066.rst                    |   2 +-
 Documentation/hwmon/max16064.rst                   |   2 +-
 Documentation/hwmon/max16065.rst                   |   2 +-
 Documentation/hwmon/max20751.rst                   |   2 +-
 Documentation/hwmon/max34440.rst                   |   2 +-
 Documentation/hwmon/max6650.rst                    |   2 +-
 Documentation/hwmon/max8688.rst                    |   2 +-
 Documentation/hwmon/menf21bmc.rst                  |   2 +-
 Documentation/hwmon/pcf8591.rst                    |   2 +-
 Documentation/hwmon/{pxe1610 => pxe1610.rst}       |  33 +-
 Documentation/hwmon/sht3x.rst                      |   2 +-
 Documentation/hwmon/shtc1.rst                      |   2 +-
 Documentation/hwmon/tmp103.rst                     |   2 +-
 Documentation/hwmon/tps40422.rst                   |   2 +-
 Documentation/hwmon/ucd9000.rst                    |   2 +-
 Documentation/hwmon/ucd9200.rst                    |   2 +-
 Documentation/hwmon/via686a.rst                    |   2 +-
 Documentation/hwmon/zl6100.rst                     |   2 +-
 .../i2c/busses/{i2c-ali1535 => i2c-ali1535.rst}    |  13 +-
 .../i2c/busses/{i2c-ali1563 => i2c-ali1563.rst}    |   3 +
 .../i2c/busses/{i2c-ali15x3 => i2c-ali15x3.rst}    |  64 +-
 Documentation/i2c/busses/i2c-amd-mp2               |  23 -
 Documentation/i2c/busses/i2c-amd-mp2.rst           |  25 +
 .../i2c/busses/{i2c-amd756 => i2c-amd756.rst}      |   8 +-
 .../i2c/busses/{i2c-amd8111 => i2c-amd8111.rst}    |  14 +-
 .../busses/{i2c-diolan-u2c => i2c-diolan-u2c.rst}  |   3 +
 .../i2c/busses/{i2c-i801 => i2c-i801.rst}          |  33 +-
 .../i2c/busses/{i2c-ismt => i2c-ismt.rst}          |  20 +-
 .../i2c/busses/{i2c-mlxcpld => i2c-mlxcpld.rst}    |   6 +
 .../i2c/busses/{i2c-nforce2 => i2c-nforce2.rst}    |  33 +-
 .../busses/{i2c-nvidia-gpu => i2c-nvidia-gpu.rst}  |   6 +-
 .../i2c/busses/{i2c-ocores => i2c-ocores.rst}      |  22 +-
 Documentation/i2c/busses/i2c-parport               | 178 -----
 .../{i2c-parport-light => i2c-parport-light.rst}   |   8 +-
 Documentation/i2c/busses/i2c-parport.rst           | 190 +++++
 .../i2c/busses/{i2c-pca-isa => i2c-pca-isa.rst}    |   9 +-
 .../i2c/busses/{i2c-piix4 => i2c-piix4.rst}        |  18 +-
 .../i2c/busses/{i2c-sis5595 => i2c-sis5595.rst}    |  19 +-
 Documentation/i2c/busses/i2c-sis630                |  58 --
 Documentation/i2c/busses/i2c-sis630.rst            |  63 ++
 .../i2c/busses/{i2c-sis96x => i2c-sis96x.rst}      |  31 +-
 .../i2c/busses/{i2c-taos-evm => i2c-taos-evm.rst}  |   8 +-
 Documentation/i2c/busses/{i2c-via => i2c-via.rst}  |  28 +-
 .../i2c/busses/{i2c-viapro => i2c-viapro.rst}      |  12 +-
 Documentation/i2c/busses/index.rst                 |  33 +
 .../i2c/busses/{scx200_acb => scx200_acb.rst}      |   9 +-
 .../i2c/{dev-interface => dev-interface.rst}       | 104 +--
 .../{DMA-considerations => dma-considerations.rst} |   0
 Documentation/i2c/{fault-codes => fault-codes.rst} |   5 +-
 .../i2c/{functionality => functionality.rst}       |  22 +-
 ...io-fault-injection => gpio-fault-injection.rst} |  12 +-
 .../i2c/{i2c-protocol => i2c-protocol.rst}         |  28 +-
 Documentation/i2c/{i2c-stub => i2c-stub.rst}       |  20 +-
 .../i2c/{i2c-topology => i2c-topology.rst}         |  68 +-
 Documentation/i2c/index.rst                        |  37 +
 ...antiating-devices => instantiating-devices.rst} |  45 +-
 .../i2c/muxes/{i2c-mux-gpio => i2c-mux-gpio.rst}   |  26 +-
 ...module-parameters => old-module-parameters.rst} |  27 +-
 ...ave-eeprom-backend => slave-eeprom-backend.rst} |   4 +-
 .../i2c/{slave-interface => slave-interface.rst}   |  33 +-
 .../i2c/{smbus-protocol => smbus-protocol.rst}     |  86 ++-
 Documentation/i2c/{summary => summary.rst}         |   6 +-
 .../{ten-bit-addresses => ten-bit-addresses.rst}   |   5 +
 .../{upgrading-clients => upgrading-clients.rst}   | 204 ++---
 .../i2c/{writing-clients => writing-clients.rst}   |  94 ++-
 Documentation/index.rst                            |  10 +-
 Documentation/input/multi-touch-protocol.rst       |   2 +-
 Documentation/isdn/{README.avmb1 => avmb1.rst}     | 229 ++++--
 Documentation/isdn/{CREDITS => credits.rst}        |   7 +-
 Documentation/isdn/{README.gigaset => gigaset.rst} | 292 ++++---
 Documentation/isdn/{README.hysdn => hysdn.rst}     | 125 +--
 Documentation/isdn/index.rst                       |  24 +
 .../isdn/{INTERFACE.CAPI => interface_capi.rst}    | 174 +++--
 Documentation/isdn/{README.mISDN => m_isdn.rst}    |   5 +-
 Documentation/kbuild/index.rst                     |   1 +
 Documentation/kbuild/reproducible-builds.rst       | 122 +++
 Documentation/locking/spinlocks.rst                |  12 -
 .../m68k/{README.buddha => buddha-driver.rst}      |  95 ++-
 Documentation/m68k/index.rst                       |   1 +
 Documentation/maintainer/pull-requests.rst         |   2 +-
 .../mips/{AU1xxx_IDE.README => au1xxx_ide.rst}     |  89 ++-
 Documentation/mips/index.rst                       |  17 +
 Documentation/networking/caif/{README => caif.rst} |  88 ++-
 Documentation/networking/device_drivers/index.rst  |   2 +-
 Documentation/networking/index.rst                 |   2 +-
 .../mac80211_hwsim/{README => mac80211_hwsim.rst}  |  28 +-
 Documentation/nios2/{README => nios2.rst}          |   1 +
 Documentation/openrisc/index.rst                   |  18 +
 .../openrisc/{README => openrisc_port.rst}         |  25 +-
 Documentation/openrisc/{TODO => todo.rst}          |   9 +-
 Documentation/parisc/{debugging => debugging.rst}  |   7 +
 Documentation/parisc/index.rst                     |  18 +
 Documentation/parisc/{registers => registers.rst}  |  59 +-
 Documentation/process/email-clients.rst            |  20 +-
 Documentation/process/howto.rst                    |   2 +-
 Documentation/process/submitting-patches.rst       |   2 +-
 ...boot-image-header.txt => boot-image-header.rst} |  39 +-
 Documentation/riscv/index.rst                      |   1 +
 Documentation/security/tpm/index.rst               |   1 +
 Documentation/security/tpm/tpm_event_log.rst       |  55 ++
 Documentation/sound/index.rst                      |   2 +-
 Documentation/sphinx/automarkup.py                 |   5 +-
 Documentation/spi/{butterfly => butterfly.rst}     |  44 +-
 Documentation/spi/index.rst                        |  22 +
 Documentation/spi/{pxa2xx => pxa2xx.rst}           |  95 +--
 Documentation/spi/{spi-lm70llp => spi-lm70llp.rst} |  17 +-
 .../spi/{spi-sc18is602 => spi-sc18is602.rst}       |   5 +-
 Documentation/spi/{spi-summary => spi-summary.rst} | 105 +--
 Documentation/spi/{spidev => spidev.rst}           |  30 +-
 ...sight-cpu-debug.txt => coresight-cpu-debug.rst} |  67 +-
 .../trace/{coresight.txt => coresight.rst}         | 372 ++++-----
 Documentation/trace/ftrace.rst                     |  13 +-
 Documentation/trace/index.rst                      |   2 +
 .../translations/it_IT/process/changes.rst         |  22 +-
 Documentation/translations/it_IT/process/howto.rst |   2 +-
 .../it_IT/process/submitting-patches.rst           |   2 +-
 Documentation/translations/ja_JP/SubmittingPatches |   2 +-
 Documentation/translations/ja_JP/howto.rst         |   2 +-
 Documentation/translations/ko_KR/howto.rst         |   2 +-
 Documentation/translations/zh_CN/arm64/booting.txt |   4 +-
 Documentation/translations/zh_CN/process/howto.rst |  14 +-
 .../zh_CN/process/submitting-patches.rst           |   2 +-
 Documentation/w1/index.rst                         |  21 +
 Documentation/w1/masters/{ds2482 => ds2482.rst}    |  16 +-
 Documentation/w1/masters/{ds2490 => ds2490.rst}    |   6 +-
 Documentation/w1/masters/index.rst                 |  14 +
 Documentation/w1/masters/mxc-w1                    |  12 -
 Documentation/w1/masters/mxc-w1.rst                |  17 +
 .../w1/masters/{omap-hdq => omap-hdq.rst}          |  12 +-
 Documentation/w1/masters/{w1-gpio => w1-gpio.rst}  |  21 +-
 Documentation/w1/slaves/index.rst                  |  16 +
 .../w1/slaves/{w1_ds2406 => w1_ds2406.rst}         |   4 +-
 .../w1/slaves/{w1_ds2413 => w1_ds2413.rst}         |   9 +
 Documentation/w1/slaves/w1_ds2423                  |  47 --
 Documentation/w1/slaves/w1_ds2423.rst              |  54 ++
 .../w1/slaves/{w1_ds2438 => w1_ds2438.rst}         |  10 +-
 .../w1/slaves/{w1_ds28e04 => w1_ds28e04.rst}       |   5 +
 .../w1/slaves/{w1_ds28e17 => w1_ds28e17.rst}       |  16 +-
 Documentation/w1/slaves/{w1_therm => w1_therm.rst} |  11 +-
 Documentation/w1/{w1.generic => w1-generic.rst}    |  88 ++-
 Documentation/w1/{w1.netlink => w1-netlink.rst}    |  89 ++-
 MAINTAINERS                                        |  86 ++-
 drivers/auxdisplay/Kconfig                         |   2 +-
 drivers/hwmon/atxp1.c                              |   2 +-
 drivers/hwmon/smm665.c                             |   2 +-
 drivers/hwtracing/coresight/Kconfig                |   2 +-
 drivers/i2c/Kconfig                                |   4 +-
 drivers/i2c/busses/Kconfig                         |   2 +-
 drivers/i2c/busses/i2c-i801.c                      |   2 +-
 drivers/i2c/busses/i2c-taos-evm.c                  |   2 +-
 drivers/i2c/i2c-core-base.c                        |   4 +-
 drivers/iio/dummy/iio_simple_dummy.c               |   4 +-
 drivers/rtc/rtc-ds1374.c                           |   2 +-
 drivers/spi/Kconfig                                |   2 +-
 drivers/spi/spi-butterfly.c                        |   2 +-
 drivers/spi/spi-lm70llp.c                          |   2 +-
 drivers/staging/isdn/hysdn/Kconfig                 |   2 +-
 fs/cifs/export.c                                   |   2 +-
 fs/exportfs/expfs.c                                |   2 +-
 fs/isofs/export.c                                  |   2 +-
 fs/jfs/Kconfig                                     |   2 +-
 fs/orangefs/file.c                                 |   2 +-
 fs/orangefs/orangefs-kernel.h                      |   2 +-
 fs/ufs/Kconfig                                     |   2 +-
 include/linux/dcache.h                             |   2 +-
 include/linux/exportfs.h                           |   2 +-
 include/linux/i2c.h                                |   2 +-
 include/linux/platform_data/sc18is602.h            |   2 +-
 include/linux/thermal.h                            |   4 +-
 scripts/kernel-doc                                 |   3 +-
 251 files changed, 5192 insertions(+), 3969 deletions(-)
 create mode 100644 Documentation/admin-guide/auxdisplay/cfag12864b.rst
 create mode 100644 Documentation/admin-guide/auxdisplay/index.rst
 create mode 100644 Documentation/admin-guide/auxdisplay/ks0108.rst
 rename Documentation/{filesystems/cifs/AUTHORS => admin-guide/cifs/authors.rst} (60%)
 rename Documentation/{filesystems/cifs/CHANGES => admin-guide/cifs/changes.rst} (91%)
 create mode 100644 Documentation/admin-guide/cifs/index.rst
 rename Documentation/{filesystems/cifs/cifs.txt => admin-guide/cifs/introduction.rst} (98%)
 rename Documentation/{filesystems/cifs/TODO => admin-guide/cifs/todo.rst} (58%)
 rename Documentation/{filesystems/cifs/README => admin-guide/cifs/usage.rst} (72%)
 rename Documentation/{filesystems => admin-guide}/cifs/winucase_convert.pl (100%)
 rename Documentation/{filesystems/jfs.txt => admin-guide/jfs.rst} (51%)
 rename Documentation/{filesystems/ufs.txt => admin-guide/ufs.rst} (69%)
 rename Documentation/{wimax/README.i2400m => admin-guide/wimax/i2400m.rst} (69%)
 create mode 100644 Documentation/admin-guide/wimax/index.rst
 rename Documentation/{wimax/README.wimax => admin-guide/wimax/wimax.rst} (74%)
 delete mode 100644 Documentation/arm/sa1100/adsbitsy.rst
 delete mode 100644 Documentation/arm/sa1100/brutus.rst
 delete mode 100644 Documentation/arm/sa1100/freebird.rst
 delete mode 100644 Documentation/arm/sa1100/graphicsclient.rst
 delete mode 100644 Documentation/arm/sa1100/graphicsmaster.rst
 delete mode 100644 Documentation/arm/sa1100/huw_webpanel.rst
 delete mode 100644 Documentation/arm/sa1100/itsy.rst
 delete mode 100644 Documentation/arm/sa1100/nanoengine.rst
 delete mode 100644 Documentation/arm/sa1100/pangolin.rst
 delete mode 100644 Documentation/arm/sa1100/pleb.rst
 delete mode 100644 Documentation/arm/sa1100/tifon.rst
 delete mode 100644 Documentation/arm/sa1100/yopy.rst
 delete mode 100644 Documentation/arm/sh-mobile/.gitignore
 delete mode 100644 Documentation/auxdisplay/cfag12864b
 delete mode 100644 Documentation/auxdisplay/ks0108
 rename Documentation/{packing.txt => core-api/packing.rst} (61%)
 delete mode 100644 Documentation/devicetree/writing-schema.md
 create mode 100644 Documentation/devicetree/writing-schema.rst
 rename Documentation/{ => driver-api}/thermal/cpu-cooling-api.rst (100%)
 rename Documentation/{ => driver-api}/thermal/exynos_thermal.rst (100%)
 rename Documentation/{ => driver-api}/thermal/exynos_thermal_emulation.rst (100%)
 rename Documentation/{ => driver-api}/thermal/index.rst (86%)
 rename Documentation/{ => driver-api}/thermal/intel_powerclamp.rst (100%)
 rename Documentation/{ => driver-api}/thermal/nouveau_thermal.rst (100%)
 rename Documentation/{ => driver-api}/thermal/power_allocator.rst (100%)
 rename Documentation/{ => driver-api}/thermal/sysfs-api.rst (98%)
 rename Documentation/{ => driver-api}/thermal/x86_pkg_temperature_thermal.rst (94%)
 delete mode 100644 Documentation/features/locking/rwsem-optimized/arch-support.txt
 rename Documentation/filesystems/{directory-locking => directory-locking.rst} (86%)
 rename Documentation/filesystems/{Locking => locking.rst} (79%)
 rename Documentation/filesystems/nfs/{Exporting => exporting.rst} (91%)
 delete mode 100644 Documentation/filesystems/porting
 create mode 100644 Documentation/filesystems/porting.rst
 rename Documentation/filesystems/{ubifs-authentication.md => ubifs-authentication.rst} (95%)
 rename Documentation/hwmon/{pxe1610 => pxe1610.rst} (82%)
 rename Documentation/i2c/busses/{i2c-ali1535 => i2c-ali1535.rst} (82%)
 rename Documentation/i2c/busses/{i2c-ali1563 => i2c-ali1563.rst} (93%)
 rename Documentation/i2c/busses/{i2c-ali15x3 => i2c-ali15x3.rst} (72%)
 delete mode 100644 Documentation/i2c/busses/i2c-amd-mp2
 create mode 100644 Documentation/i2c/busses/i2c-amd-mp2.rst
 rename Documentation/i2c/busses/{i2c-amd756 => i2c-amd756.rst} (79%)
 rename Documentation/i2c/busses/{i2c-amd8111 => i2c-amd8111.rst} (66%)
 rename Documentation/i2c/busses/{i2c-diolan-u2c => i2c-diolan-u2c.rst} (91%)
 rename Documentation/i2c/busses/{i2c-i801 => i2c-i801.rst} (89%)
 rename Documentation/i2c/busses/{i2c-ismt => i2c-ismt.rst} (81%)
 rename Documentation/i2c/busses/{i2c-mlxcpld => i2c-mlxcpld.rst} (88%)
 rename Documentation/i2c/busses/{i2c-nforce2 => i2c-nforce2.rst} (58%)
 rename Documentation/i2c/busses/{i2c-nvidia-gpu => i2c-nvidia-gpu.rst} (63%)
 rename Documentation/i2c/busses/{i2c-ocores => i2c-ocores.rst} (82%)
 delete mode 100644 Documentation/i2c/busses/i2c-parport
 rename Documentation/i2c/busses/{i2c-parport-light => i2c-parport-light.rst} (91%)
 create mode 100644 Documentation/i2c/busses/i2c-parport.rst
 rename Documentation/i2c/busses/{i2c-pca-isa => i2c-pca-isa.rst} (72%)
 rename Documentation/i2c/busses/{i2c-piix4 => i2c-piix4.rst} (92%)
 rename Documentation/i2c/busses/{i2c-sis5595 => i2c-sis5595.rst} (74%)
 delete mode 100644 Documentation/i2c/busses/i2c-sis630
 create mode 100644 Documentation/i2c/busses/i2c-sis630.rst
 rename Documentation/i2c/busses/{i2c-sis96x => i2c-sis96x.rst} (74%)
 rename Documentation/i2c/busses/{i2c-taos-evm => i2c-taos-evm.rst} (91%)
 rename Documentation/i2c/busses/{i2c-via => i2c-via.rst} (54%)
 rename Documentation/i2c/busses/{i2c-viapro => i2c-viapro.rst} (87%)
 create mode 100644 Documentation/i2c/busses/index.rst
 rename Documentation/i2c/busses/{scx200_acb => scx200_acb.rst} (86%)
 rename Documentation/i2c/{dev-interface => dev-interface.rst} (71%)
 rename Documentation/i2c/{DMA-considerations => dma-considerations.rst} (100%)
 rename Documentation/i2c/{fault-codes => fault-codes.rst} (98%)
 rename Documentation/i2c/{functionality => functionality.rst} (91%)
 rename Documentation/i2c/{gpio-fault-injection => gpio-fault-injection.rst} (97%)
 rename Documentation/i2c/{i2c-protocol => i2c-protocol.rst} (83%)
 rename Documentation/i2c/{i2c-stub => i2c-stub.rst} (93%)
 rename Documentation/i2c/{i2c-topology => i2c-topology.rst} (89%)
 create mode 100644 Documentation/i2c/index.rst
 rename Documentation/i2c/{instantiating-devices => instantiating-devices.rst} (93%)
 rename Documentation/i2c/muxes/{i2c-mux-gpio => i2c-mux-gpio.rst} (85%)
 rename Documentation/i2c/{old-module-parameters => old-module-parameters.rst} (75%)
 rename Documentation/i2c/{slave-eeprom-backend => slave-eeprom-backend.rst} (90%)
 rename Documentation/i2c/{slave-interface => slave-interface.rst} (94%)
 rename Documentation/i2c/{smbus-protocol => smbus-protocol.rst} (82%)
 rename Documentation/i2c/{summary => summary.rst} (96%)
 rename Documentation/i2c/{ten-bit-addresses => ten-bit-addresses.rst} (95%)
 rename Documentation/i2c/{upgrading-clients => upgrading-clients.rst} (54%)
 rename Documentation/i2c/{writing-clients => writing-clients.rst} (91%)
 rename Documentation/isdn/{README.avmb1 => avmb1.rst} (50%)
 rename Documentation/isdn/{CREDITS => credits.rst} (96%)
 rename Documentation/isdn/{README.gigaset => gigaset.rst} (74%)
 rename Documentation/isdn/{README.hysdn => hysdn.rst} (80%)
 create mode 100644 Documentation/isdn/index.rst
 rename Documentation/isdn/{INTERFACE.CAPI => interface_capi.rst} (75%)
 rename Documentation/isdn/{README.mISDN => m_isdn.rst} (89%)
 create mode 100644 Documentation/kbuild/reproducible-builds.rst
 rename Documentation/m68k/{README.buddha => buddha-driver.rst} (73%)
 rename Documentation/mips/{AU1xxx_IDE.README => au1xxx_ide.rst} (67%)
 create mode 100644 Documentation/mips/index.rst
 rename Documentation/networking/caif/{README => caif.rst} (70%)
 rename Documentation/networking/mac80211_hwsim/{README => mac80211_hwsim.rst} (81%)
 rename Documentation/nios2/{README => nios2.rst} (96%)
 create mode 100644 Documentation/openrisc/index.rst
 rename Documentation/openrisc/{README => openrisc_port.rst} (80%)
 rename Documentation/openrisc/{TODO => todo.rst} (78%)
 rename Documentation/parisc/{debugging => debugging.rst} (94%)
 create mode 100644 Documentation/parisc/index.rst
 rename Documentation/parisc/{registers => registers.rst} (70%)
 rename Documentation/riscv/{boot-image-header.txt => boot-image-header.rst} (72%)
 create mode 100644 Documentation/security/tpm/tpm_event_log.rst
 rename Documentation/spi/{butterfly => butterfly.rst} (71%)
 create mode 100644 Documentation/spi/index.rst
 rename Documentation/spi/{pxa2xx => pxa2xx.rst} (83%)
 rename Documentation/spi/{spi-lm70llp => spi-lm70llp.rst} (88%)
 rename Documentation/spi/{spi-sc18is602 => spi-sc18is602.rst} (92%)
 rename Documentation/spi/{spi-summary => spi-summary.rst} (93%)
 rename Documentation/spi/{spidev => spidev.rst} (90%)
 rename Documentation/trace/{coresight-cpu-debug.txt => coresight-cpu-debug.rst} (84%)
 rename Documentation/trace/{coresight.txt => coresight.rst} (56%)
 create mode 100644 Documentation/w1/index.rst
 rename Documentation/w1/masters/{ds2482 => ds2482.rst} (71%)
 rename Documentation/w1/masters/{ds2490 => ds2490.rst} (98%)
 create mode 100644 Documentation/w1/masters/index.rst
 delete mode 100644 Documentation/w1/masters/mxc-w1
 create mode 100644 Documentation/w1/masters/mxc-w1.rst
 rename Documentation/w1/masters/{omap-hdq => omap-hdq.rst} (90%)
 rename Documentation/w1/masters/{w1-gpio => w1-gpio.rst} (75%)
 create mode 100644 Documentation/w1/slaves/index.rst
 rename Documentation/w1/slaves/{w1_ds2406 => w1_ds2406.rst} (96%)
 rename Documentation/w1/slaves/{w1_ds2413 => w1_ds2413.rst} (81%)
 delete mode 100644 Documentation/w1/slaves/w1_ds2423
 create mode 100644 Documentation/w1/slaves/w1_ds2423.rst
 rename Documentation/w1/slaves/{w1_ds2438 => w1_ds2438.rst} (93%)
 rename Documentation/w1/slaves/{w1_ds28e04 => w1_ds28e04.rst} (93%)
 rename Documentation/w1/slaves/{w1_ds28e17 => w1_ds28e17.rst} (88%)
 rename Documentation/w1/slaves/{w1_therm => w1_therm.rst} (95%)
 rename Documentation/w1/{w1.generic => w1-generic.rst} (59%)
 rename Documentation/w1/{w1.netlink => w1-netlink.rst} (77%)
