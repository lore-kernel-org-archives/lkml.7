Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F351AC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 20:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D0221479
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 20:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560891304;
	bh=hcQOiXiUlLdpQavtM5lQlIaKL+LyjDqwlx+ZalQYgzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vKlkJq7YaV8QHkkiUSWn4ASCkWZY9TV+hFGvL71sc2yP3CxEeJmtvE+oU+XBXB9pJ
	 mU8xpxirhaWaOu6S58lP+nQC4dtRFRmjgSBX2gFjkFIz4hV2+FfibWMWvGq0AbKvZc
	 ydSifFfXTubCQdZsIh4jZl9jURa6KecN1JrOkp78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730992AbfFRUzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 16:55:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50938 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730772AbfFRUx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 16:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xd8ftG/fTlUxVtmXvmQG8Iuh9fusMy5ANPML2tMEoOw=; b=LZdVyByb4gsvMcjGYSIt0ns3tu
        TmbQ4A47r31YJb+77l8UyKPsdwxuxVh7wOmO6I1GgkHnk8ritZhGMk615GjuOFs4uwJPAO7B74kMf
        jRKc2RG2232qnkbooIIJrNeh51kAfVuaiZyUirvrOcSlb3f6hX2vim+A0gwle8C4V6Qy7sMueS8bN
        uQm1KxoAQH8nxzyYZzt5sG59AWmvUDNCm9SsYWEZ6Ed1C1zKx+jap/amqm51inxd3Oig83db4VCRR
        XbV4mZj9jND/EyXlmapvshmLBPT7DVmRYDu0EYH31Bk+AGMAArEcPds6FrB/EQOe44CrrNDBFOQ+a
        UTLp6vYA==;
Received: from 177.133.86.196.dynamic.adsl.gvt.net.br ([177.133.86.196] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdL77-0008RT-4a; Tue, 18 Jun 2019 20:53:57 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hdL6z-0001yp-JU; Tue, 18 Jun 2019 17:53:49 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 00/29] Convert files to ReST - part 2
Date:   Tue, 18 Jun 2019 17:53:18 -0300
Message-Id: <cover.1560890800.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <b0d24e805d5368719cc64e8104d64ee9b5b89dd0.1560890772.git.mchehab+samsung@kernel.org>
References: <cover.1560890771.git.mchehab+samsung@kernel.org>
 <b0d24e805d5368719cc64e8104d64ee9b5b89dd0.1560890772.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second part of a series I wrote sometime ago where I manually
convert lots of files to be properly parsed by Sphinx as ReST files.

As it touches on lot of stuff, this series is based on today's linux-next, 
at tag next-20190617.

The first version of this series had 57 patches. The first part with 28 patches
were already merged. Right now, there are still ~76  patches pending applying
(including this series), and that's because I opted to do ~1 patch per converted
 directory.

That sounds too much to be send on a single round. So, I'm opting to split
it on 3 parts for the conversion, plus a final patch adding orphaned books
to existing ones. 

Those patches should probably be good to be merged either by subsystem
maintainers or via the docs tree.

I opted to mark new files not included yet to the main index.rst (directly or
indirectly) with the :orphan: tag, in order to avoid adding warnings to the
build system. This should be removed after we find a "home" for all
the converted files within the new document tree arrangement, after I
submit the third part.

Both this series and  the other parts of this work are on my devel git tree,
at:

	https://git.linuxtv.org/mchehab/experimental.git/log/?h=convert_rst_renames_v5.1

The final output in html (after all patches I currently have, including 
the upcoming series) can be seen at:

	https://www.infradead.org/~mchehab/rst_conversion/

It contains all pending work from my side related to the conversion, plus
the patches I finished a first version today with contains the renaming 
patches and de-orphan changes.

---

Version 2:

- Removed patches merged via other trees;
- rebased on the top of today's linux-next (next-20190617);
- Fix a typo on one patch's description;
- Added received acks.


Mauro Carvalho Chehab (29):
  docs: connector: convert to ReST and rename to connector.rst
  docs: lcd-panel-cgram.txt: convert docs to ReST and rename to *.rst
  docs: lp855x-driver.txt: convert to ReST and move to kernel-api
  docs: m68k: convert docs to ReST and rename to *.rst
  docs: cma/debugfs.txt: convert docs to ReST and rename to *.rst
  docs: console.txt: convert docs to ReST and rename to *.rst
  docs: pti_intel_mid.txt: convert it to pti_intel_mid.rst
  docs: early-userspace: convert docs to ReST and rename to *.rst
  docs: driver-model: convert docs to ReST and rename to *.rst
  docs: arm: convert docs to ReST and rename to *.rst
  docs: memory-devices: convert ti-emif.txt to ReST
  docs: xen-tpmfront.txt: convert it to .rst
  docs: bus-devices: ti-gpmc.rst: convert it to ReST
  docs: nvmem: convert docs to ReST and rename to *.rst
  docs: phy: convert samsung-usb2.txt to ReST format
  docs: rbtree.txt: fix Sphinx build warnings
  docs: DMA-API-HOWTO.txt: fix an unmarked code block
  docs: accounting: convert to ReST
  docs: ia64: convert to ReST
  docs: leds: convert to ReST
  docs: laptops: convert to ReST
  docs: iio: convert to ReST
  docs: namespaces: convert to ReST
  docs: nfc: convert to ReST
  docs: md: convert to ReST
  docs: mtd: convert to ReST
  docs: nvdimm: convert to ReST
  docs: xtensa: convert to ReST
  docs: mmc: convert to ReST

 Documentation/ABI/testing/sysfs-block-device  |   2 +-
 .../ABI/testing/sysfs-platform-asus-laptop    |   2 +-
 Documentation/DMA-API-HOWTO.txt               |   2 +-
 .../{cgroupstats.txt => cgroupstats.rst}      |  14 +-
 ...ay-accounting.txt => delay-accounting.rst} |  61 ++-
 Documentation/accounting/index.rst            |  14 +
 Documentation/accounting/{psi.txt => psi.rst} |  40 +-
 ...kstats-struct.txt => taskstats-struct.rst} |  79 ++-
 .../{taskstats.txt => taskstats.rst}          |  15 +-
 Documentation/admin-guide/cgroup-v2.rst       |   6 +-
 .../admin-guide/kernel-parameters.rst         |   2 +-
 .../admin-guide/kernel-parameters.txt         |   2 +-
 Documentation/arm/Marvell/README              | 395 -------------
 Documentation/arm/Netwinder                   |  78 ---
 Documentation/arm/SA1100/FreeBird             |  21 -
 Documentation/arm/SA1100/empeg                |   2 -
 Documentation/arm/SA1100/serial_UART          |  47 --
 Documentation/arm/{README => arm.rst}         |  50 +-
 Documentation/arm/{Booting => booting.rst}    |  71 ++-
 ...ance.txt => cluster-pm-race-avoidance.rst} | 177 +++---
 .../arm/{firmware.txt => firmware.rst}        |  14 +-
 Documentation/arm/index.rst                   |  80 +++
 .../arm/{Interrupts => interrupts.rst}        |  86 +--
 Documentation/arm/{IXP4xx => ixp4xx.rst}      |  61 ++-
 ...nel_mode_neon.txt => kernel_mode_neon.rst} |   3 +
 ...er_helpers.txt => kernel_user_helpers.rst} |  79 +--
 .../keystone/{knav-qmss.txt => knav-qmss.rst} |   6 +-
 .../keystone/{Overview.txt => overview.rst}   |  47 +-
 Documentation/arm/marvel.rst                  | 488 +++++++++++++++++
 .../arm/{mem_alignment => mem_alignment.rst}  |  11 +-
 Documentation/arm/{memory.txt => memory.rst}  |   9 +-
 .../arm/{Microchip/README => microchip.rst}   |  63 ++-
 Documentation/arm/netwinder.rst               |  85 +++
 Documentation/arm/nwfpe/index.rst             |  11 +
 .../nwfpe/{README.FPE => netwinder-fpe.rst}   |  24 +-
 Documentation/arm/nwfpe/{NOTES => notes.rst}  |   3 +
 Documentation/arm/nwfpe/{README => nwfpe.rst} |  10 +-
 Documentation/arm/nwfpe/{TODO => todo.rst}    |  47 +-
 Documentation/arm/{OMAP/DSS => omap/dss.rst}  | 112 ++--
 Documentation/arm/omap/index.rst              |  10 +
 .../arm/{OMAP/README => omap/omap.rst}        |   7 +
 .../arm/{OMAP/omap_pm => omap/omap_pm.rst}    |  55 +-
 Documentation/arm/{Porting => porting.rst}    |  14 +-
 Documentation/arm/pxa/{mfp.txt => mfp.rst}    | 106 ++--
 .../{SA1100/ADSBitsy => sa1100/adsbitsy.rst}  |  14 +-
 .../{SA1100/Assabet => sa1100/assabet.rst}    | 185 +++----
 .../arm/{SA1100/Brutus => sa1100/brutus.rst}  |  45 +-
 .../arm/{SA1100/CERF => sa1100/cerf.rst}      |  10 +-
 Documentation/arm/sa1100/freebird.rst         |  25 +
 .../graphicsclient.rst}                       |  46 +-
 .../graphicsmaster.rst}                       |  13 +-
 .../HUW_WEBPANEL => sa1100/huw_webpanel.rst}  |   8 +-
 Documentation/arm/sa1100/index.rst            |  23 +
 .../arm/{SA1100/Itsy => sa1100/itsy.rst}      |  14 +-
 .../arm/{SA1100/LART => sa1100/lart.rst}      |   3 +-
 .../nanoEngine => sa1100/nanoengine.rst}      |   6 +-
 .../{SA1100/Pangolin => sa1100/pangolin.rst}  |  10 +-
 .../arm/{SA1100/PLEB => sa1100/pleb.rst}      |   6 +-
 Documentation/arm/sa1100/serial_uart.rst      |  51 ++
 .../arm/{SA1100/Tifon => sa1100/tifon.rst}    |   4 +-
 .../arm/{SA1100/Yopy => sa1100/yopy.rst}      |   5 +-
 .../cpufreq.rst}                              |   5 +-
 .../eb2410itx.rst}                            |   5 +-
 .../GPIO.txt => samsung-s3c24xx/gpio.rst}     |  23 +-
 .../H1940.txt => samsung-s3c24xx/h1940.rst}   |   5 +-
 Documentation/arm/samsung-s3c24xx/index.rst   |  18 +
 .../NAND.txt => samsung-s3c24xx/nand.rst}     |   6 +-
 .../overview.rst}                             |  21 +-
 .../s3c2412.rst}                              |   5 +-
 .../s3c2413.rst}                              |   7 +-
 .../smdk2440.rst}                             |   5 +-
 .../suspend.rst}                              |  20 +-
 .../usb-host.rst}                             |  16 +-
 .../bootloader-interface.rst}                 |  27 +-
 .../clksrc-change-registers.awk               |   0
 .../{Samsung/GPIO.txt => samsung/gpio.rst}    |   7 +-
 Documentation/arm/samsung/index.rst           |  10 +
 .../Overview.txt => samsung/overview.rst}     |  15 +-
 Documentation/arm/{Setup => setup.rst}        |  49 +-
 .../arm/{SH-Mobile => sh-mobile}/.gitignore   |   0
 .../overview.txt => spear/overview.rst}       |  20 +-
 .../arm/sti/{overview.txt => overview.rst}    |  21 +-
 ...h407-overview.txt => stih407-overview.rst} |   9 +-
 ...h415-overview.txt => stih415-overview.rst} |   8 +-
 ...h416-overview.txt => stih416-overview.rst} |   5 +-
 ...h418-overview.txt => stih418-overview.rst} |   9 +-
 Documentation/arm/stm32/overview.rst          |   2 -
 .../arm/stm32/stm32f429-overview.rst          |   7 +-
 .../arm/stm32/stm32f746-overview.rst          |   7 +-
 .../arm/stm32/stm32f769-overview.rst          |   7 +-
 .../arm/stm32/stm32h743-overview.rst          |   7 +-
 .../arm/stm32/stm32mp157-overview.rst         |   3 +-
 Documentation/arm/{sunxi/README => sunxi.rst} |  98 +++-
 .../arm/sunxi/{clocks.txt => clocks.rst}      |   7 +-
 .../arm/{swp_emulation => swp_emulation.rst}  |  24 +-
 Documentation/arm/{tcm.txt => tcm.rst}        |  54 +-
 Documentation/arm/{uefi.txt => uefi.rst}      |  39 +-
 .../release-notes.rst}                        |   4 +-
 Documentation/arm/{vlocks.txt => vlocks.rst}  |   9 +-
 ...cd-panel-cgram.txt => lcd-panel-cgram.rst} |   9 +-
 Documentation/backlight/lp855x-driver.rst     |  83 +++
 Documentation/backlight/lp855x-driver.txt     |  66 ---
 .../bus-devices/{ti-gpmc.txt => ti-gpmc.rst}  | 159 ++++--
 .../cma/{debugfs.txt => debugfs.rst}          |   8 +-
 .../{connector.txt => connector.rst}          | 130 ++---
 .../console/{console.txt => console.rst}      |  63 ++-
 Documentation/devicetree/bindings/arm/xen.txt |   2 +-
 .../devicetree/booting-without-of.txt         |   4 +-
 Documentation/driver-api/gpio/driver.rst      |   2 +-
 .../driver-model/{binding.txt => binding.rst} |  20 +-
 .../driver-model/{bus.txt => bus.rst}         |  69 +--
 .../driver-model/{class.txt => class.rst}     |  74 +--
 ...esign-patterns.txt => design-patterns.rst} | 106 ++--
 .../driver-model/{device.txt => device.rst}   |  57 +-
 .../driver-model/{devres.txt => devres.rst}   |  50 +-
 .../driver-model/{driver.txt => driver.rst}   | 112 ++--
 Documentation/driver-model/index.rst          |  26 +
 .../{overview.txt => overview.rst}            |  37 +-
 .../{platform.txt => platform.rst}            |  30 +-
 .../driver-model/{porting.txt => porting.rst} | 333 +++++------
 .../{buffer-format.txt => buffer-format.rst}  |  19 +-
 .../{README => early_userspace_support.rst}   |   3 +
 Documentation/early-userspace/index.rst       |  18 +
 Documentation/eisa.txt                        |   4 +-
 Documentation/fb/fbcon.rst                    |   4 +-
 Documentation/filesystems/nfs/nfsroot.txt     |   2 +-
 .../filesystems/ramfs-rootfs-initramfs.txt    |   4 +-
 Documentation/hwmon/submitting-patches.rst    |   2 +-
 .../ia64/{aliasing.txt => aliasing.rst}       |  73 ++-
 Documentation/ia64/{efirtc.txt => efirtc.rst} | 118 ++--
 .../ia64/{err_inject.txt => err_inject.rst}   | 349 ++++++------
 Documentation/ia64/{fsys.txt => fsys.rst}     | 127 +++--
 Documentation/ia64/{README => ia64.rst}       |  26 +-
 Documentation/ia64/index.rst                  |  18 +
 .../ia64/{IRQ-redir.txt => irq-redir.rst}     |  31 +-
 Documentation/ia64/{mca.txt => mca.rst}       |  10 +-
 Documentation/ia64/{serial.txt => serial.rst} |  36 +-
 Documentation/ia64/xen.rst                    | 206 +++++++
 Documentation/ia64/xen.txt                    | 183 -------
 .../iio/{ep93xx_adc.txt => ep93xx_adc.rst}    |  15 +-
 .../{iio_configfs.txt => iio_configfs.rst}    |  52 +-
 Documentation/iio/index.rst                   |  12 +
 Documentation/index.rst                       |   1 +
 .../{asus-laptop.txt => asus-laptop.rst}      |  92 ++--
 ...otection.txt => disk-shock-protection.rst} |  32 +-
 Documentation/laptops/index.rst               |  17 +
 .../{laptop-mode.txt => laptop-mode.rst}      | 509 +++++++++--------
 .../{sony-laptop.txt => sony-laptop.rst}      |  58 +-
 .../laptops/{sonypi.txt => sonypi.rst}        |  28 +-
 .../{thinkpad-acpi.txt => thinkpad-acpi.rst}  | 367 ++++++++-----
 .../{toshiba_haps.txt => toshiba_haps.rst}    |  47 +-
 Documentation/leds/index.rst                  |  25 +
 .../leds/{leds-blinkm.txt => leds-blinkm.rst} |  64 ++-
 ...s-class-flash.txt => leds-class-flash.rst} |  49 +-
 .../leds/{leds-class.txt => leds-class.rst}   |  15 +-
 .../leds/{leds-lm3556.txt => leds-lm3556.rst} | 100 +++-
 .../leds/{leds-lp3944.txt => leds-lp3944.rst} |  23 +-
 Documentation/leds/leds-lp5521.rst            | 115 ++++
 Documentation/leds/leds-lp5521.txt            | 101 ----
 Documentation/leds/leds-lp5523.rst            | 147 +++++
 Documentation/leds/leds-lp5523.txt            | 130 -----
 Documentation/leds/leds-lp5562.rst            | 137 +++++
 Documentation/leds/leds-lp5562.txt            | 120 ----
 Documentation/leds/leds-lp55xx.rst            | 224 ++++++++
 Documentation/leds/leds-lp55xx.txt            | 194 -------
 Documentation/leds/leds-mlxcpld.rst           | 118 ++++
 Documentation/leds/leds-mlxcpld.txt           | 110 ----
 ...edtrig-oneshot.txt => ledtrig-oneshot.rst} |  11 +-
 ...ig-transient.txt => ledtrig-transient.rst} |  63 ++-
 ...edtrig-usbport.txt => ledtrig-usbport.rst} |  11 +-
 Documentation/leds/{uleds.txt => uleds.rst}   |   5 +-
 Documentation/m68k/index.rst                  |  17 +
 ...{kernel-options.txt => kernel-options.rst} | 319 ++++++-----
 Documentation/md/index.rst                    |  12 +
 .../md/{md-cluster.txt => md-cluster.rst}     | 188 ++++---
 .../md/{raid5-cache.txt => raid5-cache.rst}   |  28 +-
 .../md/{raid5-ppl.txt => raid5-ppl.rst}       |   2 +
 .../{ti-emif.txt => ti-emif.rst}              |  27 +-
 Documentation/mmc/index.rst                   |  13 +
 .../{mmc-async-req.txt => mmc-async-req.rst}  |  53 +-
 .../{mmc-dev-attrs.txt => mmc-dev-attrs.rst}  |  32 +-
 .../{mmc-dev-parts.txt => mmc-dev-parts.rst}  |  13 +-
 .../mmc/{mmc-tools.txt => mmc-tools.rst}      |   5 +-
 Documentation/mtd/index.rst                   |  12 +
 .../mtd/{intel-spi.txt => intel-spi.rst}      |  46 +-
 .../mtd/{nand_ecc.txt => nand_ecc.rst}        | 481 ++++++++--------
 .../mtd/{spi-nor.txt => spi-nor.rst}          |   7 +-
 ...bility-list.txt => compatibility-list.rst} |  10 +-
 Documentation/namespaces/index.rst            |  11 +
 ...ource-control.txt => resource-control.rst} |   4 +
 Documentation/nfc/index.rst                   |  11 +
 .../nfc/{nfc-hci.txt => nfc-hci.rst}          | 163 +++---
 .../nfc/{nfc-pn544.txt => nfc-pn544.rst}      |   6 +-
 Documentation/nvdimm/{btt.txt => btt.rst}     | 140 ++---
 Documentation/nvdimm/index.rst                |  12 +
 .../nvdimm/{nvdimm.txt => nvdimm.rst}         | 518 ++++++++++--------
 .../nvdimm/{security.txt => security.rst}     |   4 +-
 Documentation/nvmem/{nvmem.txt => nvmem.rst}  | 112 ++--
 .../{samsung-usb2.txt => samsung-usb2.rst}    |  62 ++-
 Documentation/pti/pti_intel_mid.rst           | 106 ++++
 Documentation/pti/pti_intel_mid.txt           |  99 ----
 Documentation/rbtree.txt                      |   6 +-
 .../{xen-tpmfront.txt => xen-tpmfront.rst}    | 103 ++--
 Documentation/sysctl/vm.txt                   |   4 +-
 Documentation/translations/zh_CN/arm/Booting  |   4 +-
 .../zh_CN/arm/kernel_user_helpers.txt         |   4 +-
 .../xtensa/{atomctl.txt => atomctl.rst}       |  13 +-
 .../xtensa/{booting.txt => booting.rst}       |   5 +-
 Documentation/xtensa/index.rst                |  12 +
 Documentation/xtensa/mmu.rst                  | 195 +++++++
 Documentation/xtensa/mmu.txt                  | 189 -------
 MAINTAINERS                                   |  16 +-
 arch/arm/Kconfig                              |   2 +-
 arch/arm/common/mcpm_entry.c                  |   2 +-
 arch/arm/common/mcpm_head.S                   |   2 +-
 arch/arm/common/vlock.S                       |   2 +-
 arch/arm/include/asm/setup.h                  |   2 +-
 arch/arm/include/uapi/asm/setup.h             |   2 +-
 arch/arm/kernel/entry-armv.S                  |   2 +-
 arch/arm/mach-exynos/common.h                 |   2 +-
 arch/arm/mach-ixp4xx/Kconfig                  |  14 +-
 arch/arm/mach-s3c24xx/pm.c                    |   2 +-
 arch/arm/mm/Kconfig                           |   4 +-
 arch/arm/plat-samsung/Kconfig                 |   6 +-
 arch/arm/tools/mach-types                     |   2 +-
 arch/arm64/Kconfig                            |   2 +-
 arch/arm64/kernel/kuser32.S                   |   2 +-
 arch/ia64/kernel/efi.c                        |   2 +-
 arch/ia64/kernel/fsys.S                       |   2 +-
 arch/ia64/mm/ioremap.c                        |   2 +-
 arch/ia64/pci/pci.c                           |   2 +-
 arch/mips/bmips/setup.c                       |   2 +-
 arch/xtensa/include/asm/initialize_mmu.h      |   2 +-
 drivers/base/platform.c                       |   2 +-
 drivers/char/Kconfig                          |   2 +-
 drivers/crypto/sunxi-ss/sun4i-ss-cipher.c     |   2 +-
 drivers/crypto/sunxi-ss/sun4i-ss-core.c       |   2 +-
 drivers/crypto/sunxi-ss/sun4i-ss-hash.c       |   2 +-
 drivers/crypto/sunxi-ss/sun4i-ss.h            |   2 +-
 drivers/gpio/gpio-cs5535.c                    |   2 +-
 drivers/iio/Kconfig                           |   2 +-
 drivers/input/touchscreen/sun4i-ts.c          |   2 +-
 drivers/leds/trigger/Kconfig                  |   2 +-
 drivers/leds/trigger/ledtrig-transient.c      |   2 +-
 drivers/mtd/nand/raw/nand_ecc.c               |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |   2 +-
 drivers/nvdimm/Kconfig                        |   2 +-
 drivers/platform/x86/Kconfig                  |   4 +-
 drivers/tty/Kconfig                           |   2 +-
 drivers/tty/serial/Kconfig                    |   2 +-
 drivers/w1/Kconfig                            |   2 +-
 include/linux/connector.h                     |  63 ++-
 init/Kconfig                                  |   2 +-
 net/netfilter/Kconfig                         |   2 +-
 samples/Kconfig                               |   2 +-
 scripts/coccinelle/free/devm_free.cocci       |   2 +-
 usr/Kconfig                                   |   2 +-
 257 files changed, 7122 insertions(+), 5341 deletions(-)
 rename Documentation/accounting/{cgroupstats.txt => cgroupstats.rst} (77%)
 rename Documentation/accounting/{delay-accounting.txt => delay-accounting.rst} (77%)
 create mode 100644 Documentation/accounting/index.rst
 rename Documentation/accounting/{psi.txt => psi.rst} (91%)
 rename Documentation/accounting/{taskstats-struct.txt => taskstats-struct.rst} (78%)
 rename Documentation/accounting/{taskstats.txt => taskstats.rst} (95%)
 delete mode 100644 Documentation/arm/Marvell/README
 delete mode 100644 Documentation/arm/Netwinder
 delete mode 100644 Documentation/arm/SA1100/FreeBird
 delete mode 100644 Documentation/arm/SA1100/empeg
 delete mode 100644 Documentation/arm/SA1100/serial_UART
 rename Documentation/arm/{README => arm.rst} (88%)
 rename Documentation/arm/{Booting => booting.rst} (89%)
 rename Documentation/arm/{cluster-pm-race-avoidance.txt => cluster-pm-race-avoidance.rst} (84%)
 rename Documentation/arm/{firmware.txt => firmware.rst} (86%)
 create mode 100644 Documentation/arm/index.rst
 rename Documentation/arm/{Interrupts => interrupts.rst} (81%)
 rename Documentation/arm/{IXP4xx => ixp4xx.rst} (84%)
 rename Documentation/arm/{kernel_mode_neon.txt => kernel_mode_neon.rst} (99%)
 rename Documentation/arm/{kernel_user_helpers.txt => kernel_user_helpers.rst} (78%)
 rename Documentation/arm/keystone/{knav-qmss.txt => knav-qmss.rst} (92%)
 rename Documentation/arm/keystone/{Overview.txt => overview.rst} (59%)
 create mode 100644 Documentation/arm/marvel.rst
 rename Documentation/arm/{mem_alignment => mem_alignment.rst} (89%)
 rename Documentation/arm/{memory.txt => memory.rst} (90%)
 rename Documentation/arm/{Microchip/README => microchip.rst} (92%)
 create mode 100644 Documentation/arm/netwinder.rst
 create mode 100644 Documentation/arm/nwfpe/index.rst
 rename Documentation/arm/nwfpe/{README.FPE => netwinder-fpe.rst} (94%)
 rename Documentation/arm/nwfpe/{NOTES => notes.rst} (99%)
 rename Documentation/arm/nwfpe/{README => nwfpe.rst} (98%)
 rename Documentation/arm/nwfpe/{TODO => todo.rst} (75%)
 rename Documentation/arm/{OMAP/DSS => omap/dss.rst} (86%)
 create mode 100644 Documentation/arm/omap/index.rst
 rename Documentation/arm/{OMAP/README => omap/omap.rst} (62%)
 rename Documentation/arm/{OMAP/omap_pm => omap/omap_pm.rst} (83%)
 rename Documentation/arm/{Porting => porting.rst} (94%)
 rename Documentation/arm/pxa/{mfp.txt => mfp.rst} (83%)
 rename Documentation/arm/{SA1100/ADSBitsy => sa1100/adsbitsy.rst} (90%)
 rename Documentation/arm/{SA1100/Assabet => sa1100/assabet.rst} (62%)
 rename Documentation/arm/{SA1100/Brutus => sa1100/brutus.rst} (75%)
 rename Documentation/arm/{SA1100/CERF => sa1100/cerf.rst} (91%)
 create mode 100644 Documentation/arm/sa1100/freebird.rst
 rename Documentation/arm/{SA1100/GraphicsClient => sa1100/graphicsclient.rst} (87%)
 rename Documentation/arm/{SA1100/GraphicsMaster => sa1100/graphicsmaster.rst} (92%)
 rename Documentation/arm/{SA1100/HUW_WEBPANEL => sa1100/huw_webpanel.rst} (78%)
 create mode 100644 Documentation/arm/sa1100/index.rst
 rename Documentation/arm/{SA1100/Itsy => sa1100/itsy.rst} (88%)
 rename Documentation/arm/{SA1100/LART => sa1100/lart.rst} (90%)
 rename Documentation/arm/{SA1100/nanoEngine => sa1100/nanoengine.rst} (74%)
 rename Documentation/arm/{SA1100/Pangolin => sa1100/pangolin.rst} (81%)
 rename Documentation/arm/{SA1100/PLEB => sa1100/pleb.rst} (95%)
 create mode 100644 Documentation/arm/sa1100/serial_uart.rst
 rename Documentation/arm/{SA1100/Tifon => sa1100/tifon.rst} (88%)
 rename Documentation/arm/{SA1100/Yopy => sa1100/yopy.rst} (74%)
 rename Documentation/arm/{Samsung-S3C24XX/CPUfreq.txt => samsung-s3c24xx/cpufreq.rst} (96%)
 rename Documentation/arm/{Samsung-S3C24XX/EB2410ITX.txt => samsung-s3c24xx/eb2410itx.rst} (92%)
 rename Documentation/arm/{Samsung-S3C24XX/GPIO.txt => samsung-s3c24xx/gpio.rst} (89%)
 rename Documentation/arm/{Samsung-S3C24XX/H1940.txt => samsung-s3c24xx/h1940.rst} (94%)
 create mode 100644 Documentation/arm/samsung-s3c24xx/index.rst
 rename Documentation/arm/{Samsung-S3C24XX/NAND.txt => samsung-s3c24xx/nand.rst} (92%)
 rename Documentation/arm/{Samsung-S3C24XX/Overview.txt => samsung-s3c24xx/overview.rst} (94%)
 rename Documentation/arm/{Samsung-S3C24XX/S3C2412.txt => samsung-s3c24xx/s3c2412.rst} (96%)
 rename Documentation/arm/{Samsung-S3C24XX/S3C2413.txt => samsung-s3c24xx/s3c2413.rst} (77%)
 rename Documentation/arm/{Samsung-S3C24XX/SMDK2440.txt => samsung-s3c24xx/smdk2440.rst} (94%)
 rename Documentation/arm/{Samsung-S3C24XX/Suspend.txt => samsung-s3c24xx/suspend.rst} (94%)
 rename Documentation/arm/{Samsung-S3C24XX/USB-Host.txt => samsung-s3c24xx/usb-host.rst} (94%)
 rename Documentation/arm/{Samsung/Bootloader-interface.txt => samsung/bootloader-interface.rst} (72%)
 rename Documentation/arm/{Samsung => samsung}/clksrc-change-registers.awk (100%)
 rename Documentation/arm/{Samsung/GPIO.txt => samsung/gpio.rst} (87%)
 create mode 100644 Documentation/arm/samsung/index.rst
 rename Documentation/arm/{Samsung/Overview.txt => samsung/overview.rst} (86%)
 rename Documentation/arm/{Setup => setup.rst} (87%)
 rename Documentation/arm/{SH-Mobile => sh-mobile}/.gitignore (100%)
 rename Documentation/arm/{SPEAr/overview.txt => spear/overview.rst} (91%)
 rename Documentation/arm/sti/{overview.txt => overview.rst} (82%)
 rename Documentation/arm/sti/{stih407-overview.txt => stih407-overview.rst} (82%)
 rename Documentation/arm/sti/{stih415-overview.txt => stih415-overview.rst} (79%)
 rename Documentation/arm/sti/{stih416-overview.txt => stih416-overview.rst} (83%)
 rename Documentation/arm/sti/{stih418-overview.txt => stih418-overview.rst} (83%)
 rename Documentation/arm/{sunxi/README => sunxi.rst} (83%)
 rename Documentation/arm/sunxi/{clocks.txt => clocks.rst} (92%)
 rename Documentation/arm/{swp_emulation => swp_emulation.rst} (63%)
 rename Documentation/arm/{tcm.txt => tcm.rst} (86%)
 rename Documentation/arm/{uefi.txt => uefi.rst} (63%)
 rename Documentation/arm/{VFP/release-notes.txt => vfp/release-notes.rst} (92%)
 rename Documentation/arm/{vlocks.txt => vlocks.rst} (98%)
 rename Documentation/auxdisplay/{lcd-panel-cgram.txt => lcd-panel-cgram.rst} (88%)
 create mode 100644 Documentation/backlight/lp855x-driver.rst
 delete mode 100644 Documentation/backlight/lp855x-driver.txt
 rename Documentation/bus-devices/{ti-gpmc.txt => ti-gpmc.rst} (58%)
 rename Documentation/cma/{debugfs.txt => debugfs.rst} (91%)
 rename Documentation/connector/{connector.txt => connector.rst} (57%)
 rename Documentation/console/{console.txt => console.rst} (80%)
 rename Documentation/driver-model/{binding.txt => binding.rst} (92%)
 rename Documentation/driver-model/{bus.txt => bus.rst} (76%)
 rename Documentation/driver-model/{class.txt => class.rst} (75%)
 rename Documentation/driver-model/{design-patterns.txt => design-patterns.rst} (59%)
 rename Documentation/driver-model/{device.txt => device.rst} (71%)
 rename Documentation/driver-model/{devres.txt => devres.rst} (93%)
 rename Documentation/driver-model/{driver.txt => driver.rst} (75%)
 create mode 100644 Documentation/driver-model/index.rst
 rename Documentation/driver-model/{overview.txt => overview.rst} (90%)
 rename Documentation/driver-model/{platform.txt => platform.rst} (95%)
 rename Documentation/driver-model/{porting.txt => porting.rst} (62%)
 rename Documentation/early-userspace/{buffer-format.txt => buffer-format.rst} (91%)
 rename Documentation/early-userspace/{README => early_userspace_support.rst} (99%)
 create mode 100644 Documentation/early-userspace/index.rst
 rename Documentation/ia64/{aliasing.txt => aliasing.rst} (83%)
 rename Documentation/ia64/{efirtc.txt => efirtc.rst} (70%)
 rename Documentation/ia64/{err_inject.txt => err_inject.rst} (82%)
 rename Documentation/ia64/{fsys.txt => fsys.rst} (76%)
 rename Documentation/ia64/{README => ia64.rst} (61%)
 create mode 100644 Documentation/ia64/index.rst
 rename Documentation/ia64/{IRQ-redir.txt => irq-redir.rst} (86%)
 rename Documentation/ia64/{mca.txt => mca.rst} (96%)
 rename Documentation/ia64/{serial.txt => serial.rst} (87%)
 create mode 100644 Documentation/ia64/xen.rst
 delete mode 100644 Documentation/ia64/xen.txt
 rename Documentation/iio/{ep93xx_adc.txt => ep93xx_adc.rst} (71%)
 rename Documentation/iio/{iio_configfs.txt => iio_configfs.rst} (73%)
 create mode 100644 Documentation/iio/index.rst
 rename Documentation/laptops/{asus-laptop.txt => asus-laptop.rst} (84%)
 rename Documentation/laptops/{disk-shock-protection.txt => disk-shock-protection.rst} (91%)
 create mode 100644 Documentation/laptops/index.rst
 rename Documentation/laptops/{laptop-mode.txt => laptop-mode.rst} (62%)
 rename Documentation/laptops/{sony-laptop.txt => sony-laptop.rst} (85%)
 rename Documentation/laptops/{sonypi.txt => sonypi.rst} (87%)
 rename Documentation/laptops/{thinkpad-acpi.txt => thinkpad-acpi.rst} (89%)
 rename Documentation/laptops/{toshiba_haps.txt => toshiba_haps.rst} (60%)
 create mode 100644 Documentation/leds/index.rst
 rename Documentation/leds/{leds-blinkm.txt => leds-blinkm.rst} (57%)
 rename Documentation/leds/{leds-class-flash.txt => leds-class-flash.rst} (74%)
 rename Documentation/leds/{leds-class.txt => leds-class.rst} (92%)
 rename Documentation/leds/{leds-lm3556.txt => leds-lm3556.rst} (70%)
 rename Documentation/leds/{leds-lp3944.txt => leds-lp3944.rst} (78%)
 create mode 100644 Documentation/leds/leds-lp5521.rst
 delete mode 100644 Documentation/leds/leds-lp5521.txt
 create mode 100644 Documentation/leds/leds-lp5523.rst
 delete mode 100644 Documentation/leds/leds-lp5523.txt
 create mode 100644 Documentation/leds/leds-lp5562.rst
 delete mode 100644 Documentation/leds/leds-lp5562.txt
 create mode 100644 Documentation/leds/leds-lp55xx.rst
 delete mode 100644 Documentation/leds/leds-lp55xx.txt
 create mode 100644 Documentation/leds/leds-mlxcpld.rst
 delete mode 100644 Documentation/leds/leds-mlxcpld.txt
 rename Documentation/leds/{ledtrig-oneshot.txt => ledtrig-oneshot.rst} (90%)
 rename Documentation/leds/{ledtrig-transient.txt => ledtrig-transient.rst} (81%)
 rename Documentation/leds/{ledtrig-usbport.txt => ledtrig-usbport.rst} (86%)
 rename Documentation/leds/{uleds.txt => uleds.rst} (95%)
 create mode 100644 Documentation/m68k/index.rst
 rename Documentation/m68k/{kernel-options.txt => kernel-options.rst} (78%)
 create mode 100644 Documentation/md/index.rst
 rename Documentation/md/{md-cluster.txt => md-cluster.rst} (68%)
 rename Documentation/md/{raid5-cache.txt => raid5-cache.rst} (92%)
 rename Documentation/md/{raid5-ppl.txt => raid5-ppl.rst} (98%)
 rename Documentation/memory-devices/{ti-emif.txt => ti-emif.rst} (81%)
 create mode 100644 Documentation/mmc/index.rst
 rename Documentation/mmc/{mmc-async-req.txt => mmc-async-req.rst} (75%)
 rename Documentation/mmc/{mmc-dev-attrs.txt => mmc-dev-attrs.rst} (73%)
 rename Documentation/mmc/{mmc-dev-parts.txt => mmc-dev-parts.rst} (83%)
 rename Documentation/mmc/{mmc-tools.txt => mmc-tools.rst} (92%)
 create mode 100644 Documentation/mtd/index.rst
 rename Documentation/mtd/{intel-spi.txt => intel-spi.rst} (71%)
 rename Documentation/mtd/{nand_ecc.txt => nand_ecc.rst} (67%)
 rename Documentation/mtd/{spi-nor.txt => spi-nor.rst} (94%)
 rename Documentation/namespaces/{compatibility-list.txt => compatibility-list.rst} (86%)
 create mode 100644 Documentation/namespaces/index.rst
 rename Documentation/namespaces/{resource-control.txt => resource-control.rst} (89%)
 create mode 100644 Documentation/nfc/index.rst
 rename Documentation/nfc/{nfc-hci.txt => nfc-hci.rst} (71%)
 rename Documentation/nfc/{nfc-pn544.txt => nfc-pn544.rst} (82%)
 rename Documentation/nvdimm/{btt.txt => btt.rst} (71%)
 create mode 100644 Documentation/nvdimm/index.rst
 rename Documentation/nvdimm/{nvdimm.txt => nvdimm.rst} (60%)
 rename Documentation/nvdimm/{security.txt => security.rst} (99%)
 rename Documentation/nvmem/{nvmem.txt => nvmem.rst} (62%)
 rename Documentation/phy/{samsung-usb2.txt => samsung-usb2.rst} (77%)
 create mode 100644 Documentation/pti/pti_intel_mid.rst
 delete mode 100644 Documentation/pti/pti_intel_mid.txt
 rename Documentation/security/tpm/{xen-tpmfront.txt => xen-tpmfront.rst} (66%)
 rename Documentation/xtensa/{atomctl.txt => atomctl.rst} (81%)
 rename Documentation/xtensa/{booting.txt => booting.rst} (91%)
 create mode 100644 Documentation/xtensa/index.rst
 create mode 100644 Documentation/xtensa/mmu.rst
 delete mode 100644 Documentation/xtensa/mmu.txt

-- 
2.21.0


