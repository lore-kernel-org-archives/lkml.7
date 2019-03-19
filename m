Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBB3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640EA20811
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfCSP2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:28:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56440 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726612AbfCSP2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 11:28:22 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E1DD6FFEAD84195B0C75;
        Tue, 19 Mar 2019 23:28:17 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Mar 2019
 23:28:07 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <andy.gross@linaro.org>, <david.brown@linaro.org>, <kishon@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] phy: qcom-ufs: Make ufs_qcom_phy_disable_iface_clk static
Date:   Tue, 19 Mar 2019 23:27:38 +0800
Message-ID: <20190319152738.23312-1-yuehaibing@huawei.com>
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

drivers/phy/qualcomm/phy-qcom-ufs.c:462:6:
 warning: symbol 'ufs_qcom_phy_disable_iface_clk' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/phy/qualcomm/phy-qcom-ufs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-ufs.c b/drivers/phy/qualcomm/phy-qcom-ufs.c
index f2979cc..78c339b 100644
--- a/drivers/phy/qualcomm/phy-qcom-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-ufs.c
@@ -459,7 +459,7 @@ static int ufs_qcom_phy_enable_iface_clk(struct ufs_qcom_phy *phy)
 }
 
 /* Turn OFF M-PHY RMMI interface clocks */
-void ufs_qcom_phy_disable_iface_clk(struct ufs_qcom_phy *phy)
+static void ufs_qcom_phy_disable_iface_clk(struct ufs_qcom_phy *phy)
 {
 	if (phy->is_iface_clk_enabled) {
 		clk_disable_unprepare(phy->tx_iface_clk);
-- 
2.7.4


