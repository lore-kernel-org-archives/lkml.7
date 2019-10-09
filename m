Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBD9C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA7D7206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfJIHXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 03:23:37 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:18166 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725440AbfJIHXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 03:23:36 -0400
X-UUID: 5d3df0523a0f41da83eacb9d5041331b-20191009
X-UUID: 5d3df0523a0f41da83eacb9d5041331b-20191009
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1959411265; Wed, 09 Oct 2019 15:23:28 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 9 Oct 2019 15:23:23 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 9 Oct 2019 15:23:22 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Thierry Reding <treding@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: [PATCH v2] phy: tegra: xusb: remove unused variable
Date:   Wed, 9 Oct 2019 15:23:09 +0800
Message-ID: <1570605789-5352-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D8D0E1454E0F109BF23A8F7C510BBF7B068E2C21E0924A0A2A54C96B63F1F33D2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The local variable @priv is set but not used, can be removed

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
v2: add Acked-by: Thierry
---
 drivers/phy/tegra/xusb-tegra210.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/phy/tegra/xusb-tegra210.c b/drivers/phy/tegra/xusb-tegra210.c
index 0c0df6897a3b..bc71c897298a 100644
--- a/drivers/phy/tegra/xusb-tegra210.c
+++ b/drivers/phy/tegra/xusb-tegra210.c
@@ -1225,13 +1225,10 @@ static int tegra210_hsic_phy_power_on(struct phy *phy)
 	struct tegra_xusb_hsic_lane *hsic = to_hsic_lane(lane);
 	struct tegra_xusb_hsic_pad *pad = to_hsic_pad(lane->pad);
 	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
-	struct tegra210_xusb_padctl *priv;
 	unsigned int index = lane->index;
 	u32 value;
 	int err;
 
-	priv = to_tegra210_xusb_padctl(padctl);
-
 	err = regulator_enable(pad->supply);
 	if (err)
 		return err;
-- 
2.23.0

