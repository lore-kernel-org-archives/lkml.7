Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DDFC282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36E420874
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555939779;
	bh=7Im5LQA28ooByuCnSfvBBnrzmt0yCn/gCtecvbnYE3w=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=wquNDAdwDe0U3GNwR+PPR5vEpeWo2PagSzIMvg8aZczMrYVuOBVNuS2UZUItMlI3b
	 cA+KzKwvI9Ug4F0yaljATG6Ab+JbGAARbV1JP6K/jKAx7/bplmKU/8nsY+EzQ1vprV
	 cLq3o4qB9qC4qYNpS90JGJVPlPS3yzuIOFbWsK+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfDVN2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 09:28:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37048 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbfDVN2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 09:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bT7vBfLYZFAIYID6XqqTFsWK+L1AmIBFgqBTlp/lhxs=; b=Vuh5iDIMzt3bBId8U4YJZdzWl
        JMR/fLljQFeLOiZ4VISsR8XRMyZiNbXMBt84ELCszCyP9fNtBVZYSPF5Yh7nI+dswfx8JpIGLnKeX
        GrihekflXV+fzjm7JQ1T+MLxWiXFwtujKLBfunr5XSgI6r+eOWUCbQUOMefcLoGpaKbnjcy5/ZMfV
        Hy6eU9Abntx3PHIj1z+IkdpnMkO7L3/TwvdgNZyrOUoUWwDO7KNrmkS/6MQey3jblRAl0LZC3fv/x
        kmPNKZbPyQkj1nwKTymsiffWgxwAR1qbl7TErIwSQK0Y+CM1jkf4ttzfmtOSN2zR6wmbaBC3Tughq
        2wziaPaIw==;
Received: from 179.176.125.229.dynamic.adsl.gvt.net.br ([179.176.125.229] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIYzU-0005Hb-MB; Mon, 22 Apr 2019 13:28:14 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hIYzS-0005jS-7X; Mon, 22 Apr 2019 10:28:10 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        linux-riscv@lists.infradead.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 00/79] Convert files to ReST
Date:   Mon, 22 Apr 2019 10:26:49 -0300
Message-Id: <cover.1555938375.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series convert lots of files to be properly parsed by Sphinx
as ReST files.

As it touches on lot of stuff, this series is based on linux-next,
at tag next-20190418.

The version 2 is mainly focused on addressing a comment I received
from several subsystem maintainters:

- While it was doing the conversion, the files were not
  being renamed to ReST. So, they weren't producing any document.

So, I opted to do the rename as well, on each patch, and to add a
:orphan:  markup at the beginning of each file, in order to shut up
the Sphinx warning that the file was not included on any TOC.

The second version of this series also touches a lot more directories
without any index.rst.

After this patch, just a few directories at Documentation won't have
an index.rst file:

    $ for i in $(find Documentation/ -name '*.txt'|perl -ne 's,([^/]*/[^/]*/).*,\1,; print $_;'|sort|uniq|grep -v Documentation/output|grep -v Documentation/sphinx); do if [ ! -f $i/index.rst ]; then echo $i; fi; done|grep -v .txt

    Documentation/ABI/
    Documentation/devicetree/
    Documentation/features/
    Documentation/platform/
    Documentation/RCU/
    Documentation/scsi/
    Documentation/virtual/

I'm working on another patch patch series with removes the :orphan: from
the added files while adding them to some book. As such series would
cause lots of conflicts, the best would be to wait for this series to be applied
by each subsystem maintainer before adding it (probably late on some
merge window).

Ah, I removed the patches with converts /acpi, /x86 and /PCI from this
submission. As pointed by Rafael, Changbin is already working on
those.

Also, I got some acks from some of those conversions. I'm opting to not
adding here, as all patches were changed (due to the rename and addition
of the index.rst file). So, if you send your ack already, feel free to re-send.

Both this series and  the next steps are on my devel git tree,
at:

	https://git.linuxtv.org/mchehab/experimental.git/log/?h=convert_rst_v2

The final output in html can be seen at:

	https://www.infradead.org/~mchehab/rst_conversion/

Mauro Carvalho Chehab (79):
  docs: core-api: fix broken references for div64.c and gcd.c
  docs: trace: fix some Sphinx warnings
  scripts/documentation-file-ref-check: don't parse Next/ dir
  docs: aoe: convert docs to ReST and rename to *.rst
  docs: arm64: convert docs to ReST and rename to .rst
  docs: cdrom-standard.tex: convert from LaTeX to ReST
  docs: cdrom: convert docs to ReST and rename to *.rst
  docs: cgroup-v1: convert docs to ReST and rename to *.rst
  docs: cgroup-v1/blkio-controller.rst: add a note about CFQ scheduler
  docs: cpu-freq: convert docs to ReST and rename to *.rst
  docs: convert docs to ReST and rename to *.rst
  docs: fault-injection: convert docs to ReST and rename to *.rst
  docs: fb: convert docs to ReST and rename to *.rst
  docs: fpga: convert docs to ReST and rename to *.rst
  docs: gpio: convert docs to ReST and rename to *.rst
  docs: ide: convert docs to ReST and rename to *.rst
  docs: infiniband: convert docs to ReST and rename to *.rst
  docs: kbuild: convert docs to ReST and rename to *.rst
  docs: kdump: convert docs to ReST and rename to *.rst
  docs: livepatch: convert docs to ReST and rename to *.rst
  docs: locking: convert docs to ReST and rename to *.rst
  docs: mic: convert docs to ReST and rename to *.rst
  docs: netlabel: convert docs to ReST and rename to *.rst
  docs: pcmcia: convert docs to ReST and rename to *.rst
  docs: convert docs to ReST and rename to *.rst
  docs: powerpc: convert docs to ReST and rename to *.rst
  docs: pps.txt: convert to ReST and rename to pps.rst
  docs: ptp.txt: convert to ReST and move to driver-api
  docs: riscv: convert docs to ReST and rename to *.rst
  docs: Debugging390.txt: convert table to ascii artwork
  docs: s390: convert docs to ReST and rename to *.rst
  s390: include/asm/debug.h add kerneldoc markups
  docs: serial: convert docs to ReST and rename to *.rst
  docs: target: convert docs to ReST and rename to *.rst
  docs: timers: convert docs to ReST and rename to *.rst
  docs: watchdog: convert docs to ReST and rename to *.rst
  docs: xilinx: convert eemi.txt to eemi.rst
  docs: scheduler: convert docs to ReST and rename to *.rst
  docs: EDID/HOWTO.txt: convert it and rename to howto.rst
  convert docs to ReST and rename to *.rst
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
  docs: Documentation/*.txt: rename all ReST files to *.rst
  docs: accounting: convert to ReST
  docs: fmc: convert to ReST
  docs: hid: convert to ReST
  docs: ia64: convert to ReST
  docs: leds: convert to ReST
  docs: laptops: convert to ReST
  docs: iio: convert to ReST
  docs: ioctl-number.txt: convert it to ReST format
  docs: ioctl: convert to ReST
  docs: namespaces: convert to ReST
  docs: nfc: convert to ReST
  docs: md: convert to ReST
  docs: mtd: convert to ReST
  docs: nvdimm: convert to ReST
  docs: xtensa: convert to ReST
  docs: mmc: convert to ReST
  docs: sparc: convert to ReST
  docs: thermal: convert to ReST
  docs: rapidio: convert to ReST
  docs: blockdev: convert to ReST
  docs: perf: convert to ReST
  docs: sysctl: convert to ReST
  docs: block: convert to ReST

 Documentation/ABI/removed/sysfs-class-rfkill  |    2 +-
 Documentation/ABI/stable/sysfs-class-rfkill   |    2 +-
 Documentation/ABI/stable/sysfs-devices-node   |    2 +-
 Documentation/ABI/testing/procfs-diskstats    |    2 +-
 Documentation/ABI/testing/sysfs-block         |    2 +-
 Documentation/ABI/testing/sysfs-block-device  |    2 +-
 .../ABI/testing/sysfs-class-powercap          |    2 +-
 .../ABI/testing/sysfs-class-switchtec         |    2 +-
 .../ABI/testing/sysfs-devices-system-cpu      |    4 +-
 .../ABI/testing/sysfs-kernel-livepatch        |    2 +-
 Documentation/ABI/testing/sysfs-kernel-uids   |    2 +-
 .../ABI/testing/sysfs-platform-asus-laptop    |    2 +-
 .../{DMA-API-HOWTO.txt => DMA-API-HOWTO.rst}  |    2 +
 Documentation/{DMA-API.txt => DMA-API.rst}    |    8 +-
 .../{DMA-ISA-LPC.txt => DMA-ISA-LPC.rst}      |    4 +-
 ...{DMA-attributes.txt => DMA-attributes.rst} |    2 +
 Documentation/EDID/{HOWTO.txt => howto.rst}   |   31 +-
 Documentation/{IPMI.txt => IPMI.rst}          |    2 +
 .../{IRQ-affinity.txt => IRQ-affinity.rst}    |    2 +
 .../{IRQ-domain.txt => IRQ-domain.rst}        |    2 +
 Documentation/{IRQ.txt => IRQ.rst}            |    2 +
 .../{Intel-IOMMU.txt => Intel-IOMMU.rst}      |    2 +
 Documentation/PCI/pci-error-recovery.txt      |    2 +-
 Documentation/PCI/pci.txt                     |   10 +-
 Documentation/{SAK.txt => SAK.rst}            |    2 +
 Documentation/{SM501.txt => SM501.rst}        |    2 +
 .../{cgroupstats.txt => cgroupstats.rst}      |   14 +-
 ...ay-accounting.txt => delay-accounting.rst} |   61 +-
 Documentation/accounting/index.rst            |   14 +
 Documentation/accounting/{psi.txt => psi.rst} |   40 +-
 ...kstats-struct.txt => taskstats-struct.rst} |   53 +-
 .../{taskstats.txt => taskstats.rst}          |   15 +-
 Documentation/admin-guide/README.rst          |    2 +-
 Documentation/admin-guide/bug-hunting.rst     |    2 +-
 Documentation/admin-guide/cgroup-v2.rst       |    6 +-
 .../admin-guide/kernel-parameters.rst         |    2 +-
 .../admin-guide/kernel-parameters.txt         |   64 +-
 Documentation/admin-guide/l1tf.rst            |    4 +-
 Documentation/admin-guide/mm/index.rst        |    2 +-
 Documentation/admin-guide/mm/ksm.rst          |    2 +-
 .../admin-guide/mm/numa_memory_policy.rst     |    2 +-
 Documentation/aoe/{aoe.txt => aoe.rst}        |   63 +-
 Documentation/aoe/examples.rst                |   23 +
 Documentation/aoe/index.rst                   |   19 +
 Documentation/aoe/{todo.txt => todo.rst}      |    3 +
 Documentation/aoe/udev.txt                    |    2 +-
 Documentation/arm/Marvell/README              |  395 ---
 Documentation/arm/Netwinder                   |   78 -
 Documentation/arm/SA1100/FreeBird             |   21 -
 Documentation/arm/SA1100/empeg                |    2 -
 Documentation/arm/SA1100/serial_UART          |   47 -
 Documentation/arm/{README => arm.rst}         |   50 +-
 Documentation/arm/{Booting => booting.rst}    |   71 +-
 ...ance.txt => cluster-pm-race-avoidance.rst} |  177 +-
 .../arm/{firmware.txt => firmware.rst}        |   14 +-
 Documentation/arm/index.rst                   |   80 +
 .../arm/{Interrupts => interrupts.rst}        |   86 +-
 Documentation/arm/{IXP4xx => ixp4xx.rst}      |   61 +-
 ...nel_mode_neon.txt => kernel_mode_neon.rst} |    3 +
 ...er_helpers.txt => kernel_user_helpers.rst} |   79 +-
 .../keystone/{knav-qmss.txt => knav-qmss.rst} |    6 +-
 .../keystone/{Overview.txt => overview.rst}   |   47 +-
 Documentation/arm/marvel.rst                  |  488 +++
 .../arm/{mem_alignment => mem_alignment.rst}  |   11 +-
 Documentation/arm/{memory.txt => memory.rst}  |    9 +-
 .../arm/{Microchip/README => microchip.rst}   |   63 +-
 Documentation/arm/netwinder.rst               |   85 +
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
 .../{SA1100/Assabet => sa1100/assabet.rst}    |  185 +-
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
 .../arm/stm32/stm32f429-overview.rst          |    5 +-
 .../arm/stm32/stm32f746-overview.rst          |    5 +-
 .../arm/stm32/stm32f769-overview.rst          |    5 +-
 .../arm/stm32/stm32h743-overview.rst          |    5 +-
 .../arm/stm32/stm32mp157-overview.rst         |    1 +
 Documentation/arm/{sunxi/README => sunxi.rst} |   98 +-
 .../arm/sunxi/{clocks.txt => clocks.rst}      |    7 +-
 .../arm/{swp_emulation => swp_emulation.rst}  |   24 +-
 Documentation/arm/{tcm.txt => tcm.rst}        |   54 +-
 Documentation/arm/{uefi.txt => uefi.rst}      |   39 +-
 .../release-notes.rst}                        |    4 +-
 Documentation/arm/{vlocks.txt => vlocks.rst}  |    9 +-
 ...object_usage.txt => acpi_object_usage.rst} |  288 +-
 .../arm64/{arm-acpi.txt => arm-acpi.rst}      |  155 +-
 .../arm64/{booting.txt => booting.rst}        |   91 +-
 ...egisters.txt => cpu-feature-registers.rst} |  190 +-
 .../arm64/{elf_hwcaps.txt => elf_hwcaps.rst}  |   56 +-
 .../{hugetlbpage.txt => hugetlbpage.rst}      |    7 +-
 Documentation/arm64/index.rst                 |   28 +
 ...structions.txt => legacy_instructions.rst} |   43 +-
 Documentation/arm64/memory.rst                |   98 +
 Documentation/arm64/memory.txt                |   97 -
 ...ication.txt => pointer-authentication.rst} |    2 +
 ...{silicon-errata.txt => silicon-errata.rst} |   63 +-
 Documentation/arm64/{sve.txt => sve.rst}      |   12 +-
 ...agged-pointers.txt => tagged-pointers.rst} |    6 +-
 .../{atomic_bitops.txt => atomic_bitops.rst}  |    2 +
 ...cd-panel-cgram.txt => lcd-panel-cgram.rst} |    9 +-
 Documentation/backlight/lp855x-driver.rst     |   83 +
 Documentation/backlight/lp855x-driver.txt     |   66 -
 .../{bfq-iosched.txt => bfq-iosched.rst}      |   68 +-
 .../block/{biodoc.txt => biodoc.rst}          |  365 ++-
 .../block/{biovecs.txt => biovecs.rst}        |   20 +-
 Documentation/block/capability.rst            |   18 +
 Documentation/block/capability.txt            |   15 -
 ...ne-partition.txt => cmdline-partition.rst} |   13 +-
 ...{data-integrity.txt => data-integrity.rst} |   58 +-
 ...dline-iosched.txt => deadline-iosched.rst} |   19 +-
 Documentation/block/index.rst                 |   25 +
 .../block/{ioprio.txt => ioprio.rst}          |   95 +-
 .../{kyber-iosched.txt => kyber-iosched.rst}  |    3 +-
 .../block/{null_blk.txt => null_blk.rst}      |   65 +-
 Documentation/block/{pr.txt => pr.rst}        |   14 +-
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
 Documentation/blockdev/{nbd.txt => nbd.rst}   |    1 +
 .../blockdev/{paride.txt => paride.rst}       |  144 +-
 .../blockdev/{ramdisk.txt => ramdisk.rst}     |   55 +-
 Documentation/blockdev/{zram.txt => zram.rst} |  197 +-
 .../{bt8xxgpio.txt => bt8xxgpio.rst}          |    2 +
 Documentation/{btmrvl.txt => btmrvl.rst}      |    2 +
 .../bus-devices/{ti-gpmc.txt => ti-gpmc.rst}  |  159 +-
 ...-mapping.txt => bus-virt-phys-mapping.rst} |    4 +-
 Documentation/cdrom/Makefile                  |   21 -
 Documentation/cdrom/cdrom-standard.rst        | 1063 +++++++
 Documentation/cdrom/cdrom-standard.tex        | 1026 -------
 Documentation/cdrom/{ide-cd => ide-cd.rst}    |  196 +-
 Documentation/cdrom/index.rst                 |   19 +
 ...{packet-writing.txt => packet-writing.rst} |   27 +-
 ...io-controller.txt => blkio-controller.rst} |  103 +-
 .../cgroup-v1/{cgroups.txt => cgroups.rst}    |  184 +-
 .../cgroup-v1/{cpuacct.txt => cpuacct.rst}    |   15 +-
 .../cgroup-v1/{cpusets.txt => cpusets.rst}    |  205 +-
 .../cgroup-v1/{devices.txt => devices.rst}    |   40 +-
 ...er-subsystem.txt => freezer-subsystem.rst} |   14 +-
 .../cgroup-v1/{hugetlb.txt => hugetlb.rst}    |   31 +-
 Documentation/cgroup-v1/index.rst             |   30 +
 .../{memcg_test.txt => memcg_test.rst}        |  261 +-
 .../cgroup-v1/{memory.txt => memory.rst}      |  449 +--
 .../cgroup-v1/{net_cls.txt => net_cls.rst}    |   37 +-
 .../cgroup-v1/{net_prio.txt => net_prio.rst}  |   24 +-
 .../cgroup-v1/{pids.txt => pids.rst}          |   78 +-
 .../cgroup-v1/{rdma.txt => rdma.rst}          |   66 +-
 ...g-warn-once.txt => clearing-warn-once.rst} |    2 +
 .../cma/{debugfs.txt => debugfs.rst}          |    8 +-
 .../{connector.txt => connector.rst}          |  130 +-
 .../console/{console.txt => console.rst}      |   63 +-
 Documentation/core-api/kernel-api.rst         |    4 +-
 Documentation/core-api/printk-formats.rst     |    2 +-
 .../{amd-powernow.txt => amd-powernow.rst}    |   11 +-
 Documentation/cpu-freq/{core.txt => core.rst} |   68 +-
 .../{cpu-drivers.txt => cpu-drivers.rst}      |  217 +-
 ...pufreq-nforce2.txt => cpufreq-nforce2.rst} |   12 +-
 Documentation/cpu-freq/cpufreq-stats.rst      |  128 +
 Documentation/cpu-freq/cpufreq-stats.txt      |  127 -
 Documentation/cpu-freq/index.rst              |   52 +
 Documentation/cpu-freq/index.txt              |   56 -
 .../{pcc-cpufreq.txt => pcc-cpufreq.rst}      |  102 +-
 Documentation/{cpu-load.txt => cpu-load.rst}  |    2 +
 .../{cputopology.txt => cputopology.rst}      |    2 +
 Documentation/{crc32.txt => crc32.rst}        |    2 +
 Documentation/{dcdbas.txt => dcdbas.rst}      |    2 +
 ...ging-modules.txt => debugging-modules.rst} |    2 +
 ...hci1394.txt => debugging-via-ohci1394.rst} |    2 +
 Documentation/{dell_rbu.txt => dell_rbu.rst}  |    2 +
 ...{cache-policies.txt => cache-policies.rst} |   24 +-
 .../device-mapper/{cache.txt => cache.rst}    |  206 +-
 .../device-mapper/{delay.txt => delay.rst}    |   29 +-
 .../{dm-crypt.txt => dm-crypt.rst}            |   57 +-
 .../{dm-flakey.txt => dm-flakey.rst}          |   45 +-
 .../{dm-init.txt => dm-init.rst}              |   75 +-
 .../{dm-integrity.txt => dm-integrity.rst}    |   55 +-
 .../device-mapper/{dm-io.txt => dm-io.rst}    |   14 +-
 .../device-mapper/{dm-log.txt => dm-log.rst}  |    5 +-
 ...m-queue-length.txt => dm-queue-length.rst} |   25 +-
 .../{dm-raid.txt => dm-raid.rst}              |  225 +-
 ...m-service-time.txt => dm-service-time.rst} |   68 +-
 Documentation/device-mapper/dm-uevent.rst     |  110 +
 Documentation/device-mapper/dm-uevent.txt     |   97 -
 .../{dm-zoned.txt => dm-zoned.rst}            |   10 +-
 .../device-mapper/{era.txt => era.rst}        |   36 +-
 Documentation/device-mapper/index.rst         |   44 +
 .../device-mapper/{kcopyd.txt => kcopyd.rst}  |   10 +-
 Documentation/device-mapper/linear.rst        |   63 +
 Documentation/device-mapper/linear.txt        |   61 -
 .../{log-writes.txt => log-writes.rst}        |   91 +-
 ...ersistent-data.txt => persistent-data.rst} |    4 +
 .../{snapshot.txt => snapshot.rst}            |  116 +-
 .../{statistics.txt => statistics.rst}        |   66 +-
 Documentation/device-mapper/striped.rst       |   61 +
 Documentation/device-mapper/striped.txt       |   57 -
 .../device-mapper/{switch.txt => switch.rst}  |   47 +-
 ...provisioning.txt => thin-provisioning.rst} |   68 +-
 .../{unstriped.txt => unstriped.rst}          |  111 +-
 .../device-mapper/{verity.txt => verity.rst}  |   20 +-
 .../{writecache.txt => writecache.rst}        |   13 +-
 .../device-mapper/{zero.txt => zero.rst}      |   14 +-
 Documentation/devicetree/bindings/arm/xen.txt |    2 +-
 .../devicetree/bindings/phy/phy-bindings.txt  |    2 +-
 .../devicetree/booting-without-of.txt         |    4 +-
 Documentation/{digsig.txt => digsig.rst}      |    2 +
 Documentation/driver-api/gpio/driver.rst      |    2 +-
 Documentation/driver-api/pm/devices.rst       |    6 +-
 .../{pps/pps.txt => driver-api/pps.rst}       |   67 +-
 .../{ptp/ptp.txt => driver-api/ptp.rst}       |   26 +-
 Documentation/driver-api/s390-drivers.rst     |    4 +-
 Documentation/driver-api/usb/dma.rst          |    6 +-
 .../driver-api/usb/power-management.rst       |    2 +-
 .../driver-model/{binding.txt => binding.rst} |   20 +-
 .../driver-model/{bus.txt => bus.rst}         |   69 +-
 .../driver-model/{class.txt => class.rst}     |   74 +-
 ...esign-patterns.txt => design-patterns.rst} |  106 +-
 .../driver-model/{device.txt => device.rst}   |   59 +-
 .../driver-model/{devres.txt => devres.rst}   |   50 +-
 .../driver-model/{driver.txt => driver.rst}   |  112 +-
 Documentation/driver-model/index.rst          |   26 +
 .../{overview.txt => overview.rst}            |   37 +-
 .../{platform.txt => platform.rst}            |   30 +-
 .../driver-model/{porting.txt => porting.rst} |  333 +--
 .../{buffer-format.txt => buffer-format.rst}  |   19 +-
 .../{README => early_userspace_support.rst}   |    3 +
 Documentation/early-userspace/index.rst       |   18 +
 Documentation/{efi-stub.txt => efi-stub.rst}  |    2 +
 Documentation/{eisa.txt => eisa.rst}          |    6 +-
 ...ault-injection.txt => fault-injection.rst} |  265 +-
 Documentation/fault-injection/index.rst       |   20 +
 ...r-inject.txt => notifier-error-inject.rst} |   18 +-
 .../fault-injection/nvme-fault-injection.rst  |  120 +
 .../fault-injection/nvme-fault-injection.txt  |  116 -
 .../fault-injection/provoke-crashes.rst       |   48 +
 .../fault-injection/provoke-crashes.txt       |   38 -
 Documentation/fb/{api.txt => api.rst}         |   29 +-
 Documentation/fb/{arkfb.txt => arkfb.rst}     |    8 +-
 .../fb/{aty128fb.txt => aty128fb.rst}         |   35 +-
 .../fb/{cirrusfb.txt => cirrusfb.rst}         |   47 +-
 .../fb/{cmap_xfbdev.txt => cmap_xfbdev.rst}   |   57 +-
 .../fb/{deferred_io.txt => deferred_io.rst}   |   28 +-
 Documentation/fb/{efifb.txt => efifb.rst}     |   18 +-
 .../fb/{ep93xx-fb.txt => ep93xx-fb.rst}       |   27 +-
 Documentation/fb/{fbcon.txt => fbcon.rst}     |  181 +-
 .../fb/{framebuffer.txt => framebuffer.rst}   |   79 +-
 Documentation/fb/{gxfb.txt => gxfb.rst}       |   24 +-
 Documentation/fb/index.rst                    |   50 +
 .../fb/{intel810.txt => intel810.rst}         |   79 +-
 Documentation/fb/{intelfb.txt => intelfb.rst} |   62 +-
 .../fb/{internals.txt => internals.rst}       |   24 +-
 Documentation/fb/{lxfb.txt => lxfb.rst}       |   25 +-
 Documentation/fb/matroxfb.rst                 |  443 +++
 Documentation/fb/matroxfb.txt                 |  413 ---
 .../fb/{metronomefb.txt => metronomefb.rst}   |    8 +-
 Documentation/fb/{modedb.txt => modedb.rst}   |   44 +-
 Documentation/fb/pvr2fb.rst                   |   66 +
 Documentation/fb/pvr2fb.txt                   |   65 -
 Documentation/fb/{pxafb.txt => pxafb.rst}     |   81 +-
 Documentation/fb/{s3fb.txt => s3fb.rst}       |    8 +-
 .../fb/{sa1100fb.txt => sa1100fb.rst}         |   23 +-
 Documentation/fb/sh7760fb.rst                 |  130 +
 Documentation/fb/sh7760fb.txt                 |  131 -
 Documentation/fb/{sisfb.txt => sisfb.rst}     |   40 +-
 Documentation/fb/{sm501.txt => sm501.rst}     |    7 +-
 Documentation/fb/{sm712fb.txt => sm712fb.rst} |   18 +-
 Documentation/fb/sstfb.rst                    |  207 ++
 Documentation/fb/sstfb.txt                    |  174 --
 Documentation/fb/{tgafb.txt => tgafb.rst}     |   30 +-
 .../fb/{tridentfb.txt => tridentfb.rst}       |   36 +-
 Documentation/fb/{udlfb.txt => udlfb.rst}     |   55 +-
 Documentation/fb/{uvesafb.txt => uvesafb.rst} |  128 +-
 Documentation/fb/{vesafb.txt => vesafb.rst}   |  123 +-
 Documentation/fb/viafb.rst                    |  297 ++
 Documentation/fb/viafb.txt                    |  252 --
 .../fb/{vt8623fb.txt => vt8623fb.rst}         |   10 +-
 Documentation/filesystems/nfs/nfsroot.txt     |    2 +-
 .../filesystems/ramfs-rootfs-initramfs.txt    |    4 +-
 Documentation/filesystems/sysfs.txt           |    2 +-
 Documentation/filesystems/tmpfs.txt           |    2 +-
 .../filesystems/ubifs-authentication.md       |    4 +-
 Documentation/fmc/{API.txt => api.rst}        |   10 +-
 .../fmc/{carrier.txt => carrier.rst}          |   65 +-
 .../fmc/{FMC-and-SDB.txt => fmc-and-sdb.rst}  |   19 +-
 .../fmc/{fmc-chardev.txt => fmc-chardev.rst}  |    9 +-
 .../fmc/{fmc-fakedev.txt => fmc-fakedev.rst}  |   13 +-
 .../fmc/{fmc-trivial.txt => fmc-trivial.rst}  |   11 +-
 ...-write-eeprom.txt => fmc-write-eeprom.rst} |   36 +-
 .../fmc/{identifiers.txt => identifiers.rst}  |   20 +-
 Documentation/fmc/index.rst                   |   21 +
 .../fmc/{mezzanine.txt => mezzanine.rst}      |   34 +-
 .../fmc/{parameters.txt => parameters.rst}    |   11 +-
 Documentation/fpga/{dfl.txt => dfl.rst}       |   58 +-
 Documentation/fpga/index.rst                  |   17 +
 ...ex-requeue-pi.txt => futex-requeue-pi.rst} |    2 +
 .../{gcc-plugins.txt => gcc-plugins.rst}      |    2 +
 Documentation/gpio/index.rst                  |   17 +
 Documentation/gpio/{sysfs.txt => sysfs.rst}   |   39 +-
 Documentation/gpu/drm-mm.rst                  |    2 +-
 .../hid/{hid-alps.txt => hid-alps.rst}        |   85 +-
 .../hid/{hid-sensor.txt => hid-sensor.rst}    |  192 +-
 .../{hid-transport.txt => hid-transport.rst}  |   82 +-
 Documentation/hid/{hiddev.txt => hiddev.rst}  |  130 +-
 Documentation/hid/{hidraw.txt => hidraw.rst}  |   53 +-
 Documentation/hid/index.rst                   |   18 +
 Documentation/hid/intel-ish-hid.rst           |  485 +++
 Documentation/hid/intel-ish-hid.txt           |  454 ---
 Documentation/hid/{uhid.txt => uhid.rst}      |   46 +-
 Documentation/{highuid.txt => highuid.rst}    |    2 +
 .../{hw_random.txt => hw_random.rst}          |    2 +
 Documentation/hwmon/submitting-patches.rst    |    2 +-
 .../{hwspinlock.txt => hwspinlock.rst}        |    2 +
 .../ia64/{aliasing.txt => aliasing.rst}       |   71 +-
 Documentation/ia64/{efirtc.txt => efirtc.rst} |   86 +-
 .../ia64/{err_inject.txt => err_inject.rst}   |  347 ++-
 Documentation/ia64/{fsys.txt => fsys.rst}     |  127 +-
 Documentation/ia64/{README => ia64.rst}       |   26 +-
 Documentation/ia64/index.rst                  |   18 +
 .../ia64/{IRQ-redir.txt => irq-redir.rst}     |   32 +-
 Documentation/ia64/{mca.txt => mca.rst}       |   10 +-
 Documentation/ia64/{serial.txt => serial.rst} |   36 +-
 Documentation/ia64/xen.rst                    |  206 ++
 Documentation/ia64/xen.txt                    |  183 --
 Documentation/ide/changelogs.rst              |   17 +
 .../ide/{ide-tape.txt => ide-tape.rst}        |   23 +-
 Documentation/ide/{ide.txt => ide.rst}        |  147 +-
 Documentation/ide/index.rst                   |   21 +
 ...arm-plug-howto.txt => warm-plug-howto.rst} |   10 +-
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
 .../{intel_txt.txt => intel_txt.rst}          |    2 +
 .../{io-mapping.txt => io-mapping.rst}        |    2 +
 .../{io_ordering.txt => io_ordering.rst}      |    2 +
 ...g-up-ioctls.txt => botching-up-ioctls.rst} |    1 +
 Documentation/ioctl/cdrom.rst                 | 1233 ++++++++
 Documentation/ioctl/cdrom.txt                 |  967 ------
 Documentation/ioctl/{hdio.txt => hdio.rst}    |  835 ++++--
 Documentation/ioctl/index.rst                 |   16 +
 ...{ioctl-decoding.txt => ioctl-decoding.rst} |   13 +-
 Documentation/ioctl/ioctl-number.rst          |  360 +++
 Documentation/ioctl/ioctl-number.txt          |  350 ---
 Documentation/{iostats.txt => iostats.rst}    |    2 +
 ...flags-tracing.txt => irqflags-tracing.rst} |    2 +
 Documentation/{isa.txt => isa.rst}            |    2 +
 Documentation/{isapnp.txt => isapnp.rst}      |    2 +
 ...eaders_install.txt => headers_install.rst} |    5 +-
 Documentation/kbuild/index.rst                |   27 +
 Documentation/kbuild/issues.rst               |   11 +
 .../kbuild/{kbuild.txt => kbuild.rst}         |  119 +-
 ...nfig-language.txt => kconfig-language.rst} |  232 +-
 ...anguage.txt => kconfig-macro-language.rst} |   37 +-
 .../kbuild/{kconfig.txt => kconfig.rst}       |  136 +-
 .../kbuild/{makefiles.txt => makefiles.rst}   |  518 ++--
 .../kbuild/{modules.txt => modules.rst}       |  168 +-
 Documentation/kdump/index.rst                 |   21 +
 Documentation/kdump/{kdump.txt => kdump.rst}  |  131 +-
 .../kdump/{vmcoreinfo.txt => vmcoreinfo.rst}  |   59 +-
 Documentation/kernel-hacking/hacking.rst      |    4 +-
 Documentation/kernel-hacking/locking.rst      |    2 +-
 ...hreads.txt => kernel-per-CPU-kthreads.rst} |    6 +-
 Documentation/{kobject.txt => kobject.rst}    |    4 +-
 Documentation/{kprobes.txt => kprobes.rst}    |    2 +
 Documentation/{kref.txt => kref.rst}          |    2 +
 .../{asus-laptop.txt => asus-laptop.rst}      |   91 +-
 ...otection.txt => disk-shock-protection.rst} |   32 +-
 Documentation/laptops/index.rst               |   17 +
 .../{laptop-mode.txt => laptop-mode.rst}      |  509 ++--
 .../{sony-laptop.txt => sony-laptop.rst}      |   58 +-
 .../laptops/{sonypi.txt => sonypi.rst}        |   28 +-
 .../{thinkpad-acpi.txt => thinkpad-acpi.rst}  |  373 ++-
 .../{toshiba_haps.txt => toshiba_haps.rst}    |   47 +-
 Documentation/{ldm.txt => ldm.rst}            |    2 +
 Documentation/leds/index.rst                  |   25 +
 .../leds/{leds-blinkm.txt => leds-blinkm.rst} |   63 +-
 ...s-class-flash.txt => leds-class-flash.rst} |   49 +-
 .../leds/{leds-class.txt => leds-class.rst}   |   15 +-
 .../leds/{leds-lm3556.txt => leds-lm3556.rst} |  100 +-
 .../leds/{leds-lp3944.txt => leds-lp3944.rst} |   23 +-
 Documentation/leds/leds-lp5521.rst            |  115 +
 Documentation/leds/leds-lp5521.txt            |  101 -
 Documentation/leds/leds-lp5523.rst            |  147 +
 Documentation/leds/leds-lp5523.txt            |  130 -
 Documentation/leds/leds-lp5562.rst            |  137 +
 Documentation/leds/leds-lp5562.txt            |  120 -
 Documentation/leds/leds-lp55xx.rst            |  224 ++
 Documentation/leds/leds-lp55xx.txt            |  194 --
 Documentation/leds/leds-mlxcpld.rst           |  118 +
 Documentation/leds/leds-mlxcpld.txt           |  110 -
 ...edtrig-oneshot.txt => ledtrig-oneshot.rst} |   11 +-
 ...ig-transient.txt => ledtrig-transient.rst} |   63 +-
 ...edtrig-usbport.txt => ledtrig-usbport.rst} |   11 +-
 Documentation/leds/{uleds.txt => uleds.rst}   |    5 +-
 .../{callbacks.txt => callbacks.rst}          |   12 +-
 ...ive-patches.txt => cumulative-patches.rst} |   14 +-
 Documentation/livepatch/index.rst             |   21 +
 .../{livepatch.txt => livepatch.rst}          |   60 +-
 ...e-elf-format.txt => module-elf-format.rst} |  211 +-
 .../{shadow-vars.txt => shadow-vars.rst}      |   65 +-
 Documentation/locking/index.rst               |   24 +
 ...{lockdep-design.txt => lockdep-design.rst} |   41 +-
 Documentation/locking/lockstat.rst            |  204 ++
 Documentation/locking/lockstat.txt            |  183 --
 .../{locktorture.txt => locktorture.rst}      |  105 +-
 .../{mutex-design.txt => mutex-design.rst}    |   26 +-
 ...t-mutex-design.txt => rt-mutex-design.rst} |  139 +-
 .../locking/{rt-mutex.txt => rt-mutex.rst}    |   32 +-
 .../locking/{spinlocks.txt => spinlocks.rst}  |   32 +-
 ...w-mutex-design.txt => ww-mutex-design.rst} |   82 +-
 ...kup-watchdogs.txt => lockup-watchdogs.rst} |    2 +
 Documentation/{lsm.txt => lsm.rst}            |    2 +
 Documentation/{lzo.txt => lzo.rst}            |    2 +
 Documentation/m68k/index.rst                  |   17 +
 ...{kernel-options.txt => kernel-options.rst} |  319 +-
 Documentation/{mailbox.txt => mailbox.rst}    |    2 +
 Documentation/md/index.rst                    |   12 +
 .../md/{md-cluster.txt => md-cluster.rst}     |  188 +-
 .../md/{raid5-cache.txt => raid5-cache.rst}   |   28 +-
 .../md/{raid5-ppl.txt => raid5-ppl.rst}       |    2 +
 Documentation/memory-barriers.txt             |    6 +-
 .../{ti-emif.txt => ti-emif.rst}              |   27 +-
 ...hameleon-bus.txt => men-chameleon-bus.rst} |    2 +
 Documentation/mic/index.rst                   |   18 +
 .../{mic_overview.txt => mic_overview.rst}    |    6 +-
 .../{scif_overview.txt => scif_overview.rst}  |   58 +-
 Documentation/mmc/index.rst                   |   13 +
 .../{mmc-async-req.txt => mmc-async-req.rst}  |   53 +-
 .../{mmc-dev-attrs.txt => mmc-dev-attrs.rst}  |   32 +-
 .../{mmc-dev-parts.txt => mmc-dev-parts.rst}  |   13 +-
 .../mmc/{mmc-tools.txt => mmc-tools.rst}      |    5 +-
 Documentation/mtd/index.rst                   |   12 +
 .../mtd/{intel-spi.txt => intel-spi.rst}      |   46 +-
 .../mtd/{nand_ecc.txt => nand_ecc.rst}        |  481 +--
 .../mtd/{spi-nor.txt => spi-nor.rst}          |    7 +-
 ...bility-list.txt => compatibility-list.rst} |    9 +-
 Documentation/namespaces/index.rst            |   11 +
 ...ource-control.txt => resource-control.rst} |    4 +
 .../{cipso_ipv4.txt => cipso_ipv4.rst}        |   19 +-
 Documentation/netlabel/draft_ietf.rst         |    5 +
 Documentation/netlabel/index.rst              |   21 +
 .../{introduction.txt => introduction.rst}    |   16 +-
 .../{lsm_interface.txt => lsm_interface.rst}  |   16 +-
 Documentation/networking/ip-sysctl.txt        |    2 +-
 Documentation/networking/scaling.rst          |    4 +-
 Documentation/networking/timestamping.txt     |    2 +-
 Documentation/nfc/index.rst                   |   11 +
 .../nfc/{nfc-hci.txt => nfc-hci.rst}          |  163 +-
 .../nfc/{nfc-pn544.txt => nfc-pn544.rst}      |    6 +-
 .../{nommu-mmap.txt => nommu-mmap.rst}        |    2 +
 Documentation/{ntb.txt => ntb.rst}            |    2 +
 Documentation/{numastat.txt => numastat.rst}  |    2 +
 Documentation/nvdimm/{btt.txt => btt.rst}     |  139 +-
 Documentation/nvdimm/index.rst                |   12 +
 .../nvdimm/{nvdimm.txt => nvdimm.rst}         |  518 ++--
 .../nvdimm/{security.txt => security.rst}     |    4 +-
 Documentation/nvmem/{nvmem.txt => nvmem.rst}  |  112 +-
 Documentation/{padata.txt => padata.rst}      |    2 +
 ...port-lowlevel.txt => parport-lowlevel.rst} |    2 +
 .../{devicetable.txt => devicetable.rst}      |    4 +
 ...{driver-changes.txt => driver-changes.rst} |   35 +-
 .../pcmcia/{driver.txt => driver.rst}         |   18 +-
 Documentation/pcmcia/index.rst                |   20 +
 .../pcmcia/{locking.txt => locking.rst}       |   39 +-
 ...-semaphore.txt => percpu-rw-semaphore.rst} |    2 +
 .../perf/{arm-ccn.txt => arm-ccn.rst}         |   18 +-
 .../perf/{arm_dsu_pmu.txt => arm_dsu_pmu.rst} |    5 +-
 .../perf/{hisi-pmu.txt => hisi-pmu.rst}       |   35 +-
 Documentation/perf/index.rst                  |   16 +
 .../perf/{qcom_l2_pmu.txt => qcom_l2_pmu.rst} |    3 +-
 .../perf/{qcom_l3_pmu.txt => qcom_l3_pmu.rst} |    3 +-
 .../{thunderx2-pmu.txt => thunderx2-pmu.rst}  |   25 +-
 .../perf/{xgene-pmu.txt => xgene-pmu.rst}     |    3 +-
 Documentation/{phy.txt => phy.rst}            |    2 +
 .../{samsung-usb2.txt => samsung-usb2.rst}    |   62 +-
 Documentation/{pi-futex.txt => pi-futex.rst}  |    4 +-
 Documentation/{pnp.txt => pnp.rst}            |    2 +
 .../power/{apm-acpi.txt => apm-acpi.rst}      |   10 +-
 ...m-debugging.txt => basic-pm-debugging.rst} |   79 +-
 ...harger-manager.txt => charger-manager.rst} |  101 +-
 ...rivers-testing.txt => drivers-testing.rst} |   15 +-
 .../{energy-model.txt => energy-model.rst}    |  101 +-
 ...ing-of-tasks.txt => freezing-of-tasks.rst} |   91 +-
 Documentation/power/index.rst                 |   46 +
 .../power/{interface.txt => interface.rst}    |   24 +-
 Documentation/power/{opp.txt => opp.rst}      |  175 +-
 Documentation/power/{pci.txt => pci.rst}      |   87 +-
 ...qos_interface.txt => pm_qos_interface.rst} |  127 +-
 Documentation/power/power_supply_class.rst    |  282 ++
 Documentation/power/power_supply_class.txt    |  231 --
 Documentation/power/powercap/powercap.rst     |  257 ++
 Documentation/power/powercap/powercap.txt     |  236 --
 .../regulator/{consumer.txt => consumer.rst}  |  141 +-
 .../regulator/{design.txt => design.rst}      |    9 +-
 .../regulator/{machine.txt => machine.rst}    |   47 +-
 .../regulator/{overview.txt => overview.rst}  |   57 +-
 Documentation/power/regulator/regulator.rst   |   32 +
 Documentation/power/regulator/regulator.txt   |   30 -
 .../power/{runtime_pm.txt => runtime_pm.rst}  |  234 +-
 Documentation/power/{s2ram.txt => s2ram.rst}  |   20 +-
 ...hotplug.txt => suspend-and-cpuhotplug.rst} |   42 +-
 ...errupts.txt => suspend-and-interrupts.rst} |    2 +
 ...ap-files.txt => swsusp-and-swap-files.rst} |   17 +-
 ...{swsusp-dmcrypt.txt => swsusp-dmcrypt.rst} |  120 +-
 Documentation/power/swsusp.rst                |  501 ++++
 Documentation/power/swsusp.txt                |  446 ---
 .../power/{tricks.txt => tricks.rst}          |    6 +-
 ...serland-swsusp.txt => userland-swsusp.rst} |   55 +-
 Documentation/power/{video.txt => video.rst}  |  156 +-
 .../{bootwrapper.txt => bootwrapper.rst}      |   28 +-
 .../{cpu_families.txt => cpu_families.rst}    |   23 +-
 .../{cpu_features.txt => cpu_features.rst}    |    6 +-
 Documentation/powerpc/{cxl.txt => cxl.rst}    |   46 +-
 .../powerpc/{cxlflash.txt => cxlflash.rst}    |   10 +-
 .../{DAWR-POWER9.txt => dawr-power9.rst}      |   10 +-
 Documentation/powerpc/{dscr.txt => dscr.rst}  |   18 +-
 ...ecovery.txt => eeh-pci-error-recovery.rst} |  108 +-
 ...ed-dump.txt => firmware-assisted-dump.rst} |  119 +-
 Documentation/powerpc/{hvcs.txt => hvcs.rst}  |  108 +-
 Documentation/powerpc/index.rst               |   34 +
 Documentation/powerpc/isa-versions.rst        |   13 +-
 .../powerpc/{mpc52xx.txt => mpc52xx.rst}      |   12 +-
 ...nv.txt => pci_iov_resource_on_powernv.rst} |   15 +-
 .../powerpc/{pmu-ebb.txt => pmu-ebb.rst}      |    1 +
 Documentation/powerpc/ptrace.rst              |  156 +
 Documentation/powerpc/ptrace.txt              |  151 -
 .../{qe_firmware.txt => qe_firmware.rst}      |   37 +-
 .../{syscall64-abi.txt => syscall64-abi.rst}  |   29 +-
 ...al_memory.txt => transactional_memory.rst} |   45 +-
 ...reempt-locking.txt => preempt-locking.rst} |    2 +
 Documentation/process/4.Coding.rst            |    2 +-
 Documentation/process/coding-style.rst        |    2 +-
 Documentation/process/submit-checklist.rst    |    4 +-
 Documentation/process/submitting-drivers.rst  |    2 +-
 Documentation/pti/pti_intel_mid.rst           |  106 +
 Documentation/pti/pti_intel_mid.txt           |   99 -
 Documentation/{pwm.txt => pwm.rst}            |    2 +
 Documentation/rapidio/index.rst               |   15 +
 .../{mport_cdev.txt => mport_cdev.rst}        |   47 +-
 .../rapidio/{rapidio.txt => rapidio.rst}      |   39 +-
 .../rapidio/{rio_cm.txt => rio_cm.rst}        |   66 +-
 .../rapidio/{sysfs.txt => sysfs.rst}          |    4 +
 .../rapidio/{tsi721.txt => tsi721.rst}        |   45 +-
 Documentation/{rbtree.txt => rbtree.rst}      |    8 +-
 .../{remoteproc.txt => remoteproc.rst}        |    4 +-
 Documentation/{rfkill.txt => rfkill.rst}      |    2 +
 Documentation/riscv/index.rst                 |   17 +
 Documentation/riscv/{pmu.txt => pmu.rst}      |   98 +-
 ...ust-futex-ABI.txt => robust-futex-ABI.rst} |    2 +
 ...{robust-futexes.txt => robust-futexes.rst} |    2 +
 Documentation/{rpmsg.txt => rpmsg.rst}        |    2 +
 Documentation/{rtc.txt => rtc.rst}            |    2 +
 Documentation/s390/{3270.txt => 3270.rst}     |   85 +-
 Documentation/s390/Debugging390.txt           | 2142 --------------
 Documentation/s390/{cds.txt => cds.rst}       |  354 ++-
 .../s390/{CommonIO => common_io.rst}          |   49 +-
 Documentation/s390/{DASD => dasd.rst}         |   33 +-
 Documentation/s390/debugging390.rst           | 2613 +++++++++++++++++
 .../{driver-model.txt => driver-model.rst}    |  179 +-
 Documentation/s390/index.rst                  |   30 +
 .../s390/{monreader.txt => monreader.rst}     |   85 +-
 Documentation/s390/{qeth.txt => qeth.rst}     |   36 +-
 Documentation/s390/s390dbf.rst                |  133 +
 Documentation/s390/s390dbf.txt                |  667 -----
 Documentation/s390/text_files.rst             |   11 +
 .../s390/{vfio-ap.txt => vfio-ap.rst}         |  487 +--
 .../s390/{vfio-ccw.txt => vfio-ccw.rst}       |   96 +-
 .../s390/{zfcpdump.txt => zfcpdump.rst}       |    2 +
 .../{completion.txt => completion.rst}        |   38 +-
 Documentation/scheduler/index.rst             |   29 +
 .../{sched-arch.txt => sched-arch.rst}        |   18 +-
 .../{sched-bwc.txt => sched-bwc.rst}          |   30 +-
 ...{sched-deadline.txt => sched-deadline.rst} |  297 +-
 ...ed-design-CFS.txt => sched-design-CFS.rst} |   17 +-
 .../{sched-domains.txt => sched-domains.rst}  |    8 +-
 .../{sched-energy.txt => sched-energy.rst}    |   53 +-
 ...-nice-design.txt => sched-nice-design.rst} |    6 +-
 ...{sched-rt-group.txt => sched-rt-group.rst} |   30 +-
 .../{sched-stats.txt => sched-stats.rst}      |   35 +-
 Documentation/scheduler/text_files.rst        |    5 +
 .../{xen-tpmfront.txt => xen-tpmfront.rst}    |  103 +-
 .../{README.cycladesZ => cyclades_z.rst}      |    5 +-
 Documentation/serial/{driver => driver.rst}   |  115 +-
 Documentation/serial/index.rst                |   32 +
 Documentation/serial/moxa-smartio             |  523 ----
 Documentation/serial/moxa-smartio.rst         |  615 ++++
 Documentation/serial/n_gsm.rst                |  103 +
 Documentation/serial/n_gsm.txt                |   96 -
 .../serial/{rocket.txt => rocket.rst}         |  144 +-
 ...{serial-iso7816.txt => serial-iso7816.rst} |   21 +-
 .../{serial-rs485.txt => serial-rs485.rst}    |   22 +-
 Documentation/serial/{tty.txt => tty.rst}     |  111 +-
 Documentation/{sgi-ioc4.txt => sgi-ioc4.rst}  |    2 +
 Documentation/{siphash.txt => siphash.rst}    |    2 +
 .../{smsc_ece1099.txt => smsc_ece1099.rst}    |    2 +
 Documentation/sparc/{adi.txt => adi.rst}      |  174 +-
 .../sparc/{console.txt => console.rst}        |    4 +-
 Documentation/sparc/index.rst                 |   13 +
 .../oradax/{oracle-dax.txt => oracle-dax.rst} |   58 +-
 .../{speculation.txt => speculation.rst}      |    2 +
 .../{static-keys.txt => static-keys.rst}      |    2 +
 Documentation/{svga.txt => svga.rst}          |    2 +
 .../{switchtec.txt => switchtec.rst}          |    4 +-
 .../{sync_file.txt => sync_file.rst}          |    2 +
 Documentation/sysctl/abi.rst                  |   67 +
 Documentation/sysctl/abi.txt                  |   54 -
 Documentation/sysctl/{fs.txt => fs.rst}       |  141 +-
 Documentation/sysctl/{README => index.rst}    |   36 +-
 .../sysctl/{kernel.txt => kernel.rst}         |  378 +--
 Documentation/sysctl/{net.txt => net.rst}     |  141 +-
 .../sysctl/{sunrpc.txt => sunrpc.rst}         |   13 +-
 Documentation/sysctl/{user.txt => user.rst}   |   32 +-
 Documentation/sysctl/{vm.txt => vm.rst}       |  264 +-
 Documentation/target/index.rst                |   19 +
 Documentation/target/scripts.rst              |   11 +
 Documentation/target/tcm_mod_builder.rst      |  149 +
 Documentation/target/tcm_mod_builder.txt      |  145 -
 .../{tcmu-design.txt => tcmu-design.rst}      |  268 +-
 Documentation/{tee.txt => tee.rst}            |    2 +
 ...pu-cooling-api.txt => cpu-cooling-api.rst} |   39 +-
 .../{exynos_thermal => exynos_thermal.rst}    |   47 +-
 .../thermal/exynos_thermal_emulation          |   53 -
 .../thermal/exynos_thermal_emulation.rst      |   61 +
 Documentation/thermal/index.rst               |   18 +
 ...el_powerclamp.txt => intel_powerclamp.rst} |  177 +-
 .../{nouveau_thermal => nouveau_thermal.rst}  |   54 +-
 ...ower_allocator.txt => power_allocator.rst} |  140 +-
 .../thermal/{sysfs-api.txt => sysfs-api.rst}  |  490 ++--
 ...hermal => x86_pkg_temperature_thermal.rst} |   28 +-
 .../{this_cpu_ops.txt => this_cpu_ops.rst}    |    2 +
 .../timers/{highres.txt => highres.rst}       |   13 +-
 Documentation/timers/{hpet.txt => hpet.rst}   |    4 +-
 .../timers/{hrtimers.txt => hrtimers.rst}     |    6 +-
 Documentation/timers/index.rst                |   22 +
 Documentation/timers/{NO_HZ.txt => no_hz.rst} |   40 +-
 .../{timekeeping.txt => timekeeping.rst}      |    3 +-
 .../{timers-howto.txt => timers-howto.rst}    |   15 +-
 Documentation/trace/coresight-cpu-debug.txt   |    2 +-
 Documentation/trace/ftrace.rst                |    1 +
 Documentation/trace/histogram.rst             |   86 +-
 Documentation/trace/kprobetrace.rst           |    2 +-
 .../it_IT/kernel-hacking/hacking.rst          |    4 +-
 .../it_IT/kernel-hacking/locking.rst          |    2 +-
 .../translations/it_IT/process/4.Coding.rst   |    2 +-
 .../it_IT/process/submit-checklist.rst        |    4 +-
 .../translations/ko_KR/memory-barriers.txt    |    6 +-
 Documentation/translations/zh_CN/IRQ.txt      |    4 +-
 Documentation/translations/zh_CN/arm/Booting  |    4 +-
 .../zh_CN/arm/kernel_user_helpers.txt         |    4 +-
 .../translations/zh_CN/arm64/booting.txt      |    4 +-
 .../zh_CN/arm64/legacy_instructions.txt       |    4 +-
 .../translations/zh_CN/arm64/memory.txt       |    4 +-
 .../zh_CN/arm64/silicon-errata.txt            |    4 +-
 .../zh_CN/arm64/tagged-pointers.txt           |    4 +-
 .../translations/zh_CN/filesystems/sysfs.txt  |    2 +-
 .../translations/zh_CN/io_ordering.txt        |    4 +-
 .../translations/zh_CN/oops-tracing.txt       |    2 +-
 .../translations/zh_CN/process/4.Coding.rst   |    2 +-
 .../zh_CN/process/coding-style.rst            |    2 +-
 .../zh_CN/process/submit-checklist.rst        |    4 +-
 .../zh_CN/process/submitting-drivers.rst      |    2 +-
 ...access.txt => unaligned-memory-access.rst} |    2 +
 ...ed-device.txt => vfio-mediated-device.rst} |    4 +-
 Documentation/{vfio.txt => vfio.rst}          |    2 +
 .../{video-output.txt => video-output.rst}    |    2 +
 Documentation/virtual/kvm/api.txt             |    2 +-
 Documentation/vm/numa.rst                     |    6 +-
 Documentation/vm/page_migration.rst           |    2 +-
 Documentation/vm/unevictable-lru.rst          |    4 +-
 ....txt => convert_drivers_to_kernel_api.rst} |  109 +-
 .../watchdog/{hpwdt.txt => hpwdt.rst}         |   27 +-
 Documentation/watchdog/index.rst              |   25 +
 .../watchdog/{mlx-wdt.txt => mlx-wdt.rst}     |   24 +-
 .../{pcwd-watchdog.txt => pcwd-watchdog.rst}  |   13 +-
 .../{watchdog-api.txt => watchdog-api.rst}    |   76 +-
 ...kernel-api.txt => watchdog-kernel-api.rst} |   91 +-
 .../watchdog/watchdog-parameters.rst          |  736 +++++
 .../watchdog/watchdog-parameters.txt          |  410 ---
 .../{watchdog-pm.txt => watchdog-pm.rst}      |    3 +
 Documentation/watchdog/{wdt.txt => wdt.rst}   |   31 +-
 Documentation/x86/topology.txt                |    2 +-
 .../x86/x86_64/fake-numa-for-cpusets          |    4 +-
 Documentation/xilinx/{eemi.txt => eemi.rst}   |    8 +-
 Documentation/xilinx/index.rst                |   17 +
 Documentation/{xillybus.txt => xillybus.rst}  |    2 +
 .../xtensa/{atomctl.txt => atomctl.rst}       |   13 +-
 .../xtensa/{booting.txt => booting.rst}       |    5 +-
 Documentation/xtensa/index.rst                |   12 +
 Documentation/xtensa/mmu.rst                  |  195 ++
 Documentation/xtensa/mmu.txt                  |  189 --
 Documentation/{xz.txt => xz.rst}              |    2 +
 Documentation/{zorro.txt => zorro.rst}        |    2 +
 Kconfig                                       |    2 +-
 MAINTAINERS                                   |  132 +-
 arch/Kconfig                                  |    4 +-
 arch/arc/plat-eznps/Kconfig                   |    2 +-
 arch/arm/Kconfig                              |    8 +-
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
 arch/arm64/include/asm/efi.h                  |    2 +-
 arch/arm64/include/asm/image.h                |    2 +-
 arch/arm64/include/uapi/asm/sigcontext.h      |    2 +-
 arch/arm64/kernel/kexec_image.c               |    2 +-
 arch/arm64/kernel/kuser32.S                   |    2 +-
 arch/c6x/Kconfig                              |    2 +-
 arch/ia64/hp/common/sba_iommu.c               |   12 +-
 arch/ia64/kernel/efi.c                        |    2 +-
 arch/ia64/kernel/fsys.S                       |    2 +-
 arch/ia64/mm/ioremap.c                        |    2 +-
 arch/ia64/pci/pci.c                           |    2 +-
 arch/ia64/sn/pci/pci_dma.c                    |    4 +-
 arch/m68k/q40/README                          |    2 +-
 arch/microblaze/Kconfig.debug                 |    2 +-
 arch/microblaze/Kconfig.platform              |    2 +-
 arch/mips/bmips/setup.c                       |    2 +-
 arch/nds32/Kconfig                            |    2 +-
 arch/openrisc/Kconfig                         |    2 +-
 arch/parisc/Kconfig                           |    2 +-
 arch/parisc/kernel/pci-dma.c                  |    2 +-
 arch/powerpc/kernel/exceptions-64s.S          |    2 +-
 arch/powerpc/sysdev/Kconfig                   |    2 +-
 arch/riscv/Kconfig                            |    2 +-
 arch/s390/Kconfig                             |    4 +-
 arch/s390/include/asm/debug.h                 |  235 +-
 arch/sh/Kconfig                               |    4 +-
 arch/sparc/Kconfig                            |    2 +-
 arch/unicore32/include/asm/io.h               |    2 +-
 arch/x86/Kconfig                              |   10 +-
 arch/x86/include/asm/dma-mapping.h            |    4 +-
 arch/x86/kernel/amd_gart_64.c                 |    2 +-
 arch/xtensa/include/asm/initialize_mmu.h      |    2 +-
 block/Kconfig                                 |    4 +-
 block/Kconfig.iosched                         |    2 +-
 block/bfq-iosched.c                           |    2 +-
 block/blk-integrity.c                         |    2 +-
 block/ioprio.c                                |    2 +-
 block/mq-deadline.c                           |    2 +-
 block/partitions/Kconfig                      |    2 +-
 block/partitions/cmdline.c                    |    2 +-
 drivers/auxdisplay/Kconfig                    |    2 +-
 drivers/base/core.c                           |    2 +-
 drivers/base/platform.c                       |    2 +-
 drivers/block/Kconfig                         |   10 +-
 drivers/block/floppy.c                        |    2 +-
 drivers/block/zram/Kconfig                    |    6 +-
 drivers/cdrom/cdrom.c                         |    2 +-
 drivers/char/Kconfig                          |    6 +-
 drivers/char/hw_random/core.c                 |    2 +-
 drivers/char/ipmi/Kconfig                     |    2 +-
 drivers/char/ipmi/ipmi_si_hotmod.c            |    2 +-
 drivers/char/ipmi/ipmi_si_intf.c              |    2 +-
 drivers/cpufreq/Kconfig.x86                   |    2 +-
 drivers/crypto/sunxi-ss/sun4i-ss-cipher.c     |    2 +-
 drivers/crypto/sunxi-ss/sun4i-ss-core.c       |    2 +-
 drivers/crypto/sunxi-ss/sun4i-ss-hash.c       |    2 +-
 drivers/crypto/sunxi-ss/sun4i-ss.h            |    2 +-
 drivers/dma-buf/Kconfig                       |    2 +-
 drivers/firmware/Kconfig                      |    2 +-
 drivers/gpio/Kconfig                          |    2 +-
 drivers/gpio/gpio-cs5535.c                    |    2 +-
 drivers/gpu/drm/Kconfig                       |    2 +-
 drivers/gpu/drm/drm_ioctl.c                   |    2 +-
 drivers/gpu/drm/drm_modeset_lock.c            |    2 +-
 drivers/gpu/drm/i915/i915_drv.h               |    2 +-
 drivers/ide/Kconfig                           |   20 +-
 drivers/ide/ide-cd.c                          |    2 +-
 drivers/iio/Kconfig                           |    2 +-
 drivers/infiniband/core/user_mad.c            |    2 +-
 drivers/infiniband/ulp/ipoib/Kconfig          |    2 +-
 drivers/input/touchscreen/sun4i-ts.c          |    2 +-
 drivers/leds/trigger/Kconfig                  |    2 +-
 drivers/leds/trigger/ledtrig-transient.c      |    2 +-
 drivers/md/Kconfig                            |    2 +-
 drivers/md/dm-init.c                          |    2 +-
 drivers/md/dm-raid.c                          |    2 +-
 drivers/media/usb/dvb-usb-v2/anysee.c         |    2 +-
 drivers/misc/lkdtm/core.c                     |    2 +-
 drivers/mtd/devices/Kconfig                   |    2 +-
 drivers/mtd/nand/raw/nand_ecc.c               |    2 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |    2 +-
 drivers/net/ethernet/smsc/Kconfig             |    6 +-
 drivers/net/wireless/intel/iwlegacy/Kconfig   |    4 +-
 drivers/net/wireless/intel/iwlwifi/Kconfig    |    2 +-
 drivers/nvdimm/Kconfig                        |    2 +-
 drivers/opp/Kconfig                           |    2 +-
 drivers/parisc/sba_iommu.c                    |   16 +-
 drivers/parport/Kconfig                       |    2 +-
 drivers/pci/switch/Kconfig                    |    2 +-
 drivers/pcmcia/ds.c                           |    2 +-
 drivers/perf/qcom_l3_pmu.c                    |    2 +-
 drivers/platform/x86/Kconfig                  |    8 +-
 drivers/platform/x86/dcdbas.c                 |    2 +-
 drivers/platform/x86/dell_rbu.c               |    2 +-
 drivers/pnp/isapnp/Kconfig                    |    2 +-
 drivers/power/supply/power_supply_core.c      |    2 +-
 drivers/rapidio/Kconfig                       |    2 +-
 drivers/regulator/core.c                      |    2 +-
 drivers/s390/char/zcore.c                     |    2 +-
 drivers/sbus/char/oradax.c                    |    2 +-
 drivers/scsi/Kconfig                          |    4 +-
 drivers/soc/fsl/qe/qe.c                       |    2 +-
 drivers/staging/sm750fb/Kconfig               |    2 +-
 drivers/tty/Kconfig                           |    8 +-
 drivers/tty/hvc/hvcs.c                        |    2 +-
 drivers/tty/serial/Kconfig                    |    2 +-
 drivers/tty/serial/ucc_uart.c                 |    2 +-
 drivers/usb/misc/Kconfig                      |    4 +-
 drivers/vfio/Kconfig                          |    2 +-
 drivers/vfio/mdev/Kconfig                     |    2 +-
 drivers/video/fbdev/Kconfig                   |   38 +-
 drivers/video/fbdev/matrox/matroxfb_base.c    |    2 +-
 drivers/video/fbdev/pxafb.c                   |    2 +-
 drivers/video/fbdev/sh7760fb.c                |    2 +-
 drivers/w1/Kconfig                            |    2 +-
 drivers/watchdog/Kconfig                      |    6 +-
 drivers/watchdog/smsc37b787_wdt.c             |    2 +-
 include/asm-generic/bitops/atomic.h           |    2 +-
 include/linux/cgroup-defs.h                   |    2 +-
 include/linux/connector.h                     |   63 +-
 include/linux/dma-mapping.h                   |    2 +-
 include/linux/fault-inject.h                  |    2 +-
 include/linux/hw_random.h                     |    2 +-
 include/linux/interrupt.h                     |    2 +-
 include/linux/io-mapping.h                    |    2 +-
 include/linux/iopoll.h                        |    4 +-
 include/linux/jump_label.h                    |    2 +-
 include/linux/kobject.h                       |    2 +-
 include/linux/kobject_ns.h                    |    2 +-
 include/linux/lockdep.h                       |    2 +-
 include/linux/mutex.h                         |    2 +-
 include/linux/pm.h                            |    2 +-
 include/linux/rbtree.h                        |    2 +-
 include/linux/rbtree_augmented.h              |    2 +-
 include/linux/regmap.h                        |    4 +-
 include/linux/rwsem.h                         |    2 +-
 include/linux/serial_core.h                   |    2 +-
 include/linux/thermal.h                       |    4 +-
 include/media/videobuf-dma-sg.h               |    2 +-
 include/pcmcia/ds.h                           |    2 +-
 include/pcmcia/ss.h                           |    2 +-
 include/soc/fsl/qe/qe.h                       |    2 +-
 include/uapi/linux/bpf.h                      |    2 +-
 include/uapi/rdma/rdma_user_ioctl_cmds.h      |    2 +-
 init/Kconfig                                  |   12 +-
 kernel/cgroup/cpuset.c                        |    2 +-
 kernel/dma/debug.c                            |    2 +-
 kernel/locking/mutex.c                        |    2 +-
 kernel/locking/rtmutex.c                      |    2 +-
 kernel/padata.c                               |    2 +-
 kernel/panic.c                                |    2 +-
 kernel/power/Kconfig                          |    6 +-
 kernel/sched/deadline.c                       |    2 +-
 lib/Kconfig                                   |    2 +-
 lib/Kconfig.debug                             |    8 +-
 lib/crc32.c                                   |    2 +-
 lib/kobject.c                                 |    4 +-
 lib/lzo/lzo1x_decompress_safe.c               |    2 +-
 lib/xz/Kconfig                                |    2 +-
 mm/Kconfig                                    |    2 +-
 mm/nommu.c                                    |    2 +-
 mm/swap.c                                     |    2 +-
 net/bridge/netfilter/Kconfig                  |    2 +-
 net/ipv4/netfilter/Kconfig                    |    2 +-
 net/ipv6/netfilter/Kconfig                    |    2 +-
 net/netfilter/Kconfig                         |   18 +-
 net/tipc/Kconfig                              |    2 +-
 net/wireless/Kconfig                          |    2 +-
 samples/Kconfig                               |    2 +-
 samples/kprobes/kprobe_example.c              |    2 +-
 samples/kprobes/kretprobe_example.c           |    2 +-
 scripts/Kbuild.include                        |    4 +-
 scripts/Makefile.host                         |    2 +-
 scripts/checkpatch.pl                         |    8 +-
 scripts/coccinelle/free/devm_free.cocci       |    2 +-
 scripts/documentation-file-ref-check          |    5 +-
 scripts/gcc-plugins/Kconfig                   |    2 +-
 scripts/kconfig/symbol.c                      |    2 +-
 .../tests/err_recursive_dep/expected_stderr   |   14 +-
 security/Kconfig                              |    2 +-
 security/device_cgroup.c                      |    2 +-
 sound/oss/dmasound/Kconfig                    |    6 +-
 tools/include/linux/rbtree.h                  |    2 +-
 tools/include/linux/rbtree_augmented.h        |    2 +-
 tools/include/uapi/linux/bpf.h                |    2 +-
 .../Documentation/stack-validation.txt        |    2 +-
 tools/testing/fault-injection/failcmd.sh      |    2 +-
 tools/testing/selftests/zram/README           |    2 +-
 usr/Kconfig                                   |    2 +-
 961 files changed, 31818 insertions(+), 24040 deletions(-)
 rename Documentation/{DMA-API-HOWTO.txt => DMA-API-HOWTO.rst} (99%)
 rename Documentation/{DMA-API.txt => DMA-API.rst} (99%)
 rename Documentation/{DMA-ISA-LPC.txt => DMA-ISA-LPC.rst} (98%)
 rename Documentation/{DMA-attributes.txt => DMA-attributes.rst} (99%)
 rename Documentation/EDID/{HOWTO.txt => howto.rst} (83%)
 rename Documentation/{IPMI.txt => IPMI.rst} (99%)
 rename Documentation/{IRQ-affinity.txt => IRQ-affinity.rst} (99%)
 rename Documentation/{IRQ-domain.txt => IRQ-domain.rst} (99%)
 rename Documentation/{IRQ.txt => IRQ.rst} (99%)
 rename Documentation/{Intel-IOMMU.txt => Intel-IOMMU.rst} (99%)
 rename Documentation/{SAK.txt => SAK.rst} (99%)
 rename Documentation/{SM501.txt => SM501.rst} (99%)
 rename Documentation/accounting/{cgroupstats.txt => cgroupstats.rst} (77%)
 rename Documentation/accounting/{delay-accounting.txt => delay-accounting.rst} (77%)
 create mode 100644 Documentation/accounting/index.rst
 rename Documentation/accounting/{psi.txt => psi.rst} (91%)
 rename Documentation/accounting/{taskstats-struct.txt => taskstats-struct.rst} (90%)
 rename Documentation/accounting/{taskstats.txt => taskstats.rst} (95%)
 rename Documentation/aoe/{aoe.txt => aoe.rst} (79%)
 create mode 100644 Documentation/aoe/examples.rst
 create mode 100644 Documentation/aoe/index.rst
 rename Documentation/aoe/{todo.txt => todo.rst} (98%)
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
 rename Documentation/arm64/{acpi_object_usage.txt => acpi_object_usage.rst} (84%)
 rename Documentation/arm64/{arm-acpi.txt => arm-acpi.rst} (86%)
 rename Documentation/arm64/{booting.txt => booting.rst} (86%)
 rename Documentation/arm64/{cpu-feature-registers.txt => cpu-feature-registers.rst} (66%)
 rename Documentation/arm64/{elf_hwcaps.txt => elf_hwcaps.rst} (92%)
 rename Documentation/arm64/{hugetlbpage.txt => hugetlbpage.rst} (86%)
 create mode 100644 Documentation/arm64/index.rst
 rename Documentation/arm64/{legacy_instructions.txt => legacy_instructions.rst} (73%)
 create mode 100644 Documentation/arm64/memory.rst
 delete mode 100644 Documentation/arm64/memory.txt
 rename Documentation/arm64/{pointer-authentication.txt => pointer-authentication.rst} (98%)
 rename Documentation/arm64/{silicon-errata.txt => silicon-errata.rst} (55%)
 rename Documentation/arm64/{sve.txt => sve.rst} (98%)
 rename Documentation/arm64/{tagged-pointers.txt => tagged-pointers.rst} (94%)
 rename Documentation/{atomic_bitops.txt => atomic_bitops.rst} (99%)
 rename Documentation/auxdisplay/{lcd-panel-cgram.txt => lcd-panel-cgram.rst} (88%)
 create mode 100644 Documentation/backlight/lp855x-driver.rst
 delete mode 100644 Documentation/backlight/lp855x-driver.txt
 rename Documentation/block/{bfq-iosched.txt => bfq-iosched.rst} (95%)
 rename Documentation/block/{biodoc.txt => biodoc.rst} (83%)
 rename Documentation/block/{biovecs.txt => biovecs.rst} (92%)
 create mode 100644 Documentation/block/capability.rst
 delete mode 100644 Documentation/block/capability.txt
 rename Documentation/block/{cmdline-partition.txt => cmdline-partition.rst} (92%)
 rename Documentation/block/{data-integrity.txt => data-integrity.rst} (92%)
 rename Documentation/block/{deadline-iosched.txt => deadline-iosched.rst} (89%)
 create mode 100644 Documentation/block/index.rst
 rename Documentation/block/{ioprio.txt => ioprio.rst} (75%)
 rename Documentation/block/{kyber-iosched.txt => kyber-iosched.rst} (86%)
 rename Documentation/block/{null_blk.txt => null_blk.rst} (60%)
 rename Documentation/block/{pr.txt => pr.rst} (95%)
 rename Documentation/block/{queue-sysfs.txt => queue-sysfs.rst} (99%)
 rename Documentation/block/{request.txt => request.rst} (59%)
 rename Documentation/block/{stat.txt => stat.rst} (89%)
 rename Documentation/block/{switching-sched.txt => switching-sched.rst} (71%)
 rename Documentation/block/{writeback_cache_control.txt => writeback_cache_control.rst} (94%)
 rename Documentation/blockdev/drbd/{data-structure-v9.txt => data-structure-v9.rst} (94%)
 create mode 100644 Documentation/blockdev/drbd/figures.rst
 rename Documentation/blockdev/drbd/{README.txt => index.rst} (55%)
 rename Documentation/blockdev/{floppy.txt => floppy.rst} (81%)
 create mode 100644 Documentation/blockdev/index.rst
 rename Documentation/blockdev/{nbd.txt => nbd.rst} (96%)
 rename Documentation/blockdev/{paride.txt => paride.rst} (85%)
 rename Documentation/blockdev/{ramdisk.txt => ramdisk.rst} (84%)
 rename Documentation/blockdev/{zram.txt => zram.rst} (76%)
 rename Documentation/{bt8xxgpio.txt => bt8xxgpio.rst} (99%)
 rename Documentation/{btmrvl.txt => btmrvl.rst} (99%)
 rename Documentation/bus-devices/{ti-gpmc.txt => ti-gpmc.rst} (58%)
 rename Documentation/{bus-virt-phys-mapping.txt => bus-virt-phys-mapping.rst} (99%)
 delete mode 100644 Documentation/cdrom/Makefile
 create mode 100644 Documentation/cdrom/cdrom-standard.rst
 delete mode 100644 Documentation/cdrom/cdrom-standard.tex
 rename Documentation/cdrom/{ide-cd => ide-cd.rst} (82%)
 create mode 100644 Documentation/cdrom/index.rst
 rename Documentation/cdrom/{packet-writing.txt => packet-writing.rst} (91%)
 rename Documentation/cgroup-v1/{blkio-controller.txt => blkio-controller.rst} (89%)
 rename Documentation/cgroup-v1/{cgroups.txt => cgroups.rst} (88%)
 rename Documentation/cgroup-v1/{cpuacct.txt => cpuacct.rst} (90%)
 rename Documentation/cgroup-v1/{cpusets.txt => cpusets.rst} (90%)
 rename Documentation/cgroup-v1/{devices.txt => devices.rst} (88%)
 rename Documentation/cgroup-v1/{freezer-subsystem.txt => freezer-subsystem.rst} (95%)
 rename Documentation/cgroup-v1/{hugetlb.txt => hugetlb.rst} (74%)
 create mode 100644 Documentation/cgroup-v1/index.rst
 rename Documentation/cgroup-v1/{memcg_test.txt => memcg_test.rst} (62%)
 rename Documentation/cgroup-v1/{memory.txt => memory.rst} (71%)
 rename Documentation/cgroup-v1/{net_cls.txt => net_cls.rst} (50%)
 rename Documentation/cgroup-v1/{net_prio.txt => net_prio.rst} (71%)
 rename Documentation/cgroup-v1/{pids.txt => pids.rst} (62%)
 rename Documentation/cgroup-v1/{rdma.txt => rdma.rst} (79%)
 rename Documentation/{clearing-warn-once.txt => clearing-warn-once.rst} (96%)
 rename Documentation/cma/{debugfs.txt => debugfs.rst} (91%)
 rename Documentation/connector/{connector.txt => connector.rst} (57%)
 rename Documentation/console/{console.txt => console.rst} (80%)
 rename Documentation/cpu-freq/{amd-powernow.txt => amd-powernow.rst} (91%)
 rename Documentation/cpu-freq/{core.txt => core.rst} (66%)
 rename Documentation/cpu-freq/{cpu-drivers.txt => cpu-drivers.rst} (57%)
 rename Documentation/cpu-freq/{cpufreq-nforce2.txt => cpufreq-nforce2.rst} (65%)
 create mode 100644 Documentation/cpu-freq/cpufreq-stats.rst
 delete mode 100644 Documentation/cpu-freq/cpufreq-stats.txt
 create mode 100644 Documentation/cpu-freq/index.rst
 delete mode 100644 Documentation/cpu-freq/index.txt
 rename Documentation/cpu-freq/{pcc-cpufreq.txt => pcc-cpufreq.rst} (80%)
 rename Documentation/{cpu-load.txt => cpu-load.rst} (99%)
 rename Documentation/{cputopology.txt => cputopology.rst} (99%)
 rename Documentation/{crc32.txt => crc32.rst} (99%)
 rename Documentation/{dcdbas.txt => dcdbas.rst} (99%)
 rename Documentation/{debugging-modules.txt => debugging-modules.rst} (98%)
 rename Documentation/{debugging-via-ohci1394.txt => debugging-via-ohci1394.rst} (99%)
 rename Documentation/{dell_rbu.txt => dell_rbu.rst} (99%)
 rename Documentation/device-mapper/{cache-policies.txt => cache-policies.rst} (94%)
 rename Documentation/device-mapper/{cache.txt => cache.rst} (61%)
 rename Documentation/device-mapper/{delay.txt => delay.rst} (53%)
 rename Documentation/device-mapper/{dm-crypt.txt => dm-crypt.rst} (87%)
 rename Documentation/device-mapper/{dm-flakey.txt => dm-flakey.rst} (60%)
 rename Documentation/device-mapper/{dm-init.txt => dm-init.rst} (68%)
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
 rename Documentation/device-mapper/{statistics.txt => statistics.rst} (86%)
 create mode 100644 Documentation/device-mapper/striped.rst
 delete mode 100644 Documentation/device-mapper/striped.txt
 rename Documentation/device-mapper/{switch.txt => switch.rst} (84%)
 rename Documentation/device-mapper/{thin-provisioning.txt => thin-provisioning.rst} (92%)
 rename Documentation/device-mapper/{unstriped.txt => unstriped.rst} (60%)
 rename Documentation/device-mapper/{verity.txt => verity.rst} (98%)
 rename Documentation/device-mapper/{writecache.txt => writecache.rst} (96%)
 rename Documentation/device-mapper/{zero.txt => zero.rst} (83%)
 rename Documentation/{digsig.txt => digsig.rst} (99%)
 rename Documentation/{pps/pps.txt => driver-api/pps.rst} (89%)
 rename Documentation/{ptp/ptp.txt => driver-api/ptp.rst} (88%)
 rename Documentation/driver-model/{binding.txt => binding.rst} (92%)
 rename Documentation/driver-model/{bus.txt => bus.rst} (76%)
 rename Documentation/driver-model/{class.txt => class.rst} (75%)
 rename Documentation/driver-model/{design-patterns.txt => design-patterns.rst} (59%)
 rename Documentation/driver-model/{device.txt => device.rst} (69%)
 rename Documentation/driver-model/{devres.txt => devres.rst} (93%)
 rename Documentation/driver-model/{driver.txt => driver.rst} (75%)
 create mode 100644 Documentation/driver-model/index.rst
 rename Documentation/driver-model/{overview.txt => overview.rst} (90%)
 rename Documentation/driver-model/{platform.txt => platform.rst} (95%)
 rename Documentation/driver-model/{porting.txt => porting.rst} (62%)
 rename Documentation/early-userspace/{buffer-format.txt => buffer-format.rst} (91%)
 rename Documentation/early-userspace/{README => early_userspace_support.rst} (99%)
 create mode 100644 Documentation/early-userspace/index.rst
 rename Documentation/{efi-stub.txt => efi-stub.rst} (99%)
 rename Documentation/{eisa.txt => eisa.rst} (98%)
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
 rename Documentation/fb/{fbcon.txt => fbcon.rst} (68%)
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
 rename Documentation/fb/{vesafb.txt => vesafb.rst} (56%)
 create mode 100644 Documentation/fb/viafb.rst
 delete mode 100644 Documentation/fb/viafb.txt
 rename Documentation/fb/{vt8623fb.txt => vt8623fb.rst} (85%)
 rename Documentation/fmc/{API.txt => api.rst} (87%)
 rename Documentation/fmc/{carrier.txt => carrier.rst} (91%)
 rename Documentation/fmc/{FMC-and-SDB.txt => fmc-and-sdb.rst} (88%)
 rename Documentation/fmc/{fmc-chardev.txt => fmc-chardev.rst} (96%)
 rename Documentation/fmc/{fmc-fakedev.txt => fmc-fakedev.rst} (85%)
 rename Documentation/fmc/{fmc-trivial.txt => fmc-trivial.rst} (69%)
 rename Documentation/fmc/{fmc-write-eeprom.txt => fmc-write-eeprom.rst} (79%)
 rename Documentation/fmc/{identifiers.txt => identifiers.rst} (93%)
 create mode 100644 Documentation/fmc/index.rst
 rename Documentation/fmc/{mezzanine.txt => mezzanine.rst} (87%)
 rename Documentation/fmc/{parameters.txt => parameters.rst} (96%)
 rename Documentation/fpga/{dfl.txt => dfl.rst} (89%)
 create mode 100644 Documentation/fpga/index.rst
 rename Documentation/{futex-requeue-pi.txt => futex-requeue-pi.rst} (99%)
 rename Documentation/{gcc-plugins.txt => gcc-plugins.rst} (99%)
 create mode 100644 Documentation/gpio/index.rst
 rename Documentation/gpio/{sysfs.txt => sysfs.rst} (86%)
 rename Documentation/hid/{hid-alps.txt => hid-alps.rst} (64%)
 rename Documentation/hid/{hid-sensor.txt => hid-sensor.rst} (61%)
 rename Documentation/hid/{hid-transport.txt => hid-transport.rst} (93%)
 rename Documentation/hid/{hiddev.txt => hiddev.rst} (80%)
 rename Documentation/hid/{hidraw.txt => hidraw.rst} (89%)
 create mode 100644 Documentation/hid/index.rst
 create mode 100644 Documentation/hid/intel-ish-hid.rst
 delete mode 100644 Documentation/hid/intel-ish-hid.txt
 rename Documentation/hid/{uhid.txt => uhid.rst} (94%)
 rename Documentation/{highuid.txt => highuid.rst} (99%)
 rename Documentation/{hw_random.txt => hw_random.rst} (99%)
 rename Documentation/{hwspinlock.txt => hwspinlock.rst} (99%)
 rename Documentation/ia64/{aliasing.txt => aliasing.rst} (84%)
 rename Documentation/ia64/{efirtc.txt => efirtc.rst} (76%)
 rename Documentation/ia64/{err_inject.txt => err_inject.rst} (82%)
 rename Documentation/ia64/{fsys.txt => fsys.rst} (76%)
 rename Documentation/ia64/{README => ia64.rst} (61%)
 create mode 100644 Documentation/ia64/index.rst
 rename Documentation/ia64/{IRQ-redir.txt => irq-redir.rst} (84%)
 rename Documentation/ia64/{mca.txt => mca.rst} (96%)
 rename Documentation/ia64/{serial.txt => serial.rst} (87%)
 create mode 100644 Documentation/ia64/xen.rst
 delete mode 100644 Documentation/ia64/xen.txt
 create mode 100644 Documentation/ide/changelogs.rst
 rename Documentation/ide/{ide-tape.txt => ide-tape.rst} (83%)
 rename Documentation/ide/{ide.txt => ide.rst} (72%)
 create mode 100644 Documentation/ide/index.rst
 rename Documentation/ide/{warm-plug-howto.txt => warm-plug-howto.rst} (61%)
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
 rename Documentation/{intel_txt.txt => intel_txt.rst} (99%)
 rename Documentation/{io-mapping.txt => io-mapping.rst} (99%)
 rename Documentation/{io_ordering.txt => io_ordering.rst} (99%)
 rename Documentation/ioctl/{botching-up-ioctls.txt => botching-up-ioctls.rst} (99%)
 create mode 100644 Documentation/ioctl/cdrom.rst
 delete mode 100644 Documentation/ioctl/cdrom.txt
 rename Documentation/ioctl/{hdio.txt => hdio.rst} (54%)
 create mode 100644 Documentation/ioctl/index.rst
 rename Documentation/ioctl/{ioctl-decoding.txt => ioctl-decoding.rst} (54%)
 create mode 100644 Documentation/ioctl/ioctl-number.rst
 delete mode 100644 Documentation/ioctl/ioctl-number.txt
 rename Documentation/{iostats.txt => iostats.rst} (99%)
 rename Documentation/{irqflags-tracing.txt => irqflags-tracing.rst} (99%)
 rename Documentation/{isa.txt => isa.rst} (99%)
 rename Documentation/{isapnp.txt => isapnp.rst} (98%)
 rename Documentation/kbuild/{headers_install.txt => headers_install.rst} (96%)
 create mode 100644 Documentation/kbuild/index.rst
 create mode 100644 Documentation/kbuild/issues.rst
 rename Documentation/kbuild/{kbuild.txt => kbuild.rst} (72%)
 rename Documentation/kbuild/{kconfig-language.txt => kconfig-language.rst} (85%)
 rename Documentation/kbuild/{kconfig-macro-language.txt => kconfig-macro-language.rst} (94%)
 rename Documentation/kbuild/{kconfig.txt => kconfig.rst} (80%)
 rename Documentation/kbuild/{makefiles.txt => makefiles.rst} (84%)
 rename Documentation/kbuild/{modules.txt => modules.rst} (84%)
 create mode 100644 Documentation/kdump/index.rst
 rename Documentation/kdump/{kdump.txt => kdump.rst} (91%)
 rename Documentation/kdump/{vmcoreinfo.txt => vmcoreinfo.rst} (95%)
 rename Documentation/{kernel-per-CPU-kthreads.txt => kernel-per-CPU-kthreads.rst} (99%)
 rename Documentation/{kobject.txt => kobject.rst} (99%)
 rename Documentation/{kprobes.txt => kprobes.rst} (99%)
 rename Documentation/{kref.txt => kref.rst} (99%)
 rename Documentation/laptops/{asus-laptop.txt => asus-laptop.rst} (84%)
 rename Documentation/laptops/{disk-shock-protection.txt => disk-shock-protection.rst} (91%)
 create mode 100644 Documentation/laptops/index.rst
 rename Documentation/laptops/{laptop-mode.txt => laptop-mode.rst} (62%)
 rename Documentation/laptops/{sony-laptop.txt => sony-laptop.rst} (85%)
 rename Documentation/laptops/{sonypi.txt => sonypi.rst} (87%)
 rename Documentation/laptops/{thinkpad-acpi.txt => thinkpad-acpi.rst} (88%)
 rename Documentation/laptops/{toshiba_haps.txt => toshiba_haps.rst} (60%)
 rename Documentation/{ldm.txt => ldm.rst} (99%)
 create mode 100644 Documentation/leds/index.rst
 rename Documentation/leds/{leds-blinkm.txt => leds-blinkm.rst} (56%)
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
 rename Documentation/livepatch/{callbacks.txt => callbacks.rst} (94%)
 rename Documentation/livepatch/{cumulative-patches.txt => cumulative-patches.rst} (89%)
 create mode 100644 Documentation/livepatch/index.rst
 rename Documentation/livepatch/{livepatch.txt => livepatch.rst} (93%)
 rename Documentation/livepatch/{module-elf-format.txt => module-elf-format.rst} (68%)
 rename Documentation/livepatch/{shadow-vars.txt => shadow-vars.rst} (87%)
 create mode 100644 Documentation/locking/index.rst
 rename Documentation/locking/{lockdep-design.txt => lockdep-design.rst} (93%)
 create mode 100644 Documentation/locking/lockstat.rst
 delete mode 100644 Documentation/locking/lockstat.txt
 rename Documentation/locking/{locktorture.txt => locktorture.rst} (57%)
 rename Documentation/locking/{mutex-design.txt => mutex-design.rst} (94%)
 rename Documentation/locking/{rt-mutex-design.txt => rt-mutex-design.rst} (91%)
 rename Documentation/locking/{rt-mutex.txt => rt-mutex.rst} (70%)
 rename Documentation/locking/{spinlocks.txt => spinlocks.rst} (89%)
 rename Documentation/locking/{ww-mutex-design.txt => ww-mutex-design.rst} (93%)
 rename Documentation/{lockup-watchdogs.txt => lockup-watchdogs.rst} (99%)
 rename Documentation/{lsm.txt => lsm.rst} (99%)
 rename Documentation/{lzo.txt => lzo.rst} (99%)
 create mode 100644 Documentation/m68k/index.rst
 rename Documentation/m68k/{kernel-options.txt => kernel-options.rst} (78%)
 rename Documentation/{mailbox.txt => mailbox.rst} (99%)
 create mode 100644 Documentation/md/index.rst
 rename Documentation/md/{md-cluster.txt => md-cluster.rst} (68%)
 rename Documentation/md/{raid5-cache.txt => raid5-cache.rst} (92%)
 rename Documentation/md/{raid5-ppl.txt => raid5-ppl.rst} (98%)
 rename Documentation/memory-devices/{ti-emif.txt => ti-emif.rst} (81%)
 rename Documentation/{men-chameleon-bus.txt => men-chameleon-bus.rst} (99%)
 create mode 100644 Documentation/mic/index.rst
 rename Documentation/mic/{mic_overview.txt => mic_overview.rst} (96%)
 rename Documentation/mic/{scif_overview.txt => scif_overview.rst} (76%)
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
 rename Documentation/netlabel/{cipso_ipv4.txt => cipso_ipv4.rst} (87%)
 create mode 100644 Documentation/netlabel/draft_ietf.rst
 create mode 100644 Documentation/netlabel/index.rst
 rename Documentation/netlabel/{introduction.txt => introduction.rst} (91%)
 rename Documentation/netlabel/{lsm_interface.txt => lsm_interface.rst} (88%)
 create mode 100644 Documentation/nfc/index.rst
 rename Documentation/nfc/{nfc-hci.txt => nfc-hci.rst} (71%)
 rename Documentation/nfc/{nfc-pn544.txt => nfc-pn544.rst} (82%)
 rename Documentation/{nommu-mmap.txt => nommu-mmap.rst} (99%)
 rename Documentation/{ntb.txt => ntb.rst} (99%)
 rename Documentation/{numastat.txt => numastat.rst} (99%)
 rename Documentation/nvdimm/{btt.txt => btt.rst} (71%)
 create mode 100644 Documentation/nvdimm/index.rst
 rename Documentation/nvdimm/{nvdimm.txt => nvdimm.rst} (60%)
 rename Documentation/nvdimm/{security.txt => security.rst} (99%)
 rename Documentation/nvmem/{nvmem.txt => nvmem.rst} (62%)
 rename Documentation/{padata.txt => padata.rst} (99%)
 rename Documentation/{parport-lowlevel.txt => parport-lowlevel.rst} (99%)
 rename Documentation/pcmcia/{devicetable.txt => devicetable.rst} (97%)
 rename Documentation/pcmcia/{driver-changes.txt => driver-changes.rst} (90%)
 rename Documentation/pcmcia/{driver.txt => driver.rst} (66%)
 create mode 100644 Documentation/pcmcia/index.rst
 rename Documentation/pcmcia/{locking.txt => locking.rst} (81%)
 rename Documentation/{percpu-rw-semaphore.txt => percpu-rw-semaphore.rst} (99%)
 rename Documentation/perf/{arm-ccn.txt => arm-ccn.rst} (86%)
 rename Documentation/perf/{arm_dsu_pmu.txt => arm_dsu_pmu.rst} (92%)
 rename Documentation/perf/{hisi-pmu.txt => hisi-pmu.rst} (73%)
 create mode 100644 Documentation/perf/index.rst
 rename Documentation/perf/{qcom_l2_pmu.txt => qcom_l2_pmu.rst} (94%)
 rename Documentation/perf/{qcom_l3_pmu.txt => qcom_l3_pmu.rst} (93%)
 rename Documentation/perf/{thunderx2-pmu.txt => thunderx2-pmu.rst} (73%)
 rename Documentation/perf/{xgene-pmu.txt => xgene-pmu.rst} (96%)
 rename Documentation/{phy.txt => phy.rst} (99%)
 rename Documentation/phy/{samsung-usb2.txt => samsung-usb2.rst} (77%)
 rename Documentation/{pi-futex.txt => pi-futex.rst} (99%)
 rename Documentation/{pnp.txt => pnp.rst} (99%)
 rename Documentation/power/{apm-acpi.txt => apm-acpi.rst} (87%)
 rename Documentation/power/{basic-pm-debugging.txt => basic-pm-debugging.rst} (87%)
 rename Documentation/power/{charger-manager.txt => charger-manager.rst} (78%)
 rename Documentation/power/{drivers-testing.txt => drivers-testing.rst} (86%)
 rename Documentation/power/{energy-model.txt => energy-model.rst} (74%)
 rename Documentation/power/{freezing-of-tasks.txt => freezing-of-tasks.rst} (75%)
 create mode 100644 Documentation/power/index.rst
 rename Documentation/power/{interface.txt => interface.rst} (84%)
 rename Documentation/power/{opp.txt => opp.rst} (78%)
 rename Documentation/power/{pci.txt => pci.rst} (97%)
 rename Documentation/power/{pm_qos_interface.txt => pm_qos_interface.rst} (62%)
 create mode 100644 Documentation/power/power_supply_class.rst
 delete mode 100644 Documentation/power/power_supply_class.txt
 create mode 100644 Documentation/power/powercap/powercap.rst
 delete mode 100644 Documentation/power/powercap/powercap.txt
 rename Documentation/power/regulator/{consumer.txt => consumer.rst} (61%)
 rename Documentation/power/regulator/{design.txt => design.rst} (86%)
 rename Documentation/power/regulator/{machine.txt => machine.rst} (75%)
 rename Documentation/power/regulator/{overview.txt => overview.rst} (79%)
 create mode 100644 Documentation/power/regulator/regulator.rst
 delete mode 100644 Documentation/power/regulator/regulator.txt
 rename Documentation/power/{runtime_pm.txt => runtime_pm.rst} (89%)
 rename Documentation/power/{s2ram.txt => s2ram.rst} (92%)
 rename Documentation/power/{suspend-and-cpuhotplug.txt => suspend-and-cpuhotplug.rst} (90%)
 rename Documentation/power/{suspend-and-interrupts.txt => suspend-and-interrupts.rst} (98%)
 rename Documentation/power/{swsusp-and-swap-files.txt => swsusp-and-swap-files.rst} (83%)
 rename Documentation/power/{swsusp-dmcrypt.txt => swsusp-dmcrypt.rst} (67%)
 create mode 100644 Documentation/power/swsusp.rst
 delete mode 100644 Documentation/power/swsusp.txt
 rename Documentation/power/{tricks.txt => tricks.rst} (93%)
 rename Documentation/power/{userland-swsusp.txt => userland-swsusp.rst} (85%)
 rename Documentation/power/{video.txt => video.rst} (56%)
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
 rename Documentation/{preempt-locking.txt => preempt-locking.rst} (99%)
 create mode 100644 Documentation/pti/pti_intel_mid.rst
 delete mode 100644 Documentation/pti/pti_intel_mid.txt
 rename Documentation/{pwm.txt => pwm.rst} (99%)
 create mode 100644 Documentation/rapidio/index.rst
 rename Documentation/rapidio/{mport_cdev.txt => mport_cdev.rst} (84%)
 rename Documentation/rapidio/{rapidio.txt => rapidio.rst} (97%)
 rename Documentation/rapidio/{rio_cm.txt => rio_cm.rst} (76%)
 rename Documentation/rapidio/{sysfs.txt => sysfs.rst} (75%)
 rename Documentation/rapidio/{tsi721.txt => tsi721.rst} (79%)
 rename Documentation/{rbtree.txt => rbtree.rst} (99%)
 rename Documentation/{remoteproc.txt => remoteproc.rst} (99%)
 rename Documentation/{rfkill.txt => rfkill.rst} (99%)
 create mode 100644 Documentation/riscv/index.rst
 rename Documentation/riscv/{pmu.txt => pmu.rst} (77%)
 rename Documentation/{robust-futex-ABI.txt => robust-futex-ABI.rst} (99%)
 rename Documentation/{robust-futexes.txt => robust-futexes.rst} (99%)
 rename Documentation/{rpmsg.txt => rpmsg.rst} (99%)
 rename Documentation/{rtc.txt => rtc.rst} (99%)
 rename Documentation/s390/{3270.txt => 3270.rst} (90%)
 delete mode 100644 Documentation/s390/Debugging390.txt
 rename Documentation/s390/{cds.txt => cds.rst} (64%)
 rename Documentation/s390/{CommonIO => common_io.rst} (87%)
 rename Documentation/s390/{DASD => dasd.rst} (92%)
 create mode 100644 Documentation/s390/debugging390.rst
 rename Documentation/s390/{driver-model.txt => driver-model.rst} (73%)
 create mode 100644 Documentation/s390/index.rst
 rename Documentation/s390/{monreader.txt => monreader.rst} (81%)
 rename Documentation/s390/{qeth.txt => qeth.rst} (62%)
 create mode 100644 Documentation/s390/s390dbf.rst
 delete mode 100644 Documentation/s390/s390dbf.txt
 create mode 100644 Documentation/s390/text_files.rst
 rename Documentation/s390/{vfio-ap.txt => vfio-ap.rst} (72%)
 rename Documentation/s390/{vfio-ccw.txt => vfio-ccw.rst} (88%)
 rename Documentation/s390/{zfcpdump.txt => zfcpdump.rst} (97%)
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
 rename Documentation/security/tpm/{xen-tpmfront.txt => xen-tpmfront.rst} (66%)
 rename Documentation/serial/{README.cycladesZ => cyclades_z.rst} (85%)
 rename Documentation/serial/{driver => driver.rst} (92%)
 create mode 100644 Documentation/serial/index.rst
 delete mode 100644 Documentation/serial/moxa-smartio
 create mode 100644 Documentation/serial/moxa-smartio.rst
 create mode 100644 Documentation/serial/n_gsm.rst
 delete mode 100644 Documentation/serial/n_gsm.txt
 rename Documentation/serial/{rocket.txt => rocket.rst} (68%)
 rename Documentation/serial/{serial-iso7816.txt => serial-iso7816.rst} (85%)
 rename Documentation/serial/{serial-rs485.txt => serial-rs485.rst} (89%)
 rename Documentation/serial/{tty.txt => tty.rst} (74%)
 rename Documentation/{sgi-ioc4.txt => sgi-ioc4.rst} (99%)
 rename Documentation/{siphash.txt => siphash.rst} (99%)
 rename Documentation/{smsc_ece1099.txt => smsc_ece1099.rst} (99%)
 rename Documentation/sparc/{adi.txt => adi.rst} (70%)
 rename Documentation/sparc/{console.txt => console.rst} (53%)
 create mode 100644 Documentation/sparc/index.rst
 rename Documentation/sparc/oradax/{oracle-dax.txt => oracle-dax.rst} (95%)
 rename Documentation/{speculation.txt => speculation.rst} (99%)
 rename Documentation/{static-keys.txt => static-keys.rst} (99%)
 rename Documentation/{svga.txt => svga.rst} (99%)
 rename Documentation/{switchtec.txt => switchtec.rst} (98%)
 rename Documentation/{sync_file.txt => sync_file.rst} (99%)
 create mode 100644 Documentation/sysctl/abi.rst
 delete mode 100644 Documentation/sysctl/abi.txt
 rename Documentation/sysctl/{fs.txt => fs.rst} (77%)
 rename Documentation/sysctl/{README => index.rst} (78%)
 rename Documentation/sysctl/{kernel.txt => kernel.rst} (79%)
 rename Documentation/sysctl/{net.txt => net.rst} (85%)
 rename Documentation/sysctl/{sunrpc.txt => sunrpc.rst} (62%)
 rename Documentation/sysctl/{user.txt => user.rst} (77%)
 rename Documentation/sysctl/{vm.txt => vm.rst} (84%)
 create mode 100644 Documentation/target/index.rst
 create mode 100644 Documentation/target/scripts.rst
 create mode 100644 Documentation/target/tcm_mod_builder.rst
 delete mode 100644 Documentation/target/tcm_mod_builder.txt
 rename Documentation/target/{tcmu-design.txt => tcmu-design.rst} (69%)
 rename Documentation/{tee.txt => tee.rst} (99%)
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
 rename Documentation/{this_cpu_ops.txt => this_cpu_ops.rst} (99%)
 rename Documentation/timers/{highres.txt => highres.rst} (98%)
 rename Documentation/timers/{hpet.txt => hpet.rst} (91%)
 rename Documentation/timers/{hrtimers.txt => hrtimers.rst} (98%)
 create mode 100644 Documentation/timers/index.rst
 rename Documentation/timers/{NO_HZ.txt => no_hz.rst} (93%)
 rename Documentation/timers/{timekeeping.txt => timekeeping.rst} (98%)
 rename Documentation/timers/{timers-howto.txt => timers-howto.rst} (93%)
 rename Documentation/{unaligned-memory-access.txt => unaligned-memory-access.rst} (99%)
 rename Documentation/{vfio-mediated-device.txt => vfio-mediated-device.rst} (99%)
 rename Documentation/{vfio.txt => vfio.rst} (99%)
 rename Documentation/{video-output.txt => video-output.rst} (99%)
 rename Documentation/watchdog/{convert_drivers_to_kernel_api.txt => convert_drivers_to_kernel_api.rst} (75%)
 rename Documentation/watchdog/{hpwdt.txt => hpwdt.rst} (77%)
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
 rename Documentation/{xillybus.txt => xillybus.rst} (99%)
 rename Documentation/xtensa/{atomctl.txt => atomctl.rst} (81%)
 rename Documentation/xtensa/{booting.txt => booting.rst} (91%)
 create mode 100644 Documentation/xtensa/index.rst
 create mode 100644 Documentation/xtensa/mmu.rst
 delete mode 100644 Documentation/xtensa/mmu.txt
 rename Documentation/{xz.txt => xz.rst} (99%)
 rename Documentation/{zorro.txt => zorro.rst} (99%)

-- 
2.20.1


