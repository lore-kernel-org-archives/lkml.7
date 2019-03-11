Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24989C10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30C8222F6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfCKNbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:31:13 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:43745 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbfCKNT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:29 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MA7Su-1hDlE21xLm-00BZS5 for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:28 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 007/114] drivers: leds: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:19 +0100
Message-Id: <1552310346-7629-8-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:4SNdNw9l1J6lTKgi3pumUUCryyTdN0FH98dgwd9Xa/VK6Md2DpC
 BnsiFMI3DpC3YlpFWmaCx9X+HP4tzhBDvMeUksBZjEBqdl0KGzrrf5JiBPfb9GnW611563i
 kKC5/DMeRgcFiGh0hHpuJ/gYOCf2/7KY77ElqpKDuBusts7lUDPqNOKWREzPLEmmigsOa4w
 6qG6KehMyMwa8lU4++E+w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6sM0tKVDChM=:TlISrDYwV35/K0+Ry2CNML
 0ycreL4Qv6Lahu9IoXVQUZqdM4+2TSIaonv9vTNwr3HyXtZYNTf5POaBVelET1hPdY3WuJucG
 87k82qbOsI0ZJcGBfjBZXw2mahEVKZfITVTlVWGxO1TBejSyHRG4EJg4S6Xwo4Luz6zpMUc4D
 rQbJv2kNY0N7hZDq1p+cadVU++ZPSFnLiPyppI3vmcoRvdl2/k5wYZZ7C4ueIo2BnUgS7uGA5
 rd7/GZP7v1AEbuNj/MVCrharHeOnaoHBZcPL4Zu91d3D/AZftdRlvTXkTyfgsTegFIOqVyWob
 SHSQ3/f68Cs0C+G++VPsdANsP4t/qhvzFVEnYtKIzKCx78XbyldS0Sl1x2Lzwp/1c8Ec6UGUD
 pvRwDTWHd65LmjKgOQf6lrpZFrsSRsftDoW48DB/npI8l7IUrKECp/XfG4921gXuQYA0ZuzCt
 kzRLB4hKCP/9Y6hNZWWs8kNBRA5w2ja63EeWUOkXznSfgL5NOuc7mAa4Lz5irnD0uC4yjJAgf
 35UlFzpazJAntUCa6/zUrM3qcgpVVkWjFlH0dxkjdflzT3hUw2gFR+2Gbc+5RM/QjKYSLVeuy
 A4/0eqUo5zswDj9IwBC58S29KJr3Ux8qnomFdkUNGM5rN9mruFB7HaO5TNcP9+I6UqDIvNB7D
 4JwVvtco0BheWdA0ssqiub7il8V5HcoIHoGy03UpQxcJIcPorxaEbe5eR457htiDUzNUtev+y
 Ym6RQJAgKUWiLj+4ZYiCWhRQ9b/fyBB7+zVaxA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/leds/Kconfig | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index a72f97f..2b5ae50 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -56,7 +56,7 @@ config LEDS_AAT1290
 	depends on OF
 	depends on PINCTRL
 	help
-	 This option enables support for the LEDs on the AAT1290.
+	  This option enables support for the LEDs on the AAT1290.
 
 config LEDS_AN30259A
 	tristate "LED support for Panasonic AN30259A"
@@ -413,13 +413,13 @@ config LEDS_CLEVO_MAIL
 
 	  This module can drive the mail LED for the following notebooks:
 
-	  	Clevo D400P
-	  	Clevo D410J
-	  	Clevo D410V
-	  	Clevo D400V/D470V (not tested, but might work)
-	  	Clevo M540N
-	  	Clevo M5x0N (not tested, but might work)
-	  	Positivo Mobile (Clevo M5x0V)
+	        Clevo D400P
+	        Clevo D410J
+	        Clevo D410V
+	        Clevo D400V/D470V (not tested, but might work)
+	        Clevo M540N
+	        Clevo M5x0N (not tested, but might work)
+	        Positivo Mobile (Clevo M5x0V)
 
 	  If your model is not listed here you can try the "nodetect"
 	  module parameter.
@@ -462,7 +462,7 @@ config LEDS_WM831X_STATUS
 	depends on MFD_WM831X
 	help
 	  This option enables support for the status LEDs of the WM831x
-          series of PMICs.
+	  series of PMICs.
 
 config LEDS_WM8350
 	tristate "LED Support for WM8350 AudioPlus PMIC"
-- 
1.9.1

