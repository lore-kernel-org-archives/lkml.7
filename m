Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A112C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4297F21773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HMJSfK4B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732171AbfDQM7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 08:59:08 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57966 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730037AbfDQM7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 08:59:08 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3HCx6f8097955;
        Wed, 17 Apr 2019 07:59:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555505946;
        bh=ghrb1BFjNPTO4slONC0Jaq5JNWNbvk+eUBdYBG6EjtE=;
        h=From:To:CC:Subject:Date;
        b=HMJSfK4B37lNaDLcs5z5KguPd9lu6oJDQvO2SdS1UkyvoeQsAYn7l8w2kRJhko+NX
         INCPPEvp7Jm6FRMhAh8lmSu/WePIYCHLRny8OW3CZMZoSgQ+r3FMv5chaaeXp1yTIj
         kD374KZDyS28+GT4y+O3SCo4m4iqQ/TYA2lHmySo=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3HCx6hG009532
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 17 Apr 2019 07:59:06 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 17
 Apr 2019 07:59:06 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 17 Apr 2019 07:59:06 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3HCx46t032834;
        Wed, 17 Apr 2019 07:59:05 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <kishon@ti.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [GIT PULL v2] PHY: For 5.1 -rc
Date:   Wed, 17 Apr 2019 18:27:58 +0530
Message-ID: <20190417125758.5742-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please find the updated pull request for 5.1 -rc.

I've removed the lengthy ti-pipe3 PHY driver changes to follow the TRM
sequence. This will be included in 5.2 -rc1 pull request.

I've also added an additional patch to fix gadget mode working in
Allwinner's sun4i-usb PHY driver.

Let me know if I have to make any modifications.

Thanks
Kishon

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git tags/phy-for-5.1-rc-v2

for you to fetch changes up to e6f32efb1b128344a2c7df9875bc1a1abaa1d395:

  phy: sun4i-usb: Make sure to disable PHY0 passby for peripheral mode (2019-04-17 12:06:02 +0530)

----------------------------------------------------------------
phy: for 5.1-rc

  *) Fix sun4i-usb PHY driver to get USB gadget working on H3/R40/V3/V3s
  *) Fix cable state handling in phy-twl4030-usb driver to get rid of
     regulator_put() warning
  *) Fix linker errors and compilation warnings got with randconfig
  *) Fix sparse warnings and .cocci warnings

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

----------------------------------------------------------------
Arnd Bergmann (3):
      phy: allwinner: allow compile testing
      phy: ti: usb2: fix OMAP_CONTROL_PHY dependency
      phy: mapphone-mdm6600: add gpiolib dependency

Paul Kocialkowski (1):
      phy: sun4i-usb: Make sure to disable PHY0 passby for peripheral mode

Tony Lindgren (1):
      phy: phy-twl4030-usb: Fix cable state handling

YueHaibing (3):
      phy: rockchip-typec: Make usb3_pll_cfg and dp_pll_cfg static
      phy: qcom-ufs: Make ufs_qcom_phy_disable_iface_clk static
      phy: fix platform_no_drv_owner.cocci warnings

 drivers/phy/allwinner/Kconfig              |  9 ++++++---
 drivers/phy/allwinner/phy-sun4i-usb.c      |  4 ++++
 drivers/phy/marvell/phy-mvebu-a3700-utmi.c |  1 -
 drivers/phy/motorola/Kconfig               |  2 +-
 drivers/phy/qualcomm/phy-qcom-ufs.c        |  2 +-
 drivers/phy/rockchip/phy-rockchip-typec.c  |  4 ++--
 drivers/phy/ti/Kconfig                     |  2 +-
 drivers/phy/ti/phy-twl4030-usb.c           | 35 +++++++++++++----------------------
 8 files changed, 28 insertions(+), 31 deletions(-)
