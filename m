Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E05C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF54208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbfHLLPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 07:15:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39476 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbfHLLPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 07:15:36 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hx8IP-0002cp-9I; Mon, 12 Aug 2019 11:15:25 +0000
From:   Colin King <colin.king@canonical.com>
To:     Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.or
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][crypto-next] crypto: hisilicon: fix spelling mistake "HZIP_COMSUMED_BYTE" -> "HZIP_CONSUMED_BYTE"
Date:   Mon, 12 Aug 2019 12:15:25 +0100
Message-Id: <20190812111525.574-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the hzip_dfx_regs array, fix this.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/crypto/hisilicon/zip/zip_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 6e0ca75585d4..00ecae387fdd 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -206,7 +206,7 @@ static struct debugfs_reg32 hzip_dfx_regs[] = {
 	{"HZIP_AVG_DELAY                 ",  0x28ull},
 	{"HZIP_MEM_VISIBLE_DATA          ",  0x30ull},
 	{"HZIP_MEM_VISIBLE_ADDR          ",  0x34ull},
-	{"HZIP_COMSUMED_BYTE             ",  0x38ull},
+	{"HZIP_CONSUMED_BYTE             ",  0x38ull},
 	{"HZIP_PRODUCED_BYTE             ",  0x40ull},
 	{"HZIP_COMP_INF                  ",  0x70ull},
 	{"HZIP_PRE_OUT                   ",  0x78ull},
-- 
2.20.1

