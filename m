Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_RHS_DOB,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93BDC282DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C4521479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388720AbfDRKBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 06:01:15 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:35857 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388693AbfDRKBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 06:01:09 -0400
X-Originating-IP: 109.212.207.226
Received: from localhost (alyon-652-1-176-226.w109-212.abo.wanadoo.fr [109.212.207.226])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 1FD6CFF819;
        Thu, 18 Apr 2019 10:01:06 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Mathieu Malaterre <malat@debian.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 7/7] rtc: jz4740: convert to SPDX identifier
Date:   Thu, 18 Apr 2019 12:00:45 +0200
Message-Id: <20190418100045.29288-7-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190418100045.29288-1-alexandre.belloni@bootlin.com>
References: <20190418100045.29288-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use SPDX-License-Identifier instead of a verbose license text.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-jz4740.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index c9e16d857fa8..0e95282df525 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -1,17 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
  *  Copyright (C) 2010, Paul Cercueil <paul@crapouillou.net>
  *	 JZ4740 SoC RTC driver
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under  the terms of  the GNU General Public License as published by the
- *  Free Software Foundation;  either version 2 of the License, or (at your
- *  option) any later version.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
  */
 
 #include <linux/clk.h>
-- 
2.20.1

