Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D6AC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B64A214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557311463;
	bh=apoj4gMvQm42oWBT+wavPrZQs6gfPzcXwXMkvMve4to=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=MS5S1Wq+WR0Z5/+zcQyOXUDLgWEzvA+H2yYxRUEElG2tWO9JPhTsFTXJUoGchFJxG
	 e6BiUZ/abXOPIudjOQqfyLaslWjaangBWfu6kEeAWPanLAhWSH9StCUQmXXEglU3lY
	 cQ+xJWlbcfaOwPiyL9tOXJgSg3kvcm4T3QBrQFXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfEHKbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 06:31:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbfEHKbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 06:31:00 -0400
Received: from localhost (unknown [84.241.196.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B13521479;
        Wed,  8 May 2019 10:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557311458;
        bh=apoj4gMvQm42oWBT+wavPrZQs6gfPzcXwXMkvMve4to=;
        h=Date:From:To:Cc:Subject:From;
        b=Jea0O2D4TSS99Ldm3GqDbIjHEmJa6zU49aGEOvLxtoJgpXsP2/1m7g2fnVCUrLCRo
         3frxN6FO1HkeJchm+uW9U+GFgYI0f5/u+w/yGlPBSPrYF1YH0q6srhF00LI4Qsh6Lq
         VC2FolwTHJU4Q+EdQNGv1yH4vX/GtWFQuyWLdtrw=
Date:   Wed, 8 May 2019 12:30:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB/PHY patches for 5.2-rc1
Message-ID: <20190508103055.GA14454@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 37624b58542fb9f2d9a70e6ea006ef8a5f66c30b:

  Linux 5.1-rc7 (2019-04-28 17:04:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.2-rc1

for you to fetch changes up to 3515468a87a47781f6af818773650513ff14656a:

  Merge tag 'usb-for-v5.2' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-next (2019-05-03 18:05:27 +0200)

----------------------------------------------------------------
USB/PHY patches for 5.2-rc1

Here is the big set of USB and PHY driver patches for 5.2-rc1

There is the usual set of:
	- USB gadget updates
	- PHY driver updates and additions
	- USB serial driver updates and fixes
	- typec updates and new chips supported
	- mtu3 driver updates
	- xhci driver updates
	- other tiny driver updates

Nothing really interesting, just constant forward progress.

All of these have been in linux-next for a while with no reported
issues.  The usb-gadget and usb-serial trees were merged a bit "late",
but both of them had been in linux-next before they got merged here last
Friday.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Ajay Gupta (5):
      usb: typec: ucsi: ccg: add get_fw_info function
      i2c: nvidia-gpu: Supply CCGx driver the fw build info
      usb: typec: ucsi: ccg: add firmware flashing support
      usb: typec: displayport: Export probe and remove functions
      usb: typec: Add driver for NVIDIA Alt Modes

Alan Stern (5):
      usb-storage: Set virt_boundary_mask to avoid SG overflows
      USB: core: Don't unbind interfaces following device reset failure
      USB: dummy-hcd: Fix failure to give back unlinked URBs
      USB: UDC: net2280: Remove redundant "if" condition
      USB: UDC: net22{80,72}: remove mistaken test of req->zero

Alexandre Belloni (5):
      usb: gadget: udc: lpc32xx: simplify probe
      usb: gadget: udc: lpc32xx: simplify vbus handling
      usb: gadget: udc: lpc32xx: properly setup phy interrupts
      usb: gadget: udc: lpc32xx: add support for stotg04 phy
      usb: gadget: udc: lpc32xx: rework interrupt handling

Andy Shevchenko (1):
      usb: dwc3: Free resource immediately after use

Arnd Bergmann (1):
      usb: gadget: fsl: fix link error against usb-gadget module

Biju Das (5):
      dt-bindings: phy: rcar-gen2: Add r8a77470 support
      dt-bindings: rcar-gen3-phy-usb2: Add r8a77470 support
      phy: renesas: phy-rcar-gen2: Add support for r8a77470
      phy: rcar-gen3-usb2: Add support for r8a77470
      dt-bindings: usb: renesas_usbhs: Add support for r8a77470

Christoph Muellner (2):
      phy: rockchip-emmc: Allow to set drive impedance via DTS.
      dt-bindings: phy: Add a new property drive-impedance-ohm for RK's emmc PHY

Chunfeng Yun (24):
      usb: mtu3: check return value of devm_extcon_register_notifier()
      usb: mtu3: print useful information also for device and host modes
      usb: mtu3: remove unnecessary local variable @req
      usb: mtu3: rebuild the code of getting vbus regulator
      usb: mtu3: fix transfer error of USB3 Gen2 isoc
      usb: mtu3: rebuild qmu_gpd struct to prepare to support new QMU format
      usb: mtu3: supports new QMU format
      usb: mtu3: add debugfs interface files
      usb: mtu3: move vbus and mode debugfs interfaces into mtu3_debugfs.c
      usb: mtu3: add tracepoints to help debug
      usb: mtu3: add a function to switch mailbox state to string
      usb: introduce usb_ep_type_string() function
      phy: phy-mtk-tphy: get optional clock by devm_clk_get_optional()
      phy: qcom-qusb2: get optional clock by devm_clk_get_optional()
      phy: socionext: get optional clock by devm_clk_get_optional()
      phy: phy-meson-gxl-usb2: get optional clock by devm_clk_get_optional()
      usb: xhci-mtk: get optional clock by devm_clk_get_optional()
      usb: host: xhci-plat: get optional clock by devm_clk_get_optional()
      usb: misc: usb3503: get optional clock by devm_clk_get_optional()
      usb: dwc2: get optional clock by devm_clk_get_optional()
      usb: chipidea: msm: get optional clock by devm_clk_get_optional()
      usb: mtu3: get optional clock by devm_clk_get_optional()
      usb: dwc2: get optional clock by devm_clk_get_optional()
      usb: introduce usb_ep_type_string() function

Colin Ian King (2):
      phy: ti-pipe3: fix missing bit-wise or operator when assigning val
      scsi: phy: mediatek: fix typo in author's email address

Dan Carpenter (1):
      usbip: stub_rx: tidy the indenting in is_clear_halt_cmd()

Douglas Anderson (6):
      usb: dwc2: bus suspend/resume for hosts with DWC2_POWER_DOWN_PARAM_NONE
      USB: Export usb_wakeup_enabled_descendants()
      dt-bindings: usb: dwc2: Document quirk to reset PHY upon wakeup
      usb: dwc2: optionally assert phy reset when waking up
      ARM: dts: rockchip: Hook resets up to USB PHYs on rk3288.
      ARM: dts: rockchip: Add quirk for resetting rk3288's dwc2 host on wakeup

Evan Green (6):
      dt-bindings: ufs: Add #reset-cells for Qualcomm controllers
      dt-bindings: phy-qcom-qmp: Add UFS PHY reset
      dt-bindings: phy: qcom-ufs: Add resets property
      scsi: ufs: qcom: Expose the reset controller for PHY
      phy: qcom: Utilize UFS reset controller
      phy: ufs-qcom: Refactor all init steps into phy_poweron

Fabrizio Castro (1):
      dt-bindings: usb-xhci: Add r8a774c0 support

Fei Yang (1):
      usb: gadget: f_fs: don't free buffer prematurely

Greg Kroah-Hartman (7):
      USB: usb.h: tweak struct urb to remove wasted space
      Merge 5.1-rc3 into usb-next
      Merge tag 'phy-for-5.2' of git://git.kernel.org/.../kishon/linux-phy into usb-next
      USB: serial: io_edgeport: fix up switch fall-through comments
      Merge tag 'usb-serial-5.2-rc1' of https://git.kernel.org/.../johan/usb-serial into usb-next
      Merge 5.1-rc7 into usb-next
      Merge tag 'usb-for-v5.2' of git://git.kernel.org/.../balbi/usb into usb-next

Gustavo A. R. Silva (2):
      usbip: vhci_hcd: Mark expected switch fall-through
      usb: isp1760-hcd: Fix fall-through annotations

Hans de Goede (13):
      usb: typec: altmodes/displayport: Fall back to multi-func pins
      usb: typec: pi3usb30532: Keep orientation when setting mux to safe mode
      usb: typec: fusb302: Make fusb302_set_cc_polarity also set pull ups / downs
      usb: typec: fusb302: Refactor / simplify tcpm_set_cc()
      usb: typec: fusb302: Fold fusb302_set_cc_pull into tcpm_set_cc
      usb: typec: fusb302: Check vconn is off when we start toggling
      usb: typec: fusb302: Fix fusb302_handle_togdone_src Ra handling
      usb: typec: fusb302: 2 small misc. fixes
      usb: typec: fusb302: Improve suspend/resume handling
      usb: typec: fusb302: Add __printf attribute to fusb302_log function
      usb: typec: tcpm: Notify the tcpc to start connection-detection for SRPs
      usb: typec: fusb302: Implement start_toggling for all port-types
      usb: typec: fusb302: Revert "Resolve fixed power role contract setup"

Heikki Krogerus (3):
      usb: typec: wcove: Provide fwnode for the port
      usb: typec: ucsi: Preliminary support for alternate modes
      usb: typec: ucsi: Support for DisplayPort alt mode

JC Kuo (4):
      usb: host: xhci-tegra: Selectively program IPFS
      usb: host: xhci-tegra: Add Tegra186 XUSB support
      phy: tegra: xusb: Skip single function lane programming
      phy: tegra: xusb: Add Tegra186 support

Ji-Ze Hong (Peter Hong) (4):
      USB: serial: f81232: fix interrupt worker not stop
      USB: serial: f81232: clear overrun flag
      USB: serial: f81232: add high baud rate support
      USB: serial: f81232: implement break control

Johan Hovold (19):
      USB: serial: pl2303: fix non-supported xon/xoff
      USB: serial: pl2303: fix tranceiver suspend mode
      USB: serial: digi_acceleport: clean up modem-control handling
      USB: serial: digi_acceleport: clean up set_termios
      USB: serial: fix initial-termios handling
      USB: serial: ark3116: drop redundant init_termios
      USB: serial: cypress_m8: drop unused driver data flag
      USB: serial: cypress_m8: drop unused termios
      USB: serial: cypress_m8: clean up initial-termios handling
      USB: serial: iuu_phoenix: drop bogus initial cflag
      USB: serial: iuu_phoenix: simplify init_termios
      USB: serial: oti6858: simplify init_termios
      USB: serial: spcp8x5: simplify init_termios
      USB: cdc-acm: fix unthrottle races
      USB: cdc-acm: clean up throttle handling
      USB: serial: fix unthrottle races
      USB: serial: clean up throttle handling
      USB: serial: drop unnecessary goto
      USB: serial: drop unused iflag macro

Jonas Bonn (3):
      usb: gadget: atmel_usba_udc: simplify setting of interrupt-enabled mask
      usb: gadget: atmel: support USB suspend
      usb: gadget: atmel: tie wake lock to running clock

Jules Maselbas (5):
      usb: dwc2: Move UTMI_PHY_DATA defines closer
      usb: dwc2: gadget: Remove duplicated phy init
      usb: dwc2: gadget: Replace phyif with phy_utmi_width
      usb: dwc2: Move phy init into core
      usb: dwc2: gadget: Move gadget phy init into core phy init

Kangjie Lu (2):
      usb: sierra: fix a missing check of device_create_file
      usb: u132-hcd: fix potential NULL pointer dereference

Kavya Sree Kotagiri (1):
      phy: ocelot-serdes: Add support for SERDES6G muxing

Kefeng Wang (1):
      usb: musb: dsps: Use dev_get_drvdata()

Kishon Vijay Abraham I (4):
      phy: core: Add *release* phy_ops invoked when the consumer relinquishes PHY
      phy: core: Invoke pm_runtime_get_*/pm_runtime_put_* before invoking reset callback
      dt-bindings: phy: ti: Add dt binding documentation for SERDES in AM654x SoC
      phy: ti: Add a new SERDES driver for TI's AM654x SoC

Lucas Stach (2):
      dt-bindings: phy-imx8mq-usb: add optional vbus supply regulator
      phy: fsl-imx8mq-usb: add support for VBUS power control

Marc Gonzalez (5):
      phy: qcom-qmp: Add msm8998 PCIe QMP PHY support
      dt-bindings: phy-qcom-qmp: Add qcom,msm8998-qmp-pcie-phy
      dt-bindings: phy-qcom-qmp: Tweak qcom,msm8998-qmp-ufs-phy
      usb: dwc3: Allow building USB_DWC3_QCOM without EXTCON
      usb: dwc3: Allow building USB_DWC3_QCOM without EXTCON

Marek Szyprowski (1):
      usb: dwc3: move synchronize_irq() out of the spinlock protected block

Martin Blumenstingl (1):
      dt-bindings: usb: dwc2: document the vbus-supply property

Mathias Nyman (3):
      xhci: add port and bus number to port dynamic debugging
      xhci: Add tracing for input control context
      usb: xhci: add endpoint context tracing when an endpoint is added

Mathieu Malaterre (1):
      USB: hub: Remove returned value 'status' since never used

Mauro Carvalho Chehab (1):
      docs: usb: convert documents to ReST

Maxime Ripard (3):
      dt-bindings: usb: Convert USB HCD generic binding to YAML
      dt-bindings: usb: Convert the generic OHCI binding to YAML
      dt-bindings: usb: Convert the generic EHCI binding to YAML

Minas Harutyunyan (7):
      usb: dwc2: gadget: Reject LPM token during Control transfers
      usb: dwc2: Delayed status support
      usb: dwc2: gadget: Increase descriptors count for ISOC's
      usb: dwc2: Set actual frame number for completed ISOC transfer
      usb: dwc2: Fix channel disable flow
      usb: dwc2: Set lpm mode parameters depend on HW configuration
      dwc2: gadget: Fix completed transfer size calculation in DDMA

Neil Armstrong (8):
      dt-bindings: phy: Add Amlogic G12A USB2 PHY Bindings
      dt-bindings: phy: Add Amlogic G12A USB3+PCIE Combo PHY Bindings
      phy: amlogic: add Amlogic G12A USB2 PHY Driver
      phy: amlogic: Add Amlogic G12A USB3 + PCIE Combo PHY Driver
      dt-bindings: usb: dwc2: Add Amlogic G12A DWC2 Compatible
      dt-bindings: usb: dwc3: Add Amlogic G12A DWC3 Glue Bindings
      usb: dwc2: Add Amlogic G12A DWC2 Params
      usb: dwc3: Add Amlogic G12A DWC3 glue

Nicolas Saenz Julienne (1):
      usb: xhci: add Immediate Data Transfer support

Oliver Neukum (1):
      UAS: fix alignment of scatter/gather segments

Paul Cercueil (4):
      usb: musb: Silence error about blacklisting hubs if !CONFIG_USB
      dt-bindings: usb: Add usb-phy property to the jz4740-musb node
      usb: musb: jz4740: Let the platform probe the PHY
      usb: musb: jz4740: obtain USB PHY from devicetree

Raul E Rangel (1):
      usb/hcd: Send a uevent signaling that the host controller had died

Robin Murphy (1):
      usb: dwc3: of-simple: Convert to bulk clk API

Roger Quadros (5):
      phy: ti-pipe3: Introduce mode property in driver data
      phy: ti-pipe3: improve DPLL stability for SATA & USB
      phy: ti-pipe3: Fix SATA & USB PHY power up sequence
      phy: ti-pipe3: Fix PCIe power up sequence
      phy: ti: am654-serdes: Support all clksel values

Romain Izard (2):
      usb: gadget: f_ncm: Fix NTP-32 support
      usb: gadget: f_ncm: Add OS descriptor support

Samuel Holland (1):
      soc: sunxi: Fix missing dependency on REGMAP_MMIO

Serge Semin (5):
      usb: usb251xb: Lock i2c-bus segment the hub resides
      usb: usb251xb: Add an empty hub' i2c-bus segment checker
      usb: usb251xb: Add US lanes inversion dts-bindings
      usb: usb251xb: Create a ports field collector method
      usb: usb251xb: Add US port lanes inversion property

Sergey Senozhatsky (1):
      usb: gadget: do not use __constant_cpu_to_le16

Srinath Mannam (2):
      dt-bindings: phy: Add Stingray USB PHY binding document
      phy: sr-usb: Add Stingray USB PHY driver

Stanley Chu (2):
      dt-bindings: phy: Add document for phy-mtk-ufs
      phy: mediatek: Add UFS M-PHY driver

Suwan Kim (1):
      usbip: Remove unnecessary null check

Thierry Reding (4):
      dt-bindings: usb: xhci-tegra: Add Tegra186 support
      dt-bindings: phy: tegra: Add Tegra186 support
      phy: tegra: xusb: Parse dual-role mode property
      phy: tegra: xusb: Add support for power supplies

Thinh Nguyen (5):
      usb: dwc3: gadget: Set lpm_capable
      usb: dwc3: Do core validation early on probe
      usb: dwc3: debug: Print GET_STATUS(device) tracepoint
      usb: dwc3: Fix default lpm_nyet_threshold value
      usb: dwc3: Rename DWC3_DCTL_LPM_ERRATA

Tony Lindgren (2):
      usb: core: Add PM runtime calls to usb_hcd_platform_shutdown
      usb: musb: omap2430: Add support for idling phy when musb is idle

Wei Yongjun (1):
      usb: typec: ucsi: ccg: fix missing unlock on error in ccg_cmd_write_flash_row()

Yan Zhu (1):
      usb: host: use usb_endpoint_maxp instead of usb_maxpacket

Yoshihiro Shimoda (3):
      dt-bindings: phy: rcar-gen3-phy-usb2: Revise #phy-cells property
      phy: renesas: rcar-gen3-usb2: Use pdev's device pointer on dev_vdbg()
      phy: renesas: rcar-gen3-usb2: enable/disable independent irqs

Yu Chen (2):
      dt-bindings: phy: Add support for HiSilicon's hi3660 USB PHY
      phy: Add usb phy support for hi3660 Soc of Hisilicon

YueHaibing (1):
      usb: typec: fusb302: Make fusb302_irq_work static

 Documentation/ABI/testing/sysfs-driver-ucsi-ccg    |   6 +
 Documentation/ABI/testing/usb-uevent               |  27 +
 .../bindings/phy/brcm,stingray-usb-phy.txt         |  32 +
 .../devicetree/bindings/phy/fsl,imx8mq-usb-phy.txt |   3 +
 .../bindings/phy/meson-g12a-usb2-phy.txt           |  22 +
 .../bindings/phy/meson-g12a-usb3-pcie-phy.txt      |  22 +
 .../bindings/phy/nvidia,tegra124-xusb-padctl.txt   |   9 +
 .../devicetree/bindings/phy/phy-hi3660-usb3.txt    |  26 +
 .../devicetree/bindings/phy/phy-mtk-ufs.txt        |  38 +
 .../devicetree/bindings/phy/qcom-qmp-phy.txt       |  14 +-
 .../devicetree/bindings/phy/rcar-gen2-phy.txt      |  57 +-
 .../devicetree/bindings/phy/rcar-gen3-phy-usb2.txt |  14 +-
 .../devicetree/bindings/phy/rockchip-emmc-phy.txt  |   8 +-
 .../bindings/phy/ti,phy-am654-serdes.txt           |  82 ++
 Documentation/devicetree/bindings/ufs/ufs-qcom.txt |   5 +-
 .../devicetree/bindings/ufs/ufshcd-pltfrm.txt      |   3 +
 .../devicetree/bindings/usb/amlogic,dwc3.txt       |  88 ++
 Documentation/devicetree/bindings/usb/dwc2.txt     |   7 +
 .../devicetree/bindings/usb/generic-ehci.yaml      |  95 +++
 .../devicetree/bindings/usb/generic-ohci.yaml      |  89 ++
 .../bindings/usb/ingenic,jz4740-musb.txt           |   8 +
 .../bindings/usb/nvidia,tegra124-xusb.txt          |   4 +
 .../devicetree/bindings/usb/renesas_usbhs.txt      |   1 +
 Documentation/devicetree/bindings/usb/usb-ehci.txt |  46 --
 Documentation/devicetree/bindings/usb/usb-hcd.txt  |   9 -
 Documentation/devicetree/bindings/usb/usb-hcd.yaml |  25 +
 Documentation/devicetree/bindings/usb/usb-ohci.txt |  35 -
 Documentation/devicetree/bindings/usb/usb-xhci.txt |   1 +
 Documentation/devicetree/bindings/usb/usb251xb.txt |   6 +-
 Documentation/usb/WUSB-Design-overview.txt         |  56 +-
 Documentation/usb/acm.txt                          | 164 ++--
 Documentation/usb/authorization.txt                |  75 +-
 Documentation/usb/chipidea.txt                     | 101 ++-
 Documentation/usb/dwc3.txt                         |  12 +-
 Documentation/usb/ehci.txt                         |  42 +-
 Documentation/usb/functionfs.txt                   |  17 +-
 Documentation/usb/gadget-testing.txt               | 611 ++++++++------
 Documentation/usb/gadget_configfs.txt              | 306 +++----
 Documentation/usb/gadget_hid.txt                   | 175 ++--
 Documentation/usb/gadget_multi.txt                 |  43 +-
 Documentation/usb/gadget_printer.txt               | 155 ++--
 Documentation/usb/gadget_serial.txt                |  75 +-
 Documentation/usb/iuu_phoenix.txt                  |  34 +-
 Documentation/usb/mass-storage.txt                 |  19 +-
 Documentation/usb/misc_usbsevseg.txt               |   9 +-
 Documentation/usb/mtouchusb.txt                    |  42 +-
 Documentation/usb/ohci.txt                         |   5 +-
 Documentation/usb/rio.txt                          |  83 +-
 Documentation/usb/usb-help.txt                     |  21 +-
 Documentation/usb/usb-serial.txt                   | 205 +++--
 Documentation/usb/usbip_protocol.txt               | 552 +++++++------
 Documentation/usb/usbmon.txt                       | 100 ++-
 MAINTAINERS                                        |  13 +
 arch/arm/boot/dts/rk3288.dtsi                      |   7 +
 drivers/i2c/busses/i2c-nvidia-gpu.c                |   7 +
 drivers/phy/amlogic/Kconfig                        |  22 +
 drivers/phy/amlogic/Makefile                       |   2 +
 drivers/phy/amlogic/phy-meson-g12a-usb2.c          | 341 ++++++++
 drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c     | 413 ++++++++++
 drivers/phy/amlogic/phy-meson-gxl-usb2.c           |  11 +-
 drivers/phy/broadcom/Kconfig                       |  11 +
 drivers/phy/broadcom/Makefile                      |   1 +
 drivers/phy/broadcom/phy-bcm-sr-usb.c              | 394 +++++++++
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c         |  12 +
 drivers/phy/hisilicon/Kconfig                      |  10 +
 drivers/phy/hisilicon/Makefile                     |   1 +
 drivers/phy/hisilicon/phy-hi3660-usb3.c            | 233 ++++++
 drivers/phy/mediatek/Kconfig                       |  10 +
 drivers/phy/mediatek/Makefile                      |   1 +
 drivers/phy/mediatek/phy-mtk-tphy.c                |  10 +-
 drivers/phy/mediatek/phy-mtk-ufs.c                 | 245 ++++++
 drivers/phy/mscc/phy-ocelot-serdes.c               | 240 +++++-
 drivers/phy/phy-core.c                             |  11 +
 drivers/phy/qualcomm/phy-qcom-qmp.c                | 222 +++--
 drivers/phy/qualcomm/phy-qcom-qmp.h                |  12 +
 drivers/phy/qualcomm/phy-qcom-qusb2.c              |  11 +-
 drivers/phy/qualcomm/phy-qcom-ufs-i.h              |   5 +-
 drivers/phy/qualcomm/phy-qcom-ufs-qmp-14nm.c       |  25 +-
 drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.c       |  25 +-
 drivers/phy/qualcomm/phy-qcom-ufs.c                |  57 +-
 drivers/phy/renesas/Kconfig                        |   2 +-
 drivers/phy/renesas/phy-rcar-gen2.c                | 130 ++-
 drivers/phy/renesas/phy-rcar-gen3-usb2.c           | 232 +++++-
 drivers/phy/rockchip/phy-rockchip-emmc.c           |  30 +-
 drivers/phy/socionext/phy-uniphier-usb3hs.c        |  10 +-
 drivers/phy/socionext/phy-uniphier-usb3ss.c        |  10 +-
 drivers/phy/tegra/Makefile                         |   1 +
 drivers/phy/tegra/xusb-tegra186.c                  | 899 +++++++++++++++++++++
 drivers/phy/tegra/xusb.c                           |  67 +-
 drivers/phy/tegra/xusb.h                           |  35 +
 drivers/phy/ti/Kconfig                             |  12 +
 drivers/phy/ti/Makefile                            |   1 +
 drivers/phy/ti/phy-am654-serdes.c                  | 658 +++++++++++++++
 drivers/phy/ti/phy-ti-pipe3.c                      | 362 ++++++---
 drivers/scsi/ufs/Kconfig                           |   1 +
 drivers/scsi/ufs/ufs-qcom.c                        | 114 ++-
 drivers/scsi/ufs/ufs-qcom.h                        |   4 +
 drivers/soc/sunxi/Kconfig                          |   1 +
 drivers/usb/chipidea/ci_hdrc_msm.c                 |   9 +-
 drivers/usb/class/cdc-acm.c                        |  63 +-
 drivers/usb/class/cdc-acm.h                        |   3 +-
 drivers/usb/common/common.c                        |  16 +
 drivers/usb/core/hcd.c                             |  44 +-
 drivers/usb/core/hub.c                             |  25 +-
 drivers/usb/dwc2/core.c                            | 199 +++++
 drivers/usb/dwc2/core.h                            |  14 +-
 drivers/usb/dwc2/core_intr.c                       |  12 +
 drivers/usb/dwc2/gadget.c                          | 101 ++-
 drivers/usb/dwc2/hcd.c                             | 326 ++------
 drivers/usb/dwc2/hw.h                              |   8 +-
 drivers/usb/dwc2/params.c                          |  35 +-
 drivers/usb/dwc2/platform.c                        |  20 +-
 drivers/usb/dwc3/Kconfig                           |  16 +-
 drivers/usb/dwc3/Makefile                          |   1 +
 drivers/usb/dwc3/core.c                            |  18 +-
 drivers/usb/dwc3/core.h                            |   3 +-
 drivers/usb/dwc3/debug.h                           |   3 +
 drivers/usb/dwc3/dwc3-meson-g12a.c                 | 604 ++++++++++++++
 drivers/usb/dwc3/dwc3-of-simple.c                  |  95 +--
 drivers/usb/dwc3/gadget.c                          |   5 +-
 drivers/usb/gadget/function/f_fs.c                 |   3 +-
 drivers/usb/gadget/function/f_ncm.c                |  57 +-
 drivers/usb/gadget/function/f_uac1_legacy.c        |   6 +-
 drivers/usb/gadget/function/u_ncm.h                |   3 +
 drivers/usb/gadget/udc/aspeed-vhub/epn.c           |   6 +-
 drivers/usb/gadget/udc/atmel_usba_udc.c            |  84 +-
 drivers/usb/gadget/udc/atmel_usba_udc.h            |   1 +
 drivers/usb/gadget/udc/dummy_hcd.c                 |  35 +-
 drivers/usb/gadget/udc/lpc32xx_udc.c               | 167 ++--
 drivers/usb/gadget/udc/net2272.c                   |   3 +-
 drivers/usb/gadget/udc/net2280.c                   |   5 +-
 drivers/usb/host/fhci-sched.c                      |  10 +-
 drivers/usb/host/u132-hcd.c                        |   2 +
 drivers/usb/host/xhci-hub.c                        |  44 +-
 drivers/usb/host/xhci-mtk.c                        |  19 +-
 drivers/usb/host/xhci-plat.c                       |  39 +-
 drivers/usb/host/xhci-ring.c                       |  24 +-
 drivers/usb/host/xhci-tegra.c                      |  68 +-
 drivers/usb/host/xhci-trace.h                      |  30 +
 drivers/usb/host/xhci.c                            |  40 +-
 drivers/usb/host/xhci.h                            |  46 ++
 drivers/usb/isp1760/isp1760-hcd.c                  |   4 +-
 drivers/usb/misc/usb251xb.c                        | 135 ++--
 drivers/usb/misc/usb3503.c                         |  48 +-
 drivers/usb/mtu3/Makefile                          |  11 +
 drivers/usb/mtu3/mtu3.h                            |  57 +-
 drivers/usb/mtu3/mtu3_core.c                       |  27 +-
 drivers/usb/mtu3/mtu3_debug.h                      |  50 ++
 drivers/usb/mtu3/mtu3_debugfs.c                    | 539 ++++++++++++
 drivers/usb/mtu3/mtu3_dr.c                         | 156 +---
 drivers/usb/mtu3/mtu3_dr.h                         |   4 +
 drivers/usb/mtu3/mtu3_gadget.c                     |  20 +-
 drivers/usb/mtu3/mtu3_gadget_ep0.c                 |   4 +
 drivers/usb/mtu3/mtu3_hw_regs.h                    |  48 +-
 drivers/usb/mtu3/mtu3_plat.c                       |  47 +-
 drivers/usb/mtu3/mtu3_qmu.c                        | 118 ++-
 drivers/usb/mtu3/mtu3_qmu.h                        |   1 +
 drivers/usb/mtu3/mtu3_trace.c                      |  23 +
 drivers/usb/mtu3/mtu3_trace.h                      | 279 +++++++
 drivers/usb/musb/Kconfig                           |   2 +-
 drivers/usb/musb/jz4740.c                          |  19 +-
 drivers/usb/musb/musb_core.c                       |   9 +-
 drivers/usb/musb/musb_dsps.c                       |   6 +-
 drivers/usb/musb/omap2430.c                        |   6 +
 drivers/usb/phy/Kconfig                            |   2 +-
 drivers/usb/serial/ark3116.c                       |  11 -
 drivers/usb/serial/cypress_m8.c                    |  49 +-
 drivers/usb/serial/digi_acceleport.c               |  41 +-
 drivers/usb/serial/f81232.c                        | 198 ++++-
 drivers/usb/serial/generic.c                       |  76 +-
 drivers/usb/serial/io_edgeport.c                   |  37 +-
 drivers/usb/serial/iuu_phoenix.c                   |   4 +-
 drivers/usb/serial/oti6858.c                       |   5 +-
 drivers/usb/serial/pl2303.c                        |  58 +-
 drivers/usb/serial/spcp8x5.c                       |   5 +-
 drivers/usb/serial/usb-serial.c                    |  11 +-
 drivers/usb/storage/scsiglue.c                     |  26 +-
 drivers/usb/storage/sierra_ms.c                    |   4 +-
 drivers/usb/storage/uas.c                          |  35 +-
 drivers/usb/typec/altmodes/Kconfig                 |  10 +
 drivers/usb/typec/altmodes/Makefile                |   2 +
 drivers/usb/typec/altmodes/displayport.c           |  14 +-
 drivers/usb/typec/altmodes/displayport.h           |   8 +
 drivers/usb/typec/altmodes/nvidia.c                |  44 +
 drivers/usb/typec/mux/pi3usb30532.c                |   3 +-
 drivers/usb/typec/tcpm/fusb302.c                   | 438 +++++-----
 drivers/usb/typec/tcpm/tcpci.c                     |  10 +-
 drivers/usb/typec/tcpm/tcpm.c                      |  32 +-
 drivers/usb/typec/tcpm/wcove.c                     |  39 +-
 drivers/usb/typec/ucsi/Makefile                    |  15 +-
 drivers/usb/typec/ucsi/displayport.c               | 315 ++++++++
 drivers/usb/typec/ucsi/trace.c                     |  12 +
 drivers/usb/typec/ucsi/trace.h                     |  26 +
 drivers/usb/typec/ucsi/ucsi.c                      | 404 ++++++---
 drivers/usb/typec/ucsi/ucsi.h                      | 118 +++
 drivers/usb/typec/ucsi/ucsi_ccg.c                  | 884 +++++++++++++++++++-
 drivers/usb/usbip/stub_rx.c                        |   6 +-
 drivers/usb/usbip/vhci_hcd.c                       |   9 +-
 include/dt-bindings/phy/phy-am654-serdes.h         |  13 +
 include/linux/phy/phy.h                            |   2 +
 include/linux/usb.h                                |   2 +-
 include/linux/usb/ch9.h                            |   8 +
 include/linux/usb/hcd.h                            |   6 +
 include/linux/usb/serial.h                         |   8 +-
 include/linux/usb/tcpm.h                           |  13 +-
 include/linux/usb/typec_dp.h                       |   5 +
 206 files changed, 12202 insertions(+), 3336 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-ucsi-ccg
 create mode 100644 Documentation/ABI/testing/usb-uevent
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/meson-g12a-usb2-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-mtk-ufs.txt
 create mode 100644 Documentation/devicetree/bindings/phy/ti,phy-am654-serdes.txt
 create mode 100644 Documentation/devicetree/bindings/usb/generic-ehci.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/generic-ohci.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/usb-ehci.txt
 delete mode 100644 Documentation/devicetree/bindings/usb/usb-hcd.txt
 create mode 100644 Documentation/devicetree/bindings/usb/usb-hcd.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/usb-ohci.txt
 create mode 100644 drivers/phy/amlogic/phy-meson-g12a-usb2.c
 create mode 100644 drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
 create mode 100644 drivers/phy/broadcom/phy-bcm-sr-usb.c
 create mode 100644 drivers/phy/hisilicon/phy-hi3660-usb3.c
 create mode 100644 drivers/phy/mediatek/phy-mtk-ufs.c
 create mode 100644 drivers/phy/tegra/xusb-tegra186.c
 create mode 100644 drivers/phy/ti/phy-am654-serdes.c
 create mode 100644 drivers/usb/dwc3/dwc3-meson-g12a.c
 create mode 100644 drivers/usb/mtu3/mtu3_debug.h
 create mode 100644 drivers/usb/mtu3/mtu3_debugfs.c
 create mode 100644 drivers/usb/mtu3/mtu3_trace.c
 create mode 100644 drivers/usb/mtu3/mtu3_trace.h
 create mode 100644 drivers/usb/typec/altmodes/displayport.h
 create mode 100644 drivers/usb/typec/altmodes/nvidia.c
 create mode 100644 drivers/usb/typec/ucsi/displayport.c
 create mode 100644 include/dt-bindings/phy/phy-am654-serdes.h
