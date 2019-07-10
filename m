Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A84C74A23
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 13:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC0502064B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 13:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562765597;
	bh=+xwBPB8mF7Z1ywyOHvAxWL6QnEYqMz2+jnXYDONbU2E=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Sr/BQz48X68EcDtfTIgePcMDzHplQPZjioRVGvEJVCq6givtZyjTFK6UFdBGQ8VDX
	 mJTDHKcIs00FlhaL3jLsyA93Monh5fXOMrfPtJsxX+Y8pcfp6xnUoq5VMmNn7X9mE4
	 g5Zq353JuhEZ0g8Bw7dU9mYvTSvJ02vpWyyiL3tM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfGJNdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 09:33:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbfGJNdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 09:33:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B8602064B;
        Wed, 10 Jul 2019 13:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562765591;
        bh=+xwBPB8mF7Z1ywyOHvAxWL6QnEYqMz2+jnXYDONbU2E=;
        h=Date:From:To:Cc:Subject:From;
        b=mo00xmq+Mls4qZ4s++4JeiuZfjJe+sVRc+WC/o9b2o7fmoEumX/Hp5hRmTPz2KU6B
         1tltV6/JIpIf1HTAWCP+z5gUd9QnxtYoEKoiFqi2g9/LfbjkAXpr3ryyPNrpWpNwEV
         A9h0ehhmwwsJXbIBbZ8vTR9w8W2qjtgDyedB3+Z8=
Date:   Wed, 10 Jul 2019 15:33:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB patches for 5.3-rc1
Message-ID: <20190710133309.GA24176@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 4b972a01a7da614b4796475f933094751a295a2f:

  Linux 5.2-rc6 (2019-06-22 16:01:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.3-rc1

for you to fetch changes up to 2bc8bb813cba6e699b29fd0b30720288866a5e5d:

  Merge tag 'usb-ci-v5.3-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb into usb-next (2019-07-05 07:19:28 +0200)

----------------------------------------------------------------
USB / PHY patches for 5.3-rc1

Here is the big USB and PHY driver pull request for 5.3-rc1.

Lots of stuff here, all of which has been in linux-next for a while with
no reported issues.  Nothing is earth-shattering, just constant forward
progress for more devices supported and cleanups and small fixes:
  - USB gadget driver updates and fixes
  - new USB gadget driver for some hardware, followed by a quick revert
    of those patches as they were not ready to be merged...
  - PHY driver updates
  - Lots of new driver additions and cleanups with a few fixes mixed in.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (2):
      USB: core: Remove usbfs_mutex
      USB: core: Fix compiler warnings in devio.c

Andreas Fritiofson (1):
      USB: serial: ftdi_sio: add ID for isodebug v1

Andrzej Pietrasiewicz (1):
      usb: gadget: Zero ffs_io_data

Anurag Kumar Vulisha (3):
      doc: dt: bindings: usb: dwc3: Update entries for disabling U1 and U2
      usb: gadget: send usb_gadget as an argument in get_config_params
      usb: dwc3: gadget: Add support for disabling U1 and U2 entries

Ard Biesheuvel (1):
      wusb: switch to cbcmac transform

Bartlomiej Zolnierkiewicz (1):
      usb: remove redundant 'default n' from Kconfig-s

Biju Das (1):
      usb: gadget: udc: renesas_usb3: Enhance role switch support

Bjorn Andersson (3):
      dt-bindings: phy: Add binding for Qualcomm PCIe2 PHY
      phy: qcom: Add Qualcomm PCIe2 PHY driver
      phy: qcom-qmp: Correct READY_STATUS poll break condition

Chris Brandt (7):
      dt-bindings: rcar-gen3-phy-usb2: Document dr_mode
      dt-bindings: rcar-gen3-phy-usb2: Add r7s9210 support
      usb: renesas_usbhs: move flags to param
      usb: renesas_usbhs: add support for CNEN bit
      usb: renesas_usbhs: support byte addressable CFIFO
      usb: renesas_usbhs: Add support for RZ/A2
      dt-bindings: usb: renesas_usbhs: Add support for r7s9210

Chunfeng Yun (2):
      Revert "usb: mtu3: fix up undefined reference to usb_debug_root"
      usb: dwc3: remove unused @lock member of dwc3_ep struct

Colin Ian King (4):
      phy: qcom-qusb2: fix missing assignment of ret when calling clk_prepare_enable
      usb: cdc-wdm: remove redundant assignment to rv
      usb: gadget: net2272: remove redundant assignments to pointer 's'
      usb: gadget: udc: renesas_usb3: remove redundant assignment to ret

Daniel M German (2):
      usb: Replace snprintf with scnprintf in gether_get_ifname
      usb: clean up some of the computations in adu_read

Dmitry Torokhov (1):
      USB: add usbfs ioctl to retrieve the connection parameters

Douglas Anderson (3):
      Documentation: dt-bindings: Add snps,need-phy-for-wake for dwc2 USB
      ARM: dts: rockchip: Allow wakeup from rk3288-veyron's dwc2 USB ports
      USB: dwc2: Don't turn off the usbphy in suspend if wakeup is enabled

EJ Hsu (1):
      usb: gadget: storage: Remove warning message

Enric Balletbo i Serra (1):
      usb: dwc3: Fix core validation in probe, move after clocks are enabled

Fabio Estevam (3):
      usb: chipidea: Use dev_err() instead of pr_err()
      usb: chipidea: imx: Use devm_platform_ioremap_resource()
      usb: chipidea: msm: Use devm_platform_ioremap_resource()

Fei Yang (1):
      usb: gadget: f_fs: data_len used before properly set

Felipe Balbi (2):
      usb: dwc3: pci: Add Support for Intel Elkhart Lake Devices
      usb: dwc3: pci: add support for TigerLake Devices

Florian Fainelli (1):
      phy: usb: phy-brcm-usb: Remove sysfs attributes upon driver removal

Geert Uytterhoeven (1):
      usb: isp1362: Spelling s/eclusive/exclusive/

Greg Kroah-Hartman (20):
      Merge 5.2-rc3 into usb-next
      USB: atm: ueagle-atm.c: fix SPDX tag to be BSD2
      USB: atm: ueagle-atm.c: remove redundant license text
      USB: move usb debugfs directory creation to the usb common core
      Merge 5.2-rc5 into usb-next
      remove Documentation/index.rst.rej
      Merge 5.2-rc6 into usb-next
      Merge tag 'usb-for-v5.3' of git://git.kernel.org/.../balbi/usb into usb-next
      Merge tag 'phy-for-5.2-rc_v2' of git://git.kernel.org/.../kishon/linux-phy into usb-next
      Merge tag 'phy-for-5.3' of git://git.kernel.org/.../kishon/linux-phy into usb-next
      Merge tag 'usb-serial-5.3-rc1' of https://git.kernel.org/.../johan/usb-serial into usb-next
      Merge tag 'usb-for-v5.3-part2' of git://git.kernel.org/.../balbi/usb into usb-next
      Revert "usb:cdns3 Fix for stuck packets in on-chip OUT buffer."
      Revert "usb:cdns3 Add Cadence USB3 DRD Driver"
      Revert "usb:gadget Simplify usb_decode_get_set_descriptor function."
      Revert "usb:gadget Patch simplify usb_decode_set_clear_feature function."
      Revert "usb:gadget Separated decoding functions from dwc3 driver."
      Revert "dt-bindings: add binding for USBSS-DRD controller."
      Revert "usb: gadget: storage: Remove warning message"
      Merge tag 'usb-ci-v5.3-rc1' of git://git.kernel.org/.../peter.chen/usb into usb-next

Guenter Roeck (1):
      Revert "usb: dwc2: host: Setting qtd to NULL after freeing it"

Guido Günther (2):
      dt-bindings: phy: Add documentation for mixel dphy
      phy: Add driver for mixel mipi dphy found on NXP's i.MX8 SoCs

Gustavo A. R. Silva (1):
      phy: samsung: Use struct_size() in devm_kzalloc()

Hans Ulli Kroll (1):
      usb: host: fotg2: add device tree probing

Hariprasad Kelam (7):
      usb: ftdi-elan: fix possible condition with no effect (if == else)
      usb: host: u132-hcd: remove unneeded variable frame
      USB: sisusbvga: Remove unneeded variable
      usb: gadget: at91_udc: Remove unneeded variable
      fotg210-udc: Remove unneeded variable
      USB: omap_udc: Remove unneeded variable
      USB: gadget: function: fix issue Unneeded variable: "value"

Harry Pan (1):
      USB: core: correct a spelling mistake in the comment

Jim Lin (2):
      usb: Add devaddr in struct usb_device
      usb: xhci: Add Clear_TT_Buffer

Jonas Stenvall (1):
      usb: gadget: u_audio: Fixed variable declaration coding style issue

Jörgen Storvist (1):
      USB: serial: option: add support for GosunCn ME3630 RNDIS mode

Kefeng Wang (1):
      usb: dwc3: qcom: Use of_clk_get_parent_count()

Kiruthika Varadarajan (1):
      usb: gadget: ether: Fix race between gether_disconnect and rx_submit

Lee Jones (4):
      soc: qcom: geni: Add support for ACPI
      usb: dwc3: qcom: Add support for booting with ACPI
      usb: dwc3: qcom: Start USB in 'host mode' on the SDM845
      usb: dwc3: qcom: Improve error handling

Lee, Chiasheng (1):
      usb: Handle USB3 remote wakeup for LPM enabled devices correctly

Lubomir Rintel (1):
      dt-bindings: phy-pxa-usb: add bindings

Marc Gonzalez (2):
      phy: qcom-qmp: Drop useless msm8998_pciephy_cfg setting
      phy: qcom-qmp: Raise qcom_qmp_phy_enable() polling delay

Marcos Paulo de Souza (1):
      usb: storage: scsiglue: Do not skip VPD if try_vpd_pages is set

Marek Szyprowski (2):
      usb: exynos: add workaround for the USB device bindings conflict
      usb: dwc2: Force 8bit UTMI width for Samsung Exynos SoCs

Martin Blumenstingl (1):
      usb: dwc2: use a longer AHB idle timeout in dwc2_core_reset()

Mauro Carvalho Chehab (1):
      docs: usb: rename files to .rst and add them to drivers-api

Nathan Huckleberry (1):
      usb: host: xhci-tegra: Fix Wunused-const-variable

Naveen Kumar Parna (1):
      USB: OHCI: remove space before open square bracket '['

Neil Armstrong (2):
      usb: dwc3: meson-g12a: Add support for IRQ based OTG switching
      phy: meson-g12a-usb3-pcie: disable locking for cr_regmap

Nikhil Badola (2):
      usb: fsl: Set USB_EN bit to select ULPI phy
      usb :fsl: Change string format for errata property

Nikolaus Voss (2):
      drivers/usb/typec/tps6598x.c: fix portinfo width
      drivers/usb/typec/tps6598x.c: fix 4CC cmd write

Pawel Laszczak (6):
      dt-bindings: add binding for USBSS-DRD controller.
      usb:gadget Separated decoding functions from dwc3 driver.
      usb:gadget Patch simplify usb_decode_set_clear_feature function.
      usb:gadget Simplify usb_decode_get_set_descriptor function.
      usb:cdns3 Add Cadence USB3 DRD Driver
      usb:cdns3 Fix for stuck packets in on-chip OUT buffer.

Peter Chen (4):
      usb: chipidea: imx: add imx7ulp support
      usb: chipidea: imx: "fsl,usbphy" phandle is not mandatory now
      doc: dt-binding: mxs-usb-phy: add compatible for 7ulp
      usb: phy: phy-mxs-usb: add imx7ulp support

Ramneek Mehresh (1):
      usb: host: Stops USB controller init if PLL fails to lock

Shuah Khan (1):
      usbip: usbip_host: cleanup do_rebind() return path

Simon Horman (2):
      dt-bindings: usb: renesas_usbhs: Rename bindings documentation file
      dt-bindings: usb: renesas_gen3: Rename bindings documentation file

Stephen Rothwell (1):
      USB: fix types in uapi include

Suresh Gupta (1):
      usb: phy: Workaround for USB erratum-A005728

Suwan Kim (1):
      usbip: Replace unused kvec array with single variable in vhci_send_cmd_unlink()

Thierry Reding (3):
      dt-bindings: phy: tegra-xusb: List PLL power supplies
      phy: tegra: xusb: Add Tegra124 PLL power supplies
      phy: tegra: xusb: Add Tegra210 PLL power supplies

Thinh Nguyen (2):
      usb: core: hub: Enable/disable U1/U2 in configured state
      usb: core: hub: Disable hub-initiated U1/U2

Weitao Hou (1):
      usb: avoid redundant allocation and free of memory

Wolfram Sang (1):
      usb: typec: tcpm: fusb302: simplify getting the adapter of a client

Yinbo Zhu (1):
      usb: linux/fsl_device: Add platform member has_fsl_erratum_a006918

Yoshihiro Shimoda (20):
      usb: renesas_usbhs: Use specific struct instead of USBHS_TYPE_* enums
      usb: renesas_usbhs: remove sudmac support
      usb: renesas_usbhs: remove controlling PWEN/EXTLP support
      phy: renesas: rcar-gen2: Fix memory leak at error paths
      usb: renesas_usbhs: Use struct assignment instead of memcpy()
      phy: renesas: rcar-gen3-usb2: fix imbalance powered flag
      usb: renesas_usbhs: revise the irq_vbus comments
      usb: renesas_usbhs: remove notify_hotplug callback
      usb: renesas_usbhs: move macros from mod.c to the mod.h
      usb: renesas_usbhs: Avoid to write platform_data's value
      usb: renesas_usbhs: Use a specific flag instead of type for multi_clks
      usb: renesas_usbhs: Remove type member from renesas_usbhs_driver_param
      usb: renesas_usbhs: Use dev_of_node macro instead of open coded
      usb: renesas_usbhs: Add has_new_pipe_configs flag
      usb: renesas_usbhs: Add struct device * declaration in usbhs_probe()
      usb: renesas_usbhs: move device tree properties parsing
      usb: renesas_usbhs: Add a common function for the .get_id
      usb: renesas_usbhs: Use renesas_usbhs_platform_info on of_device_id.data
      usb: renesas_usbhs: Use struct platform_callback pointer
      usb: renesas_usbhs: add a workaround for a race condition of workqueue

YueHaibing (7):
      usb: host: ehci-st: Remove set but not used variable 'ehci'
      usb: host: ohci-st: Remove set but not used variable 'ohci'
      usb: ohci-s3c2410: Remove set but not used variable 'hcd'
      USB: ohci-spear: Remove set but not used variable 'ohci'
      usb: phy: mv-usb: Remove set but not used variable 'phy'
      phy: usb: phy-brcm-usb: Fix platform_no_drv_owner.cocci warnings
      phy: ti: am654-serdes: Make serdes_am654_xlate() static

 .../devicetree/bindings/phy/mixel,mipi-dsi-phy.txt |  29 ++
 .../devicetree/bindings/phy/mxs-usb-phy.txt        |   3 +-
 .../bindings/phy/nvidia,tegra124-xusb-padctl.txt   |  12 +
 .../devicetree/bindings/phy/phy-pxa-usb.txt        |  18 +
 .../devicetree/bindings/phy/qcom-pcie2-phy.txt     |  42 ++
 .../devicetree/bindings/phy/rcar-gen3-phy-usb2.txt |  13 +-
 Documentation/devicetree/bindings/usb/dwc2.txt     |   3 +
 Documentation/devicetree/bindings/usb/dwc3.txt     |   2 +
 .../usb/{renesas_usb3.txt => renesas,usb3.txt}     |   0
 .../usb/{renesas_usbhs.txt => renesas,usbhs.txt}   |   2 +
 Documentation/index.rst                            |   1 +
 Documentation/usb/{acm.txt => acm.rst}             |   0
 .../usb/{authorization.txt => authorization.rst}   |   0
 Documentation/usb/{chipidea.txt => chipidea.rst}   |   0
 Documentation/usb/{dwc3.txt => dwc3.rst}           |   0
 Documentation/usb/{ehci.txt => ehci.rst}           |   0
 .../usb/{functionfs.txt => functionfs.rst}         |   0
 .../usb/{gadget-testing.txt => gadget-testing.rst} |   4 +-
 .../{gadget_configfs.txt => gadget_configfs.rst}   |   0
 .../usb/{gadget_hid.txt => gadget_hid.rst}         |   0
 .../usb/{gadget_multi.txt => gadget_multi.rst}     |   0
 .../usb/{gadget_printer.txt => gadget_printer.rst} |   0
 .../usb/{gadget_serial.txt => gadget_serial.rst}   |   0
 Documentation/usb/index.rst                        |  39 ++
 .../usb/{iuu_phoenix.txt => iuu_phoenix.rst}       |   0
 .../usb/{mass-storage.txt => mass-storage.rst}     |   0
 .../usb/{misc_usbsevseg.txt => misc_usbsevseg.rst} |   0
 Documentation/usb/{mtouchusb.txt => mtouchusb.rst} |   0
 Documentation/usb/{ohci.txt => ohci.rst}           |   0
 Documentation/usb/{rio.txt => rio.rst}             |   0
 Documentation/usb/text_files.rst                   |  29 ++
 Documentation/usb/{usb-help.txt => usb-help.rst}   |   0
 .../usb/{usb-serial.txt => usb-serial.rst}         |   0
 .../usb/{usbip_protocol.txt => usbip_protocol.rst} |   0
 Documentation/usb/{usbmon.txt => usbmon.rst}       |   0
 ...esign-overview.txt => wusb-design-overview.rst} |   0
 MAINTAINERS                                        |  12 +-
 arch/arm/boot/dts/rk3288-veyron.dtsi               |   2 +
 crypto/ccm.c                                       |   1 +
 drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c     |   2 +-
 drivers/phy/broadcom/phy-brcm-usb.c                |   9 +-
 drivers/phy/freescale/Kconfig                      |  10 +
 drivers/phy/freescale/Makefile                     |   1 +
 drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c     | 497 +++++++++++++++++++++
 drivers/phy/qualcomm/Kconfig                       |   8 +
 drivers/phy/qualcomm/Makefile                      |   1 +
 drivers/phy/qualcomm/phy-qcom-pcie2.c              | 331 ++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.c                |   5 +-
 drivers/phy/qualcomm/phy-qcom-qusb2.c              |   2 +-
 drivers/phy/renesas/phy-rcar-gen2.c                |   2 +
 drivers/phy/renesas/phy-rcar-gen3-usb2.c           |  19 +-
 drivers/phy/samsung/phy-samsung-usb2.c             |   5 +-
 drivers/phy/tegra/xusb-tegra124.c                  |   9 +
 drivers/phy/tegra/xusb-tegra210.c                  |   9 +
 drivers/phy/ti/phy-am654-serdes.c                  |   4 +-
 drivers/soc/qcom/qcom-geni-se.c                    |  21 +-
 drivers/usb/Kconfig                                |   2 +-
 drivers/usb/Makefile                               |   3 +-
 drivers/usb/atm/Kconfig                            |   1 -
 drivers/usb/atm/ueagle-atm.c                       |  48 +-
 drivers/usb/chipidea/ci_hdrc_imx.c                 |  33 +-
 drivers/usb/chipidea/ci_hdrc_msm.c                 |   4 +-
 drivers/usb/chipidea/core.c                        |   5 +-
 drivers/usb/chipidea/usbmisc_imx.c                 |   8 +-
 drivers/usb/class/Kconfig                          |   2 +-
 drivers/usb/class/cdc-wdm.c                        |   2 +-
 drivers/usb/common/common.c                        |  21 +
 drivers/usb/common/common.h                        |  14 +
 drivers/usb/common/led.c                           |   9 +-
 drivers/usb/core/Kconfig                           |   1 -
 drivers/usb/core/devio.c                           |  71 ++-
 drivers/usb/core/hub.c                             |  45 +-
 drivers/usb/core/notify.c                          |   3 -
 drivers/usb/core/usb.c                             |  10 +-
 drivers/usb/core/usb.h                             |   1 -
 drivers/usb/dwc2/Kconfig                           |   1 -
 drivers/usb/dwc2/core.c                            |   2 +-
 drivers/usb/dwc2/core.h                            |   8 +
 drivers/usb/dwc2/hcd.c                             |  20 +-
 drivers/usb/dwc2/hcd.h                             |   1 -
 drivers/usb/dwc2/params.c                          |   1 +
 drivers/usb/dwc2/platform.c                        |  23 +-
 drivers/usb/dwc3/Kconfig                           |   2 +-
 drivers/usb/dwc3/core.c                            |  16 +-
 drivers/usb/dwc3/core.h                            |   6 +-
 drivers/usb/dwc3/dwc3-meson-g12a.c                 |  36 +-
 drivers/usb/dwc3/dwc3-pci.c                        |   8 +
 drivers/usb/dwc3/dwc3-qcom.c                       | 224 ++++++++--
 drivers/usb/dwc3/ep0.c                             |   9 +-
 drivers/usb/dwc3/gadget.c                          |  22 +-
 drivers/usb/dwc3/gadget.h                          |   6 +
 drivers/usb/gadget/Kconfig                         |   6 +-
 drivers/usb/gadget/composite.c                     |   2 +-
 drivers/usb/gadget/function/f_eem.c                |   3 +-
 drivers/usb/gadget/function/f_fs.c                 |   9 +-
 drivers/usb/gadget/function/f_mass_storage.c       |   2 +-
 drivers/usb/gadget/function/u_audio.c              |   4 +-
 drivers/usb/gadget/function/u_ether.c              |  10 +-
 drivers/usb/gadget/legacy/Kconfig                  |   8 +-
 drivers/usb/gadget/udc/at91_udc.c                  |   3 +-
 drivers/usb/gadget/udc/fotg210-udc.c               |   3 +-
 drivers/usb/gadget/udc/net2272.c                   |   5 -
 drivers/usb/gadget/udc/omap_udc.c                  |   3 +-
 drivers/usb/gadget/udc/renesas_usb3.c              |  93 +++-
 drivers/usb/host/Kconfig                           |   7 +-
 drivers/usb/host/ehci-exynos.c                     |  11 +
 drivers/usb/host/ehci-fsl.c                        |  52 ++-
 drivers/usb/host/ehci-fsl.h                        |   3 +
 drivers/usb/host/ehci-st.c                         |   2 -
 drivers/usb/host/fotg210-hcd.c                     |  10 +
 drivers/usb/host/fsl-mph-dr-of.c                   |  10 +-
 drivers/usb/host/isp1362.h                         |   2 +-
 drivers/usb/host/ohci-exynos.c                     |  11 +
 drivers/usb/host/ohci-pci.c                        |   2 +-
 drivers/usb/host/ohci-s3c2410.c                    |   2 -
 drivers/usb/host/ohci-spear.c                      |   3 -
 drivers/usb/host/ohci-st.c                         |   2 -
 drivers/usb/host/u132-hcd.c                        |   3 +-
 drivers/usb/host/xhci-ring.c                       |  27 +-
 drivers/usb/host/xhci-tegra.c                      |  23 -
 drivers/usb/host/xhci.c                            |  23 +
 drivers/usb/host/xhci.h                            |   5 +
 drivers/usb/misc/Kconfig                           |   2 +-
 drivers/usb/misc/adutux.c                          |  16 +-
 drivers/usb/misc/ftdi-elan.c                       |   7 -
 drivers/usb/misc/sisusbvga/sisusb.c                |  10 +-
 drivers/usb/mon/Kconfig                            |   2 +-
 drivers/usb/mtu3/mtu3_debugfs.c                    |   3 +-
 drivers/usb/phy/phy-mv-usb.c                       |   2 -
 drivers/usb/phy/phy-mxs-usb.c                      |  67 ++-
 drivers/usb/renesas_usbhs/Kconfig                  |   1 -
 drivers/usb/renesas_usbhs/Makefile                 |   2 +-
 drivers/usb/renesas_usbhs/common.c                 | 214 ++++-----
 drivers/usb/renesas_usbhs/common.h                 |   9 +-
 drivers/usb/renesas_usbhs/fifo.c                   |  52 ++-
 drivers/usb/renesas_usbhs/mod.c                    |  23 +-
 drivers/usb/renesas_usbhs/mod.h                    |  26 +-
 drivers/usb/renesas_usbhs/mod_gadget.c             |   7 +-
 drivers/usb/renesas_usbhs/rcar2.c                  |  22 +-
 drivers/usb/renesas_usbhs/rcar2.h                  |   3 +-
 drivers/usb/renesas_usbhs/rcar3.c                  |  33 +-
 drivers/usb/renesas_usbhs/rcar3.h                  |   5 +-
 drivers/usb/renesas_usbhs/rza.c                    |  18 +-
 drivers/usb/renesas_usbhs/rza.h                    |   3 +-
 drivers/usb/renesas_usbhs/rza2.c                   |  74 +++
 drivers/usb/serial/Kconfig                         |  10 +-
 drivers/usb/serial/belkin_sa.c                     |   2 +-
 drivers/usb/serial/belkin_sa.h                     |   2 +-
 drivers/usb/serial/cypress_m8.c                    |   2 +-
 drivers/usb/serial/empeg.c                         |   2 +-
 drivers/usb/serial/ftdi_sio.c                      |   3 +-
 drivers/usb/serial/ftdi_sio_ids.h                  |   6 +
 drivers/usb/serial/ir-usb.c                        |   2 +-
 drivers/usb/serial/keyspan_pda.c                   |   2 +-
 drivers/usb/serial/omninet.c                       |   2 +-
 drivers/usb/serial/option.c                        |   1 +
 drivers/usb/serial/oti6858.c                       |   2 +-
 drivers/usb/serial/pl2303.c                        |   2 +-
 drivers/usb/serial/usb-serial.c                    |   2 +-
 drivers/usb/serial/visor.c                         |   2 +-
 drivers/usb/serial/visor.h                         |   2 +-
 drivers/usb/serial/whiteheat.c                     |   2 +-
 drivers/usb/serial/whiteheat.h                     |   2 +-
 drivers/usb/storage/scsiglue.c                     |   7 +-
 drivers/usb/typec/tcpm/fusb302.c                   |   3 +-
 drivers/usb/typec/tps6598x.c                       |   6 +-
 drivers/usb/usbip/stub_main.c                      |   8 +-
 drivers/usb/usbip/vhci_tx.c                        |  12 +-
 drivers/usb/wusbcore/Kconfig                       |   8 +-
 drivers/usb/wusbcore/crypto.c                      | 169 ++-----
 include/linux/fsl_devices.h                        |   1 +
 include/linux/usb.h                                |   2 +
 include/linux/usb/chipidea.h                       |   1 +
 include/linux/usb/gadget.h                         |   3 +-
 include/linux/usb/renesas_usbhs.h                  |  39 +-
 include/uapi/linux/usbdevice_fs.h                  |  26 ++
 176 files changed, 2348 insertions(+), 750 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-pxa-usb.txt
 create mode 100644 Documentation/devicetree/bindings/phy/qcom-pcie2-phy.txt
 rename Documentation/devicetree/bindings/usb/{renesas_usb3.txt => renesas,usb3.txt} (100%)
 rename Documentation/devicetree/bindings/usb/{renesas_usbhs.txt => renesas,usbhs.txt} (95%)
 rename Documentation/usb/{acm.txt => acm.rst} (100%)
 rename Documentation/usb/{authorization.txt => authorization.rst} (100%)
 rename Documentation/usb/{chipidea.txt => chipidea.rst} (100%)
 rename Documentation/usb/{dwc3.txt => dwc3.rst} (100%)
 rename Documentation/usb/{ehci.txt => ehci.rst} (100%)
 rename Documentation/usb/{functionfs.txt => functionfs.rst} (100%)
 rename Documentation/usb/{gadget-testing.txt => gadget-testing.rst} (99%)
 rename Documentation/usb/{gadget_configfs.txt => gadget_configfs.rst} (100%)
 rename Documentation/usb/{gadget_hid.txt => gadget_hid.rst} (100%)
 rename Documentation/usb/{gadget_multi.txt => gadget_multi.rst} (100%)
 rename Documentation/usb/{gadget_printer.txt => gadget_printer.rst} (100%)
 rename Documentation/usb/{gadget_serial.txt => gadget_serial.rst} (100%)
 create mode 100644 Documentation/usb/index.rst
 rename Documentation/usb/{iuu_phoenix.txt => iuu_phoenix.rst} (100%)
 rename Documentation/usb/{mass-storage.txt => mass-storage.rst} (100%)
 rename Documentation/usb/{misc_usbsevseg.txt => misc_usbsevseg.rst} (100%)
 rename Documentation/usb/{mtouchusb.txt => mtouchusb.rst} (100%)
 rename Documentation/usb/{ohci.txt => ohci.rst} (100%)
 rename Documentation/usb/{rio.txt => rio.rst} (100%)
 create mode 100644 Documentation/usb/text_files.rst
 rename Documentation/usb/{usb-help.txt => usb-help.rst} (100%)
 rename Documentation/usb/{usb-serial.txt => usb-serial.rst} (100%)
 rename Documentation/usb/{usbip_protocol.txt => usbip_protocol.rst} (100%)
 rename Documentation/usb/{usbmon.txt => usbmon.rst} (100%)
 rename Documentation/usb/{WUSB-Design-overview.txt => wusb-design-overview.rst} (100%)
 create mode 100644 drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
 create mode 100644 drivers/phy/qualcomm/phy-qcom-pcie2.c
 create mode 100644 drivers/usb/common/common.h
 create mode 100644 drivers/usb/renesas_usbhs/rza2.c
