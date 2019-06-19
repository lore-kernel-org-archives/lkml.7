Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71507C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 16:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3DB2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 16:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbfFSQyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 12:54:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60960 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfFSQyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 12:54:10 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hddqY-0002CC-1K; Wed, 19 Jun 2019 16:54:06 +0000
From:   Colin King <colin.king@canonical.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6656: fix indentation on break statement
Date:   Wed, 19 Jun 2019 17:54:05 +0100
Message-Id: <20190619165405.7784-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The break statement is indented one level too deep, fix this.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/vt6656/card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vt6656/card.c b/drivers/staging/vt6656/card.c
index 08fc03d8740e..56cd77fd9ea0 100644
--- a/drivers/staging/vt6656/card.c
+++ b/drivers/staging/vt6656/card.c
@@ -166,7 +166,7 @@ static void vnt_calculate_ofdm_rate(u16 rate, u8 bb_type,
 			*tx_rate = 0x8b;
 			*rsv_time = 30;
 		}
-			break;
+		break;
 	case RATE_9M:
 		if (bb_type == BB_TYPE_11A) {
 			*tx_rate = 0x9f;
-- 
2.20.1

