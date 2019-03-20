Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E363C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64EE4218A3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfCTOPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:15:03 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5718 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726067AbfCTOPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 10:15:02 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9EDAFDF219F3A08DB406;
        Wed, 20 Mar 2019 22:15:00 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Wed, 20 Mar 2019
 22:14:53 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <aisheng.dong@nxp.com>, <festevam@gmail.com>,
        <shawnguo@kernel.org>, <stefan@agner.ch>, <kernel@pengutronix.de>,
        <linus.walleij@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] pinctrl: fsl: Make pinctrl_ipc_handle static
Date:   Wed, 20 Mar 2019 22:14:25 +0800
Message-ID: <20190320141425.20920-1-yuehaibing@huawei.com>
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

drivers/pinctrl/freescale/pinctrl-scu.c:38:19: warning:
 symbol 'pinctrl_ipc_handle' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/pinctrl/freescale/pinctrl-scu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-scu.c b/drivers/pinctrl/freescale/pinctrl-scu.c
index 83e69c0..73bf1d9 100644
--- a/drivers/pinctrl/freescale/pinctrl-scu.c
+++ b/drivers/pinctrl/freescale/pinctrl-scu.c
@@ -35,7 +35,7 @@ struct imx_sc_msg_resp_pad_get {
 	u32 val;
 } __packed;
 
-struct imx_sc_ipc *pinctrl_ipc_handle;
+static struct imx_sc_ipc *pinctrl_ipc_handle;
 
 int imx_pinctrl_sc_ipc_init(struct platform_device *pdev)
 {
-- 
2.7.0


