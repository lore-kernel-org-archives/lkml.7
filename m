Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE5BC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E5120675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbfCFPNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 10:13:06 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:50057 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727760AbfCFPNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 10:13:06 -0500
Received: from orion.localdomain ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N3sVq-1hA6sp2NRA-00zr9N; Wed, 06 Mar 2019 16:13:03 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Subject: [PATCH] drivers: input: keyboard: Kconfig: formatting cleanup
Date:   Wed,  6 Mar 2019 16:13:02 +0100
Message-Id: <1551885182-18563-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:lmEvUVrTud3m/ve1P4+3+pxXaU9vNnRE+eDyrL7aPTaeQ64BiyP
 nQ+X8gmJR3eJe9yIfkYRG5xQrI1Qz4PexEL12sO5AjPEpEAQ62OJ9FYUZjSWE9b9qRgumN+
 DveC2RwXiGO6VAXURqqdM+MGlbPtUWSNpZp1tamHw4PvcOvd7mt85RWqjjn14AbFSgMGx0D
 whf3btOUJt+qsl0noJY6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pqavpoI2Fgk=:FqKpPay5Y5enEaolZLx1nM
 Ykk7DzchIDQ4+5fDb5EBNgkbJ+qAv7wGuhW+B/tg6lnan+D+bdS0+LXPX0D3UhzsCHnCjv3QV
 Av6rWA6tqxif3/SuTEqTtaHFTgJlhRSa+sl3jJRc+Dqw4BlJ/GdhDcP7/Um1w+uf/YA79Dc1B
 2ee45Hnea9dlkM3Vrj3ykHeqg6ZDipF8pCBSYke2sIPy+U0Ba9JLIYq5Vr293eSXgGL48gox9
 /sWTqHxgmnxbowCFrDTbXKcfyxqT2wtzwcOTjcq9J7dLwlBpebW0snX5vkOX7MNXr4Uc4Arpw
 8HE8QokxXUGr90V826B+rUudyNOsjPjZCBjkYi6vwuyUPttaSNuG75IYot/eYVi2HXjvEIeTD
 80HmncfYblIMfnnDYq5RgJkbFpcb4/1jSzr4RcCP5mQn13E+1L9f9yGBVRYUexzGfGozF64aT
 ErkL7D1WbCRFYPfmQwxcEW7Svh9FG+oxQylWD3/NyyKk1eTA/jOd5XoZyFk4CsSSivtiOZBK2
 dmEjoamfLWubC9jZEjl6523qDJdgUNzLvvTwTf+uFyaLAdw14hCmSWniTocPPA5vKn4PZ4yln
 LIAUpt2Q+mpK82pQh3a6Tc7UUj6WFmsx/YBedwaAOXbdoew2PRzvuWA1MrHiClWrrrsg80AFZ
 v7ui9YTCxdScYE03p4RMFrEXXlv5WVNyDXFogCxOm1zBtcqNpAHVudUTM2UhwqMArAE+PwVPo
 1FWBptru7D9Uqf+DkR9z5x9YqeUWX13kEWVC3w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so just
take damp cloth and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/input/keyboard/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index a878351..ef39f5c 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -138,14 +138,14 @@ config KEYBOARD_ATKBD_RDI_KEYCODES
 	  left-hand column.
 
 config KEYBOARD_QT1070
-       tristate "Atmel AT42QT1070 Touch Sensor Chip"
-       depends on I2C
-       help
-         Say Y here if you want to use Atmel AT42QT1070 QTouch
-         Sensor chip as input device.
-
-         To compile this driver as a module, choose M here:
-         the module will be called qt1070
+	tristate "Atmel AT42QT1070 Touch Sensor Chip"
+	depends on I2C
+	help
+	  Say Y here if you want to use Atmel AT42QT1070 QTouch
+	  Sensor chip as input device.
+
+	  To compile this driver as a module, choose M here:
+	  the module will be called qt1070
 
 config KEYBOARD_QT2160
 	tristate "Atmel AT42QT2160 Touch Sensor Chip"
-- 
1.9.1

