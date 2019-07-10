Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB94BC74A21
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 13:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8363B2064B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 13:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562765523;
	bh=RFeNU46CT7rBPxP3Pxbbo7qgT8KD8Rw65UUEjCv0Y30=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=T3BJxdwCtUvnCakg356Tot6eZKJuooDAGUff2mjfjYlIKrXBk5RN97nQHKswCQe0j
	 yc8S5PpDDysncOFGEjEzdyrXa0NsJkdYgjv7ibSKcpsiMaXQ1MaLKvKp6AcvO+0/K1
	 8esUVWrdlUYOX6vpNrsol/e1iCOIAbKTOW05Wlro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfGJNcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 09:32:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbfGJNcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 09:32:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBEAA2064B;
        Wed, 10 Jul 2019 13:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562765518;
        bh=RFeNU46CT7rBPxP3Pxbbo7qgT8KD8Rw65UUEjCv0Y30=;
        h=Date:From:To:Cc:Subject:From;
        b=oSHFJXW77kCJfnnZGNZW+DfLZ/9X4+++AsteXbItOQ5f2MESZzNQOfY8rHL7HJd3K
         WM73YfETtFQVc/yIKWxjFlZ9PgXh70Uagnu2djcG3abARctPXMyUYurhZNNXz9rJFp
         0gmojBVRko7S4/GOXgm7VxME/bFYBgBHPGfI2e+k=
Date:   Wed, 10 Jul 2019 15:31:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver patches for 5.3-rc1
Message-ID: <20190710133156.GA23980@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 4b972a01a7da614b4796475f933094751a295a2f:

  Linux 5.2-rc6 (2019-06-22 16:01:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.3-rc1

for you to fetch changes up to 2f4281f4dce12440727ab770683cfb83eab62a26:

  Merge tag 'soundwire-5.3-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire into char-misc-next (2019-07-05 08:15:08 +0200)

----------------------------------------------------------------
Char / Misc driver patches for 5.3-rc1

Here is the "large" pull request for char and misc and other assorted
smaller driver subsystems for 5.3-rc1.

It seems that this tree is becoming the funnel point of lots of smaller
driver subsystems, which is fine for me, but that's why it is getting
larger over time and does not just contain stuff under drivers/char/ and
drivers/misc.

Lots of small updates all over the place here from different driver
subsystems:
  - habana driver updates
  - coresight driver updates
  - documentation file movements and updates
  - Android binder fixes and updates
  - extcon driver updates
  - google firmware driver updates
  - fsi driver updates
  - smaller misc and char driver updates
  - soundwire driver updates
  - nvmem driver updates
  - w1 driver fixes

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Tull (1):
      MAINTAINERS: fpga: hand off maintainership to Moritz

Alastair D'Silva (1):
      ocxl: Allow contexts to be attached with a NULL mm

Alexander Shishkin (5):
      intel_th: msu: Fix single mode with disabled IOMMU
      intel_th: pci: Add Ice Lake NNPI support
      intel_th: msu: Support multipage blocks
      intel_th: msu: Split sgt array and pointer in multiwindow mode
      intel_th: msu: Start read iterator from a non-empty window

Arnd Bergmann (1):
      coresight: platform: add OF/APCI dependency

Bartlomiej Zolnierkiewicz (1):
      misc: remove redundant 'default n' from Kconfig-s

Bryan O'Donoghue (5):
      nvmem: imx-ocotp: Elongate OCOTP_CTRL ADDR field to eight bits
      nvmem: imx-ocotp: Ensure WAIT bits are preserved when setting timing
      nvmem: imx-ocotp: Change TIMING calculation to u-boot algorithm
      nvmem: imx-ocotp: Add i.MX8MM support
      dt-bindings: imx-ocotp: Add i.MX8MM compatible

Charles Keepax (1):
      extcon: arizona: Correct error handling on regmap_update_bits_check

Chengguang Xu (1):
      chardev: set variable ret to -EBUSY before checking minor range overlap

Dalit Ben Zoor (3):
      habanalabs: make tpc registers secured
      habanalabs: clear sobs and monitors in context switch
      habanalabs: restore unsecured registers default values

Dan Carpenter (1):
      coresight: Potential uninitialized variable in probe()

Ding Xiang (1):
      slimbus: remove redundant dev_err message

Dragan Cvetic (3):
      dt-bindings: xilinx-sdfec: Add SDFEC binding
      misc: xilinx-sdfec: add core driver
      misc: xilinx_sdfec: Add CCF support

Eddie James (2):
      OCC: FSI and hwmon: Add sequence numbering
      fsi: sbefifo: Don't fail operations when in SBE IPL state

Enrico Weigelt (1):
      drivers: fpga: Kconfig: pedantic cleanups

Fabio Estevam (1):
      nvmem: Broaden the selection of NVMEM_SNVS_LPGPR

Greg Kroah-Hartman (7):
      Merge 5.2-rc4 into char-misc-next
      eeprom: idt_89hpesx: remove unneeded csr_file variable
      Merge 5.2-rc6 into char-misc-next
      Merge tag 'extcon-next-for-5.3' of git://git.kernel.org/.../chanwoo/extcon into char-misc-next
      Merge tag 'fsi-for-5.3' of git://git.kernel.org/.../joel/fsi into char-misc-next
      Merge tag 'misc-habanalabs-next-2019-07-04' of git://people.freedesktop.org/~gabbayo/linux into char-misc-next
      Merge tag 'soundwire-5.3-rc1' of git://git.kernel.org/.../vkoul/soundwire into char-misc-next

Jan Kotas (1):
      soundwire: cdns: Fix compilation error on arm64

Jean Delvare (2):
      eeprom: ee1004: Move selected page detection to a separate function
      eeprom: ee1004: Deal with nack on page selection

Jeremy Kerr (1):
      fsi/core: Fix error paths on CFAM init

Joel Stanley (1):
      MAINTAINERS: Add FSI subsystem

Jolly Shah (1):
      firmware: xilinx: zynqmp: Remove unused macro

Jonathan Corbet (1):
      slimbus: fix kerneldoc comments

Kees Cook (1):
      lkdtm: Check for SMEP clearing protections

Kefeng Wang (1):
      misc: mic: scif: fix potential double free of scif_dev

Leonard Crestez (1):
      nvmem: imx-ocotp: imx8mq is compatible with imx6 not imx7

Linus Walleij (1):
      misc: fsa9480: Delete this driver

Mariusz Bialonczyk (5):
      w1: ds2413: output_write() cosmetic fixes / simplify
      w1: ds2413: add retry support to state_read()
      w1: ds2413: when the slave is not responding during read, select it again
      w1: ds2413: fix state byte comparision
      w1: ds2805: rename w1_family struct, fixing c-p typo

Mathieu Poirier (6):
      coresight: etb10: Properly set AUX buffer head in snapshot mode
      coresight: tmc-etr: Properly set AUX buffer head in snapshot mode
      coresight: tmc-etf: Properly set AUX buffer head in snapshot mode
      coresight: tmc-etf: Fix snapshot mode update function
      coresight: perf: Don't set the truncated flag in snapshot mode
      coresight: Use coresight device names for sinks in PMU attribute

Mauro Carvalho Chehab (2):
      docs: soundwire: locking: fix tags for a code-block
      docs: misc-devices: convert files without extension to ReST

Maxime Ripard (1):
      dt-bindings: nvmem: Convert Allwinner SID to a schema

Nadav Amit (4):
      mm/balloon_compaction: List interfaces
      vmw_balloon: Compaction support
      vmw_balloon: Add memory shrinker
      vmw_balloon: Split refused pages

Nathan Chancellor (1):
      misc: sgi-xp: Properly initialize buf in xpc_get_rsvd_page_pa

Naveen Kumar Parna (3):
      char: misc: Move EXPORT_SYMBOL immediately next to the functions/varibles
      bsr: do not use assignment in if condition
      bsr: "foo * bar" should be "foo *bar"

Nick Desaulniers (1):
      lkdtm: support llvm-objcopy

Nishad Kamdar (1):
      fsi: cf-fsi-fw: Use the correct style for SPDX License Identifier

Oded Gabbay (20):
      habanalabs: improve a couple of error messages
      habanalabs: force user to set device debug mode
      habanalabs: remove dead code in habanalabs_drv.c
      habanalabs: check to load F/W before boot status
      habanalabs: remove redundant CB size adjustment
      habanalabs: remove redundant memory clear
      habanalabs: change polling functions to macros
      habanalabs: pass device pointer to asic-specific function
      habanalabs: support device memory memset > 4GB
      habanalabs: don't limit packet size for device CPU
      habanalabs: remove simulator dedicated code
      habanalabs: add rate-limit to an error message
      docs/habanalabs: update text for some entries in sysfs
      habanalabs: initialize device CPU queues after MMU init
      habanalabs: de-couple MMU and VM module initialization
      habanalabs: initialize MMU context for driver
      habanalabs: add MMU mappings for Goya CPU
      habanalabs: set Goya CPU to use ASIC MMU
      habanalabs: remove DMA mask hack for Goya
      habanalabs: add WARN in case of bad MMU mapping

Omer Shpigelman (4):
      habanalabs: remove redundant CPU checks
      habanalabs: minor documentation and prints fixes
      habanalabs: increase PCI ELBI timeout for Palladium
      habanalabs: print event name for fatal and non-RAZWI events

Pankaj Bansal (2):
      dt-bindings: add register based devices' mux controller DT bindings
      mux: mmio: add generic regmap bitfield-based multiplexer

Paul Cercueil (4):
      dt-bindings: memory: jz4780: Add compatible string for JZ4740 SoC
      memory: Kconfig: Drop dependency on MACH_JZ4780 for jz4780
      memory: jz4780-nemc: Reduce size of const array
      memory: jz4780_nemc: Add support for the JZ4740

Peng Fan (2):
      dt-bindings: fsl: scu: add ocotp binding
      nvmem: imx: add i.MX8 nvmem driver

Peter Zijlstra (1):
      VMCI: Fixup atomic64_t abuse

Pierre-Louis Bossart (15):
      soundwire: intel: filter SoundWire controller device search
      soundwire: mipi_disco: fix master/link error
      soundwire: add port-related definitions
      soundwire: remove master data port properties
      soundwire: mipi-disco: remove master_count property for masters
      soundwire: rename 'freq' fields
      soundwire: mipi-disco: fix clock stop modes
      soundwire: clarify comment
      soundwire: rename/clarify MIPI DisCo properties
      soundwire: cadence_master: use rate_limited dynamic debug
      soundwire: cadence_master: log Slave status mask on errors
      soundwire: cadence_master: check the number of bidir PDIs
      soundwire: Intel: add log for number of PCM and PDM PDIs
      soundwire: fix typo in comments
      soundwire: intel_init: add checks on link numbers

Randy Dunlap (1):
      extcon: fsa9480: Fix Kconfig warning and build errors

Sai Prakash Ranjan (2):
      dt-bindings: coresight: Change CPU phandle to required property
      coresight: Do not default to CPU0 for missing CPU phandle

Shaokun Zhang (1):
      intel_th: msu: Fix unused variable warning on arm64 platform

Srinivas Kandagatla (2):
      slimbus: core: generate uevent for non-dt only
      soundwire: add module_sdw_driver helper macro

Stephen Boyd (5):
      firmware: google: Add a module_coreboot_driver() macro and use it
      firmware: google: memconsole: Use devm_memremap()
      firmware: google: memconsole: Drop __iomem on memremap memory
      firmware: google: memconsole: Drop global func pointer
      firmware: google: coreboot: Drop unnecessary headers

Suzuki K Poulose (36):
      coresight: funnel: Clean up device book keeping
      coresight: replicator: Cleanup device tracking
      coresight: tmc: Clean up device specific data
      coresight: catu: Cleanup device specific data
      coresight: tpiu: Clean up device specific data
      coresight: stm: Cleanup device specific data
      coresight: etm: Clean up device specific data
      coresight: etb10: Clean up device specific data
      coresight: etm3x: Rearrange cp14 access detection
      coresight: stm: Rearrange probing the stimulus area
      coresight: tmc-etr: Rearrange probing default buffer size
      coresight: Rename of_coresight to coresight-platform
      coresight: platform: Make memory allocation helper generic
      coresight: Make sure device uses DT for obsolete compatible check
      coresight: Introduce generic platform data helper
      coresight: Make device to CPU mapping generic
      coresight: Remove cpu field from platform data
      coresight: Remove name from platform description
      coresight: Cleanup coresight_remove_conns
      coresight: Reuse platform data structure for connection tracking
      coresight: Rearrange platform data probing
      coresight: Add support for releasing platform specific data
      coresight: platform: Use fwnode handle for device search
      coresight: Use fwnode handle instead of device names
      coresight: Use platform agnostic names
      coresight: stm: ACPI support for parsing stimulus base
      coresight: Support for ACPI bindings
      coresight: acpi: Support for AMBA components
      coresight: acpi: Support for platform devices
      coresight: Add dummy definition for of_coresight_get_cpu()
      coresight: tmc-etr: Do not call smp_processor_id() from preemptible
      coresight: tmc-etr: alloc_perf_buf: Do not call smp_processor_id from preemptible
      coresight: tmc-etf: Do not call smp_processor_id from preemptible
      coresight: etb10: Do not call smp_processor_id from preemptible
      coresight: etm3x: Smatch: Fix potential NULL pointer dereference
      coresight: tmc: Smatch: Fix potential NULL pointer dereference

Takashi Iwai (3):
      fonts: Fix coding style
      fonts: Use BUILD_BUG_ON() for checking empty font table
      fonts: Prefer a bigger font for high resolution screens

Todd Kjos (2):
      binder: fix memory leak in error path
      binder: return errors from buffer copy functions

Tomas Winkler (7):
      mei: docs: move documentation under driver-api
      mei: docs: move iamt docs to a iamt.rst file
      mei: docs: update mei client bus documentation.
      mei: docs: add a short description for nfc behind mei
      mei: docs: add hdcp documentation
      mei: docs: fix broken links in iamt documentation.
      mei: docs: update mei documentation

Tomasz Figa (2):
      dt-bindings: extcon: Add support for fsa9480 switch
      extcon: Add fsa9480 extcon driver

Tomer Tayar (4):
      habanalabs: Allow accessing host mapped addresses via debugfs
      habanalabs: Update the device idle check
      habanalabs: Add debugfs node for engines status
      habanalabs: Add busy engines bitmask to HW idle IOCTL

Vishnu DASA (1):
      VMCI: Fix integer overflow in VMCI handle arrays

Vitaly Lubart (1):
      mei: Convert to use DEFINE_SHOW_ATTRIBUTE macro

Wei Yongjun (1):
      coresight: replicator: Add terminate entry for acpi_device_id tables

Wolfram Sang (3):
      misc: isl29003: simplify getting the adapter of a client
      misc: tsl2550: simplify getting the adapter of a client
      misc: fsa9480: simplify getting the adapter of a client

Wu Hao (3):
      fpga: dfl-fme-mgr: fix FME_PR_INTFC_ID register address.
      fpga: dfl: fme: remove copy_to_user() in ioctl for PR
      fpga: dfl: fme: align PR buffer size per PR datawidth

YueHaibing (2):
      counter: 104-quad-8: Make quad8_ops static
      intel_th: msu: Remove set but not used variable 'last'

 .../ABI/testing/debugfs-driver-habanalabs          |  18 +-
 Documentation/ABI/testing/sysfs-driver-habanalabs  |  42 +-
 .../bindings/arm/coresight-cpu-debug.txt           |   4 +-
 .../devicetree/bindings/arm/coresight.txt          |   8 +-
 .../devicetree/bindings/arm/freescale/fsl,scu.txt  |  22 +
 .../devicetree/bindings/extcon/extcon-fsa9480.txt  |  19 +
 .../memory-controllers/ingenic,jz4780-nemc.txt     |   1 +
 .../devicetree/bindings/misc/xlnx,sd-fec.txt       |  58 ++
 Documentation/devicetree/bindings/mux/mmio-mux.txt |  60 --
 Documentation/devicetree/bindings/mux/reg-mux.txt  | 129 ++++
 .../bindings/nvmem/allwinner,sun4i-a10-sid.yaml    |  51 ++
 .../bindings/nvmem/allwinner,sunxi-sid.txt         |  29 -
 .../devicetree/bindings/nvmem/imx-ocotp.txt        |   1 +
 Documentation/driver-api/index.rst                 |   1 +
 Documentation/driver-api/mei/hdcp.rst              |  32 +
 Documentation/driver-api/mei/iamt.rst              | 101 +++
 Documentation/driver-api/mei/index.rst             |  23 +
 Documentation/driver-api/mei/mei-client-bus.rst    | 168 +++++
 Documentation/driver-api/mei/mei.rst               | 176 +++++
 Documentation/driver-api/mei/nfc.rst               |  28 +
 Documentation/driver-api/soundwire/locking.rst     |   4 +-
 Documentation/misc-devices/{eeprom => eeprom.rst}  |  43 +-
 .../misc-devices/{ics932s401 => ics932s401.rst}    |   7 +-
 Documentation/misc-devices/index.rst               |   5 +
 .../misc-devices/{isl29003 => isl29003.rst}        |  15 +-
 .../misc-devices/{lis3lv02d => lis3lv02d.rst}      |  20 +-
 .../misc-devices/{max6875 => max6875.rst}          |  52 +-
 Documentation/misc-devices/mei/mei-client-bus.txt  | 141 ----
 Documentation/misc-devices/mei/mei.txt             | 266 -------
 MAINTAINERS                                        |  19 +-
 arch/powerpc/mm/book3s64/radix_tlb.c               |   5 +
 drivers/acpi/acpi_amba.c                           |   9 +
 drivers/android/binder.c                           | 157 ++--
 drivers/android/binder_alloc.c                     |  44 +-
 drivers/android/binder_alloc.h                     |  22 +-
 drivers/char/bsr.c                                 |   5 +-
 drivers/char/misc.c                                |   3 +-
 drivers/counter/104-quad-8.c                       |   2 +-
 drivers/extcon/Kconfig                             |  12 +
 drivers/extcon/Makefile                            |   1 +
 drivers/extcon/extcon-arizona.c                    |  33 +-
 drivers/extcon/extcon-fsa9480.c                    | 395 ++++++++++
 drivers/firmware/google/coreboot_table.h           |  11 +-
 drivers/firmware/google/framebuffer-coreboot.c     |  14 +-
 drivers/firmware/google/memconsole-coreboot.c      |  28 +-
 drivers/firmware/google/memconsole.c               |   9 +-
 drivers/firmware/google/vpd.c                      |  14 +-
 drivers/firmware/google/vpd_decode.c               |   2 -
 drivers/fpga/Kconfig                               |   6 +-
 drivers/fpga/dfl-fme-mgr.c                         |   4 +-
 drivers/fpga/dfl-fme-pr.c                          |  17 +-
 drivers/fsi/cf-fsi-fw.h                            |   2 +-
 drivers/fsi/fsi-core.c                             |  32 +-
 drivers/fsi/fsi-occ.c                              |  15 +-
 drivers/fsi/fsi-sbefifo.c                          |   4 +-
 drivers/hwmon/occ/common.c                         |   4 +-
 drivers/hwmon/occ/common.h                         |   1 +
 drivers/hwtracing/coresight/Kconfig                |   1 +
 drivers/hwtracing/coresight/Makefile               |   3 +-
 drivers/hwtracing/coresight/coresight-catu.c       |  40 +-
 drivers/hwtracing/coresight/coresight-catu.h       |   1 -
 drivers/hwtracing/coresight/coresight-cpu-debug.c  |   6 +-
 drivers/hwtracing/coresight/coresight-etb10.c      |  78 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c   |   8 +-
 drivers/hwtracing/coresight/coresight-etm.h        |   6 +-
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    |  12 +-
 drivers/hwtracing/coresight/coresight-etm3x.c      |  49 +-
 drivers/hwtracing/coresight/coresight-etm4x.c      |  40 +-
 drivers/hwtracing/coresight/coresight-etm4x.h      |   2 -
 drivers/hwtracing/coresight/coresight-funnel.c     |  36 +-
 drivers/hwtracing/coresight/coresight-platform.c   | 815 +++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-priv.h       |   4 +
 drivers/hwtracing/coresight/coresight-replicator.c |  43 +-
 drivers/hwtracing/coresight/coresight-stm.c        | 118 ++-
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |  43 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |  80 +-
 drivers/hwtracing/coresight/coresight-tmc.c        |  96 +--
 drivers/hwtracing/coresight/coresight-tmc.h        |   2 -
 drivers/hwtracing/coresight/coresight-tpiu.c       |  24 +-
 drivers/hwtracing/coresight/coresight.c            | 164 ++++-
 drivers/hwtracing/coresight/of_coresight.c         | 297 --------
 drivers/hwtracing/intel_th/msu.c                   | 150 ++--
 drivers/hwtracing/intel_th/pci.c                   |   5 +
 drivers/memory/Kconfig                             |   2 +-
 drivers/memory/jz4780-nemc.c                       |  26 +-
 drivers/misc/Kconfig                               |  32 +-
 drivers/misc/Makefile                              |   2 +-
 drivers/misc/altera-stapl/Kconfig                  |   1 -
 drivers/misc/c2port/Kconfig                        |   2 -
 drivers/misc/cb710/Kconfig                         |   1 -
 drivers/misc/cxl/Kconfig                           |   3 -
 drivers/misc/echo/Kconfig                          |   1 -
 drivers/misc/eeprom/ee1004.c                       |  43 +-
 drivers/misc/eeprom/idt_89hpesx.c                  |   6 +-
 drivers/misc/fsa9480.c                             | 547 --------------
 drivers/misc/genwqe/Kconfig                        |   1 -
 drivers/misc/habanalabs/asid.c                     |   2 +-
 drivers/misc/habanalabs/command_submission.c       |  10 +-
 drivers/misc/habanalabs/context.c                  |  11 +-
 drivers/misc/habanalabs/debugfs.c                  |  54 +-
 drivers/misc/habanalabs/device.c                   | 189 ++---
 drivers/misc/habanalabs/firmware_if.c              |  51 +-
 drivers/misc/habanalabs/goya/goya.c                | 635 +++++++++++-----
 drivers/misc/habanalabs/goya/goyaP.h               |  16 +-
 drivers/misc/habanalabs/goya/goya_security.c       |  16 +
 drivers/misc/habanalabs/habanalabs.h               |  93 ++-
 drivers/misc/habanalabs/habanalabs_drv.c           |  66 +-
 drivers/misc/habanalabs/habanalabs_ioctl.c         |  11 +-
 drivers/misc/habanalabs/hw_queue.c                 |   2 +-
 .../include/goya/asic_reg/dma_ch_0_masks.h         | 418 +++++++++++
 .../habanalabs/include/goya/asic_reg/goya_regs.h   |   1 +
 drivers/misc/habanalabs/memory.c                   |  13 +-
 drivers/misc/habanalabs/mmu.c                      |  20 +-
 drivers/misc/habanalabs/pci.c                      |  10 +-
 drivers/misc/habanalabs/sysfs.c                    |   4 -
 drivers/misc/isl29003.c                            |   4 +-
 drivers/misc/lis3lv02d/Kconfig                     |   2 -
 drivers/misc/lkdtm/Makefile                        |   3 +-
 drivers/misc/lkdtm/bugs.c                          |  66 ++
 drivers/misc/lkdtm/core.c                          |   1 +
 drivers/misc/lkdtm/lkdtm.h                         |   1 +
 drivers/misc/mei/debugfs.c                         | 184 ++---
 drivers/misc/mei/hdcp/mei_hdcp.c                   |  11 +-
 drivers/misc/mic/scif/scif_main.c                  |   1 +
 drivers/misc/ocxl/Kconfig                          |   1 -
 drivers/misc/ocxl/context.c                        |   9 +-
 drivers/misc/ocxl/link.c                           |  28 +-
 drivers/misc/sgi-xp/xpc_partition.c                |   2 +-
 drivers/misc/tsl2550.c                             |   2 +-
 drivers/misc/vmw_balloon.c                         | 489 +++++++++++--
 drivers/misc/vmw_vmci/vmci_context.c               |  80 +-
 drivers/misc/vmw_vmci/vmci_handle_array.c          |  38 +-
 drivers/misc/vmw_vmci/vmci_handle_array.h          |  29 +-
 drivers/misc/xilinx_sdfec.c                        | 345 +++++++++
 drivers/mux/Kconfig                                |  12 +-
 drivers/mux/mmio.c                                 |   6 +-
 drivers/nvmem/Kconfig                              |   9 +-
 drivers/nvmem/Makefile                             |   2 +
 drivers/nvmem/imx-ocotp-scu.c                      | 161 ++++
 drivers/nvmem/imx-ocotp.c                          |  52 +-
 drivers/platform/x86/Kconfig                       |   2 +-
 drivers/slimbus/core.c                             |   5 -
 drivers/slimbus/qcom-ctrl.c                        |   4 +-
 drivers/slimbus/stream.c                           |  12 +-
 drivers/soundwire/bus.c                            |   6 +-
 drivers/soundwire/cadence_master.c                 |  30 +-
 drivers/soundwire/intel.c                          |  17 +-
 drivers/soundwire/intel.h                          |   2 +-
 drivers/soundwire/intel_init.c                     |  25 +-
 drivers/soundwire/mipi_disco.c                     |  35 +-
 drivers/soundwire/stream.c                         |   8 +-
 drivers/w1/slaves/w1_ds2413.c                      |  65 +-
 drivers/w1/slaves/w1_ds2805.c                      |   6 +-
 fs/char_dev.c                                      |   3 +-
 include/linux/balloon_compaction.h                 |   4 +
 include/linux/coresight.h                          |  61 +-
 include/linux/firmware/xlnx-zynqmp.h               |   1 -
 include/linux/platform_data/fsa9480.h              |  24 -
 include/linux/soundwire/sdw.h                      |  88 ++-
 include/linux/soundwire/sdw_type.h                 |  11 +
 include/linux/vmw_vmci_defs.h                      |  41 +-
 include/uapi/misc/habanalabs.h                     |  30 +-
 lib/fonts/fonts.c                                  | 103 ++-
 mm/balloon_compaction.c                            | 144 +++-
 164 files changed, 6073 insertions(+), 2998 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/extcon/extcon-fsa9480.txt
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
 delete mode 100644 Documentation/devicetree/bindings/mux/mmio-mux.txt
 create mode 100644 Documentation/devicetree/bindings/mux/reg-mux.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
 create mode 100644 Documentation/driver-api/mei/hdcp.rst
 create mode 100644 Documentation/driver-api/mei/iamt.rst
 create mode 100644 Documentation/driver-api/mei/index.rst
 create mode 100644 Documentation/driver-api/mei/mei-client-bus.rst
 create mode 100644 Documentation/driver-api/mei/mei.rst
 create mode 100644 Documentation/driver-api/mei/nfc.rst
 rename Documentation/misc-devices/{eeprom => eeprom.rst} (76%)
 rename Documentation/misc-devices/{ics932s401 => ics932s401.rst} (94%)
 rename Documentation/misc-devices/{isl29003 => isl29003.rst} (77%)
 rename Documentation/misc-devices/{lis3lv02d => lis3lv02d.rst} (90%)
 rename Documentation/misc-devices/{max6875 => max6875.rst} (83%)
 delete mode 100644 Documentation/misc-devices/mei/mei-client-bus.txt
 delete mode 100644 Documentation/misc-devices/mei/mei.txt
 create mode 100644 drivers/extcon/extcon-fsa9480.c
 create mode 100644 drivers/hwtracing/coresight/coresight-platform.c
 delete mode 100644 drivers/hwtracing/coresight/of_coresight.c
 delete mode 100644 drivers/misc/fsa9480.c
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_0_masks.h
 create mode 100644 drivers/misc/xilinx_sdfec.c
 create mode 100644 drivers/nvmem/imx-ocotp-scu.c
 delete mode 100644 include/linux/platform_data/fsa9480.h
