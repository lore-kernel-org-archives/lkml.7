Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF6EC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9CC3206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Muu/cRol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbfGAKbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 06:31:38 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46194 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfGAKbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 06:31:38 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x61AVatT010276;
        Mon, 1 Jul 2019 05:31:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1561977096;
        bh=G2nHpZyhEwm1VCa+dz2AUyBM/c58MIYFMCKn6X98TBA=;
        h=From:To:CC:Subject:Date;
        b=Muu/cRolpZgDIlnKMWJZKWvRaQMbgW6srljdcpwpv4zlAnKxUS+ETu2Edn0uHm6wE
         P/C0JLNnw5OT/zmtcG7Lq2NNa3ViEKOtWk+w0ZFT/m01Hv/BQgbz8LqoKh6RRTz+Ai
         qImvvDRA+rxzzS3UxVPRBAYDOAoM5UfWTyWpeuPI=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x61AVaG1001383
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Jul 2019 05:31:36 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 1 Jul
 2019 05:31:36 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 1 Jul 2019 05:31:36 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x61AVYxw002583;
        Mon, 1 Jul 2019 05:31:35 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <kishon@ti.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] PHY: For 5.3
Date:   Mon, 1 Jul 2019 16:00:01 +0530
Message-ID: <20190701103001.21235-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please find the pull request for 5.3 merge window below. It adds couple
of new PHY drivers and other misc driver fixes. Please see the tag message
for complete list of changes.

Let me know if I have to change something.

Thanks
Kishon

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git tags/phy-for-5.3

for you to fetch changes up to 5206026404190125436f81088eb3667076e56083:

  phy: qcom-qmp: Raise qcom_qmp_phy_enable() polling delay (2019-06-25 19:17:38 +0530)

----------------------------------------------------------------
phy: for 5.3

  *) Add a new PHY driver for Qualcomm PCIe2 PHY
  *) Add a new PHY driver for Mixel DPHY present in i.MX8
  *) Fix Qualcomm QMP UFS PHY driver from incorrectly reporting that
     PHY enable failed
  *) Fix _BUG_ on Amlogic G12A USB3 + PCIE Combo PHY Driver due to
     calling a sleeping function from invalid context
  *) Fix WARN_ON dump on rcar-gen3-usb2 PHY driver caused due to
     imbalance powered flag
  *) Fix .cocci and sparse warnings

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

----------------------------------------------------------------
Bjorn Andersson (3):
      dt-bindings: phy: Add binding for Qualcomm PCIe2 PHY
      phy: qcom: Add Qualcomm PCIe2 PHY driver
      phy: qcom-qmp: Correct READY_STATUS poll break condition

Guido Günther (2):
      dt-bindings: phy: Add documentation for mixel dphy
      phy: Add driver for mixel mipi dphy found on NXP's i.MX8 SoCs

Gustavo A. R. Silva (1):
      phy: samsung: Use struct_size() in devm_kzalloc()

Lubomir Rintel (1):
      dt-bindings: phy-pxa-usb: add bindings

Marc Gonzalez (2):
      phy: qcom-qmp: Drop useless msm8998_pciephy_cfg setting
      phy: qcom-qmp: Raise qcom_qmp_phy_enable() polling delay

Neil Armstrong (1):
      phy: meson-g12a-usb3-pcie: disable locking for cr_regmap

Yoshihiro Shimoda (1):
      phy: renesas: rcar-gen3-usb2: fix imbalance powered flag

YueHaibing (2):
      phy: usb: phy-brcm-usb: Fix platform_no_drv_owner.cocci warnings
      phy: ti: am654-serdes: Make serdes_am654_xlate() static

 Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt |  29 ++++++++
 Documentation/devicetree/bindings/phy/phy-pxa-usb.txt        |  18 +++++
 Documentation/devicetree/bindings/phy/qcom-pcie2-phy.txt     |  42 ++++++++++++
 drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c               |   2 +-
 drivers/phy/broadcom/phy-brcm-usb.c                          |   1 -
 drivers/phy/freescale/Kconfig                                |  10 +++
 drivers/phy/freescale/Makefile                               |   1 +
 drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c               | 497 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/phy/qualcomm/Kconfig                                 |   8 +++
 drivers/phy/qualcomm/Makefile                                |   1 +
 drivers/phy/qualcomm/phy-qcom-pcie2.c                        | 331 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.c                          |   5 +-
 drivers/phy/renesas/phy-rcar-gen3-usb2.c                     |  19 ++++--
 drivers/phy/samsung/phy-samsung-usb2.c                       |   5 +-
 drivers/phy/ti/phy-am654-serdes.c                            |   4 +-
 15 files changed, 960 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-pxa-usb.txt
 create mode 100644 Documentation/devicetree/bindings/phy/qcom-pcie2-phy.txt
 create mode 100644 drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
 create mode 100644 drivers/phy/qualcomm/phy-qcom-pcie2.c

-- 
2.17.1

