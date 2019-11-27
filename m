Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8758FC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 16:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA92206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 16:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574870625;
	bh=lP960T23fgabcOf2fB6Zg1XKgeu5dYblFqKz1YdlIHc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=neLnqekrayivkpsMA+DS9mD95JDurF9eRQ+GgI+utmpgAz0XQ+ycbT3t/A8DukYP5
	 5WRceMM8qT3iFPLM3E+XXwCu00KepDHseTt3+1T8D7ULFmzcW6hAFpP4UcoiX3cFiB
	 LnX54jbpAasbvcyygIKwyL4iwFCLvylSyr8zRX1U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfK0QDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 11:03:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:55342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfK0QDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 11:03:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF806206E0;
        Wed, 27 Nov 2019 16:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574870621;
        bh=lP960T23fgabcOf2fB6Zg1XKgeu5dYblFqKz1YdlIHc=;
        h=Date:From:To:Cc:Subject:From;
        b=rqfwHy1BfPenZzwts5kMVJqmn9QinYzsBr3bsR17qVkAD9xQyYTTxlpEMGbc2gABr
         BAz72oAd4mjjJeHxARJ9waYepDy4wBs1FbW9a5MAHQ5UNiZw2EbgcW7jNA7xdzGWpb
         mp79JALwqr/I7qH6oTlWZUCIdlXXGmw16naXyVI0=
Date:   Wed, 27 Nov 2019 17:03:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB patches for 5.5-rc1
Message-ID: <20191127160338.GA3032225@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a99d8080aaf358d5d23581244e5da23b35e340b9:

  Linux 5.4-rc6 (2019-11-03 14:07:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.5-rc1

for you to fetch changes up to 91a9f2d3f9762e59cca251d2c6cef8cda1a4e62b:

  usb: gadget: udc: gr_udc: create debugfs directory under usb root (2019-11-21 18:20:29 +0100)

----------------------------------------------------------------
USB patches for 5.5-rc1

Here is the big set of USB patches for 5.5-rc1

Lots of little things in here:
  - typec updates and additions
  - usb-serial drivers cleanups and fixes
  - misc USB drivers cleanups and fixes
  - gadget drivers new features and controllers added
  - usual xhci additions
  - other minor changes

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aleksander Morgado (2):
      USB: serial: option: add support for DW5821e with eSIM support
      USB: serial: option: add support for Foxconn T77W968 LTE modules

Andrey Konovalov (4):
      USB: dummy-hcd: increase max number of devices to 32
      USB: dummy-hcd: use usb_urb_dir_in instead of usb_pipein
      USB: dummy-hcd: increase max number of devices to 32
      USB: dummy-hcd: use usb_urb_dir_in instead of usb_pipein

Bartosz Golaszewski (1):
      usb: host: xhci-tegra: use regulator_bulk_set_supply_names()

Ben Dooks (1):
      usb: ohci-nxp: fix use of integer as pointer

Ben Dooks (Codethink) (3):
      usb: renesas_usbhs: fix __le16 warnings
      usb: renesas_usbhs: fix type of buf
      usb: host: oxu210hp-hcd: fix __iomem annotations

Biju Das (4):
      dt-bindings: usb: hd3ss3220 device tree binding document
      usb: typec: driver for TI HD3SS3220 USB Type-C DRP port controller
      dt-bindings: usb: renesas_usb3: Document usb role switch support
      usb: typec: hd3ss3220: hd3ss3220_probe() warn: passing zero to 'PTR_ERR'

Boris Krasnovskiy (2):
      USB: host: ohci-at91: completely shutdown the controller in at91_stop_hc()
      USB: host: ohci-at91: resume: balance the clock start call

Charles Yeh (1):
      USB: serial: pl2303: add support for PL2303HXN

Chuhong Yuan (2):
      USB: bcma: Add a check for devm_gpiod_get
      usb: host: fotg210: add missed clk_put calls

Chunfeng Yun (17):
      usb: mtu3: add a new function to do status stage
      usb: mtu3: fix race condition about delayed_status
      usb: mtu3: add a new function to do status stage
      usb: mtu3: fix race condition about delayed_status
      usb: chipidea: debug: create debugfs directory under usb root
      usb: host: imx21: create debugfs directory under usb root
      usb: dwc3: create debugfs directory under usb root
      media: uvcvideo: drop error check of debugfs_create_dir()
      usb: musb: dsps: create debugfs directory under usb root
      usb: dwc2: create debugfs directory under usb root
      usb: gadget: bcm63xx_udc: create debugfs directory under usb root
      usb: gadget: udc: renesas_usb3: create debugfs directory under usb root
      usb: gadget: pxa27x: create debugfs directory under usb root
      usb: gadget: udc: s3c2410_udc: create debugfs directory under usb root
      usb: musb: create debugfs directory under usb root
      usb: gadget: atmel: create debugfs directory under usb root
      usb: gadget: udc: gr_udc: create debugfs directory under usb root

Colin Ian King (5):
      usb: host: u132-hcd: fix spelling mistake "overcurren" -> "overcurrent"
      usb: ftdi-elan: move a couple of statements to next line
      usbip: clean up an indentation issue
      USB: gadget: udc: clean up an indentation issue
      USB: gadget: udc: clean up an indentation issue

Dan Carpenter (1):
      usb: typec: fix an IS_ERR() vs NULL bug in hd3ss3220_probe()

David Heinzelmann (1):
      usb: hub: Check device descriptor before resusciation

Eugeniu Rosca (4):
      usb: renesas_usbhs: simplify usbhs_status_get_device_state()
      usb: renesas_usbhs: enable DVSE interrupt
      usb: renesas_usbhs: enable DVSE interrupt
      usb: renesas_usbhs: simplify usbhs_status_get_device_state()

Fabio D'Urso (1):
      USB: serial: ftdi_sio: add device IDs for U-Blox C099-F9P

Fabrizio Castro (6):
      dt-bindings: usb-xhci: Add r8a774b1 support
      dt-bindings: usb: renesas_usb3: Document r8a774b1 support
      dt-bindings: rcar-gen3-phy-usb3: Add r8a774b1 support
      dt-bindings: usb: renesas_usbhs: Add r8a774b1 support
      dt-bindings: rcar-gen3-phy-usb2: Add r8a774b1 support
      dt-bindings: dmaengine: usb-dmac: Add binding for r8a774b1

Felipe Balbi (1):
      usb: dwc3: of-simple: add a shutdown

Geert Uytterhoeven (3):
      phy: renesas: rcar-gen3-usb2: Use platform_get_irq_optional() for optional irq
      usb: Spelling s/enpoint/endpoint/
      usb: Spelling s/disconnet/disconnect/

Greg Kroah-Hartman (7):
      Merge 5.4-rc3 into usb-next
      Merge 5.4-rc5 into usb-next
      Merge 5.4-rc6 into usb-next
      Merge tag 'usb-serial-5.5-rc1' of https://git.kernel.org/.../johan/usb-serial into usb-next
      Merge tag 'usb-for-v5.5' of git://git.kernel.org/.../balbi/usb into usb-next
      usb-serial: cp201x: support Mark-10 digital force gauge
      Merge tag 'usb-ci-v5.5-rc1' of git://git.kernel.org/.../peter.chen/usb into usb-next

Gustavo A. R. Silva (1):
      usb: gadget: pch_udc: fix use after free

Hans de Goede (1):
      usb: typec: tcpm: Remove tcpc_config configuration mechanism

Heikki Krogerus (20):
      usb: roles: Add usb_role_switch_find_by_fwnode()
      extcon: axp288: Remove the build-in connection description
      usb: typec: Copy everything from struct typec_capability during registration
      usb: typec: Introduce typec_get_drvdata()
      usb: typec: Separate the operations vector
      usb: typec: tcpm: Start using struct typec_operations
      usb: typec: tps6598x: Start using struct typec_operations
      usb: typec: ucsi: Start using struct typec_operations
      usb: typec: hd3ss3220: Start using struct typec_operations
      usb: typec: Remove the callback members from struct typec_capability
      usb: typec: Remove unused members from struct typec_capability
      usb: typec: hd3ss3220: Give the connector fwnode to the port device
      usb: typec: ucsi: Simplified registration and I/O API
      usb: typec: ucsi: acpi: Move to the new API
      usb: typec: ucsi: ccg: Move to the new API
      usb: typec: ucsi: Remove the old API
      usb: typec: ucsi: Remove struct ucsi_control
      usb: typec: ucsi: Remove all bit-fields
      usb: typec: ucsi: New error codes
      usb: typec: ucsi: Optimise ucsi_unregister()

Hewenliang (1):
      usbip: tools: fix fd leakage in the function of read_attr_usbip_status

Ingo Rohloff (1):
      usb: usbfs: Suppress problematic bind and unbind uevents.

JC Kuo (2):
      xhci: tegra: Parameterize mailbox register addresses
      usb: host: xhci-tegra: Add Tegra194 XHCI support

Jayshri Pawar (1):
      usb: gadget: f_tcm: Provide support to get alternate setting in tcm function

Joel Stanley (1):
      usb: gadget: Quieten gadget config message

Johan Hovold (32):
      USB: core: drop OOM message
      USB: serial: ch341: reimplement line-speed handling
      USB: idmouse: simplify disconnect handling
      USB: idmouse: drop redundant open-count check from release
      USB: idmouse: clean up runaway white space
      USB: legousbtower: drop redundant MODULE_LICENSE ifdef
      USB: legousbtower: drop redundant NULL check
      USB: legousbtower: zero driver data at allocation
      USB: legousbtower: drop redundant open_count check
      USB: legousbtower: drop noisy disconnect messages
      USB: legousbtower: drop redundant interrupt-in running flag
      USB: legousbtower: stop interrupt-out URB unconditionally
      USB: legousbtower: remove tower_abort_transfers()
      USB: legousbtower: clean up pointer declarations in driver data
      USB: legousbtower: drop unnecessary packed attributes
      USB: legousbtower: drop redundant endianness comments
      USB: legousbtower: clean up runaway white space
      USB: legousbtower: drop superfluous brackets
      USB: legousbtower: drop superfluous newlines
      USB: serial: mos7720: fix remote wakeup
      USB: serial: mos7840: fix remote wakeup
      USB: serial: mos7840: clean up device-type handling
      USB: serial: mos7840: document MCS7810 detection hack
      USB: serial: mos7840: fix probe error handling
      USB: serial: mos7840: rip out broken interrupt handling
      USB: serial: mos7840: drop redundant urb context check
      USB: serial: mos7840: drop paranoid port checks
      USB: serial: mos7840: drop paranoid serial checks
      USB: serial: mos7840: drop serial struct accessor
      USB: serial: mos7840: drop port driver data accessors
      USB: serial: mos7840: drop read-urb check
      USB: serial: mos7840: drop port open flag

John Stultz (1):
      dt-bindings: usb: rt1711h: Add connector bindings

Jun Li (1):
      usb: chipidea: udc: protect usb interrupt enable

Kai-Heng Feng (1):
      usb: Allow USB device to be warm reset in suspended state

Krzysztof Kozlowski (6):
      usb: Fix Kconfig indentation
      usb: dwc3: Fix Kconfig indentation
      usb: host: Fix Kconfig indentation
      usb: gadget: Fix Kconfig indentation
      usb: misc: Fix Kconfig indentation
      usb: serial: Fix Kconfig indentation

Laura Abbott (1):
      usb-storage: Disable UAS on JMicron SATA enclosure

Li Jun (2):
      usb: chipidea: imx: enable vbus and id wakeup only for OTG events
      usb: chipidea: imx: check data->usbmisc_data against NULL before access

Mao Wenan (1):
      usb: typec: add dependency for TYPEC_HD3SS3220

Marco Felsch (4):
      dt-bindings: usb: usb251xb: add documentation for voltage supply
      usb: usb251xb: add vdd supply support
      usb: usb251xb: simplify reset helper
      usb: usb251xb: add pm_ops

Markus Elfring (1):
      usb: gadget: udc: lpc32xx: Use devm_platform_ioremap_resource() in lpc32xx_udc_probe()

Mathias Kresin (1):
      usb: dwc2: use a longer core rest timeout in dwc2_core_reset()

Mathias Nyman (1):
      xhci: Add tracing for xhci doorbell register writes

Matthias Maennich (1):
      usb-storage: SCSI glue: use dev_err instead of printk

Michał Mirosław (7):
      usb: gadget: u_serial: add missing port entry locking
      usb: gadget: u_serial: reimplement console support
      usb: gadget: u_serial: make OBEX port not a console
      usb: gadget: u_serial: allow more console gadget ports
      usb: gadget: legacy/serial: allow dynamic removal
      usb: gadget: u_serial: diagnose missed console messages
      usb: gadget: u_serial: use mutex for serialising open()s

Mika Westerberg (1):
      xhci-pci: Allow host runtime PM as default also for Intel Ice Lake xHCI

Nagarjuna Kristam (2):
      usb: gadget: Add UDC driver for tegra XUSB device mode controller
      usb: host: xhci-tegra: Correct phy enable sequence

Nathan Chancellor (1):
      USB: host: ohci-at91: Remove unused variable regs in at91_stop_hc

Nicolas Ferre (1):
      USB: host: ohci-at91: suspend: delay needed before to stop clocks

Nikhil Badola (2):
      usb: fsl: Remove unused variable
      usb: gadget: Correct NULL pointer checking in fsl gadget

Oliver Neukum (6):
      appledisplay: fix error handling in the scheduled work
      USB: chaoskey: fix error case of a timeout
      USBIP: add config dependency for SGL_ALLOC
      USB: uas: honor flag to avoid CAPACITY16
      USB: uas: heed CAPACITY_HEURISTICS
      USB: documentation: flags on usb-storage versus UAS

Pavel Löbl (1):
      USB: serial: mos7840: add USB ID to support Moxa UPort 2210

Peter Chen (7):
      usb: gadget: configfs: fix concurrent issue between composite APIs
      usb: host: xhci: update event ring dequeue pointer on purpose
      usb: chipidea: udc: add new API ci_hdrc_gadget_connect
      usb: chipidea: core: change vbus-regulator as optional
      usb: chipidea: imx: change hsic power regulator as optional
      usb: chipidea: imx: refine the error handling for hsic
      usb: chipidea: imx: pinctrl for HSIC is optional

Peter Geis (1):
      usb: chipidea: tegra: clean up tegra_udc flag code

Peter Ujfalusi (1):
      usb: renesas_usbhs: Use dma_request_chan() directly for channel request

Roger Quadros (2):
      dt-bindings: usb: Add binding for the TI wrapper for Cadence USB3 controller
      usb: cdns3: Add TI specific wrapper driver

Saurav Girepunje (4):
      usb: musb: musb_gadget.c: Remove unused variable
      usb: image: microtek.c: Remove unused variable
      usb: isp1760: isp1760-hcd.c: Drop condition with no effect
      usb: core: devio.c: Fix assignment of 0/1 to bool variables

Suwan Kim (2):
      usbip: Fix uninitialized symbol 'nents' in stub_recv_cmd_submit()
      usb: host: xhci: Support running urb giveback in tasklet context

Thinh Nguyen (2):
      usb: dwc3: Disable phy suspend after power-on reset
      usb: dwc3: debug: Remove newline printout

Uwe Kleine-König (3):
      usb: usb251xb: Drop some unused defines
      usb: usb251xb: Document chip variant usb2422
      usb: usb251xb: Add support for USB2422

Veeraiyan Chidambaram (3):
      usb: renesas_usbhs: add suspend event support in gadget mode
      usb: gadget: udc: renesas_usb3: add suspend event support
      usb: renesas_usbhs: add suspend event support in gadget mode

Wei Yongjun (1):
      usb: gadget: configfs: Fix missing spin_lock_init()

Yoshihiro Shimoda (2):
      dt-bindings: usb: renesas: usb3-peri: convert bindings to json-schema
      dt-bindings: usb: renesas_usbhs: convert bindings to json-schema

YueHaibing (28):
      usb: gadget: s3c-hsudc: use devm_platform_ioremap_resource() to simplify code
      usb: gadget: renesas_usb3: use devm_platform_ioremap_resource() to simplify code
      usb: gadget: r8a66597-udc: use devm_platform_ioremap_resource() to simplify code
      usb: gadget: pxa27x_udc: use devm_platform_ioremap_resource() to simplify code
      usb: gadget: pxa25x_udc: use devm_platform_ioremap_resource() to simplify code
      usb: gadget: gr_udc: use devm_platform_ioremap_resource() to simplify code
      usb: bdc: use devm_platform_ioremap_resource() to simplify code
      usb: gadget: bcm63xx_udc: use devm_platform_ioremap_resource() to simplify code
      usb: host: xhci-tegra: use devm_platform_ioremap_resource() to simplify code
      usb: isp1362-hcd: use devm_platform_ioremap_resource() to simplify code
      usb: gadget: at91_udc: use devm_platform_ioremap_resource() to simplify code
      usb: renesas_usbhs: use devm_platform_ioremap_resource() to simplify code
      usb: phy: mxs: use devm_platform_ioremap_resource() to simplify code
      usb: phy: keystone: use devm_platform_ioremap_resource() to simplify code
      USB: musb: use devm_platform_ioremap_resource() to simplify code
      usb: typec: remove duplicated include from hd3ss3220.c
      usb: phy: keystone: use devm_platform_ioremap_resource() to simplify code
      usb: phy: mxs: use devm_platform_ioremap_resource() to simplify code
      usb: renesas_usbhs: use devm_platform_ioremap_resource() to simplify code
      usb: gadget: at91_udc: use devm_platform_ioremap_resource() to simplify code
      usb: gadget: bcm63xx_udc: use devm_platform_ioremap_resource() to simplify code
      usb: bdc: use devm_platform_ioremap_resource() to simplify code
      usb: gadget: gr_udc: use devm_platform_ioremap_resource() to simplify code
      usb: gadget: pxa25x_udc: use devm_platform_ioremap_resource() to simplify code
      usb: gadget: pxa27x_udc: use devm_platform_ioremap_resource() to simplify code
      usb: gadget: r8a66597-udc: use devm_platform_ioremap_resource() to simplify code
      usb: gadget: renesas_usb3: use devm_platform_ioremap_resource() to simplify code
      usb: gadget: s3c-hsudc: use devm_platform_ioremap_resource() to simplify code

kbuild test robot (1):
      usb: typec: hd3ss3220_irq() can be static

zhengbin (4):
      usb: gadget: Remove set but not used variable 'opts' in acm_ms_do_config
      usb: gadget: Remove set but not used variable 'opts' in msg_do_config
      usb: gadget: Remove set but not used variable 'opts' in acm_ms_do_config
      usb: gadget: Remove set but not used variable 'opts' in msg_do_config

 Documentation/admin-guide/kernel-parameters.txt    |   22 +-
 .../devicetree/bindings/dma/renesas,usb-dmac.txt   |    1 +
 .../devicetree/bindings/phy/rcar-gen3-phy-usb2.txt |    2 +
 .../devicetree/bindings/phy/rcar-gen3-phy-usb3.txt |    2 +
 .../devicetree/bindings/usb/renesas,usb3-peri.txt  |   41 -
 .../devicetree/bindings/usb/renesas,usb3-peri.yaml |   86 +
 .../devicetree/bindings/usb/renesas,usbhs.txt      |   57 -
 .../devicetree/bindings/usb/renesas,usbhs.yaml     |  126 +
 .../devicetree/bindings/usb/richtek,rt1711h.txt    |   29 +
 .../devicetree/bindings/usb/ti,hd3ss3220.txt       |   38 +
 .../devicetree/bindings/usb/ti,j721e-usb.yaml      |   86 +
 Documentation/devicetree/bindings/usb/usb-xhci.txt |    1 +
 Documentation/devicetree/bindings/usb/usb251xb.txt |    3 +-
 drivers/extcon/extcon-axp288.c                     |   38 +-
 drivers/media/usb/uvc/uvc_debugfs.c                |   10 +-
 drivers/phy/renesas/phy-rcar-gen3-usb2.c           |    2 +-
 drivers/usb/cdns3/Kconfig                          |   10 +
 drivers/usb/cdns3/Makefile                         |    1 +
 drivers/usb/cdns3/cdns3-ti.c                       |  236 ++
 drivers/usb/chipidea/ci_hdrc_imx.c                 |   79 +-
 drivers/usb/chipidea/ci_hdrc_imx.h                 |    2 +
 drivers/usb/chipidea/ci_hdrc_tegra.c               |   22 +-
 drivers/usb/chipidea/core.c                        |    2 +-
 drivers/usb/chipidea/debug.c                       |    2 +-
 drivers/usb/chipidea/udc.c                         |   75 +-
 drivers/usb/chipidea/usbmisc_imx.c                 |   31 +-
 drivers/usb/core/config.c                          |   12 +-
 drivers/usb/core/devio.c                           |   19 +-
 drivers/usb/core/hub.c                             |  201 +-
 drivers/usb/dwc2/core.c                            |    2 +-
 drivers/usb/dwc2/core.h                            |    2 +-
 drivers/usb/dwc2/debugfs.c                         |    2 +-
 drivers/usb/dwc3/Kconfig                           |   30 +-
 drivers/usb/dwc3/core.c                            |   37 +
 drivers/usb/dwc3/debug.h                           |    4 +-
 drivers/usb/dwc3/debugfs.c                         |    2 +-
 drivers/usb/dwc3/dwc3-of-simple.c                  |   28 +-
 drivers/usb/gadget/composite.c                     |    6 +-
 drivers/usb/gadget/configfs.c                      |    1 +
 drivers/usb/gadget/function/f_acm.c                |   21 +
 drivers/usb/gadget/function/f_obex.c               |    2 +-
 drivers/usb/gadget/function/f_serial.c             |   21 +
 drivers/usb/gadget/function/f_tcm.c                |   13 +-
 drivers/usb/gadget/function/u_serial.c             |  516 +--
 drivers/usb/gadget/function/u_serial.h             |    8 +
 drivers/usb/gadget/legacy/Kconfig                  |   26 +-
 drivers/usb/gadget/legacy/acm_ms.c                 |    3 -
 drivers/usb/gadget/legacy/mass_storage.c           |    3 -
 drivers/usb/gadget/legacy/serial.c                 |   49 +-
 drivers/usb/gadget/udc/Kconfig                     |   19 +-
 drivers/usb/gadget/udc/Makefile                    |    1 +
 drivers/usb/gadget/udc/at91_udc.c                  |    4 +-
 drivers/usb/gadget/udc/atmel_usba_udc.c            |    3 +-
 drivers/usb/gadget/udc/bcm63xx_udc.c               |    9 +-
 drivers/usb/gadget/udc/bdc/bdc_core.c              |    4 +-
 drivers/usb/gadget/udc/bdc/bdc_udc.c               |    2 +-
 drivers/usb/gadget/udc/dummy_hcd.c                 |   10 +-
 drivers/usb/gadget/udc/fsl_qe_udc.h                |    4 +-
 drivers/usb/gadget/udc/fsl_udc_core.c              |   12 +-
 drivers/usb/gadget/udc/gr_udc.c                    |    7 +-
 drivers/usb/gadget/udc/lpc32xx_udc.c               |    6 +-
 drivers/usb/gadget/udc/mv_u3d.h                    |    2 +-
 drivers/usb/gadget/udc/pch_udc.c                   |    1 -
 drivers/usb/gadget/udc/pxa25x_udc.c                |    4 +-
 drivers/usb/gadget/udc/pxa27x_udc.c                |    6 +-
 drivers/usb/gadget/udc/r8a66597-udc.c              |    5 +-
 drivers/usb/gadget/udc/renesas_usb3.c              |   21 +-
 drivers/usb/gadget/udc/s3c-hsudc.c                 |    5 +-
 drivers/usb/gadget/udc/s3c2410_udc.c               |    3 +-
 drivers/usb/gadget/udc/tegra-xudc.c                | 3810 ++++++++++++++++++++
 drivers/usb/host/Kconfig                           |  106 +-
 drivers/usb/host/bcma-hcd.c                        |    5 +-
 drivers/usb/host/fotg210-hcd.c                     |    8 +-
 drivers/usb/host/imx21-dbg.c                       |    2 +-
 drivers/usb/host/isp1362-hcd.c                     |    5 +-
 drivers/usb/host/ohci-at91.c                       |    8 +-
 drivers/usb/host/ohci-nxp.c                        |    2 +-
 drivers/usb/host/oxu210hp-hcd.c                    |   14 +-
 drivers/usb/host/u132-hcd.c                        |    2 +-
 drivers/usb/host/xhci-pci.c                        |    4 +-
 drivers/usb/host/xhci-ring.c                       |   68 +-
 drivers/usb/host/xhci-tegra.c                      |  126 +-
 drivers/usb/host/xhci-trace.h                      |   26 +
 drivers/usb/host/xhci.c                            |    3 +-
 drivers/usb/host/xhci.h                            |   29 +
 drivers/usb/image/microtek.c                       |    3 +-
 drivers/usb/isp1760/isp1760-hcd.c                  |    2 -
 drivers/usb/misc/Kconfig                           |   22 +-
 drivers/usb/misc/appledisplay.c                    |    8 +-
 drivers/usb/misc/chaoskey.c                        |   24 +-
 drivers/usb/misc/ftdi-elan.c                       |    6 +-
 drivers/usb/misc/idmouse.c                         |   36 +-
 drivers/usb/misc/legousbtower.c                    |  303 +-
 drivers/usb/misc/sisusbvga/Kconfig                 |    2 +-
 drivers/usb/misc/usb251xb.c                        |   66 +-
 drivers/usb/mtu3/mtu3_gadget_ep0.c                 |   35 +-
 drivers/usb/musb/musb_core.c                       |    4 +-
 drivers/usb/musb/musb_debugfs.c                    |    2 +-
 drivers/usb/musb/musb_dsps.c                       |    2 +-
 drivers/usb/musb/musb_gadget.c                     |    5 +-
 drivers/usb/phy/phy-keystone.c                     |    4 +-
 drivers/usb/phy/phy-mxs-usb.c                      |    4 +-
 drivers/usb/renesas_usbhs/common.c                 |    5 +-
 drivers/usb/renesas_usbhs/common.h                 |    3 +-
 drivers/usb/renesas_usbhs/fifo.c                   |    4 +-
 drivers/usb/renesas_usbhs/mod.c                    |   19 +-
 drivers/usb/renesas_usbhs/mod_gadget.c             |   12 +-
 drivers/usb/roles/class.c                          |   21 +
 drivers/usb/serial/Kconfig                         |   48 +-
 drivers/usb/serial/ch341.c                         |   97 +-
 drivers/usb/serial/cp210x.c                        |    1 +
 drivers/usb/serial/ftdi_sio.c                      |    3 +
 drivers/usb/serial/ftdi_sio_ids.h                  |    7 +
 drivers/usb/serial/mos7720.c                       |    4 -
 drivers/usb/serial/mos7840.c                       |  762 +---
 drivers/usb/serial/option.c                        |    7 +
 drivers/usb/serial/pl2303.c                        |  124 +-
 drivers/usb/serial/pl2303.h                        |    6 +
 drivers/usb/storage/scsiglue.c                     |    4 +-
 drivers/usb/storage/uas.c                          |   10 +
 drivers/usb/storage/unusual_uas.h                  |    7 +-
 drivers/usb/typec/Kconfig                          |   11 +
 drivers/usb/typec/Makefile                         |    1 +
 drivers/usb/typec/class.c                          |   42 +-
 drivers/usb/typec/hd3ss3220.c                      |  269 ++
 drivers/usb/typec/tcpm/tcpm.c                      |  135 +-
 drivers/usb/typec/tps6598x.c                       |   49 +-
 drivers/usb/typec/ucsi/displayport.c               |   40 +-
 drivers/usb/typec/ucsi/trace.c                     |   11 -
 drivers/usb/typec/ucsi/trace.h                     |   79 +-
 drivers/usb/typec/ucsi/ucsi.c                      |  609 ++--
 drivers/usb/typec/ucsi/ucsi.h                      |  417 +--
 drivers/usb/typec/ucsi/ucsi_acpi.c                 |   91 +-
 drivers/usb/typec/ucsi/ucsi_ccg.c                  |  166 +-
 drivers/usb/usbip/Kconfig                          |    1 +
 drivers/usb/usbip/stub_rx.c                        |   50 +-
 drivers/usb/usbip/stub_tx.c                        |    2 +-
 include/linux/usb/role.h                           |    3 +
 include/linux/usb/tcpm.h                           |   41 -
 include/linux/usb/typec.h                          |   41 +-
 tools/usb/usbip/libsrc/usbip_host_common.c         |    2 +-
 141 files changed, 7240 insertions(+), 2850 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/renesas,usb3-peri.txt
 create mode 100644 Documentation/devicetree/bindings/usb/renesas,usb3-peri.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/renesas,usbhs.txt
 create mode 100644 Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/ti,hd3ss3220.txt
 create mode 100644 Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
 create mode 100644 drivers/usb/cdns3/cdns3-ti.c
 create mode 100644 drivers/usb/gadget/udc/tegra-xudc.c
 create mode 100644 drivers/usb/typec/hd3ss3220.c

