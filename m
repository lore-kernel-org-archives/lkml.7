Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA47C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 06:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DBFE2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 06:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfHMGKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 02:10:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36152 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfHMGKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 02:10:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id g67so364060wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 23:10:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uk9LUIzsgSRkXcDo9ThPQ+SJ/EmYFrkkLULf/OVB6Gk=;
        b=nmxx2gLc8tR3JzOJl8rzc3SzQAwqXCdBKO5CHZvBSOVFWZxp+4bHbW3gfC9o4TMs3q
         eFWCZCL8qSp5waGUzrCqyc0QriBTsQJwURAHl3mEyQcRY88gXaLPk616s2ZyvBHlMpNm
         4n4tq/mPlbO8W+20/GTDbzTOmJpNaF3t3gJ5jGzSCJfxC6q8k3zfAblWS8QrfVAmw5pN
         QUqCpN8dvM6v9BxkIXjE7JylX+3WPUgLex58ufX51qzNnY0k0bLqx+OJOPudU1rF5ZDf
         K7GP3DqPepwlTb0/8FdTA7DuNgM8OJXIyAICZu6yoztw5NJ6CG45Kh87q8HfxLhnBYlx
         cB3w==
X-Gm-Message-State: APjAAAVlCfuSjuUdqG/DfR0yHY+kvt6uKd7fD+/SCJB1XEOAbPGqJ4gs
        RqYlknjmObCG0+C+u8Xeppf8LypGDVs=
X-Google-Smtp-Source: APXvYqy1Xna/xTbSCLLFyNaxLEe6jSucJlbYjjCOD1yeSbN/MB02EzrZ+wJzyuGXTzE0/hKH9yrctg==
X-Received: by 2002:a7b:c929:: with SMTP id h9mr1120163wml.1.1565676653666;
        Mon, 12 Aug 2019 23:10:53 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id g26sm431358wmh.32.2019.08.12.23.10.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 23:10:53 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-kernel@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>, joe@perches.com,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] MAINTAINERS: Update path to tcb_clksrc.c
Date:   Tue, 13 Aug 2019 09:10:46 +0300
Message-Id: <20190813061046.15712-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update MAINTAINERS record to reflect the filename change
from tcb_clksrc.c to timer-atmel-tcb.c

Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-arm-kernel@lists.infradead.org
Fixes: a7aae768166e ("clocksource/drivers/tcb_clksrc: Rename the file for consistency")
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c9ad38a9414f..3ec8154e4630 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10637,7 +10637,7 @@ M:	Nicolas Ferre <nicolas.ferre@microchip.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	drivers/misc/atmel_tclib.c
-F:	drivers/clocksource/tcb_clksrc.c
+F:	drivers/clocksource/timer-atmel-tcb.c
 
 MICROCHIP USBA UDC DRIVER
 M:	Cristian Birsan <cristian.birsan@microchip.com>
-- 
2.21.0

