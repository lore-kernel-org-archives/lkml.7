Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51874C282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 271FF20880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfDOKQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 06:16:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50727 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbfDOKQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 06:16:00 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hFyeZ-0004iv-K2; Mon, 15 Apr 2019 10:15:55 +0000
From:   Colin King <colin.king@canonical.com>
To:     Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
        linux-wimax@intel.com, "David S . Miller" <davem@davemloft.net>,
        netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] wimax/i2400m: fix spelling mistake "accesibility" -> "accessibility"
Date:   Mon, 15 Apr 2019 11:15:55 +0100
Message-Id: <20190415101555.10584-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the I2400M_MS_ACCESSIBILITY_ERROR message
string, fix this.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/wimax/i2400m/control.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wimax/i2400m/control.c b/drivers/net/wimax/i2400m/control.c
index ef298d8525c5..6837fac3987b 100644
--- a/drivers/net/wimax/i2400m/control.c
+++ b/drivers/net/wimax/i2400m/control.c
@@ -254,7 +254,7 @@ static const struct
 	[I2400M_MS_ILLEGAL_VALUE] = { "illegal value", -EINVAL },
 	[I2400M_MS_MISSING_PARAMS] = { "missing parameters", -ENOMSG },
 	[I2400M_MS_VERSION_ERROR] = { "bad version", -EIO },
-	[I2400M_MS_ACCESSIBILITY_ERROR] = { "accesibility error", -EIO },
+	[I2400M_MS_ACCESSIBILITY_ERROR] = { "accessibility error", -EIO },
 	[I2400M_MS_BUSY] = { "busy", -EBUSY },
 	[I2400M_MS_CORRUPTED_TLV] = { "corrupted TLV", -EILSEQ },
 	[I2400M_MS_UNINITIALIZED] = { "uninitialized", -EILSEQ },
-- 
2.20.1

