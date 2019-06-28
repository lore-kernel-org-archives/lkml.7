Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97F4C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761652083B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561724636;
	bh=5bOYfiJv8OSLn1deZuEuw8/cFNBSz6C0MgKvtdVRCIM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=QNUovl6OTIPJu+N8+MlSAaFCqVFK1NChqbcE+H27ojmmWJQMajeQRWoAjoRlx5jdt
	 bE1lIaNuvYEalnJCnyZVWBeYdynaqHqcJ1LYKEj/9L6wH0T7RyKHmi2UEcYN3HVe/d
	 5Ys86j0pUuZpsvBjgo6iN9ubpWnJ0YowUDjNubqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfF1MXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:23:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58714 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfF1MUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4fQxxsdFYUfJeRf4072O0/L6t737tufma9oX845qpls=; b=XuvHayVU34xIM7S2gxcIu5xWS
        JJeuW7yxXWwsiUzOTY9stxXlAX3zpZBwekYrGpOZkkigkDK/2u1zr82G8QtlSeyHko3M1BjaiooyL
        1qIcmAxZl0m1oPMBDFFfa05cKEQqSts26KYtcLk2IYzpTk0fWCZ2+V1YowHZdDN7KhJ0kKa/QI5g1
        3Q5X2OaBrptPQGtWet1S7jaLH6byBuF2CkeLSQoDzrRn3CoXK0fTQYsIbYqADUwjxSU87vue1DSbv
        TNSxDijpJ+x+E9I2CBBPfMKrjFG9LvQVFpz7S5E2WTO0c7CiFXdjIIBOlIt8HL4VBDPn0ckXo5vjF
        eWU/YLyug==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgpru-00009n-Sw; Fri, 28 Jun 2019 12:20:43 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgprs-00056o-VX; Fri, 28 Jun 2019 09:20:40 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 00/43] Convert doc files to ReST
Date:   Fri, 28 Jun 2019 09:19:56 -0300
Message-Id: <cover.1561723979.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset contains the patches that weren't merged yet from
part 2 and 3 of the previous ReST conversion patchset.

This is based aganst linux-next (next-20190627), so they may not
apply cleanly at docs-next.

It does contain file renames, but, except for a few exceptions, the files
are kept where they are.

The first patches on this series were agreed to be merged via subsystem's
tree, but, as they didn't appear at -next, I'm recending as a gentile
ping.


Mauro Carvalho Chehab (43):
  docs: infiniband: convert docs to ReST and rename to *.rst
  docs: iio: convert to ReST
  docs: hid: convert to ReST
  docs: locking: convert docs to ReST and rename to *.rst
  docs: powerpc: convert docs to ReST and rename to *.rst
  docs: connector: convert to ReST and rename to connector.rst
  docs: lcd-panel-cgram.txt: convert docs to ReST and rename to *.rst
  docs: lp855x-driver.txt: convert to ReST and move to kernel-api
  docs: m68k: convert docs to ReST and rename to *.rst
  docs: cma/debugfs.txt: convert docs to ReST and rename to *.rst
  docs: console.txt: convert docs to ReST and rename to *.rst
  docs: pti_intel_mid.txt: convert it to pti_intel_mid.rst
  docs: early-userspace: convert docs to ReST and rename to *.rst
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
  docs: namespaces: convert to ReST
  docs: nfc: convert to ReST
  docs: md: convert to ReST
  docs: mtd: convert to ReST
  docs: nvdimm: convert to ReST
  docs: xtensa: convert to ReST
  docs: mmc: convert to ReST
  docs: ioctl-number.txt: convert it to ReST format
  docs: ioctl: convert to ReST
  docs: thermal: convert to ReST
  docs: rapidio: convert to ReST
  docs: blockdev: convert to ReST
  docs: perf: convert to ReST
  docs: sysctl: convert to ReST
  docs: block: convert to ReST
  docs: extcon: convert it to ReST and move to acpi dir
  docs: move gcc_plugins.txt to core-api and rename to .rst
  docs: logo.txt: rename it to COPYING-logo

 Documentation/ABI/testing/sysfs-block-device  |    2 +-
 .../ABI/testing/sysfs-platform-asus-laptop    |    2 +-
 Documentation/{logo.txt => COPYING-logo}      |    0
 Documentation/DMA-API-HOWTO.txt               |    2 +-
 Documentation/PCI/pci-error-recovery.rst      |   23 +-
 .../{cgroupstats.txt => cgroupstats.rst}      |   14 +-
 ...ay-accounting.txt => delay-accounting.rst} |   61 +-
 Documentation/accounting/index.rst            |   14 +
 Documentation/accounting/{psi.txt => psi.rst} |   40 +-
 ...kstats-struct.txt => taskstats-struct.rst} |   79 +-
 .../{taskstats.txt => taskstats.rst}          |   15 +-
 Documentation/admin-guide/cgroup-v2.rst       |    6 +-
 .../admin-guide/kernel-parameters.rst         |    2 +-
 .../admin-guide/kernel-parameters.txt         |   30 +-
 Documentation/admin-guide/mm/index.rst        |    2 +-
 Documentation/admin-guide/mm/ksm.rst          |    2 +-
 Documentation/arm/Marvell/README              |  395 ------
 Documentation/arm/Netwinder                   |   78 --
 Documentation/arm/SA1100/FreeBird             |   21 -
 Documentation/arm/SA1100/empeg                |    2 -
 Documentation/arm/SA1100/serial_UART          |   47 -
 Documentation/arm/{README => arm.rst}         |   50 +-
 Documentation/arm/{Booting => booting.rst}    |   71 +-
 ...ance.txt => cluster-pm-race-avoidance.rst} |  177 ++-
 .../arm/{firmware.txt => firmware.rst}        |   14 +-
 Documentation/arm/index.rst                   |   80 ++
 .../arm/{Interrupts => interrupts.rst}        |   86 +-
 Documentation/arm/{IXP4xx => ixp4xx.rst}      |   61 +-
 ...nel_mode_neon.txt => kernel_mode_neon.rst} |    3 +
 ...er_helpers.txt => kernel_user_helpers.rst} |   79 +-
 .../keystone/{knav-qmss.txt => knav-qmss.rst} |    6 +-
 .../keystone/{Overview.txt => overview.rst}   |   47 +-
 Documentation/arm/marvel.rst                  |  488 +++++++
 .../arm/{mem_alignment => mem_alignment.rst}  |   11 +-
 Documentation/arm/{memory.txt => memory.rst}  |    9 +-
 .../arm/{Microchip/README => microchip.rst}   |   63 +-
 Documentation/arm/netwinder.rst               |   85 ++
 Documentation/arm/nwfpe/index.rst             |   11 +
 .../nwfpe/{README.FPE => netwinder-fpe.rst}   |   24 +-
 Documentation/arm/nwfpe/{NOTES => notes.rst}  |    3 +
 Documentation/arm/nwfpe/{README => nwfpe.rst} |   10 +-
 Documentation/arm/nwfpe/{TODO => todo.rst}    |   47 +-
 Documentation/arm/{OMAP/DSS => omap/dss.rst}  |  112 +-
 Documentation/arm/omap/index.rst              |   10 +
 .../arm/{OMAP/README => omap/omap.rst}        |    7 +
 .../arm/{OMAP/omap_pm => omap/omap_pm.rst}    |   55 +-
 Documentation/arm/{Porting => porting.rst}    |   14 +-
 Documentation/arm/pxa/{mfp.txt => mfp.rst}    |  106 +-
 .../{SA1100/ADSBitsy => sa1100/adsbitsy.rst}  |   14 +-
 .../{SA1100/Assabet => sa1100/assabet.rst}    |  185 +--
 .../arm/{SA1100/Brutus => sa1100/brutus.rst}  |   45 +-
 .../arm/{SA1100/CERF => sa1100/cerf.rst}      |   10 +-
 Documentation/arm/sa1100/freebird.rst         |   25 +
 .../graphicsclient.rst}                       |   46 +-
 .../graphicsmaster.rst}                       |   13 +-
 .../HUW_WEBPANEL => sa1100/huw_webpanel.rst}  |    8 +-
 Documentation/arm/sa1100/index.rst            |   23 +
 .../arm/{SA1100/Itsy => sa1100/itsy.rst}      |   14 +-
 .../arm/{SA1100/LART => sa1100/lart.rst}      |    3 +-
 .../nanoEngine => sa1100/nanoengine.rst}      |    6 +-
 .../{SA1100/Pangolin => sa1100/pangolin.rst}  |   10 +-
 .../arm/{SA1100/PLEB => sa1100/pleb.rst}      |    6 +-
 Documentation/arm/sa1100/serial_uart.rst      |   51 +
 .../arm/{SA1100/Tifon => sa1100/tifon.rst}    |    4 +-
 .../arm/{SA1100/Yopy => sa1100/yopy.rst}      |    5 +-
 .../cpufreq.rst}                              |    5 +-
 .../eb2410itx.rst}                            |    5 +-
 .../GPIO.txt => samsung-s3c24xx/gpio.rst}     |   23 +-
 .../H1940.txt => samsung-s3c24xx/h1940.rst}   |    5 +-
 Documentation/arm/samsung-s3c24xx/index.rst   |   18 +
 .../NAND.txt => samsung-s3c24xx/nand.rst}     |    6 +-
 .../overview.rst}                             |   21 +-
 .../s3c2412.rst}                              |    5 +-
 .../s3c2413.rst}                              |    7 +-
 .../smdk2440.rst}                             |    5 +-
 .../suspend.rst}                              |   20 +-
 .../usb-host.rst}                             |   16 +-
 .../bootloader-interface.rst}                 |   27 +-
 .../clksrc-change-registers.awk               |    0
 .../{Samsung/GPIO.txt => samsung/gpio.rst}    |    7 +-
 Documentation/arm/samsung/index.rst           |   10 +
 .../Overview.txt => samsung/overview.rst}     |   15 +-
 Documentation/arm/{Setup => setup.rst}        |   49 +-
 .../arm/{SH-Mobile => sh-mobile}/.gitignore   |    0
 .../overview.txt => spear/overview.rst}       |   20 +-
 .../arm/sti/{overview.txt => overview.rst}    |   21 +-
 ...h407-overview.txt => stih407-overview.rst} |    9 +-
 ...h415-overview.txt => stih415-overview.rst} |    8 +-
 ...h416-overview.txt => stih416-overview.rst} |    5 +-
 ...h418-overview.txt => stih418-overview.rst} |    9 +-
 Documentation/arm/stm32/overview.rst          |    2 -
 .../arm/stm32/stm32f429-overview.rst          |    7 +-
 .../arm/stm32/stm32f746-overview.rst          |    7 +-
 .../arm/stm32/stm32f769-overview.rst          |    7 +-
 .../arm/stm32/stm32h743-overview.rst          |    7 +-
 .../arm/stm32/stm32mp157-overview.rst         |    3 +-
 Documentation/arm/{sunxi/README => sunxi.rst} |   98 +-
 .../arm/sunxi/{clocks.txt => clocks.rst}      |    7 +-
 .../arm/{swp_emulation => swp_emulation.rst}  |   24 +-
 Documentation/arm/{tcm.txt => tcm.rst}        |   54 +-
 Documentation/arm/{uefi.txt => uefi.rst}      |   39 +-
 .../release-notes.rst}                        |    4 +-
 Documentation/arm/{vlocks.txt => vlocks.rst}  |    9 +-
 ...cd-panel-cgram.txt => lcd-panel-cgram.rst} |    9 +-
 Documentation/backlight/lp855x-driver.rst     |   83 ++
 Documentation/backlight/lp855x-driver.txt     |   66 -
 .../{bfq-iosched.txt => bfq-iosched.rst}      |   66 +-
 .../block/{biodoc.txt => biodoc.rst}          |  328 +++--
 .../block/{biovecs.txt => biovecs.rst}        |   20 +-
 Documentation/block/capability.rst            |   18 +
 Documentation/block/capability.txt            |   15 -
 ...ne-partition.txt => cmdline-partition.rst} |   13 +-
 ...{data-integrity.txt => data-integrity.rst} |   60 +-
 ...dline-iosched.txt => deadline-iosched.rst} |   21 +-
 Documentation/block/index.rst                 |   25 +
 .../block/{ioprio.txt => ioprio.rst}          |   95 +-
 .../{kyber-iosched.txt => kyber-iosched.rst}  |    3 +-
 .../block/{null_blk.txt => null_blk.rst}      |   65 +-
 Documentation/block/{pr.txt => pr.rst}        |   18 +-
 .../{queue-sysfs.txt => queue-sysfs.rst}      |    7 +-
 .../block/{request.txt => request.rst}        |   47 +-
 Documentation/block/{stat.txt => stat.rst}    |   13 +-
 ...witching-sched.txt => switching-sched.rst} |   28 +-
 ...ontrol.txt => writeback_cache_control.rst} |   12 +-
 ...structure-v9.txt => data-structure-v9.rst} |    6 +-
 Documentation/blockdev/drbd/figures.rst       |   28 +
 .../blockdev/drbd/{README.txt => index.rst}   |   15 +-
 .../blockdev/{floppy.txt => floppy.rst}       |   88 +-
 Documentation/blockdev/index.rst              |   16 +
 Documentation/blockdev/{nbd.txt => nbd.rst}   |    2 +-
 .../blockdev/{paride.txt => paride.rst}       |  194 +--
 .../blockdev/{ramdisk.txt => ramdisk.rst}     |   55 +-
 Documentation/blockdev/{zram.txt => zram.rst} |  197 ++-
 .../bus-devices/{ti-gpmc.txt => ti-gpmc.rst}  |  159 ++-
 .../cma/{debugfs.txt => debugfs.rst}          |    8 +-
 .../{connector.txt => connector.rst}          |  130 +-
 .../console/{console.txt => console.rst}      |   63 +-
 .../gcc-plugins.rst}                          |    0
 Documentation/core-api/index.rst              |    2 +-
 Documentation/core-api/printk-formats.rst     |    2 +-
 Documentation/devicetree/bindings/arm/xen.txt |    2 +-
 .../devicetree/booting-without-of.txt         |    4 +-
 .../{buffer-format.txt => buffer-format.rst}  |   19 +-
 .../{README => early_userspace_support.rst}   |    3 +
 Documentation/early-userspace/index.rst       |   18 +
 Documentation/fb/fbcon.rst                    |    4 +-
 Documentation/filesystems/nfs/nfsroot.txt     |    2 +-
 .../filesystems/ramfs-rootfs-initramfs.txt    |    4 +-
 .../acpi/extcon-intel-int3496.rst}            |   14 +-
 Documentation/firmware-guide/acpi/index.rst   |    1 +
 .../hid/{hid-alps.txt => hid-alps.rst}        |   85 +-
 .../hid/{hid-sensor.txt => hid-sensor.rst}    |  192 +--
 .../{hid-transport.txt => hid-transport.rst}  |   82 +-
 Documentation/hid/{hiddev.txt => hiddev.rst}  |  154 +-
 Documentation/hid/{hidraw.txt => hidraw.rst}  |   53 +-
 Documentation/hid/index.rst                   |   18 +
 Documentation/hid/intel-ish-hid.rst           |  485 +++++++
 Documentation/hid/intel-ish-hid.txt           |  454 ------
 Documentation/hid/{uhid.txt => uhid.rst}      |   46 +-
 .../ia64/{aliasing.txt => aliasing.rst}       |   73 +-
 Documentation/ia64/{efirtc.txt => efirtc.rst} |  118 +-
 .../ia64/{err_inject.txt => err_inject.rst}   |  349 +++--
 Documentation/ia64/{fsys.txt => fsys.rst}     |  127 +-
 Documentation/ia64/{README => ia64.rst}       |   26 +-
 Documentation/ia64/index.rst                  |   18 +
 .../ia64/{IRQ-redir.txt => irq-redir.rst}     |   31 +-
 Documentation/ia64/{mca.txt => mca.rst}       |   10 +-
 Documentation/ia64/{serial.txt => serial.rst} |   36 +-
 Documentation/ia64/xen.rst                    |  206 +++
 Documentation/ia64/xen.txt                    |  183 ---
 .../iio/{ep93xx_adc.txt => ep93xx_adc.rst}    |   15 +-
 .../{iio_configfs.txt => iio_configfs.rst}    |   52 +-
 Documentation/iio/index.rst                   |   12 +
 Documentation/index.rst                       |    1 +
 .../{core_locking.txt => core_locking.rst}    |   64 +-
 Documentation/infiniband/index.rst            |   23 +
 .../infiniband/{ipoib.txt => ipoib.rst}       |   24 +-
 .../infiniband/{opa_vnic.txt => opa_vnic.rst} |  108 +-
 .../infiniband/{sysfs.txt => sysfs.rst}       |    4 +-
 .../{tag_matching.txt => tag_matching.rst}    |    5 +
 .../infiniband/{user_mad.txt => user_mad.rst} |   33 +-
 .../{user_verbs.txt => user_verbs.rst}        |   12 +-
 Documentation/input/input.rst                 |    2 +-
 ...g-up-ioctls.txt => botching-up-ioctls.rst} |    1 +
 Documentation/ioctl/cdrom.rst                 | 1233 +++++++++++++++++
 Documentation/ioctl/cdrom.txt                 |  967 -------------
 Documentation/ioctl/{hdio.txt => hdio.rst}    |  835 +++++++----
 Documentation/ioctl/index.rst                 |   16 +
 ...{ioctl-decoding.txt => ioctl-decoding.rst} |   13 +-
 Documentation/ioctl/ioctl-number.rst          |  362 +++++
 Documentation/ioctl/ioctl-number.txt          |  350 -----
 Documentation/kernel-hacking/locking.rst      |    2 +-
 .../{asus-laptop.txt => asus-laptop.rst}      |   92 +-
 ...otection.txt => disk-shock-protection.rst} |   32 +-
 Documentation/laptops/index.rst               |   17 +
 .../{laptop-mode.txt => laptop-mode.rst}      |  509 ++++---
 .../{sony-laptop.txt => sony-laptop.rst}      |   58 +-
 .../laptops/{sonypi.txt => sonypi.rst}        |   28 +-
 .../{thinkpad-acpi.txt => thinkpad-acpi.rst}  |  367 +++--
 .../{toshiba_haps.txt => toshiba_haps.rst}    |   47 +-
 Documentation/leds/index.rst                  |   25 +
 .../leds/{leds-blinkm.txt => leds-blinkm.rst} |   64 +-
 ...s-class-flash.txt => leds-class-flash.rst} |   49 +-
 .../leds/{leds-class.txt => leds-class.rst}   |   15 +-
 .../leds/{leds-lm3556.txt => leds-lm3556.rst} |  100 +-
 .../leds/{leds-lp3944.txt => leds-lp3944.rst} |   23 +-
 Documentation/leds/leds-lp5521.rst            |  115 ++
 Documentation/leds/leds-lp5521.txt            |  101 --
 Documentation/leds/leds-lp5523.rst            |  147 ++
 Documentation/leds/leds-lp5523.txt            |  130 --
 Documentation/leds/leds-lp5562.rst            |  137 ++
 Documentation/leds/leds-lp5562.txt            |  120 --
 Documentation/leds/leds-lp55xx.rst            |  224 +++
 Documentation/leds/leds-lp55xx.txt            |  194 ---
 Documentation/leds/leds-mlxcpld.rst           |  118 ++
 Documentation/leds/leds-mlxcpld.txt           |  110 --
 ...edtrig-oneshot.txt => ledtrig-oneshot.rst} |   11 +-
 ...ig-transient.txt => ledtrig-transient.rst} |   63 +-
 ...edtrig-usbport.txt => ledtrig-usbport.rst} |   11 +-
 Documentation/leds/{uleds.txt => uleds.rst}   |    5 +-
 Documentation/locking/index.rst               |   24 +
 ...{lockdep-design.txt => lockdep-design.rst} |   51 +-
 Documentation/locking/lockstat.rst            |  204 +++
 Documentation/locking/lockstat.txt            |  183 ---
 .../{locktorture.txt => locktorture.rst}      |  105 +-
 .../{mutex-design.txt => mutex-design.rst}    |   26 +-
 ...t-mutex-design.txt => rt-mutex-design.rst} |  139 +-
 .../locking/{rt-mutex.txt => rt-mutex.rst}    |   30 +-
 .../locking/{spinlocks.txt => spinlocks.rst}  |   32 +-
 ...w-mutex-design.txt => ww-mutex-design.rst} |   82 +-
 Documentation/m68k/index.rst                  |   17 +
 ...{kernel-options.txt => kernel-options.rst} |  319 +++--
 Documentation/md/index.rst                    |   12 +
 .../md/{md-cluster.txt => md-cluster.rst}     |  188 ++-
 .../md/{raid5-cache.txt => raid5-cache.rst}   |   28 +-
 .../md/{raid5-ppl.txt => raid5-ppl.rst}       |    2 +
 .../{ti-emif.txt => ti-emif.rst}              |   27 +-
 Documentation/mmc/index.rst                   |   13 +
 .../{mmc-async-req.txt => mmc-async-req.rst}  |   53 +-
 .../{mmc-dev-attrs.txt => mmc-dev-attrs.rst}  |   32 +-
 .../{mmc-dev-parts.txt => mmc-dev-parts.rst}  |   13 +-
 .../mmc/{mmc-tools.txt => mmc-tools.rst}      |    5 +-
 Documentation/mtd/index.rst                   |   12 +
 .../mtd/{intel-spi.txt => intel-spi.rst}      |   46 +-
 .../mtd/{nand_ecc.txt => nand_ecc.rst}        |  481 ++++---
 .../mtd/{spi-nor.txt => spi-nor.rst}          |    7 +-
 ...bility-list.txt => compatibility-list.rst} |   10 +-
 Documentation/namespaces/index.rst            |   11 +
 ...ource-control.txt => resource-control.rst} |    4 +
 Documentation/networking/ip-sysctl.txt        |    2 +-
 Documentation/nfc/index.rst                   |   11 +
 .../nfc/{nfc-hci.txt => nfc-hci.rst}          |  163 ++-
 .../nfc/{nfc-pn544.txt => nfc-pn544.rst}      |    6 +-
 Documentation/nvdimm/{btt.txt => btt.rst}     |  140 +-
 Documentation/nvdimm/index.rst                |   12 +
 .../nvdimm/{nvdimm.txt => nvdimm.rst}         |  518 ++++---
 .../nvdimm/{security.txt => security.rst}     |    4 +-
 Documentation/nvmem/{nvmem.txt => nvmem.rst}  |  112 +-
 .../perf/{arm-ccn.txt => arm-ccn.rst}         |   18 +-
 .../perf/{arm_dsu_pmu.txt => arm_dsu_pmu.rst} |    5 +-
 .../perf/{hisi-pmu.txt => hisi-pmu.rst}       |   35 +-
 Documentation/perf/index.rst                  |   16 +
 .../perf/{qcom_l2_pmu.txt => qcom_l2_pmu.rst} |    3 +-
 .../perf/{qcom_l3_pmu.txt => qcom_l3_pmu.rst} |    3 +-
 .../{thunderx2-pmu.txt => thunderx2-pmu.rst}  |   25 +-
 .../perf/{xgene-pmu.txt => xgene-pmu.rst}     |    3 +-
 .../{samsung-usb2.txt => samsung-usb2.rst}    |   62 +-
 Documentation/pi-futex.txt                    |    2 +-
 .../{bootwrapper.txt => bootwrapper.rst}      |   28 +-
 .../{cpu_families.txt => cpu_families.rst}    |   23 +-
 .../{cpu_features.txt => cpu_features.rst}    |    6 +-
 Documentation/powerpc/{cxl.txt => cxl.rst}    |   46 +-
 .../powerpc/{cxlflash.txt => cxlflash.rst}    |   10 +-
 .../{DAWR-POWER9.txt => dawr-power9.rst}      |   15 +-
 Documentation/powerpc/{dscr.txt => dscr.rst}  |   18 +-
 ...ecovery.txt => eeh-pci-error-recovery.rst} |  108 +-
 ...ed-dump.txt => firmware-assisted-dump.rst} |  117 +-
 Documentation/powerpc/{hvcs.txt => hvcs.rst}  |  108 +-
 Documentation/powerpc/index.rst               |   34 +
 Documentation/powerpc/isa-versions.rst        |   15 +-
 .../powerpc/{mpc52xx.txt => mpc52xx.rst}      |   12 +-
 ...nv.txt => pci_iov_resource_on_powernv.rst} |   15 +-
 .../powerpc/{pmu-ebb.txt => pmu-ebb.rst}      |    1 +
 Documentation/powerpc/ptrace.rst              |  156 +++
 Documentation/powerpc/ptrace.txt              |  151 --
 .../{qe_firmware.txt => qe_firmware.rst}      |   37 +-
 .../{syscall64-abi.txt => syscall64-abi.rst}  |   29 +-
 ...al_memory.txt => transactional_memory.rst} |   45 +-
 Documentation/process/submit-checklist.rst    |    2 +-
 Documentation/pti/pti_intel_mid.rst           |  106 ++
 Documentation/pti/pti_intel_mid.txt           |   99 --
 Documentation/rapidio/index.rst               |   15 +
 .../{mport_cdev.txt => mport_cdev.rst}        |   47 +-
 .../rapidio/{rapidio.txt => rapidio.rst}      |   39 +-
 .../rapidio/{rio_cm.txt => rio_cm.rst}        |   66 +-
 .../rapidio/{sysfs.txt => sysfs.rst}          |    4 +
 .../rapidio/{tsi721.txt => tsi721.rst}        |   45 +-
 Documentation/rbtree.txt                      |    6 +-
 .../{xen-tpmfront.txt => xen-tpmfront.rst}    |  103 +-
 Documentation/sysctl/abi.rst                  |   67 +
 Documentation/sysctl/abi.txt                  |   54 -
 Documentation/sysctl/{fs.txt => fs.rst}       |  142 +-
 Documentation/sysctl/{README => index.rst}    |   36 +-
 .../sysctl/{kernel.txt => kernel.rst}         |  372 ++---
 Documentation/sysctl/{net.txt => net.rst}     |  141 +-
 .../sysctl/{sunrpc.txt => sunrpc.rst}         |   13 +-
 Documentation/sysctl/{user.txt => user.rst}   |   32 +-
 Documentation/sysctl/{vm.txt => vm.rst}       |  262 ++--
 ...pu-cooling-api.txt => cpu-cooling-api.rst} |   39 +-
 .../{exynos_thermal => exynos_thermal.rst}    |   47 +-
 .../thermal/exynos_thermal_emulation          |   53 -
 .../thermal/exynos_thermal_emulation.rst      |   61 +
 Documentation/thermal/index.rst               |   18 +
 ...el_powerclamp.txt => intel_powerclamp.rst} |  177 +--
 .../{nouveau_thermal => nouveau_thermal.rst}  |   54 +-
 ...ower_allocator.txt => power_allocator.rst} |  140 +-
 .../thermal/{sysfs-api.txt => sysfs-api.rst}  |  490 ++++---
 ...hermal => x86_pkg_temperature_thermal.rst} |   28 +-
 .../it_IT/kernel-hacking/locking.rst          |    2 +-
 .../it_IT/process/submit-checklist.rst        |    2 +-
 Documentation/translations/zh_CN/arm/Booting  |    4 +-
 .../zh_CN/arm/kernel_user_helpers.txt         |    4 +-
 .../zh_CN/process/submit-checklist.rst        |    2 +-
 Documentation/vm/unevictable-lru.rst          |    2 +-
 .../xtensa/{atomctl.txt => atomctl.rst}       |   13 +-
 .../xtensa/{booting.txt => booting.rst}       |    5 +-
 Documentation/xtensa/index.rst                |   12 +
 Documentation/xtensa/mmu.rst                  |  195 +++
 Documentation/xtensa/mmu.txt                  |  189 ---
 MAINTAINERS                                   |   48 +-
 arch/arm/Kconfig                              |    2 +-
 arch/arm/common/mcpm_entry.c                  |    2 +-
 arch/arm/common/mcpm_head.S                   |    2 +-
 arch/arm/common/vlock.S                       |    2 +-
 arch/arm/include/asm/setup.h                  |    2 +-
 arch/arm/include/uapi/asm/setup.h             |    2 +-
 arch/arm/kernel/entry-armv.S                  |    2 +-
 arch/arm/mach-exynos/common.h                 |    2 +-
 arch/arm/mach-ixp4xx/Kconfig                  |   14 +-
 arch/arm/mach-s3c24xx/pm.c                    |    2 +-
 arch/arm/mm/Kconfig                           |    4 +-
 arch/arm/plat-samsung/Kconfig                 |    6 +-
 arch/arm/tools/mach-types                     |    2 +-
 arch/arm64/Kconfig                            |    2 +-
 arch/arm64/kernel/kuser32.S                   |    2 +-
 arch/ia64/kernel/efi.c                        |    2 +-
 arch/ia64/kernel/fsys.S                       |    2 +-
 arch/ia64/mm/ioremap.c                        |    2 +-
 arch/ia64/pci/pci.c                           |    2 +-
 arch/mips/bmips/setup.c                       |    2 +-
 arch/powerpc/kernel/exceptions-64s.S          |    2 +-
 arch/xtensa/include/asm/initialize_mmu.h      |    2 +-
 block/Kconfig                                 |    2 +-
 block/Kconfig.iosched                         |    2 +-
 block/bfq-iosched.c                           |    2 +-
 block/blk-integrity.c                         |    2 +-
 block/ioprio.c                                |    2 +-
 block/mq-deadline.c                           |    2 +-
 block/partitions/cmdline.c                    |    2 +-
 drivers/block/Kconfig                         |    8 +-
 drivers/block/floppy.c                        |    2 +-
 drivers/block/zram/Kconfig                    |    6 +-
 drivers/char/Kconfig                          |    2 +-
 drivers/crypto/sunxi-ss/sun4i-ss-cipher.c     |    2 +-
 drivers/crypto/sunxi-ss/sun4i-ss-core.c       |    2 +-
 drivers/crypto/sunxi-ss/sun4i-ss-hash.c       |    2 +-
 drivers/crypto/sunxi-ss/sun4i-ss.h            |    2 +-
 drivers/gpu/drm/drm_ioctl.c                   |    2 +-
 drivers/gpu/drm/drm_modeset_lock.c            |    2 +-
 drivers/iio/Kconfig                           |    2 +-
 drivers/infiniband/core/user_mad.c            |    2 +-
 drivers/infiniband/ulp/ipoib/Kconfig          |    2 +-
 drivers/input/touchscreen/sun4i-ts.c          |    2 +-
 drivers/leds/trigger/Kconfig                  |    2 +-
 drivers/leds/trigger/ledtrig-transient.c      |    2 +-
 drivers/mtd/nand/raw/nand_ecc.c               |    2 +-
 drivers/nvdimm/Kconfig                        |    2 +-
 drivers/perf/qcom_l3_pmu.c                    |    2 +-
 drivers/platform/x86/Kconfig                  |    4 +-
 drivers/rapidio/Kconfig                       |    2 +-
 drivers/soc/fsl/qe/qe.c                       |    2 +-
 drivers/tty/Kconfig                           |    2 +-
 drivers/tty/hvc/hvcs.c                        |    2 +-
 drivers/tty/serial/Kconfig                    |    2 +-
 drivers/w1/Kconfig                            |    2 +-
 include/linux/connector.h                     |   63 +-
 include/linux/lockdep.h                       |    2 +-
 include/linux/mutex.h                         |    2 +-
 include/linux/rwsem.h                         |    2 +-
 include/linux/thermal.h                       |    4 +-
 include/soc/fsl/qe/qe.h                       |    2 +-
 include/uapi/rdma/rdma_user_ioctl_cmds.h      |    2 +-
 init/Kconfig                                  |    2 +-
 kernel/locking/mutex.c                        |    2 +-
 kernel/locking/rtmutex.c                      |    2 +-
 kernel/panic.c                                |    2 +-
 lib/Kconfig.debug                             |    4 +-
 mm/swap.c                                     |    2 +-
 net/netfilter/Kconfig                         |    2 +-
 samples/Kconfig                               |    2 +-
 scripts/gcc-plugins/Kconfig                   |    2 +-
 tools/testing/selftests/zram/README           |    2 +-
 usr/Kconfig                                   |    2 +-
 403 files changed, 13486 insertions(+), 9719 deletions(-)
 rename Documentation/{logo.txt => COPYING-logo} (100%)
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
 rename Documentation/block/{bfq-iosched.txt => bfq-iosched.rst} (95%)
 rename Documentation/block/{biodoc.txt => biodoc.rst} (85%)
 rename Documentation/block/{biovecs.txt => biovecs.rst} (92%)
 create mode 100644 Documentation/block/capability.rst
 delete mode 100644 Documentation/block/capability.txt
 rename Documentation/block/{cmdline-partition.txt => cmdline-partition.rst} (92%)
 rename Documentation/block/{data-integrity.txt => data-integrity.rst} (91%)
 rename Documentation/block/{deadline-iosched.txt => deadline-iosched.rst} (89%)
 create mode 100644 Documentation/block/index.rst
 rename Documentation/block/{ioprio.txt => ioprio.rst} (75%)
 rename Documentation/block/{kyber-iosched.txt => kyber-iosched.rst} (86%)
 rename Documentation/block/{null_blk.txt => null_blk.rst} (60%)
 rename Documentation/block/{pr.txt => pr.rst} (93%)
 rename Documentation/block/{queue-sysfs.txt => queue-sysfs.rst} (99%)
 rename Documentation/block/{request.txt => request.rst} (59%)
 rename Documentation/block/{stat.txt => stat.rst} (89%)
 rename Documentation/block/{switching-sched.txt => switching-sched.rst} (67%)
 rename Documentation/block/{writeback_cache_control.txt => writeback_cache_control.rst} (94%)
 rename Documentation/blockdev/drbd/{data-structure-v9.txt => data-structure-v9.rst} (94%)
 create mode 100644 Documentation/blockdev/drbd/figures.rst
 rename Documentation/blockdev/drbd/{README.txt => index.rst} (55%)
 rename Documentation/blockdev/{floppy.txt => floppy.rst} (81%)
 create mode 100644 Documentation/blockdev/index.rst
 rename Documentation/blockdev/{nbd.txt => nbd.rst} (96%)
 rename Documentation/blockdev/{paride.txt => paride.rst} (81%)
 rename Documentation/blockdev/{ramdisk.txt => ramdisk.rst} (84%)
 rename Documentation/blockdev/{zram.txt => zram.rst} (76%)
 rename Documentation/bus-devices/{ti-gpmc.txt => ti-gpmc.rst} (58%)
 rename Documentation/cma/{debugfs.txt => debugfs.rst} (91%)
 rename Documentation/connector/{connector.txt => connector.rst} (57%)
 rename Documentation/console/{console.txt => console.rst} (80%)
 rename Documentation/{gcc-plugins.txt => core-api/gcc-plugins.rst} (100%)
 rename Documentation/early-userspace/{buffer-format.txt => buffer-format.rst} (91%)
 rename Documentation/early-userspace/{README => early_userspace_support.rst} (99%)
 create mode 100644 Documentation/early-userspace/index.rst
 rename Documentation/{extcon/intel-int3496.txt => firmware-guide/acpi/extcon-intel-int3496.rst} (66%)
 rename Documentation/hid/{hid-alps.txt => hid-alps.rst} (64%)
 rename Documentation/hid/{hid-sensor.txt => hid-sensor.rst} (61%)
 rename Documentation/hid/{hid-transport.txt => hid-transport.rst} (93%)
 rename Documentation/hid/{hiddev.txt => hiddev.rst} (77%)
 rename Documentation/hid/{hidraw.txt => hidraw.rst} (89%)
 create mode 100644 Documentation/hid/index.rst
 create mode 100644 Documentation/hid/intel-ish-hid.rst
 delete mode 100644 Documentation/hid/intel-ish-hid.txt
 rename Documentation/hid/{uhid.txt => uhid.rst} (94%)
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
 rename Documentation/infiniband/{core_locking.txt => core_locking.rst} (78%)
 create mode 100644 Documentation/infiniband/index.rst
 rename Documentation/infiniband/{ipoib.txt => ipoib.rst} (90%)
 rename Documentation/infiniband/{opa_vnic.txt => opa_vnic.rst} (63%)
 rename Documentation/infiniband/{sysfs.txt => sysfs.rst} (69%)
 rename Documentation/infiniband/{tag_matching.txt => tag_matching.rst} (98%)
 rename Documentation/infiniband/{user_mad.txt => user_mad.rst} (90%)
 rename Documentation/infiniband/{user_verbs.txt => user_verbs.rst} (93%)
 rename Documentation/ioctl/{botching-up-ioctls.txt => botching-up-ioctls.rst} (99%)
 create mode 100644 Documentation/ioctl/cdrom.rst
 delete mode 100644 Documentation/ioctl/cdrom.txt
 rename Documentation/ioctl/{hdio.txt => hdio.rst} (54%)
 create mode 100644 Documentation/ioctl/index.rst
 rename Documentation/ioctl/{ioctl-decoding.txt => ioctl-decoding.rst} (54%)
 create mode 100644 Documentation/ioctl/ioctl-number.rst
 delete mode 100644 Documentation/ioctl/ioctl-number.txt
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
 create mode 100644 Documentation/locking/index.rst
 rename Documentation/locking/{lockdep-design.txt => lockdep-design.rst} (93%)
 create mode 100644 Documentation/locking/lockstat.rst
 delete mode 100644 Documentation/locking/lockstat.txt
 rename Documentation/locking/{locktorture.txt => locktorture.rst} (57%)
 rename Documentation/locking/{mutex-design.txt => mutex-design.rst} (94%)
 rename Documentation/locking/{rt-mutex-design.txt => rt-mutex-design.rst} (91%)
 rename Documentation/locking/{rt-mutex.txt => rt-mutex.rst} (71%)
 rename Documentation/locking/{spinlocks.txt => spinlocks.rst} (89%)
 rename Documentation/locking/{ww-mutex-design.txt => ww-mutex-design.rst} (93%)
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
 rename Documentation/perf/{arm-ccn.txt => arm-ccn.rst} (86%)
 rename Documentation/perf/{arm_dsu_pmu.txt => arm_dsu_pmu.rst} (92%)
 rename Documentation/perf/{hisi-pmu.txt => hisi-pmu.rst} (73%)
 create mode 100644 Documentation/perf/index.rst
 rename Documentation/perf/{qcom_l2_pmu.txt => qcom_l2_pmu.rst} (94%)
 rename Documentation/perf/{qcom_l3_pmu.txt => qcom_l3_pmu.rst} (93%)
 rename Documentation/perf/{thunderx2-pmu.txt => thunderx2-pmu.rst} (73%)
 rename Documentation/perf/{xgene-pmu.txt => xgene-pmu.rst} (96%)
 rename Documentation/phy/{samsung-usb2.txt => samsung-usb2.rst} (77%)
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
 create mode 100644 Documentation/pti/pti_intel_mid.rst
 delete mode 100644 Documentation/pti/pti_intel_mid.txt
 create mode 100644 Documentation/rapidio/index.rst
 rename Documentation/rapidio/{mport_cdev.txt => mport_cdev.rst} (84%)
 rename Documentation/rapidio/{rapidio.txt => rapidio.rst} (97%)
 rename Documentation/rapidio/{rio_cm.txt => rio_cm.rst} (76%)
 rename Documentation/rapidio/{sysfs.txt => sysfs.rst} (75%)
 rename Documentation/rapidio/{tsi721.txt => tsi721.rst} (79%)
 rename Documentation/security/tpm/{xen-tpmfront.txt => xen-tpmfront.rst} (66%)
 create mode 100644 Documentation/sysctl/abi.rst
 delete mode 100644 Documentation/sysctl/abi.txt
 rename Documentation/sysctl/{fs.txt => fs.rst} (77%)
 rename Documentation/sysctl/{README => index.rst} (78%)
 rename Documentation/sysctl/{kernel.txt => kernel.rst} (79%)
 rename Documentation/sysctl/{net.txt => net.rst} (85%)
 rename Documentation/sysctl/{sunrpc.txt => sunrpc.rst} (62%)
 rename Documentation/sysctl/{user.txt => user.rst} (77%)
 rename Documentation/sysctl/{vm.txt => vm.rst} (85%)
 rename Documentation/thermal/{cpu-cooling-api.txt => cpu-cooling-api.rst} (82%)
 rename Documentation/thermal/{exynos_thermal => exynos_thermal.rst} (67%)
 delete mode 100644 Documentation/thermal/exynos_thermal_emulation
 create mode 100644 Documentation/thermal/exynos_thermal_emulation.rst
 create mode 100644 Documentation/thermal/index.rst
 rename Documentation/thermal/{intel_powerclamp.txt => intel_powerclamp.rst} (76%)
 rename Documentation/thermal/{nouveau_thermal => nouveau_thermal.rst} (64%)
 rename Documentation/thermal/{power_allocator.txt => power_allocator.rst} (74%)
 rename Documentation/thermal/{sysfs-api.txt => sysfs-api.rst} (66%)
 rename Documentation/thermal/{x86_pkg_temperature_thermal => x86_pkg_temperature_thermal.rst} (80%)
 rename Documentation/xtensa/{atomctl.txt => atomctl.rst} (81%)
 rename Documentation/xtensa/{booting.txt => booting.rst} (91%)
 create mode 100644 Documentation/xtensa/index.rst
 create mode 100644 Documentation/xtensa/mmu.rst
 delete mode 100644 Documentation/xtensa/mmu.txt

-- 
2.21.0


