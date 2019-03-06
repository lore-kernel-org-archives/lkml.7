Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BC5C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 777A120661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551868538;
	bh=tU3nZLifXoikKu++2Xl3HKRMfTQRwJahUKCV9WhqLWA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=PVtsc75UfMBdty6LNC2yZ7N9bJosT6MQU3r7D4iIHlwNkSqGFtZftS20BMwX5H+hy
	 9omxIKm7IF2OYk8xV6uvkEz2oRcqcKSd+nHPUzWP24YTZgkQlfFveENo1CIUZijsBM
	 r4MhVk7maPXb2e5jwRBg7VYgBJZjqUtVcB44PuOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbfCFKfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:35:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:33760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728045AbfCFKfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:35:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F222620661;
        Wed,  6 Mar 2019 10:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551868533;
        bh=tU3nZLifXoikKu++2Xl3HKRMfTQRwJahUKCV9WhqLWA=;
        h=Date:From:To:Cc:Subject:From;
        b=J1IieUCdrtrsKUYQV+vwWcKiD1pjIfsl5VraadPjdHjH/8eCbNDhHwWat2Vkt1Mid
         xcYRMoKZf0YqqjgCabCWrzMeEOTVPr4RNVV6nAuizLCPoJgUft17Bvop2ic0aCh9Cj
         YaByKwHozFC5mplCSoREesKCzQwjaglrUqP93ADQ=
Date:   Wed, 6 Mar 2019 11:35:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB/PHY driver patches for 5.1-rc1
Message-ID: <20190306103531.GA10871@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d13937116f1e82bf508a6325111b322c30c85eb9:

  Linux 5.0-rc6 (2019-02-10 14:42:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.1-rc1

for you to fetch changes up to 1c7cf3d5e1c181caca75012b65252288c18a25f2:

  wusb: Remove unnecessary static function ckhdid_printf (2019-03-01 20:53:41 +0100)

----------------------------------------------------------------
USB/PHY patches for 5.1-rc1

Here is the big USB/PHY driver pull request for 5.1-rc1.

The usual set of gadget driver updates, phy driver updates (you will
have a merge issue with Kconfig and Makefile), xhci updates, and typec
additions.  Also included in here are a lot of small cleanups and fixes
and driver updates where needed.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Abel Vesa (1):
      phy: freescale: Break dependency on SOC_IMX8MQ for USB PHY

Alan Stern (1):
      USB: gadget: Improve kerneldoc for usb_ep_dequeue()

Andrzej Pietrasiewicz (4):
      usb: dwc2: gadget: Add scatter-gather mode
      usb: gadget: move non-super speed code out of usb_ep_autoconfig_ss()
      usb: gadget: f_fs: preserve wMaxPacketSize across usb_ep_autoconfig() call
      usb: gadget: Change Andrzej Pietrasiewicz's e-mail address

Andy Shevchenko (1):
      usb: dwc3: drd: Defer probe if extcon device is not found

Balaji Manoharan (1):
      usb: xhci: Fix for Enabling USB ROLE SWITCH QUIRK on INTEL_SUNRISEPOINT_LP_XHCI

Bharath Vedartham (1):
      USB: storage: karma: add whitespace after declarations

Christoph Hellwig (2):
      fotg210-udc: remove a bogus dma_sync_single_for_device call
      fotg210-udc: pass struct device to DMA API functions

Chunfeng Yun (2):
      usb: devio: update max count of DPs per interval for ISOC
      usb: xhci: remove unused member 'parent' in xhci_regset struct

Colin Ian King (6):
      usb: host: u132-hcd: fix a couple of indentation issues
      usb: gadget: fix various indentation issues
      USB: musb: fix indentation issue on a return statement
      usb: host: oxu210hp-hcd: fix indentation issue
      USB: renesas_usbhs: fix spelling mistake "doens't" -> "doesn't"
      usb: typec: mux: remove redundant check on variable match

Daniele Palmas (1):
      USB: serial: option: add Telit ME910 ECM composition

Dmitry Osipenko (1):
      usb: chipidea: tegra: Fix missed ci_hdrc_remove_device()

Dmitry Torokhov (1):
      usb: core: add option of only authorizing internal devices

Enric Balletbo i Serra (3):
      phy: rockchip-inno-usb2: fix misspelling and kernel-doc documentation
      dt-bindings: phy-rockchip-inno-usb2: add documentation for extcon property
      phy: phy-rockchip-inno-usb2: drop reading the utmi-avalid property

Fabrizio Castro (4):
      usb: gadget: udc: renesas_usb3: Add bindings for r8a774c0
      dt-bindings: usb: renesas_usbhs: Add r8a774c0 support
      usb: gadget: udc: renesas_usb3: add support for r8a774c0
      dt-bindings: rcar-gen3-phy-usb2: Add r8a774c0 support

Felipe Balbi (10):
      usb: dwc3: gadget: add dwc3_request status tracking
      usb: dwc3: gadget: prevent dwc3_request from being queued twice
      usb: dwc3: gadget: remove req->started flag
      usb: dwc3: gadget: clear DWC3_EP_TRANSFER_STARTED on cmd complete
      usb: dwc3: gadget: don't use resource_index as a flag
      usb: dwc3: gadget: early giveback if End Transfer already completed
      usb: dwc3: gadget: remove DWC3_EP_END_TRANSFER_PENDING
      usb: dwc3: trace: pass trace buffer size to decoding functions
      usb: dwc3: debug: purge usage of strcat
      usb: dwc3: gadget: don't enable interrupt when disabling endpoint

Greg Kroah-Hartman (10):
      Merge 5.0-rc2 into usb-next
      USB: add missing SPDX lines to Kconfig and Makefiles
      USB: remove README file
      USB: host: whci: rename Kbuild file
      Merge 5.0-rc4 into usb-next
      Merge 5.0-rc6 into usb-next
      Merge tag 'phy-for-5.1' of git://git.kernel.org/.../kishon/linux-phy into usb-next
      Merge tag 'usb-for-v5.1' of git://git.kernel.org/.../balbi/usb into usb-next
      Merge tag 'usb-serial-5.1-rc1' of https://git.kernel.org/.../johan/usb-serial into usb-next
      Merge tag 'usb-serial-5.1-rc1-2' of https://git.kernel.org/.../johan/usb-serial into usb-next

Gregory CLEMENT (1):
      phy: armada375-usb2: switch to SPDX license identifier

Guenter Roeck (1):
      usb: typec: tcpm: Remove unused functions

Guido Kiener (1):
      udc: net2280: Fix net2280_disable

Gustavo A. R. Silva (7):
      USB: core: urb: Use struct_size() in kmalloc()
      xhci: Use struct_size() in kzalloc()
      uwb: use struct_size() in kzalloc()
      USB: musb: mark expected switch fall-through
      usb: dwc2: use struct_size() in kzalloc()
      usb: core: config: Use struct_size() in kzalloc()
      usb: wusbcore: wa-xfer: use struct_size() helper

Heikki Krogerus (13):
      usb: typec: displayport: Move the Configuration VDO helpers to the header
      usb: typec: Prepare alt mode enter/exit reporting for UCSI alt mode support
      usb: typec: ucsi: Remove debug.h file
      usb: typec: tps6598x: Check mode of operation
      platform/x86: intel_cht_int33fe: Prepare for better mux naming scheme
      usb: typec: Rationalize the API for the muxes
      platform/x86: intel_cht_int33fe: Remove old style mux connections
      device connection: Prepare support for firmware described connections
      usb: roles: Find the muxes by also matching against the device node
      usb: typec: Find the ports by also matching against the device node
      device connection: Find device connections also from device graphs
      usb: typec: mux: Find the muxes by also matching against the device node
      device connection: Add fwnode member to struct device_connection

Icenowy Zheng (1):
      USB: serial: cp210x: add GPIO support for CP2104

Ivan Mironov (1):
      USB: serial: cp210x: add ID for Ingenico 3070

Jakub Wilk (1):
      usb: core: Fix typo in description of "authorized_default"

Jan-Marek Glogowski (1):
      usb: handle warm-reset port requests on hub resume

Jean-Philippe Menil (1):
      usb: xhci: fix build warning - missing prototype

Jeffrey Hugo (5):
      dt-bindings: usb: Add support for msm8998
      usb: dwc3: qcom: Add support for MSM8998
      dt-bindings: phy-qcom: Add support for msm8998 usb
      phy: qcom-qmp: Add QMP V3 USB3 PHY support for msm8998
      phy: qcom-qusb2: Add QUSB2 PHY support for msm8998

Jiri Slaby (4):
      usb: sisusb_con, convert addr macros to functions
      usb: sisusb_con, cleanup configs
      usb: sisusb: let files build only when needed
      usb: sisusb: remove useless macros and compact the code

Joe Perches (1):
      wusb: Remove unnecessary static function ckhdid_printf

Johanna Abrahamsson (1):
      USB: serial: cp210x: add minimum baud rate for CP2105 SCI

John Stultz (1):
      usb: f_fs: Avoid crash due to out-of-scope stack ptr access

Jon Flatley (1):
      usb: Change "wired" to "hardwired" for connect_type

Julia Lawall (2):
      usb: gadget: udc: reduce indentation
      usb: gadget: udc: reduce indentation

Jun Li (2):
      usb: typec: tpcm: improve error handling of tcpm_register_port
      usb: chipidea: imx: remove unused header files

Kai-Heng Feng (2):
      USB: Add new USB LPM helpers
      USB: Consolidate LPM checks to avoid enabling LPM twice

Karoly Pados (1):
      USB: serial: cp210x: fix GPIO in autosuspend

Keyur Patel (1):
      usb: core: Replace hardcoded check with inline function from usb.h

Mans Rullgard (4):
      USB: serial: cp210x: support all gpios on CP2102N QFN28 package
      USB: serial: ftdi_sio: add ID for Hjelmslund Electronics USB485
      usb: core: skip interfaces disabled in devicetree
      usb: core: make default autosuspend delay configurable

Marc Gonzalez (3):
      phy: qcom-ufs: Use iopoll.h readl_poll_timeout macro
      dt-bindings: phy-qcom-qmp: Add qcom,msm8998-qmp-ufs-phy
      phy: qcom-qmp: Add QMP UFS PHY support for msm8998

Marco Felsch (2):
      dt-bindings: usb: usb251xb: add documentation for data lane swapping
      usb: usb251xb: add usb data lane port swap feature

Marek Szyprowski (1):
      usb: misc: usb3503: Add system sleep support in non-I2C mode

Matteo Croce (1):
      usb: gadget: aspeed: fix typo

Maxime Ripard (5):
      phy: dphy: Remove unused header
      phy: dphy: Change units of wakeup and init parameters
      phy: dphy: Clarify lanes parameter documentation
      dt-bindings: phy: Move the Cadence D-PHY bindings
      phy: Add Cadence D-PHY support

Michał Mirosław (1):
      usb: gadget: u_serial: process RX in workqueue instead of tasklet

Minas Harutyunyan (1):
      usb: dwc2: Fix EP TxFIFO number setting

Miquel Raynal (10):
      usb: core: comply to PHY framework
      usb: ehci-orion: avoid double PHY initialization
      usb: ehci-orion: add S2RAM support
      phy: mvebu-cp110-comphy: fix port check in ->xlate()
      phy: add A3700 COMPHY support
      dt-bindings: phy: mvebu-comphy: extend the file to describe a3700 bindings
      MAINTAINERS: phy: add entry for Armada 3700 COMPHY driver
      phy: add A3700 UTMI PHY driver
      dt-bindings: phy: mvebu-utmi: add UTMI PHY bindings
      MAINTAINERS: phy: fill Armada 3700 PHY drivers entry

Nicolas Ferre (2):
      USB: host: ohci-at91: add sam9x60-sfr definition for ohci
      dt-bindings: arm: atmel: add new sam9x60 SFR binding

Nicolas Saenz Julienne (1):
      usb: hub: add retry routine after intr URB submit error

Nikolaus Voss (1):
      usb: typec: tps6598x: handle block writes separately with plain-I2C adapters

Nikolay Yakimov (1):
      USB: Fix configuration selection issues introduced in v4.20.0

Ofer Heifetz (1):
      usb: host: xhci: mvebu: add reset on resume quirk

Paul Cercueil (4):
      Documentation: dt: Add binding info for jz4740-musb driver
      usb: musb: jz4740: Add support for devicetree
      usb: musb: Kconfig: Drop dependency on MACH_JZ4740 for jz4740
      usb: musb: Kconfig: Drop dependency on CONFIG_USB for jz4740

Paul Elder (1):
      usb: gadget: uvc: add uvcg_warn macro

Paul Gortmaker (3):
      phy: make phy-core explicitly non-modular
      phy: make phy-mvebu-sata explicitly non-modular
      phy: make phy-armada375-usb2 explicitly non-modular

Paul Kocialkowski (2):
      usb: chipidea: Grab the (legacy) USB PHY by phandle first
      usb: chipidea: Refactor USB PHY selection and keep a single PHY

Peter Chen (1):
      usb: misc: usbtest: add super-speed isoc support

Philipp Puschmann (2):
      dt-bindings: usb: ci-hdrc-usb2: add property power-active-high
      usb: chipidea: imx: set power polarity

Prabhat Chand Pandey (1):
      usb: xhci: dbc: Fixing typo error.

Qingmin Liu (1):
      phy: bcm-sr-pcie: Change operation when PIPEMUX=1

Ran Wang (3):
      usb: ehci: fsl: Update register accessing for arm/arm64 platforms
      usb: kconfig: remove dependency FSL_SOC for ehci fsl driver
      drivers: usb :fsl: Remove USB Errata checking code

Roger Quadros (7):
      usb: dwc3: gadget: Fix OTG events when gadget driver isn't loaded
      dt-bindings: usb: keystone-usb: Add ti,am654-dwc3 support
      usb: dwc3: keystone: Add support for ti,am654-dwc3
      phy: ti: usb2: Fix logic on -EPROBE_DEFER
      phy: ti: Don't depend on OMAP_OCP2SCP
      dt-bindings: phy: ti: Add support for AM654x USB2 PHY
      phy: ti: usb2: Add support for AM654 USB2 PHY

Shuah Khan (2):
      usbip: Fix vhci_urb_enqueue() URB null transfer buffer error path
      usbip: Fix vep_free_request() null pointer checks on input args

Suwan Kim (2):
      usb: core: Simplify return value of usb_get_configuration()
      usb: core: Move variable initialization to appropriate place

Sven Van Asbroeck (1):
      usb: phy: twl6030-usb: fix possible use-after-free on remove

Thierry Reding (1):
      xhci: tegra: Prevent error pointer dereference

Thinh Nguyen (2):
      usb: dwc3: haps: Workaround matching VID PID
      usb: dwc3: Reset num_trbs after skipping

Yoshihiro Shimoda (2):
      usb: renesas_usbhs: replace udelay() with usleep_range()
      usb: renesas_usbhs: replace udelay() with usleep_range()

YueHaibing (6):
      usb: ftdi-elan: remove a unnecessary variable 'empty_packets'
      usb: ftdi-elan: Fix if == else warnings in ftdi_elan_respond_engine
      usb: gadget: Remove dead branch code
      usb: typec: mux: Fix unsigned comparison with less than zero
      usb: host: oxu210hp-hcd: remove set but not used variables 'uframes, transfer_buffer_length'
      cdc-wdm: pass return value of recover_from_urb_loss

liangshengjun (1):
      usb: gadget: function: sync f_uac1 ac header baInterfaceNr

 Documentation/ABI/testing/sysfs-bus-usb            |   2 +-
 Documentation/admin-guide/kernel-parameters.txt    |   3 +-
 .../devicetree/bindings/arm/atmel-sysregs.txt      |   1 +
 .../bindings/display/bridge/cdns,dsi.txt           |  21 --
 .../devicetree/bindings/phy/cdns,dphy.txt          |  20 ++
 .../devicetree/bindings/phy/phy-mvebu-comphy.txt   |  65 +++-
 .../devicetree/bindings/phy/phy-mvebu-utmi.txt     |  38 ++
 .../bindings/phy/phy-rockchip-inno-usb2.txt        |   2 +
 .../devicetree/bindings/phy/qcom-qmp-phy.txt       |   9 +
 .../devicetree/bindings/phy/qcom-qusb2-phy.txt     |   1 +
 .../devicetree/bindings/phy/rcar-gen3-phy-usb2.txt |   2 +
 Documentation/devicetree/bindings/phy/ti-phy.txt   |   1 +
 .../devicetree/bindings/usb/ci-hdrc-usb2.txt       |   1 +
 .../bindings/usb/ingenic,jz4740-musb.txt           |  24 ++
 .../devicetree/bindings/usb/keystone-usb.txt       |   6 +-
 .../devicetree/bindings/usb/qcom,dwc3.txt          |   1 +
 .../devicetree/bindings/usb/renesas_usb3.txt       |   1 +
 .../devicetree/bindings/usb/renesas_usbhs.txt      |   1 +
 Documentation/devicetree/bindings/usb/usb251xb.txt |   4 +
 Documentation/usb/authorization.txt                |   4 +-
 MAINTAINERS                                        |   8 +
 drivers/base/devcon.c                              |  62 +++-
 drivers/phy/broadcom/phy-bcm-sr-pcie.c             |   4 +-
 drivers/phy/cadence/Kconfig                        |  13 +-
 drivers/phy/cadence/Makefile                       |   1 +
 drivers/phy/cadence/cdns-dphy.c                    | 391 +++++++++++++++++++++
 drivers/phy/freescale/Kconfig                      |   2 +-
 drivers/phy/marvell/Kconfig                        |  21 ++
 drivers/phy/marvell/Makefile                       |   2 +
 drivers/phy/marvell/phy-armada375-usb2.c           |  13 +-
 drivers/phy/marvell/phy-mvebu-a3700-comphy.c       | 318 +++++++++++++++++
 drivers/phy/marvell/phy-mvebu-a3700-utmi.c         | 278 +++++++++++++++
 drivers/phy/marvell/phy-mvebu-cp110-comphy.c       |   2 -
 drivers/phy/marvell/phy-mvebu-sata.c               |   9 +-
 drivers/phy/phy-core-mipi-dphy.c                   |   8 +-
 drivers/phy/phy-core.c                             |  12 +-
 drivers/phy/qualcomm/phy-qcom-qmp.c                | 143 ++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h                |   4 +
 drivers/phy/qualcomm/phy-qcom-qusb2.c              |  40 +++
 drivers/phy/qualcomm/phy-qcom-ufs-i.h              |  19 +-
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c      |  48 ++-
 drivers/phy/ti/Kconfig                             |   6 +-
 drivers/phy/ti/phy-omap-usb2.c                     | 105 +++---
 drivers/platform/x86/intel_cht_int33fe.c           |  15 +-
 drivers/usb/Kconfig                                |   1 +
 drivers/usb/README                                 |  54 ---
 drivers/usb/atm/Kconfig                            |   1 +
 drivers/usb/chipidea/Kconfig                       |   2 +
 drivers/usb/chipidea/ci_hdrc_imx.c                 |   6 +-
 drivers/usb/chipidea/ci_hdrc_imx.h                 |   1 +
 drivers/usb/chipidea/ci_hdrc_tegra.c               |   1 +
 drivers/usb/chipidea/core.c                        |  46 ++-
 drivers/usb/chipidea/usbmisc_imx.c                 |   7 +
 drivers/usb/class/Kconfig                          |   1 +
 drivers/usb/class/cdc-wdm.c                        |   2 +-
 drivers/usb/core/Kconfig                           |  13 +
 drivers/usb/core/config.c                          |  14 +-
 drivers/usb/core/devio.c                           |  10 +-
 drivers/usb/core/driver.c                          |  23 +-
 drivers/usb/core/generic.c                         |  44 ++-
 drivers/usb/core/hcd.c                             |  56 +--
 drivers/usb/core/hub.c                             |  66 +++-
 drivers/usb/core/hub.h                             |   2 +
 drivers/usb/core/message.c                         |  10 +-
 drivers/usb/core/phy.c                             |  28 ++
 drivers/usb/core/phy.h                             |   2 +
 drivers/usb/core/sysfs.c                           |   5 +-
 drivers/usb/core/urb.c                             |   5 +-
 drivers/usb/core/usb.c                             |  37 +-
 drivers/usb/core/usb.h                             |  10 +-
 drivers/usb/dwc2/Kconfig                           |   2 +
 drivers/usb/dwc2/gadget.c                          | 114 ++++--
 drivers/usb/dwc2/hcd.c                             |   4 +-
 drivers/usb/dwc3/Kconfig                           |   8 +-
 drivers/usb/dwc3/core.h                            |  12 +-
 drivers/usb/dwc3/debug.h                           | 156 ++++----
 drivers/usb/dwc3/drd.c                             |   9 +-
 drivers/usb/dwc3/dwc3-haps.c                       |   9 +
 drivers/usb/dwc3/dwc3-keystone.c                   |  11 +-
 drivers/usb/dwc3/dwc3-qcom.c                       |   1 +
 drivers/usb/dwc3/gadget.c                          |  65 ++--
 drivers/usb/dwc3/gadget.h                          |   4 +-
 drivers/usb/dwc3/trace.h                           |  10 +-
 drivers/usb/gadget/Kconfig                         |   1 +
 drivers/usb/gadget/epautoconf.c                    |  41 ++-
 drivers/usb/gadget/function/f_fs.c                 |  12 +
 drivers/usb/gadget/function/f_uac1.c               |  10 +-
 drivers/usb/gadget/function/u_ecm.h                |   2 +-
 drivers/usb/gadget/function/u_eem.h                |   2 +-
 drivers/usb/gadget/function/u_ether_configfs.h     |   2 +-
 drivers/usb/gadget/function/u_fs.h                 |   2 +-
 drivers/usb/gadget/function/u_gether.h             |   2 +-
 drivers/usb/gadget/function/u_hid.h                |   2 +-
 drivers/usb/gadget/function/u_midi.h               |   2 +-
 drivers/usb/gadget/function/u_ncm.h                |   2 +-
 drivers/usb/gadget/function/u_printer.h            |   2 +-
 drivers/usb/gadget/function/u_rndis.h              |   2 +-
 drivers/usb/gadget/function/u_serial.c             |  35 +-
 drivers/usb/gadget/function/u_uac2.h               |   2 +-
 drivers/usb/gadget/function/u_uvc.h                |   2 +-
 drivers/usb/gadget/function/uvc.h                  |   2 +
 drivers/usb/gadget/function/uvc_configfs.c         |  10 +-
 drivers/usb/gadget/function/uvc_configfs.h         |   2 +-
 drivers/usb/gadget/function/uvc_v4l2.h             |   2 +-
 drivers/usb/gadget/function/uvc_video.h            |   2 +-
 drivers/usb/gadget/legacy/Kconfig                  |   1 +
 drivers/usb/gadget/legacy/inode.c                  |  40 +--
 drivers/usb/gadget/u_f.c                           |   2 +-
 drivers/usb/gadget/u_f.h                           |   2 +-
 drivers/usb/gadget/u_os_desc.h                     |   2 +-
 drivers/usb/gadget/udc/Kconfig                     |   1 +
 drivers/usb/gadget/udc/aspeed-vhub/epn.c           |   2 +-
 drivers/usb/gadget/udc/aspeed-vhub/hub.c           |   2 +-
 drivers/usb/gadget/udc/bdc/Kconfig                 |   2 +
 drivers/usb/gadget/udc/bdc/bdc_cmd.c               |   4 +-
 drivers/usb/gadget/udc/core.c                      |   8 +-
 drivers/usb/gadget/udc/fotg210-udc.c               |  11 +-
 drivers/usb/gadget/udc/net2280.c                   |   6 +-
 drivers/usb/gadget/udc/renesas_usb3.c              |   4 +
 drivers/usb/gadget/udc/snps_udc_core.c             |  17 +-
 drivers/usb/host/Kconfig                           |   8 +-
 drivers/usb/host/ehci-fsl.c                        |  69 ++--
 drivers/usb/host/ehci-orion.c                      |  44 ++-
 drivers/usb/host/fsl-mph-dr-of.c                   |   6 +
 drivers/usb/host/ohci-at91.c                       |   7 +-
 drivers/usb/host/oxu210hp-hcd.c                    |  10 +-
 drivers/usb/host/u132-hcd.c                        |   6 +-
 drivers/usb/host/whci/{Kbuild => Makefile}         |   2 +
 drivers/usb/host/xhci-dbgcap.c                     |   6 +-
 drivers/usb/host/xhci-debugfs.h                    |   1 -
 drivers/usb/host/xhci-mem.c                        |   2 +-
 drivers/usb/host/xhci-mvebu.c                      |  11 +
 drivers/usb/host/xhci-mvebu.h                      |   6 +
 drivers/usb/host/xhci-pci.c                        |   1 +
 drivers/usb/host/xhci-plat.c                       |   7 +
 drivers/usb/host/xhci-tegra.c                      |   4 +-
 drivers/usb/host/xhci.c                            |   3 +-
 drivers/usb/image/Kconfig                          |   1 +
 drivers/usb/isp1760/Kconfig                        |   2 +
 drivers/usb/misc/Kconfig                           |   1 +
 drivers/usb/misc/ftdi-elan.c                       |  26 --
 drivers/usb/misc/sisusbvga/Kconfig                 |   1 +
 drivers/usb/misc/sisusbvga/Makefile                |   3 +-
 drivers/usb/misc/sisusbvga/sisusb.c                |  32 +-
 drivers/usb/misc/sisusbvga/sisusb.h                |  15 +-
 drivers/usb/misc/sisusbvga/sisusb_con.c            | 127 +++----
 drivers/usb/misc/sisusbvga/sisusb_init.c           |   5 -
 drivers/usb/misc/usb251xb.c                        |  15 +-
 drivers/usb/misc/usb3503.c                         |  38 +-
 drivers/usb/misc/usbtest.c                         |  28 +-
 drivers/usb/mon/Kconfig                            |   1 +
 drivers/usb/mtu3/Kconfig                           |   2 +
 drivers/usb/musb/Kconfig                           |   5 +-
 drivers/usb/musb/jz4740.c                          |  10 +
 drivers/usb/musb/musb_host.c                       |   4 +-
 drivers/usb/phy/Kconfig                            |   1 +
 drivers/usb/phy/phy-twl6030-usb.c                  |   2 +-
 drivers/usb/renesas_usbhs/mod_host.c               |   2 +-
 drivers/usb/renesas_usbhs/rcar3.c                  |   2 +-
 drivers/usb/renesas_usbhs/rza.c                    |   2 +-
 drivers/usb/roles/Kconfig                          |   2 +
 drivers/usb/roles/Makefile                         |   2 +
 drivers/usb/roles/class.c                          |  21 +-
 drivers/usb/serial/Kconfig                         |   1 +
 drivers/usb/serial/cp210x.c                        | 130 ++++++-
 drivers/usb/serial/ftdi_sio.c                      |   2 +
 drivers/usb/serial/ftdi_sio_ids.h                  |   6 +
 drivers/usb/serial/option.c                        |   2 +
 drivers/usb/storage/Kconfig                        |   1 +
 drivers/usb/storage/karma.c                        |   2 +
 drivers/usb/typec/Kconfig                          |   1 +
 drivers/usb/typec/altmodes/Kconfig                 |   1 +
 drivers/usb/typec/altmodes/Makefile                |   2 +
 drivers/usb/typec/altmodes/displayport.c           |   4 -
 drivers/usb/typec/class.c                          |  33 +-
 drivers/usb/typec/mux.c                            |  94 ++++-
 drivers/usb/typec/mux/Kconfig                      |   2 +
 drivers/usb/typec/tcpm/Kconfig                     |   2 +
 drivers/usb/typec/tcpm/tcpm.c                      |  68 +---
 drivers/usb/typec/tps6598x.c                       |  79 ++++-
 drivers/usb/typec/ucsi/Kconfig                     |   2 +
 drivers/usb/typec/ucsi/debug.h                     |  65 ----
 drivers/usb/typec/ucsi/trace.c                     |  59 ++++
 drivers/usb/typec/ucsi/trace.h                     |   7 +-
 drivers/usb/usbip/Kconfig                          |   2 +
 drivers/usb/usbip/vhci_hcd.c                       |   6 +-
 drivers/usb/usbip/vudc_dev.c                       |   3 +-
 drivers/usb/wusbcore/Kconfig                       |   1 +
 drivers/usb/wusbcore/cbaf.c                        |  15 +-
 drivers/usb/wusbcore/dev-sysfs.c                   |   5 +-
 drivers/usb/wusbcore/devconnect.c                  |   2 +-
 drivers/usb/wusbcore/wa-xfer.c                     |  15 +-
 drivers/usb/wusbcore/wusbhc.c                      |   6 +-
 drivers/uwb/drp-ie.c                               |   5 +-
 include/linux/device.h                             |   6 +
 include/linux/fsl_devices.h                        |   7 +-
 include/linux/phy/phy-mipi-dphy.h                  |  13 +-
 include/linux/usb/hcd.h                            |  10 +-
 include/linux/usb/role.h                           |   2 +
 include/linux/usb/tcpm.h                           |   6 -
 include/linux/usb/typec_dp.h                       |   4 +
 include/linux/usb/typec_mux.h                      |   3 +-
 include/linux/usb/wusb.h                           |  16 -
 203 files changed, 2951 insertions(+), 1110 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt
 create mode 100644 Documentation/devicetree/bindings/usb/ingenic,jz4740-musb.txt
 create mode 100644 drivers/phy/cadence/cdns-dphy.c
 create mode 100644 drivers/phy/marvell/phy-mvebu-a3700-comphy.c
 create mode 100644 drivers/phy/marvell/phy-mvebu-a3700-utmi.c
 delete mode 100644 drivers/usb/README
 rename drivers/usb/host/whci/{Kbuild => Makefile} (79%)
 delete mode 100644 drivers/usb/typec/ucsi/debug.h
