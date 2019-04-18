Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E014CC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC10A20652
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389045AbfDRNhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:37:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6642 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388346AbfDRNhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:37:14 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E9CCE49812A64A14A155;
        Thu, 18 Apr 2019 21:36:57 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Thu, 18 Apr 2019
 21:36:48 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <kishon@ti.com>, <rogerq@ti.com>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] phy: ti: am654-serdes: Make serdes_am654_xlate() static
Date:   Thu, 18 Apr 2019 21:36:33 +0800
Message-ID: <20190418133633.3908-1-yuehaibing@huawei.com>
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

drivers/phy/ti/phy-am654-serdes.c:250:12: warning:
 symbol 'serdes_am654_xlate' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/phy/ti/phy-am654-serdes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/ti/phy-am654-serdes.c b/drivers/phy/ti/phy-am654-serdes.c
index d376920..f8edd08 100644
--- a/drivers/phy/ti/phy-am654-serdes.c
+++ b/drivers/phy/ti/phy-am654-serdes.c
@@ -247,8 +247,8 @@ static void serdes_am654_release(struct phy *x)
 	mux_control_deselect(phy->control);
 }
 
-struct phy *serdes_am654_xlate(struct device *dev, struct of_phandle_args
-				 *args)
+static struct phy *serdes_am654_xlate(struct device *dev,
+				      struct of_phandle_args *args)
 {
 	struct serdes_am654 *am654_phy;
 	struct phy *phy;
-- 
2.7.4


