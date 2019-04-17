Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB80C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942D820663
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732825AbfDQQea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:34:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43307 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730463AbfDQQea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:34:30 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hGnVy-00078P-3J; Wed, 17 Apr 2019 16:34:26 +0000
From:   Colin King <colin.king@canonical.com>
To:     Eugen Hristev <eugen.hristev@microchip.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: atmel-isc: fix spelling mistake "profie" -> "profile"
Date:   Wed, 17 Apr 2019 17:34:25 +0100
Message-Id: <20190417163425.12826-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a v4l2_warn warning message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/media/platform/atmel/atmel-isc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/atmel/atmel-isc.c b/drivers/media/platform/atmel/atmel-isc.c
index 9a399aa7ca92..e3cfce05d6b6 100644
--- a/drivers/media/platform/atmel/atmel-isc.c
+++ b/drivers/media/platform/atmel/atmel-isc.c
@@ -1011,7 +1011,7 @@ static int isc_update_profile(struct isc_device *isc)
 	}
 
 	if (counter < 0) {
-		v4l2_warn(&isc->v4l2_dev, "Time out to update profie\n");
+		v4l2_warn(&isc->v4l2_dev, "Time out to update profile\n");
 		return -ETIMEDOUT;
 	}
 
-- 
2.20.1

