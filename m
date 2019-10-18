Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2216CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 23:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA3921D7C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 23:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731806AbfJRXRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 19:17:52 -0400
Received: from piie.net ([80.82.223.85]:44834 "EHLO piie.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730058AbfJRXRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 19:17:51 -0400
X-Greylist: delayed 392 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Oct 2019 19:17:50 EDT
Received: from localhost (HSI-KBW-078-043-057-186.hsi4.kabel-badenwuerttemberg.de [78.43.57.186])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by piie.net (Postfix) with ESMTPSA id 96B0D2B6C;
        Sat, 19 Oct 2019 01:11:21 +0200 (CEST)
From:   Peter Kaestle <peter@piie.net>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     Peter Kaestle <peter@piie.net>, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/2] treewide: Rename Peter Feuerer to Peter Kaestle
Date:   Sat, 19 Oct 2019 00:59:36 +0200
Message-Id: <20191018225936.131763-2-peter@piie.net>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018225936.131763-1-peter@piie.net>
References: <20191018225936.131763-1-peter@piie.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

treewide: Rename Peter Feuerer to Peter Kaestle

Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Peter Kaestle <peter@piie.net>

---
 MAINTAINERS                     | 2 +-
 drivers/platform/x86/acerhdf.c  | 4 ++--
 drivers/thermal/gov_bang_bang.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0154674cbad3..a907670c5e79 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -295,7 +295,7 @@ S:	Maintained
 F:	drivers/net/ethernet/alteon/acenic*
 
 ACER ASPIRE ONE TEMPERATURE AND FAN DRIVER
-M:	Peter Feuerer <peter@piie.net>
+M:	Peter Kaestle <peter@piie.net>
 L:	platform-driver-x86@vger.kernel.org
 W:	http://piie.net/?section=acerhdf
 S:	Maintained
diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index d40f365d8d7a..8cc86f4e3ac1 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -4,7 +4,7 @@
  *           of the aspire one netbook, turns on/off the fan
  *           as soon as the upper/lower threshold is reached.
  *
- * (C) 2009 - Peter Feuerer     peter (a) piie.net
+ * (C) 2009 - Peter Kaestle     peter (a) piie.net
  *                              http://piie.net
  *     2009 Borislav Petkov	bp (a) alien8.de
  *
@@ -803,7 +803,7 @@ static void __exit acerhdf_exit(void)
 }
 
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Peter Feuerer");
+MODULE_AUTHOR("Peter Kaestle");
 MODULE_DESCRIPTION("Aspire One temperature and fan driver");
 MODULE_ALIAS("dmi:*:*Acer*:pnAOA*:");
 MODULE_ALIAS("dmi:*:*Acer*:pnAO751h*:");
diff --git a/drivers/thermal/gov_bang_bang.c b/drivers/thermal/gov_bang_bang.c
index e0575d29023a..b831fc77cf64 100644
--- a/drivers/thermal/gov_bang_bang.c
+++ b/drivers/thermal/gov_bang_bang.c
@@ -2,7 +2,7 @@
 /*
  *  gov_bang_bang.c - A simple thermal throttling governor using hysteresis
  *
- *  Copyright (C) 2014 Peter Feuerer <peter@piie.net>
+ *  Copyright (C) 2014 Peter Kaestle <peter@piie.net>
  *
  *  Based on step_wise.c with following Copyrights:
  *  Copyright (C) 2012 Intel Corp
-- 
2.23.0

