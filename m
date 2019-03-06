Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17871C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7FD520661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfCFS2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:28:30 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:54365 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfCFS23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:28:29 -0500
Received: from orion.localdomain ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MjjOl-1gePOq42Nn-00lB0w; Wed, 06 Mar 2019 19:27:16 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     perex@perex.cz, tiwai@suse.com
Subject: [PATCH] sound: soc: qcom: Kconfig: formatting cleanup
Date:   Wed,  6 Mar 2019 19:27:08 +0100
Message-Id: <1551896828-30562-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:hBpBApIZMQIdrwK37yW7DxXZRxuPku8Nqp+AUMb6W6PNcMkvr9a
 4B3PnFESy9+qSk5m90bu29+B6CErP6BkK2w4EWvVzP/2jW7uBM3D1CJ1gEg6vbj4TDxAiTC
 5awq6ZlWJXZ4mVpYgr7PQhPJzE5xtkZWJ9hycexnFcKlZNoZv7rj/peEmp5ePg9Xl0hsO3w
 0Nn5jK0pGMyGrVfksKrDQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:561sHun1cWY=:NjH9x9cS6u4uFQRPYt/91j
 TlyxJtcQbEsDsu8FXEYfc/m7ziVLpARV0UpMV8g/9WRExhINmC6ALsaFDC7uyOCA8FbJe8qUQ
 Zkkx+uoUCi97RqVOTDhYYDh3+LGSIJ3xwlkLfwP0fwqtE0+ilXt9SYLxcFs7vp7BgyfN/dl3h
 ptItLwRwqd1kwzEaKS0LN080XeOYfZs98lG7u7C1hi7Wrb5t8hCuKALNWv2upiaxvUm38bQTb
 Sh2RUFN+8iH5xYtrowOUTHnTWmaQTO3qThNUydwu2XLbZ6GuSgI4ZHPsZwW1fPdMoPt5Aar6F
 o9KNuxS9s5xnr//atMlfcphV+QTtNPPI08g3M9j3SHB/t9z5K9XAjr85OPB4rodZhEFTnjklD
 ixiDFRSV99LuI0ah6NJQBcrjCCsj1Kz1SeSH4wVxZjgczs90Kw57on7PQDZD6gY6fvez8bjzg
 /gKcCcePbNKapIMk/GQ2mA/OiCgxrN7Ma6dgaR5ZqnmbIKGayyqlJbjSs5KsH2RzNtoVKn2h3
 /OCAP0yHbwT+Gd7VkUT5XCpfzM4yGJ82YG1oFcPVTIOVC/73DKsMXgqE+IcFGL7oYkRYnRGW1
 k+yPXA/OYEnHNXbs8SRjV4MOAFkDyRkh74qQCOqdqfWXYsfYqG6mYXQCmHTyysMy/UbC85ok7
 TL1jsC28jvQSyKykCR83JK6Rz+CKFPMyPnsBzGotSsW1K2lt4JMqiJnKTlfRTjzKuSYjIq41v
 uwss0RLFnU+A+Vx4GZawcZ3CyY976qpOa+SgPJ4DIZaIV4exeSEL9v3fpunbkpBb99LE6SDw5
 BSdwRILEz+q1JvvaZlaEDf4kC9oVHMkNzK1L48itK6z6vdinJ0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 sound/soc/qcom/Kconfig | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 804ae0d..a748ad0 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -2,8 +2,8 @@ config SND_SOC_QCOM
 	tristate "ASoC support for QCOM platforms"
 	depends on ARCH_QCOM || COMPILE_TEST
 	help
-          Say Y or M if you want to add support to use audio devices
-          in Qualcomm Technologies SOC-based platforms.
+	  Say Y or M if you want to add support to use audio devices
+	  in Qualcomm Technologies SOC-based platforms.
 
 config SND_SOC_LPASS_CPU
 	tristate
@@ -29,17 +29,17 @@ config SND_SOC_STORM
 	select SND_SOC_LPASS_IPQ806X
 	select SND_SOC_MAX98357A
 	help
-          Say Y or M if you want add support for SoC audio on the
-          Qualcomm Technologies IPQ806X-based Storm board.
+	  Say Y or M if you want add support for SoC audio on the
+	  Qualcomm Technologies IPQ806X-based Storm board.
 
 config SND_SOC_APQ8016_SBC
 	tristate "SoC Audio support for APQ8016 SBC platforms"
 	depends on SND_SOC_QCOM
 	select SND_SOC_LPASS_APQ8016
 	help
-          Support for Qualcomm Technologies LPASS audio block in
-          APQ8016 SOC-based systems.
-          Say Y if you want to use audio devices on MI2S.
+	  Support for Qualcomm Technologies LPASS audio block in
+	  APQ8016 SOC-based systems.
+	  Say Y if you want to use audio devices on MI2S.
 
 config SND_SOC_QCOM_COMMON
 	tristate
@@ -81,10 +81,10 @@ config SND_SOC_QDSP6
 	select SND_SOC_QDSP6_ASM
 	select SND_SOC_QDSP6_ASM_DAI
 	help
-	 To add support for MSM QDSP6 Soc Audio.
-	 This will enable sound soc platform specific
-	 audio drivers. This includes q6asm, q6adm,
-	 q6afe interfaces to DSP using apr.
+	  To add support for MSM QDSP6 Soc Audio.
+	  This will enable sound soc platform specific
+	  audio drivers. This includes q6asm, q6adm,
+	  q6afe interfaces to DSP using apr.
 
 config SND_SOC_MSM8996
 	tristate "SoC Machine driver for MSM8996 and APQ8096 boards"
@@ -92,9 +92,9 @@ config SND_SOC_MSM8996
 	select SND_SOC_QDSP6
 	select SND_SOC_QCOM_COMMON
 	help
-          Support for Qualcomm Technologies LPASS audio block in
-          APQ8096 SoC-based systems.
-          Say Y if you want to use audio device on this SoCs
+	  Support for Qualcomm Technologies LPASS audio block in
+	  APQ8096 SoC-based systems.
+	  Say Y if you want to use audio device on this SoCs
 
 config SND_SOC_SDM845
 	tristate "SoC Machine driver for SDM845 boards"
-- 
1.9.1

