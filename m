Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015FFC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5EC208CE
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574306448;
	bh=3MWW/Bpxanm/z/AU2uq9QV8D77+obZXHDNXLGUOq6xg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=pQPUjEkTFnXN0KBbv1HC6GDerPQJ0LPM9QdiE0M9/h/d+6eD+blOcXjINiGwBZzD7
	 igx6/F4YB3c2Wc4x/klucGe49NqBsS29uoBanfRE8393yBPcSSO+U7sw1bnAFmJOr/
	 YACMCjcTAWESFjKBC3H2IEJRVSE7pUSo/fXtJvYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfKUDUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 22:20:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:34574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727560AbfKUDUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 22:20:44 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 442E720B7C;
        Thu, 21 Nov 2019 03:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574306444;
        bh=3MWW/Bpxanm/z/AU2uq9QV8D77+obZXHDNXLGUOq6xg=;
        h=From:To:Cc:Subject:Date:From;
        b=O/sFcqlo4H7igNIeccqFVsL7azE5pHyRIbMYIa1f9kYXzvf0d6ut4gaJP+Un20iH4
         L8pUPv2C2eAoCTSwxpLyep68QV13Ypw3V35e6zW+watBRJ/0oY0hzF0lzAUQLxuaix
         IF8UkXiqirWC02gjUeyVzoBzBsoPZdQRgdnIYZqE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
Subject: [PATCH v2] auxdisplay: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 04:20:41 +0100
Message-Id: <1574306441-29723-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Fix also 7-space and tab+1 space indentation issues.
---
 drivers/auxdisplay/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
index b8313a04422d..48efa7a047f3 100644
--- a/drivers/auxdisplay/Kconfig
+++ b/drivers/auxdisplay/Kconfig
@@ -111,7 +111,7 @@ config CFAG12864B
 	  If unsure, say N.
 
 config CFAG12864B_RATE
-       int "Refresh rate (hertz)"
+	int "Refresh rate (hertz)"
 	depends on CFAG12864B
 	default "20"
 	---help---
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
2.7.4

