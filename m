Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3DCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C3F21874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbfCUPJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:09:40 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5726 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727881AbfCUPJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:09:40 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C36234C16555B3AA113A;
        Thu, 21 Mar 2019 23:09:32 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Thu, 21 Mar 2019
 23:09:21 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <jesper.nilsson@axis.com>, <lars.persson@axis.com>,
        <linus.walleij@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@axis.com>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] pinctrl: artpec6: Make two functions static
Date:   Thu, 21 Mar 2019 23:09:09 +0800
Message-ID: <20190321150909.3576-1-yuehaibing@huawei.com>
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

Fix sparse warnings:

drivers/pinctrl/pinctrl-artpec6.c:691:5: warning:
 symbol 'artpec6_pmx_enable' was not declared. Should it be static?
drivers/pinctrl/pinctrl-artpec6.c:705:6: warning:
 symbol 'artpec6_pmx_disable' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/pinctrl/pinctrl-artpec6.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-artpec6.c b/drivers/pinctrl/pinctrl-artpec6.c
index d89dc43..e836850 100644
--- a/drivers/pinctrl/pinctrl-artpec6.c
+++ b/drivers/pinctrl/pinctrl-artpec6.c
@@ -688,8 +688,9 @@ static void artpec6_pmx_select_func(struct pinctrl_dev *pctldev,
 	}
 }
 
-int artpec6_pmx_enable(struct pinctrl_dev *pctldev, unsigned int function,
-		       unsigned int group)
+static int artpec6_pmx_enable(struct pinctrl_dev *pctldev,
+			      unsigned int function,
+			      unsigned int group)
 {
 	struct artpec6_pmx *pmx = pinctrl_dev_get_drvdata(pctldev);
 
@@ -702,8 +703,9 @@ int artpec6_pmx_enable(struct pinctrl_dev *pctldev, unsigned int function,
 	return 0;
 }
 
-void artpec6_pmx_disable(struct pinctrl_dev *pctldev, unsigned int function,
-			 unsigned int group)
+static void artpec6_pmx_disable(struct pinctrl_dev *pctldev,
+				unsigned int function,
+				unsigned int group)
 {
 	struct artpec6_pmx *pmx = pinctrl_dev_get_drvdata(pctldev);
 
-- 
2.7.0


