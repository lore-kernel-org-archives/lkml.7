Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F77C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD7E2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfCKNUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:20:11 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:57579 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727643AbfCKNTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:41 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MYvTy-1hY2yB3KTo-00UslH for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:39 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 092/114] drivers: dma: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:44 +0100
Message-Id: <1552310346-7629-93-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:Rn7DQ343Bu/2qWpqtMkZX9VF2l+bPWRk85kKtVuenuZMvdTuWTT
 ZLaRoRCFdwTBvfDy1DW9hzcMrPoULDpOi2X+2UWvDElvOuVXlGjssN30Va5FeJDaJY44vFg
 HRIYk4sVIyalIl7N5fvE7jeb4oGTxOKOacVgMA/jGnfZAkkCubOFAEtrxZpL8mNTGvGo9df
 233GmsLO1+9ULdBt4yEOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8F4sFYvN9PE=:ucqq8O69rn4vBhX08D2kGb
 orjZryDC3N9rxWC6ztc6PKUEOQA270Gvy3frRPUNL+sW7rk0M26y2jAuA45QW7ROhfI0Y5Qqt
 56B4qwGLUyJerEfl0l4nFkpwI725U6iLPZHiwRF8D9+7HZJvD8PWCl8wos3iXDrXY5nSZkqwd
 2z69bymaCmwiDr3AVylkaNcB6u2stasNP+OJ02LwtyNvZLOrjV9eH17e7K4ZDPnjue7gkHLjp
 GCy3IcFhdh36ybpGk+ZL2yVyePy49eJeU9wdL5lXVTlkfhuF3eOkpfcpgsz53xWdd0sYZEV9I
 cJbWwv9XqY/1foRpcwtQCrkYhYs3quO+6rr6NDL7tR2nFA6gUxUmu4m4uokPAdMk8Eh9Lomi4
 GpobFjxr9hztxri/ZlFI3aMpyElxoQIc+eXwWRU9/SomM3POrRnnvZTi0SFEfi1KxHchP9Q8A
 HrxeNLyvmF0dge4MtmjAsVVtlIHLQbI7gxGonS64+XxVAAkTCZYjhbqXelJy92qAbD6MhPkQ0
 Tt0gHsuDlhJErEXkJ0ufWmR5m/AhBLjTmTic3dL7GykUxyHMPBtSmwpWqzpOsv9smKRVdCSVw
 QLoTkTfWsIllJ5uN4+7/sSpR5iEBBXmmyRHpGOvSjj+OhV8SpW9PuFWKPyB/V+xj2V98NOtKP
 QMbhPhCvVbeblz+u3i3xmFnW2hE0gFFc4ZXbmMUCvJ9Cwo21apZs83KRQRqcJZZX8UqByJTLe
 AHx07ja3NBSOzT+1c5ahWAfZXeSrkhlKD+evKw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/dma/Kconfig | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index d2286c7..305cf36 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -14,19 +14,19 @@ menuconfig DMADEVICES
 	  be empty in some cases.
 
 config DMADEVICES_DEBUG
-        bool "DMA Engine debugging"
-        depends on DMADEVICES != n
-        help
-          This is an option for use by developers; most people should
-          say N here.  This enables DMA engine core and driver debugging.
+	bool "DMA Engine debugging"
+	depends on DMADEVICES != n
+	help
+	  This is an option for use by developers; most people should
+	  say N here.  This enables DMA engine core and driver debugging.
 
 config DMADEVICES_VDEBUG
-        bool "DMA Engine verbose debugging"
-        depends on DMADEVICES_DEBUG != n
-        help
-          This is an option for use by developers; most people should
-          say N here.  This enables deeper (more verbose) debugging of
-          the DMA engine core and drivers.
+	bool "DMA Engine verbose debugging"
+	depends on DMADEVICES_DEBUG != n
+	help
+	  This is an option for use by developers; most people should
+	  say N here.  This enables deeper (more verbose) debugging of
+	  the DMA engine core and drivers.
 
 
 if DMADEVICES
@@ -219,14 +219,14 @@ config FSL_EDMA
 	  This module can be found on Freescale Vybrid and LS-1 SoCs.
 
 config FSL_RAID
-        tristate "Freescale RAID engine Support"
-        depends on FSL_SOC && !ASYNC_TX_ENABLE_CHANNEL_SWITCH
-        select DMA_ENGINE
-        select DMA_ENGINE_RAID
-        ---help---
-          Enable support for Freescale RAID Engine. RAID Engine is
-          available on some QorIQ SoCs (like P5020/P5040). It has
-          the capability to offload memcpy, xor and pq computation
+	tristate "Freescale RAID engine Support"
+	depends on FSL_SOC && !ASYNC_TX_ENABLE_CHANNEL_SWITCH
+	select DMA_ENGINE
+	select DMA_ENGINE_RAID
+	---help---
+	  Enable support for Freescale RAID Engine. RAID Engine is
+	  available on some QorIQ SoCs (like P5020/P5040). It has
+	  the capability to offload memcpy, xor and pq computation
 	  for raid5/6.
 
 config IMG_MDC_DMA
@@ -357,7 +357,7 @@ config MOXART_DMA
 	select DMA_VIRTUAL_CHANNELS
 	help
 	  Enable support for the MOXA ART SoC DMA controller.
- 
+
 	  Say Y here if you enabled MMP ADMA, otherwise say N.
 
 config MPC512X_DMA
-- 
1.9.1

