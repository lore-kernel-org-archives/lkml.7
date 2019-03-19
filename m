Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5580AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22FA620811
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfCSPan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:30:43 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4712 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727018AbfCSPan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 11:30:43 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0DF676576801C7BB2A43;
        Tue, 19 Mar 2019 23:30:40 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Mar 2019
 23:30:34 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <kishon@ti.com>, <heiko@sntech.de>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] phy: rockchip-typec: Make usb3_pll_cfg and dp_pll_cfg static
Date:   Tue, 19 Mar 2019 23:30:28 +0800
Message-ID: <20190319153028.22452-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Fix sparse warning:

drivers/phy/rockchip/phy-rockchip-typec.c:403:16: warning: symbol 'usb3_pll_cfg' was not declared. Should it be static?
drivers/phy/rockchip/phy-rockchip-typec.c:420:16: warning: symbol 'dp_pll_cfg' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/phy/rockchip/phy-rockchip-typec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
index e32edee..8ad366e 100644
--- a/drivers/phy/rockchip/phy-rockchip-typec.c
+++ b/drivers/phy/rockchip/phy-rockchip-typec.c
@@ -400,7 +400,7 @@ struct phy_reg {
 	u32 addr;
 };
 
-struct phy_reg usb3_pll_cfg[] = {
+static struct phy_reg usb3_pll_cfg[] = {
 	{ 0xf0,		CMN_PLL0_VCOCAL_INIT },
 	{ 0x18,		CMN_PLL0_VCOCAL_ITER },
 	{ 0xd0,		CMN_PLL0_INTDIV },
@@ -417,7 +417,7 @@ struct phy_reg usb3_pll_cfg[] = {
 	{ 0x8,		CMN_DIAG_PLL0_LF_PROG },
 };
 
-struct phy_reg dp_pll_cfg[] = {
+static struct phy_reg dp_pll_cfg[] = {
 	{ 0xf0,		CMN_PLL1_VCOCAL_INIT },
 	{ 0x18,		CMN_PLL1_VCOCAL_ITER },
 	{ 0x30b9,	CMN_PLL1_VCOCAL_START },
-- 
2.7.4


