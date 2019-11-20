Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D299BC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E3622528
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257388;
	bh=PWiMiIEwJf/JzLtDh41p7WDHax5VfsbHhUXiIDTL3Sw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=bJs0I+QdJNR04dSMplRhOC6NdfziMPacZ8Bem/NI6QVHBPbiTriRT5+DjVf6szqAr
	 4hWLAN1n2vqq3LeZLweMTAKeNKKYZFzhVU3qFeOP11yMhLXAS9HJZ9riu39xD1j6bJ
	 xhQiyFBdBAhyDW/kv84JO/UcfCTRftgAOFrm710g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731470AbfKTNnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:43:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:50998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730467AbfKTNnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:43:05 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4264B22529;
        Wed, 20 Nov 2019 13:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257385;
        bh=PWiMiIEwJf/JzLtDh41p7WDHax5VfsbHhUXiIDTL3Sw=;
        h=From:To:Cc:Subject:Date:From;
        b=cOkS0uhSL/YfZabJXDSnCXHedQOsy+ae07FbIwVzgQD8qTVF+Vh9eRQELn9fspmEA
         l4JGtnbHpKUQTZJmiDC9Pg1yAwqgE2ULYEKFnGLXgWZRjP4wkJTlS1Ll0fqFzR2I4N
         DQ4xEqx33uMxDOeRkA969RsTMplg3r9c1BYonU/g=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
Subject: [PATCH] auxdisplay: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:43:01 +0800
Message-Id: <20191120134301.16244-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/auxdisplay/Kconfig | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
index b8313a04422d..a92be39825f6 100644
--- a/drivers/auxdisplay/Kconfig
+++ b/drivers/auxdisplay/Kconfig
@@ -329,7 +329,7 @@ config PANEL_LCD_PROTO
 
 config PANEL_LCD_PIN_E
 	depends on PANEL_PROFILE="0" && PANEL_LCD="1" && PANEL_LCD_PROTO="0"
-        int "Parallel port pin number & polarity connected to the LCD E signal (-17...17) "
+	int "Parallel port pin number & polarity connected to the LCD E signal (-17...17) "
 	range -17 17
 	default 14
 	---help---
@@ -344,7 +344,7 @@ config PANEL_LCD_PIN_E
 
 config PANEL_LCD_PIN_RS
 	depends on PANEL_PROFILE="0" && PANEL_LCD="1" && PANEL_LCD_PROTO="0"
-        int "Parallel port pin number & polarity connected to the LCD RS signal (-17...17) "
+	int "Parallel port pin number & polarity connected to the LCD RS signal (-17...17) "
 	range -17 17
 	default 17
 	---help---
@@ -359,7 +359,7 @@ config PANEL_LCD_PIN_RS
 
 config PANEL_LCD_PIN_RW
 	depends on PANEL_PROFILE="0" && PANEL_LCD="1" && PANEL_LCD_PROTO="0"
-        int "Parallel port pin number & polarity connected to the LCD RW signal (-17...17) "
+	int "Parallel port pin number & polarity connected to the LCD RW signal (-17...17) "
 	range -17 17
 	default 16
 	---help---
@@ -374,7 +374,7 @@ config PANEL_LCD_PIN_RW
 
 config PANEL_LCD_PIN_SCL
 	depends on PANEL_PROFILE="0" && PANEL_LCD="1" && PANEL_LCD_PROTO!="0"
-        int "Parallel port pin number & polarity connected to the LCD SCL signal (-17...17) "
+	int "Parallel port pin number & polarity connected to the LCD SCL signal (-17...17) "
 	range -17 17
 	default 1
 	---help---
@@ -389,7 +389,7 @@ config PANEL_LCD_PIN_SCL
 
 config PANEL_LCD_PIN_SDA
 	depends on PANEL_PROFILE="0" && PANEL_LCD="1" && PANEL_LCD_PROTO!="0"
-        int "Parallel port pin number & polarity connected to the LCD SDA signal (-17...17) "
+	int "Parallel port pin number & polarity connected to the LCD SDA signal (-17...17) "
 	range -17 17
 	default 2
 	---help---
@@ -404,12 +404,12 @@ config PANEL_LCD_PIN_SDA
 
 config PANEL_LCD_PIN_BL
 	depends on PANEL_PROFILE="0" && PANEL_LCD="1"
-        int "Parallel port pin number & polarity connected to the LCD backlight signal (-17...17) "
+	int "Parallel port pin number & polarity connected to the LCD backlight signal (-17...17) "
 	range -17 17
 	default 0
 	---help---
 	  This describes the number of the parallel port pin to which the LCD 'BL' signal
-          has been connected. It can be :
+	  has been connected. It can be :
 
 	          0 : no connection (eg: connected to ground)
 	      1..17 : directly connected to any of these pins on the DB25 plug
-- 
2.17.1

