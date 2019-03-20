Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC72C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A853E2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbfCTMec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:34:32 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:58981 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfCTMeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:34:31 -0400
Received: from localhost (unknown [182.72.246.220])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 075C1200011;
        Wed, 20 Mar 2019 12:34:28 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/6] rtc: goldfish: sort headers
Date:   Wed, 20 Mar 2019 13:34:14 +0100
Message-Id: <20190320123417.13724-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320123417.13724-1-alexandre.belloni@bootlin.com>
References: <20190320123417.13724-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort headers alphabetically.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-goldfish.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-goldfish.c b/drivers/rtc/rtc-goldfish.c
index 354a1aa58495..23301e15992c 100644
--- a/drivers/rtc/rtc-goldfish.c
+++ b/drivers/rtc/rtc-goldfish.c
@@ -14,10 +14,10 @@
  *
  */
 
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/rtc.h>
-#include <linux/io.h>
 
 #define TIMER_TIME_LOW		0x00	/* get low bits of current time  */
 					/*   and update TIMER_TIME_HIGH  */
-- 
2.20.1

