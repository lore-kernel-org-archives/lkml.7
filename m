Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D1EC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD87206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YZZyjgAq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbfH0Ov4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 10:51:56 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57466 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfH0Ovz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 10:51:55 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7REpr71109192;
        Tue, 27 Aug 2019 09:51:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1566917513;
        bh=JqkR8CYK6qrItoP8AoGib779xPBL5ua2PMErp2rVJCo=;
        h=From:To:CC:Subject:Date;
        b=YZZyjgAqgMOWJfw2e4tKoH+JeSyIhBISd6cuGtc8L1JlABaQVAsA2XzWHPmacSztn
         QuftWyO4a4Hzx3Wdpfgl4mje+SJQwpmdk17EyZic2ZPXuLWAbHOHzorAgjubXd6Wfo
         T1pZ96cNt2WGxBnJQ8tUymQ+iaAmHupcXBjNJW7o=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7REpr7L027994
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Aug 2019 09:51:53 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 27
 Aug 2019 09:51:53 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 27 Aug 2019 09:51:53 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7REpp2d092482;
        Tue, 27 Aug 2019 09:51:52 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <kishon@ti.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] PHY: For 5.4
Date:   Tue, 27 Aug 2019 20:21:46 +0530
Message-ID: <20190827145146.4735-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please find the pull request for 5.4 merge window below. Most of the
updates here are in Marvell's Armada CP110 COMPHY. It also adds a new
PHY driver for Lantiq (now Intel) VRX200/ARX300 PCIe PHY. Please see
the tag message for all the changes.

Let me know If I have to change something.

Thanks
Kishon

The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git tags/phy-for-5.4

for you to fetch changes up to 5af67635c36ed92ef172c7bbf4d711364bc3bdf7:

  phy: marvell: phy-mvebu-cp110-comphy: rename instances of DLT (2019-08-27 11:37:09 +0530)

----------------------------------------------------------------
phy: for 5.4

  *) Add a new PHY driver for Lantiq VRX200/ARX300 PCIe PHY
  *) Add missing of_node_put() to a bunch of drivers using
     for_each_available_child_of_node()
  *) Add RXAUI/PCIe/SATA/USB3 support in Marvell's Armada
     CP110 COMPHY
  *) Other misc fixes and cleanup

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

----------------------------------------------------------------
Bjorn Andersson (1):
  phy: qcom-qmp: Correct ready status, again

Grzegorz Jaszczyk (5):
  phy: mvebu-cp110-comphy: Add SMC call support
  phy: mvebu-cp110-comphy: Add RXAUI support
  phy: mvebu-cp110-comphy: Add USB3 host/device support
  phy: mvebu-cp110-comphy: Add SATA support
  phy: mvebu-cp110-comphy: Add PCIe support

Marek Szyprowski (2):
  phy: core: document phy_calibrate()
  phy: samsung: disable bind/unbind platform driver feature

Martin Blumenstingl (3):
  dt-bindings: phy: add binding for the Lantiq VRX200 and ARX300 PCIe
    PHYs
  phy: lantiq: vrx200-pcie: add a driver for the Lantiq VRX200 PCIe PHY
  phy: enable compile-testing for the Lantiq PHY drivers

Matt Pelland (2):
  phy: marvell: phy-mvebu-cp110-comphy: implement RXAUI support
  phy: marvell: phy-mvebu-cp110-comphy: rename instances of DLT

Miquel Raynal (10):
  phy: mvebu-a3700-comphy: Inform users if their firmware is too old
  phy: mvebu-cp110-comphy: Add clocks support
  phy: mvebu-cp110-comphy: Explicitly initialize the lane submode
  phy: mvebu-cp110-comphy: List already supported Ethernet modes
  phy: mvebu-cp110-comphy: Rename the macro handling only Ethernet modes
  phy: mvebu-cp110-comphy: Allow non-Ethernet modes to be configured
  phy: mvebu-cp110-comphy: Cosmetic change in a helper
  phy: mvebu-cp110-comphy: Update comment about powering off all lanes
    at boot
  dt-bindings: phy: Add Marvell COMPHY clocks
  dt-bindings: pci: add PHY properties to Armada 7K/8K controller
    bindings

Nathan Chancellor (1):
  phy-rockchip-inno-hdmi: Fix RK3328_TERM_RESISTOR_CALIB_SPEED_7_0's
    third value

Nishka Dasgupta (4):
  phy: marvell: phy-armada38x-comphy: Add of_node_put() before return
  phy: marvell: phy-mvebu-cp110-comphy: Add of_node_put() before return
  phy: marvell: phy-mvebu-a3700-comphy: Add of_node_put() before return
  phy: qualcomm: phy-qcom-qmp: Add of_node_put() before return

Wen Yang (1):
  phy: ti: am654-serdes: fix an use-after-free in
    serdes_am654_clk_register()

Yoshihiro Shimoda (1):
  phy: renesas: rcar-gen3-usb2: Disable clearing VBUS in over-current

 .../devicetree/bindings/pci/pci-armada8k.txt  |   8 +
 .../bindings/phy/lantiq,vrx200-pcie-phy.yaml  |  95 ++++
 .../bindings/phy/phy-mvebu-comphy.txt         |  10 +
 drivers/phy/Makefile                          |   2 +-
 drivers/phy/lantiq/Kconfig                    |  11 +
 drivers/phy/lantiq/Makefile                   |   1 +
 drivers/phy/lantiq/phy-lantiq-vrx200-pcie.c   | 494 ++++++++++++++++
 drivers/phy/marvell/Kconfig                   |   1 +
 drivers/phy/marvell/phy-armada38x-comphy.c    |   4 +-
 drivers/phy/marvell/phy-mvebu-a3700-comphy.c  |  17 +-
 drivers/phy/marvell/phy-mvebu-cp110-comphy.c  | 525 ++++++++++++++++--
 drivers/phy/phy-core.c                        |  10 +
 drivers/phy/qualcomm/phy-qcom-qmp.c           |  44 +-
 drivers/phy/renesas/phy-rcar-gen3-usb2.c      |   2 +
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c |   2 +-
 drivers/phy/samsung/phy-exynos-dp-video.c     |   1 +
 drivers/phy/samsung/phy-exynos-mipi-video.c   |   1 +
 drivers/phy/samsung/phy-exynos-pcie.c         |   1 +
 drivers/phy/samsung/phy-exynos5-usbdrd.c      |   1 +
 drivers/phy/samsung/phy-exynos5250-sata.c     |   1 +
 drivers/phy/samsung/phy-samsung-usb2.c        |   1 +
 drivers/phy/ti/phy-am654-serdes.c             |  33 +-
 .../dt-bindings/phy/phy-lantiq-vrx200-pcie.h  |  11 +
 23 files changed, 1187 insertions(+), 89 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/lantiq,vrx200-pcie-phy.yaml
 create mode 100644 drivers/phy/lantiq/phy-lantiq-vrx200-pcie.c
 create mode 100644 include/dt-bindings/phy/phy-lantiq-vrx200-pcie.h

-- 
2.17.1

