Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EA5C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB0D2133D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RrnKrvC6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfDCSTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:19:33 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40582 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfDCSTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 14:19:33 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x33IJO6k060613;
        Wed, 3 Apr 2019 13:19:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554315564;
        bh=lIKnU3NDBCgql+RGCVa4BBUqTEy5yZRn3Jn1HUAz0tw=;
        h=From:To:CC:Subject:Date;
        b=RrnKrvC6SzlyrTuCWPsGfrfM8ziQObvsQqnNj5PsstZsU4EydkqSwSvtxs2PWEbIq
         PwP+tgqnK+B9kYaULZR3i7LRe+/bYLSzbZGRHnDfG4JniQTU5EjhUPrtfR5JY7ByME
         smx7dFB37FAoikcs+cPdMfzoNBEchU/fKXo85NaY=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x33IJO63003058
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 3 Apr 2019 13:19:24 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 3 Apr
 2019 13:19:24 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 3 Apr 2019 13:19:24 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x33IJOaQ010013;
        Wed, 3 Apr 2019 13:19:24 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <rdunlap@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH] leds: Small fixes for Flash class description
Date:   Wed, 3 Apr 2019 13:19:22 -0500
Message-ID: <20190403181922.21273-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix misspelling and capitalization of LED in the Kconfig.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/leds/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index a72f97fca57b..f24d31138471 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -23,8 +23,8 @@ config LEDS_CLASS_FLASH
 	tristate "LED Flash Class Support"
 	depends on LEDS_CLASS
 	help
-	  This option enables the flash led sysfs class in /sys/class/leds.
-	  It wrapps LED Class and adds flash LEDs specific sysfs attributes
+	  This option enables the flash LED sysfs class in /sys/class/leds.
+	  It wraps LED Class and adds flash LEDs specific sysfs attributes
 	  and kernel internal API to it. You'll need this to provide support
 	  for the flash related features of a LED device. It can be built
 	  as a module.
-- 
2.19.0

