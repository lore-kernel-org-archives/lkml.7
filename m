Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF77C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 676972084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Idkt4nrp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbfDCEoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:44:54 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50408 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbfDCEox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:44:53 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x334iqbe004212;
        Tue, 2 Apr 2019 23:44:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554266692;
        bh=2HLrKvguXqpiytKLCxS4JOog9/NEY14r+nIYqNKcvkU=;
        h=From:To:CC:Subject:Date;
        b=Idkt4nrp9hUlSq/dS5AmN6BDxNX8GPMpzCE8GqCQjIfxvh8+gIPPtmomMu3N+MQ6F
         YJp1G9IB3OF8iPJc6GolMj59TV0n45MYUwhbkIQz0JVqGN4qHp76PFzepR4nSlEIAq
         S7wWaVPzXe6xV2kNlNd348D9eBjxmtdkUFj81WSc=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x334iqLO126345
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Apr 2019 23:44:52 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 2 Apr
 2019 23:44:51 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 2 Apr 2019 23:44:52 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x334ioAa088537;
        Tue, 2 Apr 2019 23:44:51 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <kishon@ti.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] PHY: For 5.1 -rc
Date:   Wed, 3 Apr 2019 10:13:53 +0530
Message-ID: <20190403044353.21620-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please find the pull request for 5.1 -rc cycle below.

It fixes PHY programming sequence in phy-ti-pipe3 driver to align with
TRM, requests IRQ only for OTG in phy-rcar-gen3-usb2 and a bunch of
other linker errors and compilation warnings seen in randconfig.

Please see the complete list of changes in the tag message below and let
me know if I have to make any modifications.

Thanks
Kishon

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git tags/phy-for-5.1-rc

for you to fetch changes up to d5d60c3f25ab52de7c5dfd31f584f190b754629e:

  phy: fix platform_no_drv_owner.cocci warnings (2019-04-03 10:02:20 +0530)

----------------------------------------------------------------
phy: for 5.1-rc

  *) Follow TRM sequence in phy-ti-pipe3 driver to ensure DPLL & PHY
     operates correctly over the entire temperature range
  *) Fix missing bit-wise 'OR' operator in ti-pipe3 driver
  *) Fix to request IRQ only for OTG in phy-rcar-gen3-usb2 driver
  *) Fix linker errors and compilation warnings got with randconfig
  *) Fix sparse warnings and .cocci warnings

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

----------------------------------------------------------------
Arnd Bergmann (3):
      phy: allwinner: allow compile testing
      phy: ti: usb2: fix OMAP_CONTROL_PHY dependency
      phy: mapphone-mdm6600: add gpiolib dependency

Colin Ian King (1):
      phy: ti-pipe3: fix missing bit-wise or operator when assigning val

Fabrizio Castro (1):
      phy: renesas: rcar-gen3-usb2: No need to request IRQ for non-OTG

Roger Quadros (4):
      phy: ti-pipe3: Introduce mode property in driver data
      phy: ti-pipe3: improve DPLL stability for SATA & USB
      phy: ti-pipe3: Fix SATA & USB PHY power up sequence
      phy: ti-pipe3: Fix PCIe power up sequence

Tony Lindgren (1):
      phy: phy-twl4030-usb: Fix cable state handling

YueHaibing (3):
      phy: rockchip-typec: Make usb3_pll_cfg and dp_pll_cfg static
      phy: qcom-ufs: Make ufs_qcom_phy_disable_iface_clk static
      phy: fix platform_no_drv_owner.cocci warnings

 drivers/phy/allwinner/Kconfig              |   9 ++--
 drivers/phy/marvell/phy-mvebu-a3700-utmi.c |   1 -
 drivers/phy/motorola/Kconfig               |   2 +-
 drivers/phy/qualcomm/phy-qcom-ufs.c        |   2 +-
 drivers/phy/renesas/phy-rcar-gen3-usb2.c   |  27 ++++++------
 drivers/phy/rockchip/phy-rockchip-typec.c  |   4 +-
 drivers/phy/ti/Kconfig                     |   2 +-
 drivers/phy/ti/phy-ti-pipe3.c              | 362 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------
 drivers/phy/ti/phy-twl4030-usb.c           |  35 ++++++---------
 9 files changed, 303 insertions(+), 141 deletions(-)
