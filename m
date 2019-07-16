Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C367C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 11:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07085206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 11:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563274892;
	bh=1DAhrUe/Akt4yHwuWxmtYzHYYpnntRto0GjVqJ6eFeA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=JE0tq/x1GeesGiRbwbW7WVUD4ZqwKe0nFS71PKUhJvah8/mBLRDINyPZICEVxyUu6
	 DWmGOMP2q7le+pyZVwD9sSBtOAubGr4ObBBOfYxo3fI1JxNiw43/RnNloFfj+Tdv1t
	 09fM5TrvGReYtLOK7VdPcKLxc7GO/Cbx8ppdQhp8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387531AbfGPLBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 07:01:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33818 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733037AbfGPLBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 07:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QK5MXCj6vyX+zVfDdC+Ad2MD8OAJPBHQSqUNp7OP34s=; b=lpd9A/kahrj80XyY+gdl0Fxfl
        r39oK0FkesiJoYVyg3YyjQ/3aZ1wSRKzgN7HIlnptr7T97DP/nHRd1Lk2r7Wq0aJXCadZ4Nzu9MQD
        9AkBs1ZaFxgTXEQQ6Cfp2eHkgjtKSk8ivtP96A7TSiqI5Bqu7qX2X3OFhwlq831sSmvBPNjsH98zx
        +xlRLdVi+qILUue6/91S2X0i1ygmdA5eeNzjtjUXp5vIAKnuiDrFEJ9HeWWx9oIxWN/AXvHbvXbVG
        kVBb3y+HUnyj4mjXs/WECk88tHgL1fEN6CgvhahshbeuVwpdkxBR65dsRu/y9cStB63/McEEPGZc4
        +zL5EwDxg==;
Received: from [189.27.46.152] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hnLD4-0004NY-Vw; Tue, 16 Jul 2019 11:01:28 +0000
Date:   Tue, 16 Jul 2019 08:01:22 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Documentation Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v5.3-rc1] docs: addition of a large set of files to
 the documentation body
Message-ID: <20190716080122.28a17014@coco.lan>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

As agreed with Jon, I'm sending this big series directly to you, c/c him,
as this series required a special care, in order to avoid conflicts with
other trees.

Please pull from:
  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media.git tags/docs/v5.3-1

For a series of patches that add several files that are compatible with
ReST to the Kernel documentation body.

PS.: there's a trivial conflict with rdma tree, due to the addition
of infiniband to Documentation/index.rst.

Thanks!
Mauro

The following changes since commit fec88ab0af9706b2201e5daf377c5031c62d11f7:

  Merge tag 'for-linus-hmm' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma (2019-07-14 19:42:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media.git tags/docs/v5.3-1

for you to fetch changes up to 168869492e7009b6861b615f1d030c99bc805e83:

  docs: kbuild: fix build with pdf and fix some minor issues (2019-07-15 11:03:04 -0300)

----------------------------------------------------------------
docs conversion for v5.3-rc1

----------------------------------------------------------------
Mauro Carvalho Chehab (77):
      docs: locking: convert docs to ReST and rename to *.rst
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
      docs: rapidio: convert to ReST
      docs: blockdev: convert to ReST
      docs: perf: convert to ReST
      docs: sysctl: convert to ReST
      docs: block: convert to ReST
      docs: move gcc_plugins.txt to core-api and rename to .rst
      docs: logo.txt: rename it to COPYING-logo
      docs: rapidio: add it to the driver API
      docs: perf: move to the admin-guide
      docs: nvdimm: add it to the driver-api book
      docs: namespace: move it to the admin-guide
      docs: mtd: move it to the driver-api book
      docs: nfc: add it to the driver-api book
      docs: mmc: move it to the driver-api
      docs: md: move it to the driver-api book
      docs: leds: add it to the driver-api book
      docs: ioctl: add it to the uAPI guide
      docs: interconnect.rst: add it to the driver-api guide
      docs: add arch doc directories to the index
      docs: device-mapper: move it to the admin-guide
      docs: early-userspace: move to driver-api guide
      docs: admin-guide: move sysctl directory to it
      docs: admin-guide: add laptops documentation
      docs: admin-guide: add kdump documentation into it
      docs: blockdev: add it to the admin-guide
      docs: security: move some books to it and update
      docs: x86: move two x86-specific files to x86 arch dir
      docs: ocxl.rst: add it to the uAPI book
      docs: lp855x-driver.rst: add it to the driver-api book
      docs: driver-model: move it to the driver-api book
      docs: add some documentation dirs to the driver-api book
      docs: aoe: add it to the driver-api book
      docs: cgroup-v1: add it to the admin-guide book
      docs: admin-guide: add a series of orphaned documents
      docs: driver-api: add a series of orphaned documents
      docs: driver-api: add xilinx driver API documentation
      docs: driver-api: add remaining converted dirs to it
      docs: serial: move it to the driver-api
      docs: phy: place documentation under driver-api
      docs: add a memory-devices subdir to driver-api
      docs: add SPDX tags to new index files
      docs: add some directories to the main documentation index
      docs: locking: add it to the main index
      docs: gpio: add sysfs interface to the admin-guide
      docs: don't use nested tables
      docs: arm: fix a breakage with pdf output
      docs: block: fix pdf output
      docs: kbuild: fix build with pdf and fix some minor issues

 CREDITS                                            |    2 +-
 Documentation/ABI/obsolete/sysfs-gpio              |    2 +-
 Documentation/ABI/removed/sysfs-class-rfkill       |    2 +-
 Documentation/ABI/stable/sysfs-class-rfkill        |    2 +-
 Documentation/ABI/stable/sysfs-devices-node        |    2 +-
 Documentation/ABI/testing/procfs-diskstats         |    2 +-
 Documentation/ABI/testing/sysfs-block              |    2 +-
 Documentation/ABI/testing/sysfs-block-device       |    2 +-
 Documentation/ABI/testing/sysfs-class-switchtec    |    2 +-
 Documentation/ABI/testing/sysfs-devices-system-cpu |    4 +-
 .../ABI/testing/sysfs-platform-asus-laptop         |    2 +-
 Documentation/{logo.txt => COPYING-logo}           |    0
 Documentation/DMA-API-HOWTO.txt                    |    2 +-
 .../{cgroupstats.txt => cgroupstats.rst}           |   14 +-
 .../{delay-accounting.txt => delay-accounting.rst} |   61 +-
 Documentation/accounting/index.rst                 |   14 +
 Documentation/accounting/{psi.txt => psi.rst}      |   42 +-
 .../{taskstats-struct.txt => taskstats-struct.rst} |   79 +-
 .../accounting/{taskstats.txt => taskstats.rst}    |   15 +-
 Documentation/{ => admin-guide}/aoe/aoe.rst        |    4 +-
 Documentation/{ => admin-guide}/aoe/autoload.sh    |    0
 Documentation/{ => admin-guide}/aoe/examples.rst   |    0
 Documentation/{ => admin-guide}/aoe/index.rst      |    2 -
 Documentation/{ => admin-guide}/aoe/status.sh      |    0
 Documentation/{ => admin-guide}/aoe/todo.rst       |    0
 .../{ => admin-guide}/aoe/udev-install.sh          |    0
 Documentation/{ => admin-guide}/aoe/udev.txt       |    2 +-
 .../blockdev/drbd/DRBD-8.3-data-packets.svg        |    0
 .../blockdev/drbd/DRBD-data-packets.svg            |    0
 .../blockdev/drbd/conn-states-8.dot                |    0
 .../blockdev/drbd/data-structure-v9.rst}           |    6 +-
 .../blockdev/drbd/disk-states-8.dot                |    0
 .../drbd/drbd-connection-state-overview.dot        |    0
 .../admin-guide/blockdev/drbd/figures.rst          |   30 +
 .../blockdev/drbd/index.rst}                       |   15 +-
 .../blockdev/drbd/node-states-8.dot                |    1 -
 .../floppy.txt => admin-guide/blockdev/floppy.rst} |   88 +-
 Documentation/admin-guide/blockdev/index.rst       |   16 +
 .../nbd.txt => admin-guide/blockdev/nbd.rst}       |    2 +-
 .../paride.txt => admin-guide/blockdev/paride.rst} |  196 ++--
 .../blockdev/ramdisk.rst}                          |   55 +-
 .../zram.txt => admin-guide/blockdev/zram.rst}     |  197 ++--
 .../{btmrvl.txt => admin-guide/btmrvl.rst}         |    0
 Documentation/admin-guide/bug-hunting.rst          |    4 +-
 .../cgroup-v1/blkio-controller.rst                 |    0
 .../{ => admin-guide}/cgroup-v1/cgroups.rst        |    4 +-
 .../{ => admin-guide}/cgroup-v1/cpuacct.rst        |    0
 .../{ => admin-guide}/cgroup-v1/cpusets.rst        |    2 +-
 .../{ => admin-guide}/cgroup-v1/devices.rst        |    0
 .../cgroup-v1/freezer-subsystem.rst                |    0
 .../{ => admin-guide}/cgroup-v1/hugetlb.rst        |    0
 .../{ => admin-guide}/cgroup-v1/index.rst          |    2 -
 .../{ => admin-guide}/cgroup-v1/memcg_test.rst     |    4 +-
 .../{ => admin-guide}/cgroup-v1/memory.rst         |    0
 .../{ => admin-guide}/cgroup-v1/net_cls.rst        |    0
 .../{ => admin-guide}/cgroup-v1/net_prio.rst       |    0
 Documentation/{ => admin-guide}/cgroup-v1/pids.rst |    0
 Documentation/{ => admin-guide}/cgroup-v1/rdma.rst |    0
 Documentation/admin-guide/cgroup-v2.rst            |    8 +-
 .../clearing-warn-once.rst}                        |    0
 .../{cpu-load.txt => admin-guide/cpu-load.rst}     |    0
 .../cputopology.rst}                               |    0
 .../device-mapper/cache-policies.rst               |    0
 .../{ => admin-guide}/device-mapper/cache.rst      |    0
 .../{ => admin-guide}/device-mapper/delay.rst      |    0
 .../{ => admin-guide}/device-mapper/dm-crypt.rst   |    0
 .../{ => admin-guide}/device-mapper/dm-dust.txt    |    0
 .../{ => admin-guide}/device-mapper/dm-flakey.rst  |    0
 .../{ => admin-guide}/device-mapper/dm-init.rst    |    0
 .../device-mapper/dm-integrity.rst                 |    0
 .../{ => admin-guide}/device-mapper/dm-io.rst      |    0
 .../{ => admin-guide}/device-mapper/dm-log.rst     |    0
 .../device-mapper/dm-queue-length.rst              |    0
 .../{ => admin-guide}/device-mapper/dm-raid.rst    |    0
 .../device-mapper/dm-service-time.rst              |    0
 .../{ => admin-guide}/device-mapper/dm-uevent.rst  |    0
 .../{ => admin-guide}/device-mapper/dm-zoned.rst   |    0
 .../{ => admin-guide}/device-mapper/era.rst        |    0
 .../{ => admin-guide}/device-mapper/index.rst      |    2 -
 .../{ => admin-guide}/device-mapper/kcopyd.rst     |    0
 .../{ => admin-guide}/device-mapper/linear.rst     |    0
 .../{ => admin-guide}/device-mapper/log-writes.rst |    0
 .../device-mapper/persistent-data.rst              |    0
 .../{ => admin-guide}/device-mapper/snapshot.rst   |    0
 .../{ => admin-guide}/device-mapper/statistics.rst |    4 +-
 .../{ => admin-guide}/device-mapper/striped.rst    |    0
 .../{ => admin-guide}/device-mapper/switch.rst     |    0
 .../device-mapper/thin-provisioning.rst            |    0
 .../{ => admin-guide}/device-mapper/unstriped.rst  |    0
 .../{ => admin-guide}/device-mapper/verity.rst     |    0
 .../{ => admin-guide}/device-mapper/writecache.rst |    0
 .../{ => admin-guide}/device-mapper/zero.rst       |    0
 .../{efi-stub.txt => admin-guide/efi-stub.rst}     |    0
 Documentation/{ => admin-guide}/gpio/index.rst     |    2 +-
 Documentation/{ => admin-guide}/gpio/sysfs.rst     |    0
 .../{highuid.txt => admin-guide/highuid.rst}       |    0
 Documentation/admin-guide/hw-vuln/l1tf.rst         |    2 +-
 .../{hw_random.txt => admin-guide/hw_random.rst}   |    0
 Documentation/admin-guide/index.rst                |   28 +
 .../{iostats.txt => admin-guide/iostats.rst}       |    0
 .../{ => admin-guide}/kdump/gdbmacros.txt          |    0
 Documentation/{ => admin-guide}/kdump/index.rst    |    1 -
 Documentation/{ => admin-guide}/kdump/kdump.rst    |    0
 .../{ => admin-guide}/kdump/vmcoreinfo.rst         |    0
 Documentation/admin-guide/kernel-parameters.rst    |    2 +-
 Documentation/admin-guide/kernel-parameters.txt    |   44 +-
 .../kernel-per-CPU-kthreads.rst}                   |    2 +-
 .../laptops/asus-laptop.rst}                       |   92 +-
 .../laptops/disk-shock-protection.rst}             |   32 +-
 Documentation/admin-guide/laptops/index.rst        |   17 +
 .../laptops/laptop-mode.rst}                       |  579 +++++----
 .../{ => admin-guide}/laptops/lg-laptop.rst        |    1 -
 .../laptops/sony-laptop.rst}                       |   58 +-
 .../sonypi.txt => admin-guide/laptops/sonypi.rst}  |   50 +-
 .../laptops/thinkpad-acpi.rst}                     |  369 +++---
 .../laptops/toshiba_haps.rst}                      |   49 +-
 .../lcd-panel-cgram.rst}                           |    7 +-
 Documentation/{ldm.txt => admin-guide/ldm.rst}     |    0
 .../lockup-watchdogs.rst}                          |    0
 .../debugfs.txt => admin-guide/mm/cma_debugfs.rst} |    6 +-
 Documentation/admin-guide/mm/index.rst             |    3 +-
 Documentation/admin-guide/mm/ksm.rst               |    2 +-
 .../admin-guide/mm/numa_memory_policy.rst          |    2 +-
 .../namespaces/compatibility-list.rst}             |   10 +-
 Documentation/admin-guide/namespaces/index.rst     |   11 +
 .../namespaces/resource-control.rst}               |    4 +
 .../{numastat.txt => admin-guide/numastat.rst}     |    0
 .../arm-ccn.txt => admin-guide/perf/arm-ccn.rst}   |   18 +-
 .../perf/arm_dsu_pmu.rst}                          |    5 +-
 .../hisi-pmu.txt => admin-guide/perf/hisi-pmu.rst} |   37 +-
 Documentation/admin-guide/perf/index.rst           |   16 +
 .../perf/qcom_l2_pmu.rst}                          |    3 +-
 .../perf/qcom_l3_pmu.rst}                          |    3 +-
 .../perf/thunderx2-pmu.rst}                        |   25 +-
 .../perf/xgene-pmu.rst}                            |    3 +-
 Documentation/{pnp.txt => admin-guide/pnp.rst}     |    0
 .../{driver-api => admin-guide}/rapidio.rst        |    0
 Documentation/{rtc.txt => admin-guide/rtc.rst}     |    0
 Documentation/{svga.txt => admin-guide/svga.rst}   |    0
 Documentation/admin-guide/sysctl/abi.rst           |   67 ++
 .../{sysctl/fs.txt => admin-guide/sysctl/fs.rst}   |  146 +--
 .../README => admin-guide/sysctl/index.rst}        |   34 +-
 .../kernel.txt => admin-guide/sysctl/kernel.rst}   |  374 +++---
 .../{sysctl/net.txt => admin-guide/sysctl/net.rst} |  141 ++-
 .../sunrpc.txt => admin-guide/sysctl/sunrpc.rst}   |   13 +-
 .../user.txt => admin-guide/sysctl/user.rst}       |   32 +-
 .../{sysctl/vm.txt => admin-guide/sysctl/vm.rst}   |  264 +++--
 .../video-output.rst}                              |    0
 Documentation/arm/Marvell/README                   |  395 -------
 Documentation/arm/Netwinder                        |   78 --
 Documentation/arm/SA1100/FreeBird                  |   21 -
 Documentation/arm/SA1100/empeg                     |    2 -
 Documentation/arm/SA1100/serial_UART               |   47 -
 Documentation/arm/{README => arm.rst}              |   50 +-
 Documentation/arm/{Booting => booting.rst}         |   71 +-
 ...avoidance.txt => cluster-pm-race-avoidance.rst} |  177 +--
 Documentation/arm/{firmware.txt => firmware.rst}   |   14 +-
 Documentation/arm/index.rst                        |   80 ++
 Documentation/arm/{Interrupts => interrupts.rst}   |   90 +-
 Documentation/arm/{IXP4xx => ixp4xx.rst}           |   61 +-
 .../{kernel_mode_neon.txt => kernel_mode_neon.rst} |    3 +
 ...el_user_helpers.txt => kernel_user_helpers.rst} |   79 +-
 .../arm/keystone/{knav-qmss.txt => knav-qmss.rst}  |    6 +-
 .../arm/keystone/{Overview.txt => overview.rst}    |   47 +-
 Documentation/arm/marvel.rst                       |  488 ++++++++
 .../arm/{mem_alignment => mem_alignment.rst}       |   11 +-
 Documentation/arm/{memory.txt => memory.rst}       |    9 +-
 .../arm/{Microchip/README => microchip.rst}        |   63 +-
 Documentation/arm/netwinder.rst                    |   85 ++
 Documentation/arm/nwfpe/index.rst                  |   13 +
 .../arm/nwfpe/{README.FPE => netwinder-fpe.rst}    |   24 +-
 Documentation/arm/nwfpe/{NOTES => notes.rst}       |    3 +
 Documentation/arm/nwfpe/{README => nwfpe.rst}      |   10 +-
 Documentation/arm/nwfpe/{TODO => todo.rst}         |   47 +-
 Documentation/arm/{OMAP/DSS => omap/dss.rst}       |  102 +-
 Documentation/arm/omap/index.rst                   |   12 +
 Documentation/arm/{OMAP/README => omap/omap.rst}   |    7 +
 .../arm/{OMAP/omap_pm => omap/omap_pm.rst}         |   55 +-
 Documentation/arm/{Porting => porting.rst}         |   14 +-
 Documentation/arm/pxa/{mfp.txt => mfp.rst}         |  110 +-
 .../arm/{SA1100/ADSBitsy => sa1100/adsbitsy.rst}   |   14 +-
 .../arm/{SA1100/Assabet => sa1100/assabet.rst}     |  193 +--
 .../arm/{SA1100/Brutus => sa1100/brutus.rst}       |   49 +-
 Documentation/arm/{SA1100/CERF => sa1100/cerf.rst} |   10 +-
 Documentation/arm/sa1100/freebird.rst              |   25 +
 .../GraphicsClient => sa1100/graphicsclient.rst}   |   48 +-
 .../GraphicsMaster => sa1100/graphicsmaster.rst}   |   13 +-
 .../HUW_WEBPANEL => sa1100/huw_webpanel.rst}       |    8 +-
 Documentation/arm/sa1100/index.rst                 |   25 +
 Documentation/arm/{SA1100/Itsy => sa1100/itsy.rst} |   14 +-
 Documentation/arm/{SA1100/LART => sa1100/lart.rst} |    3 +-
 .../{SA1100/nanoEngine => sa1100/nanoengine.rst}   |    6 +-
 .../arm/{SA1100/Pangolin => sa1100/pangolin.rst}   |   10 +-
 Documentation/arm/{SA1100/PLEB => sa1100/pleb.rst} |    6 +-
 Documentation/arm/sa1100/serial_uart.rst           |   51 +
 .../arm/{SA1100/Tifon => sa1100/tifon.rst}         |    4 +-
 Documentation/arm/{SA1100/Yopy => sa1100/yopy.rst} |    5 +-
 .../CPUfreq.txt => samsung-s3c24xx/cpufreq.rst}    |    5 +-
 .../eb2410itx.rst}                                 |    5 +-
 .../GPIO.txt => samsung-s3c24xx/gpio.rst}          |   23 +-
 .../H1940.txt => samsung-s3c24xx/h1940.rst}        |    5 +-
 Documentation/arm/samsung-s3c24xx/index.rst        |   20 +
 .../NAND.txt => samsung-s3c24xx/nand.rst}          |    6 +-
 .../Overview.txt => samsung-s3c24xx/overview.rst}  |   21 +-
 .../S3C2412.txt => samsung-s3c24xx/s3c2412.rst}    |    5 +-
 .../S3C2413.txt => samsung-s3c24xx/s3c2413.rst}    |    7 +-
 .../SMDK2440.txt => samsung-s3c24xx/smdk2440.rst}  |    5 +-
 .../Suspend.txt => samsung-s3c24xx/suspend.rst}    |   20 +-
 .../USB-Host.txt => samsung-s3c24xx/usb-host.rst}  |   16 +-
 .../bootloader-interface.rst}                      |   27 +-
 .../clksrc-change-registers.awk                    |    0
 .../arm/{Samsung/GPIO.txt => samsung/gpio.rst}     |    7 +-
 Documentation/arm/samsung/index.rst                |   12 +
 .../{Samsung/Overview.txt => samsung/overview.rst} |   15 +-
 Documentation/arm/{Setup => setup.rst}             |   49 +-
 .../arm/{SH-Mobile => sh-mobile}/.gitignore        |    0
 .../arm/{SPEAr/overview.txt => spear/overview.rst} |   21 +-
 .../arm/sti/{overview.txt => overview.rst}         |   21 +-
 .../{stih407-overview.txt => stih407-overview.rst} |    9 +-
 .../{stih415-overview.txt => stih415-overview.rst} |    8 +-
 .../{stih416-overview.txt => stih416-overview.rst} |    5 +-
 .../{stih418-overview.txt => stih418-overview.rst} |    9 +-
 Documentation/arm/stm32/overview.rst               |    2 -
 Documentation/arm/stm32/stm32f429-overview.rst     |    7 +-
 Documentation/arm/stm32/stm32f746-overview.rst     |    7 +-
 Documentation/arm/stm32/stm32f769-overview.rst     |    7 +-
 Documentation/arm/stm32/stm32h743-overview.rst     |    7 +-
 Documentation/arm/stm32/stm32mp157-overview.rst    |    3 +-
 Documentation/arm/{sunxi/README => sunxi.rst}      |   98 +-
 Documentation/arm/sunxi/{clocks.txt => clocks.rst} |    7 +-
 .../arm/{swp_emulation => swp_emulation.rst}       |   24 +-
 Documentation/arm/{tcm.txt => tcm.rst}             |   54 +-
 Documentation/arm/{uefi.txt => uefi.rst}           |   39 +-
 .../release-notes.txt => vfp/release-notes.rst}    |    4 +-
 Documentation/arm/{vlocks.txt => vlocks.rst}       |    9 +-
 Documentation/arm64/index.rst                      |    2 -
 Documentation/backlight/lp855x-driver.txt          |   66 --
 .../block/{bfq-iosched.txt => bfq-iosched.rst}     |   68 +-
 Documentation/block/{biodoc.txt => biodoc.rst}     |  335 ++++--
 Documentation/block/{biovecs.txt => biovecs.rst}   |   20 +-
 Documentation/block/capability.rst                 |   18 +
 Documentation/block/capability.txt                 |   15 -
 ...cmdline-partition.txt => cmdline-partition.rst} |   13 +-
 .../{data-integrity.txt => data-integrity.rst}     |   60 +-
 .../{deadline-iosched.txt => deadline-iosched.rst} |   21 +-
 Documentation/block/index.rst                      |   25 +
 Documentation/block/{ioprio.txt => ioprio.rst}     |  103 +-
 .../block/{kyber-iosched.txt => kyber-iosched.rst} |    3 +-
 Documentation/block/{null_blk.txt => null_blk.rst} |   65 +-
 Documentation/block/{pr.txt => pr.rst}             |   18 +-
 .../block/{queue-sysfs.txt => queue-sysfs.rst}     |    7 +-
 Documentation/block/{request.txt => request.rst}   |   47 +-
 Documentation/block/{stat.txt => stat.rst}         |   13 +-
 .../{switching-sched.txt => switching-sched.rst}   |   28 +-
 ...che_control.txt => writeback_cache_control.rst} |   12 +-
 Documentation/cdrom/index.rst                      |    2 +-
 .../{gcc-plugins.txt => core-api/gcc-plugins.rst}  |    0
 Documentation/core-api/index.rst                   |    1 +
 Documentation/core-api/printk-formats.rst          |    2 +-
 Documentation/devicetree/bindings/arm/xen.txt      |    2 +-
 .../devicetree/bindings/phy/phy-bindings.txt       |    2 +-
 .../devicetree/bindings/phy/phy-pxa-usb.txt        |    2 +-
 Documentation/devicetree/booting-without-of.txt    |    4 +-
 .../driver-api/backlight/lp855x-driver.rst         |   81 ++
 .../{bt8xxgpio.txt => driver-api/bt8xxgpio.rst}    |    0
 .../connector.txt => driver-api/connector.rst}     |  130 +--
 .../console.txt => driver-api/console.rst}         |   63 +-
 .../{dcdbas.txt => driver-api/dcdbas.rst}          |    0
 .../{dell_rbu.txt => driver-api/dell_rbu.rst}      |    0
 .../{ => driver-api}/driver-model/binding.rst      |    0
 .../{ => driver-api}/driver-model/bus.rst          |    0
 .../{ => driver-api}/driver-model/class.rst        |    0
 .../driver-model/design-patterns.rst               |    0
 .../{ => driver-api}/driver-model/device.rst       |    0
 .../{ => driver-api}/driver-model/devres.rst       |    0
 .../{ => driver-api}/driver-model/driver.rst       |    0
 .../{ => driver-api}/driver-model/index.rst        |    2 -
 .../{ => driver-api}/driver-model/overview.rst     |    0
 .../{ => driver-api}/driver-model/platform.rst     |    0
 .../{ => driver-api}/driver-model/porting.rst      |    2 +-
 .../early-userspace/buffer-format.rst}             |   19 +-
 .../early-userspace/early_userspace_support.rst}   |    3 +
 Documentation/driver-api/early-userspace/index.rst |   18 +
 .../{EDID/howto.rst => driver-api/edid.rst}        |    2 +-
 Documentation/{eisa.txt => driver-api/eisa.rst}    |    4 +-
 Documentation/driver-api/gpio/driver.rst           |    2 +-
 Documentation/driver-api/index.rst                 |   43 +-
 .../{interconnect => driver-api}/interconnect.rst  |    2 -
 Documentation/{isa.txt => driver-api/isa.rst}      |    0
 .../{isapnp.txt => driver-api/isapnp.rst}          |    0
 .../pblk.txt => driver-api/lightnvm-pblk.rst}      |    0
 Documentation/driver-api/md/index.rst              |   12 +
 .../md/md-cluster.rst}                             |  184 ++-
 .../md/raid5-cache.rst}                            |   28 +-
 .../raid5-ppl.txt => driver-api/md/raid5-ppl.rst}  |    2 +
 Documentation/driver-api/memory-devices/index.rst  |   18 +
 .../memory-devices/ti-emif.rst}                    |   27 +-
 .../memory-devices/ti-gpmc.rst}                    |  163 ++-
 .../men-chameleon-bus.rst}                         |    0
 Documentation/driver-api/mmc/index.rst             |   13 +
 .../mmc/mmc-async-req.rst}                         |   59 +-
 .../mmc/mmc-dev-attrs.rst}                         |   32 +-
 .../mmc/mmc-dev-parts.rst}                         |   13 +-
 .../mmc-tools.txt => driver-api/mmc/mmc-tools.rst} |    5 +-
 Documentation/driver-api/mtd/index.rst             |   12 +
 .../intel-spi.txt => driver-api/mtd/intel-spi.rst} |   46 +-
 .../nand_ecc.txt => driver-api/mtd/nand_ecc.rst}   |  497 ++++----
 .../spi-nor.txt => driver-api/mtd/spi-nor.rst}     |    7 +-
 Documentation/driver-api/nfc/index.rst             |   11 +
 .../nfc-hci.txt => driver-api/nfc/nfc-hci.rst}     |  167 +--
 .../nfc-pn544.txt => driver-api/nfc/nfc-pn544.rst} |    6 +-
 Documentation/{ntb.txt => driver-api/ntb.rst}      |    0
 .../{nvdimm/btt.txt => driver-api/nvdimm/btt.rst}  |  144 +--
 Documentation/driver-api/nvdimm/index.rst          |   12 +
 .../nvdimm.txt => driver-api/nvdimm/nvdimm.rst}    |  526 +++++----
 .../nvdimm/security.rst}                           |    4 +-
 .../{nvmem/nvmem.txt => driver-api/nvmem.rst}      |  112 +-
 .../parport-lowlevel.rst}                          |    0
 Documentation/driver-api/phy/index.rst             |   18 +
 Documentation/{phy.txt => driver-api/phy/phy.rst}  |    0
 .../phy/samsung-usb2.rst}                          |   60 +-
 Documentation/driver-api/pps.rst                   |    2 +-
 Documentation/driver-api/pti_intel_mid.rst         |  106 ++
 Documentation/driver-api/ptp.rst                   |    2 +-
 Documentation/{pwm.txt => driver-api/pwm.rst}      |    0
 Documentation/driver-api/rapidio/index.rst         |   15 +
 .../rapidio/mport_cdev.rst}                        |   47 +-
 .../rapidio.txt => driver-api/rapidio/rapidio.rst} |   39 +-
 .../rio_cm.txt => driver-api/rapidio/rio_cm.rst}   |   66 +-
 .../sysfs.txt => driver-api/rapidio/sysfs.rst}     |    4 +
 .../tsi721.txt => driver-api/rapidio/tsi721.rst}   |   45 +-
 .../{rfkill.txt => driver-api/rfkill.rst}          |    0
 .../{ => driver-api}/serial/cyclades_z.rst         |    0
 Documentation/{ => driver-api}/serial/driver.rst   |    2 +-
 Documentation/{ => driver-api}/serial/index.rst    |    2 +-
 .../{ => driver-api}/serial/moxa-smartio.rst       |    0
 Documentation/{ => driver-api}/serial/n_gsm.rst    |    0
 Documentation/{ => driver-api}/serial/rocket.rst   |    0
 .../{ => driver-api}/serial/serial-iso7816.rst     |    0
 .../{ => driver-api}/serial/serial-rs485.rst       |    0
 Documentation/{ => driver-api}/serial/tty.rst      |    0
 .../{sgi-ioc4.txt => driver-api/sgi-ioc4.rst}      |    0
 Documentation/{SM501.txt => driver-api/sm501.rst}  |    0
 .../smsc_ece1099.rst}                              |    0
 .../{switchtec.txt => driver-api/switchtec.rst}    |    2 +-
 .../{sync_file.txt => driver-api/sync_file.rst}    |    0
 .../vfio-mediated-device.rst}                      |    2 +-
 Documentation/{vfio.txt => driver-api/vfio.rst}    |    0
 Documentation/{ => driver-api}/xilinx/eemi.rst     |    0
 Documentation/{ => driver-api}/xilinx/index.rst    |    1 -
 .../{xillybus.txt => driver-api/xillybus.rst}      |    0
 Documentation/{zorro.txt => driver-api/zorro.rst}  |    0
 Documentation/fault-injection/index.rst            |    2 +-
 Documentation/fb/fbcon.rst                         |    4 +-
 Documentation/fb/index.rst                         |    2 +-
 Documentation/fb/vesafb.rst                        |    2 +-
 Documentation/filesystems/nfs/nfsroot.txt          |    2 +-
 Documentation/filesystems/proc.txt                 |    2 +-
 .../filesystems/ramfs-rootfs-initramfs.txt         |    4 +-
 Documentation/filesystems/sysfs.txt                |    2 +-
 Documentation/filesystems/tmpfs.txt                |    2 +-
 Documentation/firmware-guide/acpi/enumeration.rst  |    2 +-
 Documentation/fpga/index.rst                       |    2 +-
 Documentation/hid/index.rst                        |    2 +-
 Documentation/hwmon/submitting-patches.rst         |    2 +-
 Documentation/ia64/{aliasing.txt => aliasing.rst}  |   73 +-
 Documentation/ia64/{efirtc.txt => efirtc.rst}      |  120 +-
 .../ia64/{err_inject.txt => err_inject.rst}        |  359 +++---
 Documentation/ia64/{fsys.txt => fsys.rst}          |  133 ++-
 Documentation/ia64/{README => ia64.rst}            |   26 +-
 Documentation/ia64/index.rst                       |   18 +
 .../ia64/{IRQ-redir.txt => irq-redir.rst}          |   31 +-
 Documentation/ia64/{mca.txt => mca.rst}            |   10 +-
 Documentation/ia64/{serial.txt => serial.rst}      |   36 +-
 Documentation/ia64/xen.rst                         |  206 ++++
 Documentation/ia64/xen.txt                         |  183 ---
 Documentation/ide/index.rst                        |    2 +-
 Documentation/iio/index.rst                        |    2 +-
 Documentation/index.rst                            |   32 +
 ...tching-up-ioctls.txt => botching-up-ioctls.rst} |    1 +
 Documentation/ioctl/cdrom.rst                      | 1233 ++++++++++++++++++++
 Documentation/ioctl/cdrom.txt                      |  967 ---------------
 Documentation/ioctl/{hdio.txt => hdio.rst}         |  835 ++++++++-----
 Documentation/ioctl/index.rst                      |   16 +
 .../{ioctl-decoding.txt => ioctl-decoding.rst}     |   13 +-
 Documentation/ioctl/ioctl-number.rst               |  361 ++++++
 Documentation/ioctl/ioctl-number.txt               |  351 ------
 Documentation/kbuild/index.rst                     |    2 +-
 Documentation/kbuild/issues.rst                    |   20 +-
 Documentation/kbuild/kbuild.rst                    |    3 +-
 Documentation/kbuild/kconfig-language.rst          |   12 +
 Documentation/kbuild/kconfig.rst                   |    8 +-
 Documentation/kbuild/makefiles.rst                 |    1 +
 Documentation/kernel-hacking/locking.rst           |    2 +-
 Documentation/leds/index.rst                       |    2 +-
 Documentation/livepatch/index.rst                  |    2 +-
 Documentation/locking/index.rst                    |   24 +
 .../{lockdep-design.txt => lockdep-design.rst}     |   51 +-
 Documentation/locking/lockstat.rst                 |  204 ++++
 Documentation/locking/lockstat.txt                 |  183 ---
 .../locking/{locktorture.txt => locktorture.rst}   |  105 +-
 .../locking/{mutex-design.txt => mutex-design.rst} |   26 +-
 .../{rt-mutex-design.txt => rt-mutex-design.rst}   |  139 ++-
 .../locking/{rt-mutex.txt => rt-mutex.rst}         |   30 +-
 .../locking/{spinlocks.txt => spinlocks.rst}       |   32 +-
 .../{ww-mutex-design.txt => ww-mutex-design.rst}   |   82 +-
 Documentation/m68k/index.rst                       |   17 +
 .../{kernel-options.txt => kernel-options.rst}     |  319 ++---
 Documentation/mic/index.rst                        |    2 -
 Documentation/netlabel/index.rst                   |    2 +-
 Documentation/networking/ip-sysctl.txt             |    2 +-
 Documentation/pcmcia/index.rst                     |    2 +-
 Documentation/pi-futex.txt                         |    2 +-
 Documentation/powerpc/firmware-assisted-dump.txt   |    2 +-
 Documentation/process/submit-checklist.rst         |    2 +-
 Documentation/pti/pti_intel_mid.txt                |   99 --
 Documentation/rbtree.txt                           |    6 +-
 Documentation/riscv/index.rst                      |    2 -
 Documentation/s390/debugging390.rst                |    2 +-
 Documentation/s390/index.rst                       |    2 -
 Documentation/s390/vfio-ccw.rst                    |    6 +-
 Documentation/scheduler/index.rst                  |    2 -
 Documentation/scheduler/sched-deadline.rst         |    2 +-
 Documentation/scheduler/sched-design-CFS.rst       |    2 +-
 Documentation/scheduler/sched-rt-group.rst         |    2 +-
 Documentation/security/index.rst                   |    5 +-
 .../security/{LSM.rst => lsm-development.rst}      |    0
 Documentation/{lsm.txt => security/lsm.rst}        |    0
 Documentation/{SAK.txt => security/sak.rst}        |    0
 .../{siphash.txt => security/siphash.rst}          |    0
 Documentation/security/tpm/index.rst               |    1 +
 .../tpm/{xen-tpmfront.txt => xen-tpmfront.rst}     |  105 +-
 Documentation/sparc/index.rst                      |    2 -
 Documentation/sysctl/abi.txt                       |   54 -
 Documentation/target/index.rst                     |    2 +-
 Documentation/timers/index.rst                     |    2 +-
 .../translations/it_IT/kernel-hacking/locking.rst  |    2 +-
 .../it_IT/process/submit-checklist.rst             |    2 +-
 Documentation/translations/zh_CN/arm/Booting       |    4 +-
 .../translations/zh_CN/arm/kernel_user_helpers.txt |    4 +-
 .../translations/zh_CN/filesystems/sysfs.txt       |    2 +-
 Documentation/translations/zh_CN/gpio.txt          |    4 +-
 Documentation/translations/zh_CN/oops-tracing.txt  |    4 +-
 .../zh_CN/process/submit-checklist.rst             |    2 +-
 .../{ => userspace-api}/accelerators/ocxl.rst      |    2 -
 Documentation/userspace-api/index.rst              |    1 +
 Documentation/vm/numa.rst                          |    4 +-
 Documentation/vm/page_migration.rst                |    2 +-
 Documentation/vm/unevictable-lru.rst               |    4 +-
 Documentation/w1/w1.netlink                        |    2 +-
 Documentation/watchdog/index.rst                   |    2 +-
 Documentation/x86/index.rst                        |    2 +
 .../{Intel-IOMMU.txt => x86/intel-iommu.rst}       |    0
 Documentation/{intel_txt.txt => x86/intel_txt.rst} |    0
 Documentation/x86/topology.rst                     |    2 +-
 Documentation/x86/x86_64/fake-numa-for-cpusets.rst |    4 +-
 Documentation/xtensa/{atomctl.txt => atomctl.rst}  |   13 +-
 Documentation/xtensa/{booting.txt => booting.rst}  |    5 +-
 Documentation/xtensa/index.rst                     |   12 +
 Documentation/xtensa/mmu.rst                       |  195 ++++
 Documentation/xtensa/mmu.txt                       |  189 ---
 MAINTAINERS                                        |   90 +-
 arch/arm/Kconfig                                   |    6 +-
 arch/arm/common/mcpm_entry.c                       |    2 +-
 arch/arm/common/mcpm_head.S                        |    2 +-
 arch/arm/common/vlock.S                            |    2 +-
 arch/arm/include/asm/setup.h                       |    2 +-
 arch/arm/include/uapi/asm/setup.h                  |    2 +-
 arch/arm/kernel/entry-armv.S                       |    2 +-
 arch/arm/mach-exynos/common.h                      |    2 +-
 arch/arm/mach-ixp4xx/Kconfig                       |   14 +-
 arch/arm/mach-s3c24xx/pm.c                         |    2 +-
 arch/arm/mm/Kconfig                                |    4 +-
 arch/arm/plat-samsung/Kconfig                      |    6 +-
 arch/arm/tools/mach-types                          |    2 +-
 arch/arm64/Kconfig                                 |    4 +-
 arch/arm64/kernel/kuser32.S                        |    2 +-
 arch/ia64/kernel/efi.c                             |    2 +-
 arch/ia64/kernel/fsys.S                            |    2 +-
 arch/ia64/mm/ioremap.c                             |    2 +-
 arch/ia64/pci/pci.c                                |    2 +-
 arch/mips/bmips/setup.c                            |    2 +-
 arch/parisc/Kconfig                                |    2 +-
 arch/sh/Kconfig                                    |    4 +-
 arch/sparc/Kconfig                                 |    2 +-
 arch/x86/Kconfig                                   |    8 +-
 arch/xtensa/include/asm/initialize_mmu.h           |    2 +-
 block/Kconfig                                      |    4 +-
 block/Kconfig.iosched                              |    2 +-
 block/bfq-iosched.c                                |    2 +-
 block/blk-integrity.c                              |    2 +-
 block/ioprio.c                                     |    2 +-
 block/mq-deadline.c                                |    2 +-
 block/partitions/Kconfig                           |    2 +-
 block/partitions/cmdline.c                         |    2 +-
 drivers/base/platform.c                            |    2 +-
 drivers/block/Kconfig                              |    8 +-
 drivers/block/floppy.c                             |    2 +-
 drivers/block/zram/Kconfig                         |    6 +-
 drivers/char/Kconfig                               |    6 +-
 drivers/char/hw_random/core.c                      |    2 +-
 drivers/crypto/sunxi-ss/sun4i-ss-cipher.c          |    2 +-
 drivers/crypto/sunxi-ss/sun4i-ss-core.c            |    2 +-
 drivers/crypto/sunxi-ss/sun4i-ss-hash.c            |    2 +-
 drivers/crypto/sunxi-ss/sun4i-ss.h                 |    2 +-
 drivers/dma-buf/Kconfig                            |    2 +-
 drivers/gpio/Kconfig                               |    2 +-
 drivers/gpio/gpio-cs5535.c                         |    2 +-
 drivers/gpu/drm/Kconfig                            |    2 +-
 drivers/gpu/drm/drm_ioctl.c                        |    2 +-
 drivers/gpu/drm/drm_modeset_lock.c                 |    2 +-
 drivers/input/touchscreen/sun4i-ts.c               |    2 +-
 drivers/md/Kconfig                                 |    2 +-
 drivers/md/dm-init.c                               |    2 +-
 drivers/md/dm-raid.c                               |    2 +-
 drivers/mtd/nand/raw/nand_ecc.c                    |    2 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |    2 +-
 drivers/nvdimm/Kconfig                             |    2 +-
 drivers/pci/switch/Kconfig                         |    2 +-
 drivers/perf/qcom_l3_pmu.c                         |    2 +-
 drivers/platform/x86/Kconfig                       |    8 +-
 drivers/platform/x86/dcdbas.c                      |    2 +-
 drivers/platform/x86/dell_rbu.c                    |    2 +-
 drivers/pnp/isapnp/Kconfig                         |    2 +-
 drivers/rapidio/Kconfig                            |    2 +-
 drivers/staging/unisys/Documentation/overview.txt  |    4 +-
 drivers/tty/Kconfig                                |    6 +-
 drivers/tty/serial/Kconfig                         |    2 +-
 drivers/tty/serial/ucc_uart.c                      |    2 +-
 drivers/vfio/Kconfig                               |    2 +-
 drivers/vfio/mdev/Kconfig                          |    2 +-
 drivers/w1/Kconfig                                 |    2 +-
 fs/proc/Kconfig                                    |    2 +-
 include/linux/cgroup-defs.h                        |    2 +-
 include/linux/connector.h                          |   63 +-
 include/linux/device.h                             |    2 +-
 include/linux/hw_random.h                          |    2 +-
 include/linux/lockdep.h                            |    2 +-
 include/linux/mutex.h                              |    2 +-
 include/linux/platform_device.h                    |    2 +-
 include/linux/rwsem.h                              |    2 +-
 include/linux/serial_core.h                        |    2 +-
 include/uapi/linux/bpf.h                           |    2 +-
 include/uapi/rdma/rdma_user_ioctl_cmds.h           |    2 +-
 init/Kconfig                                       |    6 +-
 kernel/cgroup/cpuset.c                             |    2 +-
 kernel/locking/mutex.c                             |    2 +-
 kernel/locking/rtmutex.c                           |    2 +-
 kernel/panic.c                                     |    2 +-
 lib/Kconfig.debug                                  |    4 +-
 mm/swap.c                                          |    2 +-
 samples/Kconfig                                    |    2 +-
 scripts/coccinelle/free/devm_free.cocci            |    2 +-
 scripts/gcc-plugins/Kconfig                        |    2 +-
 security/Kconfig                                   |    2 +-
 security/device_cgroup.c                           |    2 +-
 tools/include/uapi/linux/bpf.h                     |    2 +-
 tools/testing/selftests/zram/README                |    2 +-
 usr/Kconfig                                        |    2 +-
 559 files changed, 10527 insertions(+), 7593 deletions(-)
 rename Documentation/{logo.txt => COPYING-logo} (100%)
 rename Documentation/accounting/{cgroupstats.txt => cgroupstats.rst} (77%)
 rename Documentation/accounting/{delay-accounting.txt => delay-accounting.rst} (77%)
 create mode 100644 Documentation/accounting/index.rst
 rename Documentation/accounting/{psi.txt => psi.rst} (91%)
 rename Documentation/accounting/{taskstats-struct.txt => taskstats-struct.rst} (78%)
 rename Documentation/accounting/{taskstats.txt => taskstats.rst} (95%)
 rename Documentation/{ => admin-guide}/aoe/aoe.rst (97%)
 rename Documentation/{ => admin-guide}/aoe/autoload.sh (100%)
 rename Documentation/{ => admin-guide}/aoe/examples.rst (100%)
 rename Documentation/{ => admin-guide}/aoe/index.rst (95%)
 rename Documentation/{ => admin-guide}/aoe/status.sh (100%)
 rename Documentation/{ => admin-guide}/aoe/todo.rst (100%)
 rename Documentation/{ => admin-guide}/aoe/udev-install.sh (100%)
 rename Documentation/{ => admin-guide}/aoe/udev.txt (93%)
 rename Documentation/{ => admin-guide}/blockdev/drbd/DRBD-8.3-data-packets.svg (100%)
 rename Documentation/{ => admin-guide}/blockdev/drbd/DRBD-data-packets.svg (100%)
 rename Documentation/{ => admin-guide}/blockdev/drbd/conn-states-8.dot (100%)
 rename Documentation/{blockdev/drbd/data-structure-v9.txt => admin-guide/blockdev/drbd/data-structure-v9.rst} (94%)
 rename Documentation/{ => admin-guide}/blockdev/drbd/disk-states-8.dot (100%)
 rename Documentation/{ => admin-guide}/blockdev/drbd/drbd-connection-state-overview.dot (100%)
 create mode 100644 Documentation/admin-guide/blockdev/drbd/figures.rst
 rename Documentation/{blockdev/drbd/README.txt => admin-guide/blockdev/drbd/index.rst} (55%)
 rename Documentation/{ => admin-guide}/blockdev/drbd/node-states-8.dot (99%)
 rename Documentation/{blockdev/floppy.txt => admin-guide/blockdev/floppy.rst} (81%)
 create mode 100644 Documentation/admin-guide/blockdev/index.rst
 rename Documentation/{blockdev/nbd.txt => admin-guide/blockdev/nbd.rst} (96%)
 rename Documentation/{blockdev/paride.txt => admin-guide/blockdev/paride.rst} (81%)
 rename Documentation/{blockdev/ramdisk.txt => admin-guide/blockdev/ramdisk.rst} (84%)
 rename Documentation/{blockdev/zram.txt => admin-guide/blockdev/zram.rst} (76%)
 rename Documentation/{btmrvl.txt => admin-guide/btmrvl.rst} (100%)
 rename Documentation/{ => admin-guide}/cgroup-v1/blkio-controller.rst (100%)
 rename Documentation/{ => admin-guide}/cgroup-v1/cgroups.rst (99%)
 rename Documentation/{ => admin-guide}/cgroup-v1/cpuacct.rst (100%)
 rename Documentation/{ => admin-guide}/cgroup-v1/cpusets.rst (99%)
 rename Documentation/{ => admin-guide}/cgroup-v1/devices.rst (100%)
 rename Documentation/{ => admin-guide}/cgroup-v1/freezer-subsystem.rst (100%)
 rename Documentation/{ => admin-guide}/cgroup-v1/hugetlb.rst (100%)
 rename Documentation/{ => admin-guide}/cgroup-v1/index.rst (97%)
 rename Documentation/{ => admin-guide}/cgroup-v1/memcg_test.rst (98%)
 rename Documentation/{ => admin-guide}/cgroup-v1/memory.rst (100%)
 rename Documentation/{ => admin-guide}/cgroup-v1/net_cls.rst (100%)
 rename Documentation/{ => admin-guide}/cgroup-v1/net_prio.rst (100%)
 rename Documentation/{ => admin-guide}/cgroup-v1/pids.rst (100%)
 rename Documentation/{ => admin-guide}/cgroup-v1/rdma.rst (100%)
 rename Documentation/{clearing-warn-once.txt => admin-guide/clearing-warn-once.rst} (100%)
 rename Documentation/{cpu-load.txt => admin-guide/cpu-load.rst} (100%)
 rename Documentation/{cputopology.txt => admin-guide/cputopology.rst} (100%)
 rename Documentation/{ => admin-guide}/device-mapper/cache-policies.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/cache.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/delay.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/dm-crypt.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/dm-dust.txt (100%)
 rename Documentation/{ => admin-guide}/device-mapper/dm-flakey.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/dm-init.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/dm-integrity.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/dm-io.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/dm-log.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/dm-queue-length.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/dm-raid.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/dm-service-time.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/dm-uevent.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/dm-zoned.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/era.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/index.rst (98%)
 rename Documentation/{ => admin-guide}/device-mapper/kcopyd.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/linear.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/log-writes.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/persistent-data.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/snapshot.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/statistics.rst (98%)
 rename Documentation/{ => admin-guide}/device-mapper/striped.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/switch.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/thin-provisioning.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/unstriped.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/verity.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/writecache.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/zero.rst (100%)
 rename Documentation/{efi-stub.txt => admin-guide/efi-stub.rst} (100%)
 rename Documentation/{ => admin-guide}/gpio/index.rst (78%)
 rename Documentation/{ => admin-guide}/gpio/sysfs.rst (100%)
 rename Documentation/{highuid.txt => admin-guide/highuid.rst} (100%)
 rename Documentation/{hw_random.txt => admin-guide/hw_random.rst} (100%)
 rename Documentation/{iostats.txt => admin-guide/iostats.rst} (100%)
 rename Documentation/{ => admin-guide}/kdump/gdbmacros.txt (100%)
 rename Documentation/{ => admin-guide}/kdump/index.rst (97%)
 rename Documentation/{ => admin-guide}/kdump/kdump.rst (100%)
 rename Documentation/{ => admin-guide}/kdump/vmcoreinfo.rst (100%)
 rename Documentation/{kernel-per-CPU-kthreads.txt => admin-guide/kernel-per-CPU-kthreads.rst} (99%)
 rename Documentation/{laptops/asus-laptop.txt => admin-guide/laptops/asus-laptop.rst} (84%)
 rename Documentation/{laptops/disk-shock-protection.txt => admin-guide/laptops/disk-shock-protection.rst} (91%)
 create mode 100644 Documentation/admin-guide/laptops/index.rst
 rename Documentation/{laptops/laptop-mode.txt => admin-guide/laptops/laptop-mode.rst} (62%)
 rename Documentation/{ => admin-guide}/laptops/lg-laptop.rst (99%)
 rename Documentation/{laptops/sony-laptop.txt => admin-guide/laptops/sony-laptop.rst} (85%)
 rename Documentation/{laptops/sonypi.txt => admin-guide/laptops/sonypi.rst} (82%)
 rename Documentation/{laptops/thinkpad-acpi.txt => admin-guide/laptops/thinkpad-acpi.rst} (89%)
 rename Documentation/{laptops/toshiba_haps.txt => admin-guide/laptops/toshiba_haps.rst} (58%)
 rename Documentation/{auxdisplay/lcd-panel-cgram.txt => admin-guide/lcd-panel-cgram.rst} (89%)
 rename Documentation/{ldm.txt => admin-guide/ldm.rst} (100%)
 rename Documentation/{lockup-watchdogs.txt => admin-guide/lockup-watchdogs.rst} (100%)
 rename Documentation/{cma/debugfs.txt => admin-guide/mm/cma_debugfs.rst} (92%)
 rename Documentation/{namespaces/compatibility-list.txt => admin-guide/namespaces/compatibility-list.rst} (86%)
 create mode 100644 Documentation/admin-guide/namespaces/index.rst
 rename Documentation/{namespaces/resource-control.txt => admin-guide/namespaces/resource-control.rst} (89%)
 rename Documentation/{numastat.txt => admin-guide/numastat.rst} (100%)
 rename Documentation/{perf/arm-ccn.txt => admin-guide/perf/arm-ccn.rst} (86%)
 rename Documentation/{perf/arm_dsu_pmu.txt => admin-guide/perf/arm_dsu_pmu.rst} (92%)
 rename Documentation/{perf/hisi-pmu.txt => admin-guide/perf/hisi-pmu.rst} (73%)
 create mode 100644 Documentation/admin-guide/perf/index.rst
 rename Documentation/{perf/qcom_l2_pmu.txt => admin-guide/perf/qcom_l2_pmu.rst} (94%)
 rename Documentation/{perf/qcom_l3_pmu.txt => admin-guide/perf/qcom_l3_pmu.rst} (93%)
 rename Documentation/{perf/thunderx2-pmu.txt => admin-guide/perf/thunderx2-pmu.rst} (73%)
 rename Documentation/{perf/xgene-pmu.txt => admin-guide/perf/xgene-pmu.rst} (96%)
 rename Documentation/{pnp.txt => admin-guide/pnp.rst} (100%)
 rename Documentation/{driver-api => admin-guide}/rapidio.rst (100%)
 rename Documentation/{rtc.txt => admin-guide/rtc.rst} (100%)
 rename Documentation/{svga.txt => admin-guide/svga.rst} (100%)
 create mode 100644 Documentation/admin-guide/sysctl/abi.rst
 rename Documentation/{sysctl/fs.txt => admin-guide/sysctl/fs.rst} (77%)
 rename Documentation/{sysctl/README => admin-guide/sysctl/index.rst} (78%)
 rename Documentation/{sysctl/kernel.txt => admin-guide/sysctl/kernel.rst} (79%)
 rename Documentation/{sysctl/net.txt => admin-guide/sysctl/net.rst} (85%)
 rename Documentation/{sysctl/sunrpc.txt => admin-guide/sysctl/sunrpc.rst} (62%)
 rename Documentation/{sysctl/user.txt => admin-guide/sysctl/user.rst} (77%)
 rename Documentation/{sysctl/vm.txt => admin-guide/sysctl/vm.rst} (84%)
 rename Documentation/{video-output.txt => admin-guide/video-output.rst} (100%)
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
 rename Documentation/{gcc-plugins.txt => core-api/gcc-plugins.rst} (100%)
 create mode 100644 Documentation/driver-api/backlight/lp855x-driver.rst
 rename Documentation/{bt8xxgpio.txt => driver-api/bt8xxgpio.rst} (100%)
 rename Documentation/{connector/connector.txt => driver-api/connector.rst} (57%)
 rename Documentation/{console/console.txt => driver-api/console.rst} (79%)
 rename Documentation/{dcdbas.txt => driver-api/dcdbas.rst} (100%)
 rename Documentation/{dell_rbu.txt => driver-api/dell_rbu.rst} (100%)
 rename Documentation/{ => driver-api}/driver-model/binding.rst (100%)
 rename Documentation/{ => driver-api}/driver-model/bus.rst (100%)
 rename Documentation/{ => driver-api}/driver-model/class.rst (100%)
 rename Documentation/{ => driver-api}/driver-model/design-patterns.rst (100%)
 rename Documentation/{ => driver-api}/driver-model/device.rst (100%)
 rename Documentation/{ => driver-api}/driver-model/devres.rst (100%)
 rename Documentation/{ => driver-api}/driver-model/driver.rst (100%)
 rename Documentation/{ => driver-api}/driver-model/index.rst (96%)
 rename Documentation/{ => driver-api}/driver-model/overview.rst (100%)
 rename Documentation/{ => driver-api}/driver-model/platform.rst (100%)
 rename Documentation/{ => driver-api}/driver-model/porting.rst (99%)
 rename Documentation/{early-userspace/buffer-format.txt => driver-api/early-userspace/buffer-format.rst} (91%)
 rename Documentation/{early-userspace/README => driver-api/early-userspace/early_userspace_support.rst} (99%)
 create mode 100644 Documentation/driver-api/early-userspace/index.rst
 rename Documentation/{EDID/howto.rst => driver-api/edid.rst} (98%)
 rename Documentation/{eisa.txt => driver-api/eisa.rst} (98%)
 rename Documentation/{interconnect => driver-api}/interconnect.rst (99%)
 rename Documentation/{isa.txt => driver-api/isa.rst} (100%)
 rename Documentation/{isapnp.txt => driver-api/isapnp.rst} (100%)
 rename Documentation/{lightnvm/pblk.txt => driver-api/lightnvm-pblk.rst} (100%)
 create mode 100644 Documentation/driver-api/md/index.rst
 rename Documentation/{md/md-cluster.txt => driver-api/md/md-cluster.rst} (68%)
 rename Documentation/{md/raid5-cache.txt => driver-api/md/raid5-cache.rst} (92%)
 rename Documentation/{md/raid5-ppl.txt => driver-api/md/raid5-ppl.rst} (98%)
 create mode 100644 Documentation/driver-api/memory-devices/index.rst
 rename Documentation/{memory-devices/ti-emif.txt => driver-api/memory-devices/ti-emif.rst} (80%)
 rename Documentation/{bus-devices/ti-gpmc.txt => driver-api/memory-devices/ti-gpmc.rst} (58%)
 rename Documentation/{men-chameleon-bus.txt => driver-api/men-chameleon-bus.rst} (100%)
 create mode 100644 Documentation/driver-api/mmc/index.rst
 rename Documentation/{mmc/mmc-async-req.txt => driver-api/mmc/mmc-async-req.rst} (75%)
 rename Documentation/{mmc/mmc-dev-attrs.txt => driver-api/mmc/mmc-dev-attrs.rst} (73%)
 rename Documentation/{mmc/mmc-dev-parts.txt => driver-api/mmc/mmc-dev-parts.rst} (83%)
 rename Documentation/{mmc/mmc-tools.txt => driver-api/mmc/mmc-tools.rst} (92%)
 create mode 100644 Documentation/driver-api/mtd/index.rst
 rename Documentation/{mtd/intel-spi.txt => driver-api/mtd/intel-spi.rst} (71%)
 rename Documentation/{mtd/nand_ecc.txt => driver-api/mtd/nand_ecc.rst} (67%)
 rename Documentation/{mtd/spi-nor.txt => driver-api/mtd/spi-nor.rst} (94%)
 create mode 100644 Documentation/driver-api/nfc/index.rst
 rename Documentation/{nfc/nfc-hci.txt => driver-api/nfc/nfc-hci.rst} (71%)
 rename Documentation/{nfc/nfc-pn544.txt => driver-api/nfc/nfc-pn544.rst} (82%)
 rename Documentation/{ntb.txt => driver-api/ntb.rst} (100%)
 rename Documentation/{nvdimm/btt.txt => driver-api/nvdimm/btt.rst} (71%)
 create mode 100644 Documentation/driver-api/nvdimm/index.rst
 rename Documentation/{nvdimm/nvdimm.txt => driver-api/nvdimm/nvdimm.rst} (60%)
 rename Documentation/{nvdimm/security.txt => driver-api/nvdimm/security.rst} (99%)
 rename Documentation/{nvmem/nvmem.txt => driver-api/nvmem.rst} (62%)
 rename Documentation/{parport-lowlevel.txt => driver-api/parport-lowlevel.rst} (100%)
 create mode 100644 Documentation/driver-api/phy/index.rst
 rename Documentation/{phy.txt => driver-api/phy/phy.rst} (100%)
 rename Documentation/{phy/samsung-usb2.txt => driver-api/phy/samsung-usb2.rst} (77%)
 create mode 100644 Documentation/driver-api/pti_intel_mid.rst
 rename Documentation/{pwm.txt => driver-api/pwm.rst} (100%)
 create mode 100644 Documentation/driver-api/rapidio/index.rst
 rename Documentation/{rapidio/mport_cdev.txt => driver-api/rapidio/mport_cdev.rst} (84%)
 rename Documentation/{rapidio/rapidio.txt => driver-api/rapidio/rapidio.rst} (97%)
 rename Documentation/{rapidio/rio_cm.txt => driver-api/rapidio/rio_cm.rst} (76%)
 rename Documentation/{rapidio/sysfs.txt => driver-api/rapidio/sysfs.rst} (75%)
 rename Documentation/{rapidio/tsi721.txt => driver-api/rapidio/tsi721.rst} (79%)
 rename Documentation/{rfkill.txt => driver-api/rfkill.rst} (100%)
 rename Documentation/{ => driver-api}/serial/cyclades_z.rst (100%)
 rename Documentation/{ => driver-api}/serial/driver.rst (99%)
 rename Documentation/{ => driver-api}/serial/index.rst (90%)
 rename Documentation/{ => driver-api}/serial/moxa-smartio.rst (100%)
 rename Documentation/{ => driver-api}/serial/n_gsm.rst (100%)
 rename Documentation/{ => driver-api}/serial/rocket.rst (100%)
 rename Documentation/{ => driver-api}/serial/serial-iso7816.rst (100%)
 rename Documentation/{ => driver-api}/serial/serial-rs485.rst (100%)
 rename Documentation/{ => driver-api}/serial/tty.rst (100%)
 rename Documentation/{sgi-ioc4.txt => driver-api/sgi-ioc4.rst} (100%)
 rename Documentation/{SM501.txt => driver-api/sm501.rst} (100%)
 rename Documentation/{smsc_ece1099.txt => driver-api/smsc_ece1099.rst} (100%)
 rename Documentation/{switchtec.txt => driver-api/switchtec.rst} (97%)
 rename Documentation/{sync_file.txt => driver-api/sync_file.rst} (100%)
 rename Documentation/{vfio-mediated-device.txt => driver-api/vfio-mediated-device.rst} (99%)
 rename Documentation/{vfio.txt => driver-api/vfio.rst} (100%)
 rename Documentation/{ => driver-api}/xilinx/eemi.rst (100%)
 rename Documentation/{ => driver-api}/xilinx/index.rst (94%)
 rename Documentation/{xillybus.txt => driver-api/xillybus.rst} (100%)
 rename Documentation/{zorro.txt => driver-api/zorro.rst} (100%)
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
 rename Documentation/ioctl/{botching-up-ioctls.txt => botching-up-ioctls.rst} (99%)
 create mode 100644 Documentation/ioctl/cdrom.rst
 delete mode 100644 Documentation/ioctl/cdrom.txt
 rename Documentation/ioctl/{hdio.txt => hdio.rst} (54%)
 create mode 100644 Documentation/ioctl/index.rst
 rename Documentation/ioctl/{ioctl-decoding.txt => ioctl-decoding.rst} (54%)
 create mode 100644 Documentation/ioctl/ioctl-number.rst
 delete mode 100644 Documentation/ioctl/ioctl-number.txt
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
 delete mode 100644 Documentation/pti/pti_intel_mid.txt
 rename Documentation/security/{LSM.rst => lsm-development.rst} (100%)
 rename Documentation/{lsm.txt => security/lsm.rst} (100%)
 rename Documentation/{SAK.txt => security/sak.rst} (100%)
 rename Documentation/{siphash.txt => security/siphash.rst} (100%)
 rename Documentation/security/tpm/{xen-tpmfront.txt => xen-tpmfront.rst} (66%)
 delete mode 100644 Documentation/sysctl/abi.txt
 rename Documentation/{ => userspace-api}/accelerators/ocxl.rst (99%)
 rename Documentation/{Intel-IOMMU.txt => x86/intel-iommu.rst} (100%)
 rename Documentation/{intel_txt.txt => x86/intel_txt.rst} (100%)
 rename Documentation/xtensa/{atomctl.txt => atomctl.rst} (81%)
 rename Documentation/xtensa/{booting.txt => booting.rst} (91%)
 create mode 100644 Documentation/xtensa/index.rst
 create mode 100644 Documentation/xtensa/mmu.rst
 delete mode 100644 Documentation/xtensa/mmu.txt

