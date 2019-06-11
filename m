Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EA6C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1258F20665
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="T2ucwwEA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388492AbfFKOCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:02:52 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:53020 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387447AbfFKOCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:02:52 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5BE2n39093194;
        Tue, 11 Jun 2019 09:02:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560261769;
        bh=rTVHPsme2vwmW5bl4IO54W0h/joHnLB+llx7bWMRQSk=;
        h=From:To:CC:Subject:Date;
        b=T2ucwwEAyleluS07cZ3FgfinTGFS67FBKRWCJ8NJEIepQXJXT85vezCnePWQSU3f+
         E3967XNJzbpxPNv60NzX5Ka6005RlUaTqxyVJvhdvy3pQRK4y0bUEVN/8e9oXJn6FC
         tyY3oEh1A1Lz+aipL35SDOHhquJ8I73Axjt0xNM8=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5BE2n8X071093
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Jun 2019 09:02:49 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 11
 Jun 2019 09:02:48 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 11 Jun 2019 09:02:48 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5BE2lUc117180;
        Tue, 11 Jun 2019 09:02:47 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <kishon@ti.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] PHY: for 5.2-rc
Date:   Tue, 11 Jun 2019 19:31:22 +0530
Message-ID: <20190611140122.9429-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please find the pull request for 5.2 -rc cycle.

The major fix being moving supplies powering PLLs used by USB, SATA,
PCIe to tegra-xusb driver fixing initialization failure.

Others are minor fixes. Please see the tag message below for more
details.

Consider merging it in this -rc cycle and let me know if you want me
to make any changes.

Thanks
Kishon

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git tags/phy-for-5.2-rc

for you to fetch changes up to ada28f7b3a97fa720864c86504a7c426ee6f91c1:

  phy: tegra: xusb: Add Tegra210 PLL power supplies (2019-06-07 15:58:34 +0530)

----------------------------------------------------------------
phy: for 5.2-rc

  *) Move Tegra124 PLL power supplies to be enabled by xusb-tegra124
  *) Move Tegra210 PLL power supplies to be enabled by xusb-tegra210
  *) Minor fixes: fix memory leaks at error path, fix sparse warnings
     and addresses coverity.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

----------------------------------------------------------------
Colin Ian King (1):
      phy: qcom-qusb2: fix missing assignment of ret when calling clk_prepare_enable

Florian Fainelli (1):
      phy: usb: phy-brcm-usb: Remove sysfs attributes upon driver removal

Thierry Reding (3):
      dt-bindings: phy: tegra-xusb: List PLL power supplies
      phy: tegra: xusb: Add Tegra124 PLL power supplies
      phy: tegra: xusb: Add Tegra210 PLL power supplies

Yoshihiro Shimoda (1):
      phy: renesas: rcar-gen2: Fix memory leak at error paths

YueHaibing (1):
      phy: ti: am654-serdes: Make serdes_am654_xlate() static

 Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt | 12 ++++++++++++
 drivers/phy/broadcom/phy-brcm-usb.c                                   |  8 ++++++++
 drivers/phy/qualcomm/phy-qcom-qusb2.c                                 |  2 +-
 drivers/phy/renesas/phy-rcar-gen2.c                                   |  2 ++
 drivers/phy/tegra/xusb-tegra124.c                                     |  9 +++++++++
 drivers/phy/tegra/xusb-tegra210.c                                     |  9 +++++++++
 drivers/phy/ti/phy-am654-serdes.c                                     |  4 ++--
 7 files changed, 43 insertions(+), 3 deletions(-)
-- 
2.17.1

