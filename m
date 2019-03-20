Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E36C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 21:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F56E218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 21:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfCTVW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 17:22:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56088 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfCTVWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 17:22:14 -0400
Received: from [5.148.53.5] (helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1h6iez-0005LS-NE; Wed, 20 Mar 2019 21:22:05 +0000
From:   Colin King <colin.king@canonical.com>
To:     Stanley Chu <stanley.chu@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] scsi: phy: mediatek: fix typo in author's email address
Date:   Wed, 20 Mar 2019 21:22:05 +0000
Message-Id: <20190320212205.5726-2-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320212205.5726-1-colin.king@canonical.com>
References: <20190320212205.5726-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a typo in the module author's email address. Fix this.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/phy/mediatek/phy-mtk-ufs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/mediatek/phy-mtk-ufs.c b/drivers/phy/mediatek/phy-mtk-ufs.c
index 9a80a76d7990..cf94f5c35dc5 100644
--- a/drivers/phy/mediatek/phy-mtk-ufs.c
+++ b/drivers/phy/mediatek/phy-mtk-ufs.c
@@ -241,5 +241,5 @@ static struct platform_driver ufs_mtk_phy_driver = {
 module_platform_driver(ufs_mtk_phy_driver);
 
 MODULE_DESCRIPTION("Universal Flash Storage (UFS) MediaTek MPHY");
-MODULE_AUTHOR("Stanley Chu <stanley.chu@medaitek.com>");
+MODULE_AUTHOR("Stanley Chu <stanley.chu@mediatek.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.20.1

