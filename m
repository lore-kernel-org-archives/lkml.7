Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27588C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 16:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30A1207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 16:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574872260;
	bh=DLc6FTntBxHm2s+c5WlzKUxEkYzNXAB4Upunvs9kvQY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=HFnPcUMrWgROP3fCfLywgTifc/jXt6P7AqXzDGke6JzPrz4d708Aee1mOjEu/hdA+
	 EHRv5GL/o2zSI524BJAOYyc1TFC23DlBSAz3EtWp8zhvvUvqrUinHhWe5xziyee2kI
	 jXaC3g9vKier7Ek74hrDyWld4hwKNJQkKulpPC5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfK0Qa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 11:30:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:35882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726909AbfK0Qa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 11:30:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 503092075C;
        Wed, 27 Nov 2019 16:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574872255;
        bh=DLc6FTntBxHm2s+c5WlzKUxEkYzNXAB4Upunvs9kvQY=;
        h=Date:From:To:Cc:Subject:From;
        b=Fx8lnittqnc77ylbdjaCUMRRRkBeJvrSK8nyFn6lsjMg1+L16I2Jjq553VWXP1iY5
         4NqK7V7Wl0hM2Mwcad9A+y2HP6NT1iotkmfBWX7xRRgghfEDoGn1g/StMPbUU5CRAO
         xIV1zefqbzBIzurqx0/Id4jie3LpYvGglLjy1R/8=
Date:   Wed, 27 Nov 2019 17:30:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver patches for 5.5-rc1
Message-ID: <20191127163053.GA3086750@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 31f4f5b495a62c9a8b15b1c3581acd5efeb9af8c:

  Linux 5.4-rc7 (2019-11-10 16:17:15 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.5-rc1

for you to fetch changes up to b78cda795ac83333293f1bfa3165572a47e550c2:

  Merge tag 'misc-habanalabs-next-2019-11-21' of git://people.freedesktop.org/~gabbayo/linux into char-misc-next (2019-11-21 17:35:28 +0100)

----------------------------------------------------------------
Char/Misc driver patches for 5.5-rc1

Here is the big set of char/misc and other driver patches for 5.5-rc1

Loads of different things in here, this feels like the catch-all of
driver subsystems these days.  Full details are in the shortlog, but
nothing major overall, just lots of driver updates and additions.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Shishkin (5):
      stm class: Lose the protocol driver when dropping its reference
      intel_th: Document software sinks
      intel_th: Fix a double put_device() in error path
      intel_th: pci: Add Ice Lake CPU support
      intel_th: pci: Add Tiger Lake CPU support

Alexander Usyskin (7):
      mei: fix modalias documentation
      mei: me: fix me_intr_clear function name in KDoc
      mei: bus: prefix device names on bus with the bus name
      mei: me: add comet point V device id
      mei: me: store irq number in the hw struct.
      mei: add trc detection register to sysfs
      mei: bus: add more client attributes to sysfs

Alexandru Ardelean (1):
      uio: fix irq init with dt support & irq not defined

Andrew Jeffery (3):
      trace: fsi: Print transfer size unsigned
      fsi: core: Fix small accesses and unaligned offsets via sysfs
      fsi: aspeed: Fix OPB0 byte order register values

Andrew Murray (2):
      coresight: etm4x: Save/restore state across CPU low power states
      dt-bindings: arm: coresight: Add support for coresight-loses-context-with-cpu

Angelo Dureghello (1):
      w1: new driver. DS2430 chip

Anup Patel (1):
      platform: goldfish: Allow goldfish drivers for archs with IOMEM and DMA

Arnd Bergmann (2):
      ppdev: fix PPGETTIME/PPSETTIME ioctls
      lp: fix sparc64 LPSETTIMEOUT ioctl

Baolin Wang (1):
      nvmem: sc27xx: Change to use devm_hwspin_lock_request_specific() to request one hwlock

Bard Liao (2):
      soundwire: intel: remove playback/capture stream_name
      soundwire: cadence_master: improve PDI allocation

Bartosz Golaszewski (1):
      phy: tegra: use regulator_bulk_set_supply_names()

Ben Dooks (2):
      phy: phy-brcm-usb-init: fix __iomem annotations
      phy: phy-brcm-usb-init: fix use of integer as pointer

Ben Dooks (Codethink) (2):
      pcmcia: include <pcmcia/ds.h> for pcmcia_parse_tuple
      pcmcia: include cs_internal.h for missing declarations

Biju Das (1):
      phy: renesas: phy-rcar-gen2: Fix the array off by one warning

Brian Masney (2):
      dt-bindings: interconnect: qcom: add msm8974 bindings
      interconnect: qcom: add msm8974 driver

Christian Kellner (1):
      thunderbolt: Add 'generation' attribute for devices

Chunfeng Yun (1):
      phy: tegra: xusb: remove unused variable

Colin Ian King (2):
      phy: xgene: make array serdes_reg static const, makes object smaller
      extcon: sm5502: remove redundant assignment to variable cable_type

Denis Efremov (1):
      greybus: remove excessive check in gb_connection_hd_cport_quiesce()

Dhanuka Warusadura (1):
      w1: Fix documentation warning.

Dmitry Torokhov (1):
      lis3lv02d: switch to using input device polling mode

Fabrizio Castro (2):
      dt-bindings: rcar-gen3-phy-usb2: Add r8a774b1 support
      dt-bindings: rcar-gen3-phy-usb3: Add r8a774b1 support

Finley Xiao (1):
      nvmem: add Rockchip OTP driver

Freeman Liu (2):
      dt-bindings: nvmem: Add Spreadtrum eFuse controller documentation
      nvmem: sprd: Add Spreadtrum SoCs eFuse support

Geert Uytterhoeven (1):
      phy: renesas: rcar-gen3-usb2: Use platform_get_irq_optional() for optional irq

Greg Kroah-Hartman (9):
      Merge 5.4-rc3 into char-misc-next
      Merge 5.4-rc5 into char-misc-next
      Merge tag 'extcon-next-for-5.5' of git://git.kernel.org/.../chanwoo/extcon into char-misc-next
      Merge tag 'phy-for-5.5' of git://git.kernel.org/.../kishon/linux-phy into char-misc-next
      Merge tag 'thunderbolt-for-v5.5' of git://git.kernel.org/.../westeri/thunderbolt into char-misc-next
      Merge tag 'fpga-dfl-for-5.5' of git://git.kernel.org/.../mdf/linux-fpga into char-misc-next
      Merge tag 'soundwire-5.5-rc1' of git://git.kernel.org/.../vkoul/soundwire into char-misc-next
      Merge 5.4-rc7 into char-misc-next
      Merge tag 'misc-habanalabs-next-2019-11-21' of git://people.freedesktop.org/~gabbayo/linux into char-misc-next

Grygorii Strashko (1):
      phy: ti: gmii-sel: fix mac tx internal delay for rgmii-rxid

Heiko Stuebner (4):
      phy: add PHY_MODE_LVDS
      dt-bindings: phy: add yaml binding for rockchip,px30-dsi-dphy
      phy: phy-rockchip-inno-usb2: add phy description for px30
      dt-bindings: nvmem: add binding for Rockchip OTP controller

Icenowy Zheng (1):
      phy: allwinner: add phy driver for USB3 PHY on Allwinner H6 SoC

Jann Horn (5):
      binder: Use common definition of SZ_1K
      binder: Remove incorrect comment about vm_insert_page() behavior
      binder: Fix race between mmap() and binder_alloc_print_pages()
      binder: Prevent repeated use of ->mmap() via NULL mapping
      binder: Handle start==NULL in binder_update_page_range()

Jean Delvare (1):
      eeprom: Warn that the driver is deprecated

Jeremy Kerr (2):
      fsi: Add fsi-master class
      fsi: Move master attributes to fsi-master class

Joe Perches (1):
      sgi-gru: simplify procfs code some more

Joel Stanley (5):
      ABI: Update FSI path documentation
      fsi: Move defines to common header
      dt-bindings: fsi: Add description of FSI master
      fsi: Add ast2600 master driver
      fsi: aspeed: Add trace points

Johannes Thumshirn (1):
      drivers: mcb: use symbol namespaces

Jorge Ramirez-Ortiz (4):
      misc: fastrpc: add mmap/unmap support
      misc: fastrpc: do not interrupt kernel calls
      misc: fastrpc: handle interrupted contexts
      misc: fastrpc: revert max init file size back to 2MB

Krzysztof Kozlowski (3):
      char: Fix Kconfig indentation
      misc: Fix Kconfig indentation
      char: Fix Kconfig indentation, continued

Lucas Stach (1):
      nvmem: imx-ocotp: reset error status on probe

Marcel Holtmann (1):
      rfkill: allocate static minor

Mark Brown (1):
      coresight: Add explicit architecture dependency

Markus Elfring (1):
      phy-mvebu-a3700-utmi: Use devm_platform_ioremap_resource() in mvebu_a3700_utmi_phy_probe()

Mika Westerberg (19):
      Merge branch 'thunderbolt/fixes' into thunderbolt/next
      thunderbolt: Introduce tb_switch_is_icm()
      thunderbolt: Log switch route string on config read/write timeout
      thunderbolt: Log error if adding switch fails
      thunderbolt: Convert basic adapter register names to follow the USB4 spec
      thunderbolt: Convert PCIe adapter register names to follow the USB4 spec
      thunderbolt: Convert DP adapter register names to follow the USB4 spec
      thunderbolt: Make tb_sw_write() take const parameter
      thunderbolt: Add helper macro to iterate over switch ports
      thunderbolt: Refactor add_switch() into two functions
      thunderbolt: Add support for lane bonding
      thunderbolt: Add default linking between lane adapters if not provided by DROM
      thunderbolt: Expand controller name in tb_switch_is_xy()
      thunderbolt: Add downstream PCIe port mappings for Alpine and Titan Ridge
      thunderbolt: Add Display Port CM handshake for Titan Ridge devices
      thunderbolt: Add Display Port adapter pairing and resource management
      thunderbolt: Add bandwidth management for Display Port tunnels
      thunderbolt: Do not start firmware unless asked by the user
      thunderbolt: Power cycle the router if NVM authentication fails

Mike Leach (8):
      coresight: etm4x: Fixes for ETM v4.4 architecture updates.
      coresight: etm4x: Fix input validation for sysfs.
      coresight: etm4x: Add missing API to set EL match on address filters
      coresight: etm4x: Fix issues with start-stop logic.
      coresight: etm4x: Improve usability of sysfs - include/exclude addr.
      coresight: etm4x: Improve usability of sysfs - CID and VMID masks.
      coresight: etm4x: Add view comparator settings API to sysfs.
      coresight: etm4x: Add missing single-shot control API to sysfs

Moti Haimovski (1):
      habanalabs: expose reset counters via existing INFO IOCTL

Nagarjuna Kristam (4):
      phy: tegra: xusb: Add XUSB dual mode support on Tegra210
      phy: tegra: xusb: Add usb3 port fake support on Tegra210
      phy: tegra: xusb: Add vbus override support on Tegra210
      phy: tegra: xusb: Add vbus override support on Tegra186

Nishad Kamdar (2):
      ocxl: Use the correct style for SPDX License Identifier
      misc: Use the correct style for SPDX License Identifier

Oded Gabbay (16):
      habanalabs: handle F/W failure for sensor initialization
      habanalabs: set TPC Icache to 16 cache lines
      habanalabs: add opcode to INFO IOCTL to return clock rate
      habanalabs: expose card name in INFO IOCTL
      habanalabs: read F/W versions before failure
      habanalabs: use registers name defines for ETR block
      habanalabs: set ETR as non-secured
      habanalabs: increase max jobs number to 512
      habanalabs: don't print error when queues are full
      habanalabs: export uapi defines to user-space
      habanalabs: remove prints on successful device initialization
      habanalabs: use defines for F/W files
      habanalabs: make code more concise
      habanalabs: make the reset code more consistent
      habanalabs: flush EQ workers in hard reset
      habanalabs: add more protection of device during reset

Omer Shpigelman (9):
      habanalabs: re-factor memory module code
      habanalabs: type specific MMU cache invalidation
      habanalabs: re-factor MMU masks and documentation
      habanalabs: split MMU properties to PCI/DRAM
      habanalabs: prevent read/write from/to the device during hard reset
      habanalabs: optimize MMU unmap
      habanalabs: skip VA block list update in reset flow
      habanalabs: invalidate MMU cache only once
      habanalabs: remove unnecessary checks

Ondrej Jirman (1):
      dt-bindings: Add bindings for USB3 phy on Allwinner H6

Peng Fan (2):
      nvmem: imx: scu: support hole region check
      nvmem: imx: scu: support write

Pierre-Louis Bossart (14):
      soundwire: intel: add missing headers for cross-compilation
      soundwire: intel: remove X86 dependency
      soundwire: remove DAI_ID_RANGE definitions
      soundwire: cadence/intel: simplify PDI/port mapping
      soundwire: intel: don't filter out PDI0/1
      soundwire: intel/cadence: fix startup sequence
      soundwire: cadence_master: add hw_reset capability in debugfs
      soundwire: intel: add helper for initialization
      soundwire: intel/cadence: add flag for interrupt enable
      soundwire: cadence_master: make clock stop exit configurable on init
      soundwire: intel: fix PDI/stream mapping for Bulk
      soundwire: remove bitfield for unique_id, use u8
      soundwire: slave: add helper to extract slave ID
      soundwire: ignore uniqueID when irrelevant

Randy Dunlap (1):
      misc: MIC: drop all 'comment' lines from its Kconfig

Richard Gong (1):
      firmware: Fix incompatible function behavior for RSU driver

Rikard Falkeborn (1):
      coresight: etm4x: Fix BMVAL misuse

Rui Feng (1):
      misc: rtsx: Add support for RTS5261

Sebastian Reichel (1):
      nvmem: core: fix nvmem_cell_write inline function

Srinivas Kandagatla (2):
      misc: fastrpc: fix memory leak from miscdev->name
      nvmem: imx: scu: fix dependency in Kconfig

Stephan Gerhold (2):
      extcon: sm5502: Reset registers during initialization
      phy: qcom-usb-hs: Fix extcon double register after power cycle

Stephen Boyd (1):
      fpga: Remove dev_err() usage after platform_get_irq()

Sudip Mukherjee (4):
      parport: daisy: avoid hardcoded name
      parport: do not check portlist when using device-model
      parport: load lowlevel driver if ports not found
      parport: daisy: use new parport device model

Tanmay Vilas Kumar Jagdale (1):
      coresight: etm4x: Add support for ThunderX2

Tomas Winkler (4):
      mei: buf: drop 'running hook' debug messages.
      samples: mei: use hostprogs kbuild constructs
      mei: me: mei_me_dev_init() use struct device instead of struct pci_dev.
      mei: abstract fw status register read.

Tomer Tayar (3):
      habanalabs: Fix typos
      habanalabs: Mark queue as expecting CB handle or address
      habanalabs: Add a new H/W queue type

Vinod Koul (3):
      soundwire: intel: use correct header for io calls
      dt-bindings: phy-qcom-qmp: Add sm8150 UFS phy compatible string
      phy: qcom-qmp: Add SM8150 QMP UFS PHY support

Wei Yongjun (3):
      phy: lantiq: vrx200-pcie: fix error return code in ltq_vrx200_pcie_phy_power_on()
      coresight: funnel: Fix missing spin_lock_init()
      coresight: replicator: Fix missing spin_lock_init()

Wu Hao (2):
      fpga: dfl: fme: add thermal management support
      fpga: dfl: fme: add power management support

Wyon Bi (1):
      phy/rockchip: Add support for Innosilicon MIPI/LVDS/TTL PHY

Xu Yilun (1):
      Documentation: fpga: dfl: add descriptions for thermal/power management interfaces

Yabin Cui (1):
      coresight: Serialize enabling/disabling a link device.

Yauhen Kharuzhy (1):
      extcon-intel-cht-wc: Don't reset USB data connection at probe

Yoshihiro Shimoda (1):
      phy: renesas: rcar-gen3-usb2: Fix sysfs interface of "role"

YueHaibing (7):
      w1: sgi_w1: use devm_platform_ioremap_resource() to simplify code
      misc: atmel_tclib: use devm_platform_ioremap_resource() to simplify code
      phy: hisilicon: use devm_platform_ioremap_resource() to simplify code
      phy: ti: dm816x: remove set but not used variable 'phy_data'
      char: xillybus: use devm_platform_ioremap_resource() to simplify code
      habanalabs: remove set but not used variable 'ctx'
      habanalabs: remove set but not used variable 'qman_base_addr'

kbuild test robot (1):
      fsi: fsi_master_class can be static

zhong jiang (2):
      drivers/misc: ti-st: Remove unneeded variable in st_tty_open
      misc: rtsx: Remove unneeded variable in rts5260_card_power_on

 Documentation/ABI/testing/sysfs-bus-fsi            |  16 +-
 Documentation/ABI/testing/sysfs-bus-mei            |  23 +-
 Documentation/ABI/testing/sysfs-bus-thunderbolt    |  36 +
 Documentation/ABI/testing/sysfs-class-mei          |  10 +
 Documentation/ABI/testing/sysfs-platform-dfl-fme   | 132 ++++
 .../devicetree/bindings/arm/coresight.txt          |   9 +
 .../devicetree/bindings/fsi/fsi-master-aspeed.txt  |  24 +
 .../bindings/interconnect/qcom,msm8974.yaml        |  62 ++
 .../devicetree/bindings/nvmem/rockchip-otp.txt     |  25 +
 .../devicetree/bindings/nvmem/sprd-efuse.txt       |  39 +
 .../bindings/phy/allwinner,sun50i-h6-usb3-phy.yaml |  47 ++
 .../bindings/phy/phy-rockchip-inno-usb2.txt        |   1 +
 .../devicetree/bindings/phy/qcom-qmp-phy.txt       |   7 +-
 .../devicetree/bindings/phy/rcar-gen3-phy-usb2.txt |   2 +
 .../devicetree/bindings/phy/rcar-gen3-phy-usb3.txt |   2 +
 .../bindings/phy/rockchip,px30-dsi-dphy.yaml       |  75 ++
 Documentation/fpga/dfl.rst                         |  10 +
 Documentation/trace/intel_th.rst                   |  28 +-
 drivers/android/binder.c                           |   6 +-
 drivers/android/binder_alloc.c                     |  42 +-
 drivers/char/Kconfig                               |   6 +-
 drivers/char/agp/Kconfig                           |   2 +-
 drivers/char/hw_random/Kconfig                     |  18 +-
 drivers/char/ipmi/Kconfig                          |  98 +--
 drivers/char/lp.c                                  |   4 +
 drivers/char/ppdev.c                               |  16 +-
 drivers/char/xillybus/xillybus_of.c                |   5 +-
 drivers/extcon/extcon-intel-cht-wc.c               |  16 +-
 drivers/extcon/extcon-sm5502.c                     |   6 +-
 drivers/extcon/extcon-sm5502.h                     |   2 +
 drivers/firmware/stratix10-rsu.c                   |  42 +-
 drivers/firmware/stratix10-svc.c                   |  18 +-
 drivers/fpga/Kconfig                               |   2 +-
 drivers/fpga/dfl-fme-main.c                        | 385 ++++++++++
 drivers/fpga/zynq-fpga.c                           |   4 +-
 drivers/fsi/Kconfig                                |   8 +
 drivers/fsi/Makefile                               |   1 +
 drivers/fsi/fsi-core.c                             |  67 +-
 drivers/fsi/fsi-master-aspeed.c                    | 544 ++++++++++++++
 drivers/fsi/fsi-master-hub.c                       |  46 --
 drivers/fsi/fsi-master.h                           |  71 ++
 drivers/gpio/gpio-menz127.c                        |   1 +
 drivers/greybus/connection.c                       |   3 -
 drivers/hwtracing/coresight/Kconfig                |   1 +
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    | 312 +++++++-
 drivers/hwtracing/coresight/coresight-etm4x.c      | 351 ++++++++-
 drivers/hwtracing/coresight/coresight-etm4x.h      |  81 ++-
 drivers/hwtracing/coresight/coresight-funnel.c     |  37 +-
 drivers/hwtracing/coresight/coresight-replicator.c |  36 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |  26 +-
 drivers/hwtracing/coresight/coresight.c            |  51 +-
 drivers/hwtracing/intel_th/core.c                  |   8 +-
 drivers/hwtracing/intel_th/pci.c                   |  10 +
 drivers/hwtracing/stm/policy.c                     |   4 +
 drivers/iio/adc/men_z188_adc.c                     |   1 +
 drivers/interconnect/qcom/Kconfig                  |   9 +
 drivers/interconnect/qcom/Makefile                 |   2 +
 drivers/interconnect/qcom/msm8974.c                | 784 ++++++++++++++++++++
 drivers/mcb/mcb-core.c                             |  28 +-
 drivers/mcb/mcb-lpc.c                              |   1 +
 drivers/mcb/mcb-parse.c                            |   2 +-
 drivers/mcb/mcb-pci.c                              |   1 +
 drivers/misc/Kconfig                               |  17 +-
 drivers/misc/atmel_tclib.c                         |   4 +-
 drivers/misc/cardreader/Makefile                   |   2 +-
 drivers/misc/cardreader/rts5260.c                  |   3 +-
 drivers/misc/cardreader/rts5261.c                  | 792 ++++++++++++++++++++
 drivers/misc/cardreader/rts5261.h                  | 233 ++++++
 drivers/misc/cardreader/rtsx_pcr.c                 |  43 +-
 drivers/misc/cardreader/rtsx_pcr.h                 |   1 +
 drivers/misc/eeprom/eeprom.c                       |   4 +
 drivers/misc/fastrpc.c                             | 209 +++++-
 drivers/misc/habanalabs/command_submission.c       | 127 +++-
 drivers/misc/habanalabs/debugfs.c                  | 112 ++-
 drivers/misc/habanalabs/device.c                   |  18 +-
 drivers/misc/habanalabs/firmware_if.c              |   5 +-
 drivers/misc/habanalabs/goya/goya.c                |  78 +-
 drivers/misc/habanalabs/goya/goyaP.h               |   2 +
 drivers/misc/habanalabs/goya/goya_coresight.c      |  53 +-
 drivers/misc/habanalabs/goya/goya_hwmgr.c          |  31 +
 drivers/misc/habanalabs/habanalabs.h               | 171 +++--
 drivers/misc/habanalabs/habanalabs_ioctl.c         |  73 +-
 drivers/misc/habanalabs/hw_queue.c                 | 249 +++++--
 .../habanalabs/include/goya/asic_reg/goya_masks.h  |   2 +
 .../habanalabs/include/goya/asic_reg/goya_regs.h   |   1 +
 .../include/goya/asic_reg/psoc_etr_regs.h          | 114 +++
 drivers/misc/habanalabs/include/hl_boot_if.h       |   2 +
 .../habanalabs/include/hw_ip/mmu/mmu_general.h     |   7 +-
 drivers/misc/habanalabs/include/qman_if.h          |  12 +
 drivers/misc/habanalabs/memory.c                   | 392 +++++-----
 drivers/misc/habanalabs/mmu.c                      | 204 ++++--
 drivers/misc/hpilo.h                               |   2 +-
 drivers/misc/ibmvmc.h                              |   4 +-
 drivers/misc/lis3lv02d/lis3lv02d.c                 |  80 +-
 drivers/misc/lis3lv02d/lis3lv02d.h                 |   4 +-
 drivers/misc/mei/bus-fixup.c                       |   9 -
 drivers/misc/mei/bus.c                             |  42 +-
 drivers/misc/mei/client.h                          |  36 +
 drivers/misc/mei/hw-me-regs.h                      |   4 +-
 drivers/misc/mei/hw-me.c                           |  74 +-
 drivers/misc/mei/hw-me.h                           |  12 +-
 drivers/misc/mei/hw-txe.c                          |  10 +-
 drivers/misc/mei/init.c                            |   6 +-
 drivers/misc/mei/main.c                            |  24 +
 drivers/misc/mei/mei_dev.h                         |  18 +-
 drivers/misc/mei/pci-me.c                          |  16 +-
 drivers/misc/mic/Kconfig                           |  16 -
 drivers/misc/ocxl/ocxl_internal.h                  |   2 +-
 drivers/misc/ocxl/trace.h                          |   2 +-
 drivers/misc/sgi-gru/gruprocfs.c                   |  11 +-
 drivers/misc/ti-st/st_core.c                       |   4 +-
 drivers/nvmem/Kconfig                              |  23 +
 drivers/nvmem/Makefile                             |   4 +
 drivers/nvmem/imx-ocotp-scu.c                      | 120 ++-
 drivers/nvmem/imx-ocotp.c                          |   4 +
 drivers/nvmem/rockchip-otp.c                       | 268 +++++++
 drivers/nvmem/sc27xx-efuse.c                       |  13 +-
 drivers/nvmem/sprd-efuse.c                         | 424 +++++++++++
 drivers/parport/daisy.c                            |  40 +-
 drivers/parport/probe.c                            |   2 +-
 drivers/parport/share.c                            |  26 +-
 drivers/pcmcia/cardbus.c                           |   2 +
 drivers/pcmcia/cistpl.c                            |   1 +
 drivers/phy/allwinner/Kconfig                      |  11 +
 drivers/phy/allwinner/Makefile                     |   1 +
 drivers/phy/allwinner/phy-sun50i-usb3.c            | 190 +++++
 drivers/phy/broadcom/phy-brcm-usb-init.c           |  10 +-
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c         |   4 +-
 drivers/phy/hisilicon/phy-histb-combphy.c          |   4 +-
 drivers/phy/lantiq/phy-lantiq-vrx200-pcie.c        |   3 +-
 drivers/phy/marvell/phy-mvebu-a3700-utmi.c         |   9 +-
 drivers/phy/phy-xgene.c                            |   2 +-
 drivers/phy/qualcomm/phy-qcom-qmp.c                | 120 +++
 drivers/phy/qualcomm/phy-qcom-qmp.h                |  96 +++
 drivers/phy/qualcomm/phy-qcom-usb-hs.c             |   7 +-
 drivers/phy/renesas/phy-rcar-gen2.c                |   5 +-
 drivers/phy/renesas/phy-rcar-gen3-usb2.c           |   7 +-
 drivers/phy/rockchip/Kconfig                       |   8 +
 drivers/phy/rockchip/Makefile                      |   1 +
 drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c   | 805 +++++++++++++++++++++
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c      |   1 +
 drivers/phy/tegra/xusb-tegra186.c                  |  23 +
 drivers/phy/tegra/xusb-tegra210.c                  | 137 +++-
 drivers/phy/tegra/xusb.c                           |  93 ++-
 drivers/phy/tegra/xusb.h                           |   4 +
 drivers/phy/ti/phy-dm816x-usb.c                    |   3 -
 drivers/phy/ti/phy-gmii-sel.c                      |   2 +-
 drivers/platform/goldfish/Kconfig                  |   3 +-
 drivers/soundwire/Kconfig                          |   2 +-
 drivers/soundwire/bus.c                            |   7 +-
 drivers/soundwire/cadence_master.c                 | 292 ++++----
 drivers/soundwire/cadence_master.h                 |  39 +-
 drivers/soundwire/intel.c                          | 201 ++---
 drivers/soundwire/intel_init.c                     |   1 +
 drivers/soundwire/slave.c                          |  98 ++-
 drivers/thunderbolt/cap.c                          |   6 +-
 drivers/thunderbolt/ctl.c                          |   8 +-
 drivers/thunderbolt/eeprom.c                       |  11 -
 drivers/thunderbolt/icm.c                          | 157 ++--
 drivers/thunderbolt/lc.c                           | 193 ++++-
 drivers/thunderbolt/path.c                         |  52 +-
 drivers/thunderbolt/switch.c                       | 586 ++++++++++++---
 drivers/thunderbolt/tb.c                           | 340 +++++++--
 drivers/thunderbolt/tb.h                           |  81 ++-
 drivers/thunderbolt/tb_msgs.h                      |   2 +
 drivers/thunderbolt/tb_regs.h                      |  97 ++-
 drivers/thunderbolt/tunnel.c                       | 364 +++++++++-
 drivers/thunderbolt/tunnel.h                       |  10 +-
 drivers/thunderbolt/xdomain.c                      |   5 +-
 drivers/tty/serial/8250/8250_men_mcb.c             |   1 +
 drivers/tty/serial/men_z135_uart.c                 |   1 +
 drivers/uio/uio_dmem_genirq.c                      |  14 +-
 drivers/w1/masters/sgi_w1.c                        |   4 +-
 drivers/w1/slaves/Kconfig                          |   8 +
 drivers/w1/slaves/Makefile                         |   1 +
 drivers/w1/slaves/w1_ds2430.c                      | 295 ++++++++
 drivers/watchdog/menz69_wdt.c                      |   1 +
 include/dt-bindings/interconnect/qcom,msm8974.h    | 146 ++++
 include/linux/coresight.h                          |   6 +
 .../linux/firmware/intel/stratix10-svc-client.h    |   8 +
 include/linux/miscdevice.h                         |   1 +
 include/linux/nvmem-consumer.h                     |   2 +-
 include/linux/parport.h                            |   1 +
 include/linux/phy/phy.h                            |   3 +-
 include/linux/phy/tegra/xusb.h                     |   4 +-
 include/linux/rtsx_pci.h                           |   1 +
 include/linux/soundwire/sdw.h                      |   7 +-
 include/linux/w1.h                                 |   1 +
 include/trace/events/fsi.h                         |   6 +-
 include/trace/events/fsi_master_aspeed.h           |  77 ++
 include/uapi/misc/fastrpc.h                        |  15 +
 include/uapi/misc/habanalabs.h                     |  48 +-
 net/rfkill/core.c                                  |   9 +-
 samples/Kconfig                                    |   7 +
 samples/Makefile                                   |   1 +
 samples/mei/Makefile                               |  12 +-
 196 files changed, 11037 insertions(+), 1714 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8974.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/rockchip-otp.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/sprd-efuse.txt
 create mode 100644 Documentation/devicetree/bindings/phy/allwinner,sun50i-h6-usb3-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip,px30-dsi-dphy.yaml
 create mode 100644 drivers/fsi/fsi-master-aspeed.c
 create mode 100644 drivers/interconnect/qcom/msm8974.c
 create mode 100644 drivers/misc/cardreader/rts5261.c
 create mode 100644 drivers/misc/cardreader/rts5261.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_etr_regs.h
 create mode 100644 drivers/nvmem/rockchip-otp.c
 create mode 100644 drivers/nvmem/sprd-efuse.c
 create mode 100644 drivers/phy/allwinner/phy-sun50i-usb3.c
 create mode 100644 drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c
 create mode 100644 drivers/w1/slaves/w1_ds2430.c
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8974.h
 create mode 100644 include/trace/events/fsi_master_aspeed.h
