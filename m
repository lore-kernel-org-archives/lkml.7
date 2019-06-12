Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA7FC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B55A52082C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PPEti6sa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732135AbfFLK3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 06:29:35 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35040 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbfFLK3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 06:29:34 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5CATX6X062162;
        Wed, 12 Jun 2019 05:29:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560335373;
        bh=gffXr0SPmGe2RjlhTe5mohxf2lQM5X6YUpJTien3xyc=;
        h=From:To:CC:Subject:Date;
        b=PPEti6saL+4v+jr6tI2oF0dQR1hyTUAmO0+v/KKSTbVQ4OxOL+xD4xMwnP6ZGwk86
         9jGDm1NxNzPd0pGagBu/i4BQ/aVCFbiK70VuoRFNmyxt1OFMbZtXGRHRMrLnLVlmy6
         Nv4ztYr/lwuSK/W/ne691rtHRCgO4C0rDiQ40Vsw=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5CATXjs085203
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Jun 2019 05:29:33 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 12
 Jun 2019 05:29:32 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 12 Jun 2019 05:29:32 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5CATTJW128310;
        Wed, 12 Jun 2019 05:29:30 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <kishon@ti.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [GIT PULL v2] PHY: for 5.2-rc 
Date:   Wed, 12 Jun 2019 15:57:57 +0530
Message-ID: <20190612102803.25398-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please find the updated pull request for 5.2 -rc cycle. Here I dropped
the patch that added "static" for a function to fix sparse warning.

I'm also sending the patches along with this pull request in case you'd
like to look them.

Consider merging it in this -rc cycle and let me know if you want me
to make any further changes.

Thanks
Kishon

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git tags/phy-for-5.2-rc_v2

for you to fetch changes up to e3888cda394c72dcfd450afec1121d9777a59805:

  phy: tegra: xusb: Add Tegra210 PLL power supplies (2019-06-12 15:35:44 +0530)

----------------------------------------------------------------
phy: for 5.2-rc

  *) Move Tegra124 PLL power supplies to be enabled by xusb-tegra124
  *) Move Tegra210 PLL power supplies to be enabled by xusb-tegra210
  *) Minor fixes: fix memory leaks at error path and addresses coverity.

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

 Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt | 12 ++++++++++++
 drivers/phy/broadcom/phy-brcm-usb.c                                   |  8 ++++++++
 drivers/phy/qualcomm/phy-qcom-qusb2.c                                 |  2 +-
 drivers/phy/renesas/phy-rcar-gen2.c                                   |  2 ++
 drivers/phy/tegra/xusb-tegra124.c                                     |  9 +++++++++
 drivers/phy/tegra/xusb-tegra210.c                                     |  9 +++++++++
 6 files changed, 41 insertions(+), 1 deletion(-)
-- 
2.17.1

