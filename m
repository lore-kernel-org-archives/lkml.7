Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CF3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C1820657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfCKNUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:20:07 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:34637 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbfCKNTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:40 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MspyA-1go0uY3Ly4-00tGHz for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:38 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 085/114] drivers: auxdisplay: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:37 +0100
Message-Id: <1552310346-7629-86-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:q925iGOy2aggQprCxLy7UeYHGHf7WRS1kyZecRYjlBSGfXzSxHY
 JJfKtgzbXlDC8NXthUSKnua151itCU0avb8wZ7p4HcSjVOd8RSScKcP38z5F0+ubMQG8gDF
 4CfQXrKtwXlVCsEqgWKnYQBtre/+p7vUm90hX/3M147ep8137+kDO4KF0lbeJAzxHh+Eqqg
 DDzHP4W+HOQkCY/7MBthA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WzzqEkel6Dk=:awAr9FbnaOVEsraRuMVd8S
 vV1pVmzC51r2Q6nYKvDvJaRKfUxNEnkCMtQU5It6JG8pTV7plroTcljhTvcZPBBPil601I+s3
 uqjkKI7Z7zPu4QcwlZZrFipDD7zu4P+7c9Zu3JfFHXINBbfHkoK6KTQfrztminIjcc4yJsksW
 9BS8T2vH8nGrrD0uxVLBghXIEBUUOS7pZiR/gZmQlyl5sCS2jY8nI8veS41Kd5k5fg3VbMl5a
 sj8wAX/J+RZL9SdNDLbMQJDiS7dz5PPx+v82BWbWRIqKmOXP6a3oP6bE7WhXgJjBEqpALFdCX
 5y+UyDz9c5YunAty25xXPUB7Vmu03FSCWjVHWs8PiMSMEWTIE6+e3nug4HF/TOPQEusV5TpG+
 WHFAPOk5RnSsWNrQoPvKzP7sayNjgqzY/0ZFTwrIcNro/k9V9pdpgLN3p2su6M7UAa5iokcgU
 PE9eRBQyuncFmWMq3wC+XsOLyPbfrd/ZoCUcD7XdeCq4Fp48VCXYRZID8lNMIQ3dD8es/s4H8
 DHoLHcvkQxBkI7YU5VPE4i2sdHPEpEpWGfeABFh3wWmQUaCy3Jxif8bm4CO4SHhBroG2iO2/Q
 DJ3c7hvdd0ykxdluTaqNgDJY9UPnRnkGRIpDR6xJh2C+ur2d5Mg033Sv1Nkr+Brh3OAZ3iqal
 ojVNexPIFAwX86z8DXFKvRW53win8feAOZR9W6EBVb5iqDsZW9IUS+PjswLBHh+PM3Ux18HZb
 kTc1ruEFRMKQKA/0UXnoSxeH4FFJHtRREL5pdA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/auxdisplay/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
index 57410f9..d08dcc2 100644
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
@@ -331,7 +331,7 @@ config PANEL_LCD_PROTO
 
 config PANEL_LCD_PIN_E
 	depends on PANEL_PROFILE="0" && PANEL_LCD="1" && PANEL_LCD_PROTO="0"
-        int "Parallel port pin number & polarity connected to the LCD E signal (-17...17) "
+	int "Parallel port pin number & polarity connected to the LCD E signal (-17...17) "
 	range -17 17
 	default 14
 	---help---
@@ -346,7 +346,7 @@ config PANEL_LCD_PIN_E
 
 config PANEL_LCD_PIN_RS
 	depends on PANEL_PROFILE="0" && PANEL_LCD="1" && PANEL_LCD_PROTO="0"
-        int "Parallel port pin number & polarity connected to the LCD RS signal (-17...17) "
+	int "Parallel port pin number & polarity connected to the LCD RS signal (-17...17) "
 	range -17 17
 	default 17
 	---help---
@@ -361,7 +361,7 @@ config PANEL_LCD_PIN_RS
 
 config PANEL_LCD_PIN_RW
 	depends on PANEL_PROFILE="0" && PANEL_LCD="1" && PANEL_LCD_PROTO="0"
-        int "Parallel port pin number & polarity connected to the LCD RW signal (-17...17) "
+	int "Parallel port pin number & polarity connected to the LCD RW signal (-17...17) "
 	range -17 17
 	default 16
 	---help---
@@ -376,7 +376,7 @@ config PANEL_LCD_PIN_RW
 
 config PANEL_LCD_PIN_SCL
 	depends on PANEL_PROFILE="0" && PANEL_LCD="1" && PANEL_LCD_PROTO!="0"
-        int "Parallel port pin number & polarity connected to the LCD SCL signal (-17...17) "
+	int "Parallel port pin number & polarity connected to the LCD SCL signal (-17...17) "
 	range -17 17
 	default 1
 	---help---
@@ -391,7 +391,7 @@ config PANEL_LCD_PIN_SCL
 
 config PANEL_LCD_PIN_SDA
 	depends on PANEL_PROFILE="0" && PANEL_LCD="1" && PANEL_LCD_PROTO!="0"
-        int "Parallel port pin number & polarity connected to the LCD SDA signal (-17...17) "
+	int "Parallel port pin number & polarity connected to the LCD SDA signal (-17...17) "
 	range -17 17
 	default 2
 	---help---
@@ -406,12 +406,12 @@ config PANEL_LCD_PIN_SDA
 
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
1.9.1

