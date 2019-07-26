Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6C0C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BACD22CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfGZOII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:08:08 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2779 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726784AbfGZOII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:08:08 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 185953502BBE3CD197FC;
        Fri, 26 Jul 2019 22:08:04 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Fri, 26 Jul 2019
 22:07:58 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <payal.s.kshirsagar.98@gmail.com>,
        <paul.walmsley@sifive.com>
CC:     <linux-kernel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] staging: rtl8723bs: remove set but not used variable 'pszBBRegMpFile'
Date:   Fri, 26 Jul 2019 22:07:34 +0800
Message-ID: <20190726140734.39564-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c: In function phy_BB8723b_Config_ParaFile:
drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c:436:77:
 warning: variable pszBBRegMpFile set but not used [-Wunused-but-set-variable]

It is never used so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
index 25c75b9..f06539d 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
@@ -431,14 +431,12 @@ static int phy_BB8723b_Config_ParaFile(struct adapter *Adapter)
 	u8 sz8723BBRegFile[] = RTL8723B_PHY_REG;
 	u8 sz8723AGCTableFile[] = RTL8723B_AGC_TAB;
 	u8 sz8723BBBRegPgFile[] = RTL8723B_PHY_REG_PG;
-	u8 sz8723BBRegMpFile[] = RTL8723B_PHY_REG_MP;
 	u8 sz8723BRFTxPwrLmtFile[] = RTL8723B_TXPWR_LMT;
-	u8 *pszBBRegFile = NULL, *pszAGCTableFile = NULL, *pszBBRegPgFile = NULL, *pszBBRegMpFile = NULL, *pszRFTxPwrLmtFile = NULL;
+	u8 *pszBBRegFile = NULL, *pszAGCTableFile = NULL, *pszBBRegPgFile = NULL, *pszRFTxPwrLmtFile = NULL;
 
 	pszBBRegFile = sz8723BBRegFile;
 	pszAGCTableFile = sz8723AGCTableFile;
 	pszBBRegPgFile = sz8723BBBRegPgFile;
-	pszBBRegMpFile = sz8723BBRegMpFile;
 	pszRFTxPwrLmtFile = sz8723BRFTxPwrLmtFile;
 
 	/*  Read Tx Power Limit File */
-- 
2.7.4


