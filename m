Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2E8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D746A2184D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfCKNTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:19:34 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:51205 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbfCKNTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:30 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mkpj7-1gdsi73fbj-00mHBM for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:28 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 010/114] sound: soc: qcom: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:22 +0100
Message-Id: <1552310346-7629-11-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:B3VBc+NZWKIAEsI0Am9cP0XvhXXe0dm+E5IFhdjQzhGqiO7euNO
 VXP3tbFSOP91W4ATX3gp3NwXB7ODUmi4n/q9jlh1IuzzPruZjiPKlOgI+qBwlpVWSErKtU0
 nPug9oBawbpGScjN5/B6IHWd9J7j/w5tP50YVAZQPqHuhGvc8leESWFe/3I3PLACzwSzf1Y
 pjEOVMGjmtL9uLjcymJSg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xWdzfQ9yk9I=:b97SE35KiKNTDV1NatanJL
 L2src6+jAcuv3i4Y1E3sFoZdvLweRnidWh2P4gCdoRiWKROepFkZJZVu73tkCiMYbZA2DP8St
 Izf8V3rtl3senUUYMr7vPaaz2weWHPvC2p/xaefcLwngxh0/6mYxLGduGMHSeHUKPiiKd9wfH
 Bs5H5/gYEgEFYNzjMA0YXbTOHbcgb214n/pr4u2Ai0E+73cu/Ry+VlNCIeiFI8toVq5Z8Om/u
 QkkjHRNpjFfeSuH/ycdnV97INSWl6MZlmuwTb9eV0X9ktbBwMCx7KAW2NF/tv8QUq1xH5sOsV
 QtB5bTz5NITiD7il9s+XSB7b8lcgXVE6FQ/Bky6GnwKegwAindvrT+eXMexM1Jv8+p2bfXZwt
 hxBvDBp+VNYgDdwd/3tZrejK2Wss7IfrIK6fMYxVMnfQ9TweWfyQndIkObjytCPLP7R9hi8ZY
 svIq9nTYBRGtO0eGAGVWM0zQvWsP3zAHG9Mcya4WDTxi2RD514OmP+A0Z6rGjnnWj69YMnqe7
 tnt9FlNi4rGMsETsB4TRSoRO4LUSmM7aWCSa55bRcSzW9hrxILPPZ32jR7I7n0ReYOcJ6Qldi
 v2AWTBKojnfkCeHdXG8TOTm6LxPgcoCHOniO/dLZoDb0BGkwoGCLkwgefRCL0aJ7nyzs/lROV
 W4BHrzuKf1AWzhyvSSIjMac2i2K16GIqlORkkbWf3NM0dbvDFnV36uSDMJFdlGt/rcA/ACNt8
 eZBGL7ELntjp1s1fuuf8irXaxsxuD0ILCsschg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 sound/soc/qcom/Kconfig | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 75ceb04..85397f4 100644
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

