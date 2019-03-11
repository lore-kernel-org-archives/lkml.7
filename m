Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53E5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1DE206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfCKN1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:27:49 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:58291 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbfCKNTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:36 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MrQMz-1gg5dQ1Sx5-00oT2y for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:35 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 059/114] drivers: phy: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:11 +0100
Message-Id: <1552310346-7629-60-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:kWmaZhFIzMG+Frx9HN45RnyptPiIiKiQPCcYlbUcVVwAP1o+Tt/
 aYkZu9xpTLqMHJTXjcJ5SQoqSrRK2EghoFcMdpqp7O2QqBbcdn0ZCzEJsGi4pXIaR3AOu1p
 xQxFJdcWsJ5gdjwPnvgpvyGRynMfk8sWl5AHm44l+2B3bgFy9OniNmkgH2pIKyhk/l+PsoP
 2EWZnWM/rMu5MWLC1nb7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hVY1Vk5V33k=:LvdQZfBNb/7WIKST3eX5Bi
 5BDfYHM/Hfv1i4XyV9jTP//e5hwUvEVi2ynYHbrCzqfyn/Ep51nnVrbwVUzD2iitvallyGYKS
 hOFnRoJy+AkFiY2t02zc6bbu/+xl/g7oJ44OoJcZDRev9vwZ4hWahRsNI/bqLeWSKOdUtrrcp
 A2mfc4B2wemJIoJX/AVsvNG54Ess1LmFCxafUy/JXk8F9BhU4PXuZXis8rbe6w8D6/T+PtmkO
 hKq5crYVX6H3HMjvzFNrD8H3FJYfM6JiaYyJYUhl88UDr6tSbB1z3TfMxYQMW9mH8UBLfhnaJ
 tS0jNX0tMVU5McBiHfl04lKLMAflQpCv7+S7QJsFAM1vlj7RZI+StcJuQsZ5ZaBcrsaWqY+3W
 RssoCLy2HIQzK2Fdxv/9ApGVnjOXZFBjocojneNf9wLvYHO7H3Ws+Em87lK0EtPRixtxuBstw
 jF7s1cK3fVK4NV3EHkPpAzkQvq/pjDEVP4s3IjEsujVuRJl2dRTHzOO0i9o1tc/TrG7Z07lTu
 9lmx/CCkFf2gXG0QKBwD8MafOlVMqr8BpBUTgcC41F/nO5GsuZdeH+gubJqaHe9NId+vVufE7
 f8HdSH9AjqjNYobbH0I7L97NQPTqhIqeTQ/B76HPS7xyKJGWWRVyMFtMCFSSd4YOTR0HvMZEz
 If3pbheuuqeWZ0f/gb95300zhSWOYgQBzi08SD8Gr1E7w81D8c2eFy+8nfNVGNRq/ioProR7a
 3JKx8GBou9FxIdbEhg06xtMF2Nbk3nVlTH23qA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/phy/hisilicon/Kconfig | 16 ++++++++--------
 drivers/phy/mediatek/Kconfig  | 20 ++++++++++----------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/phy/hisilicon/Kconfig b/drivers/phy/hisilicon/Kconfig
index b40ee54..589e74b 100644
--- a/drivers/phy/hisilicon/Kconfig
+++ b/drivers/phy/hisilicon/Kconfig
@@ -22,14 +22,14 @@ config PHY_HISTB_COMBPHY
 	  If unsure, say N.
 
 config PHY_HISI_INNO_USB2
-       tristate "HiSilicon INNO USB2 PHY support"
-       depends on (ARCH_HISI && ARM64) || COMPILE_TEST
-       select GENERIC_PHY
-       select MFD_SYSCON
-       help
-         Support for INNO USB2 PHY on HiSilicon SoCs. This Phy supports
-         USB 1.5Mb/s, USB 12Mb/s, USB 480Mb/s speeds. It supports one
-         USB host port to accept one USB device.
+	tristate "HiSilicon INNO USB2 PHY support"
+	depends on (ARCH_HISI && ARM64) || COMPILE_TEST
+	select GENERIC_PHY
+	select MFD_SYSCON
+	help
+	  Support for INNO USB2 PHY on HiSilicon SoCs. This Phy supports
+	  USB 1.5Mb/s, USB 12Mb/s, USB 480Mb/s speeds. It supports one
+	  USB host port to accept one USB device.
 
 config PHY_HIX5HD2_SATA
 	tristate "HIX5HD2 SATA PHY Driver"
diff --git a/drivers/phy/mediatek/Kconfig b/drivers/phy/mediatek/Kconfig
index 8857d00..76f9701 100644
--- a/drivers/phy/mediatek/Kconfig
+++ b/drivers/phy/mediatek/Kconfig
@@ -2,22 +2,22 @@
 # Phy drivers for Mediatek devices
 #
 config PHY_MTK_TPHY
-    tristate "MediaTek T-PHY Driver"
-    depends on ARCH_MEDIATEK && OF
-    select GENERIC_PHY
-    help
-      Say 'Y' here to add support for MediaTek T-PHY driver,
-      it supports multiple usb2.0, usb3.0 ports, PCIe and
+	tristate "MediaTek T-PHY Driver"
+	depends on ARCH_MEDIATEK && OF
+	select GENERIC_PHY
+	help
+	  Say 'Y' here to add support for MediaTek T-PHY driver,
+	  it supports multiple usb2.0, usb3.0 ports, PCIe and
 	  SATA, and meanwhile supports two version T-PHY which have
 	  different banks layout, the T-PHY with shared banks between
 	  multi-ports is first version, otherwise is second veriosn,
 	  so you can easily distinguish them by banks layout.
 
 config PHY_MTK_XSPHY
-    tristate "MediaTek XS-PHY Driver"
-    depends on ARCH_MEDIATEK && OF
-    select GENERIC_PHY
-    help
+	tristate "MediaTek XS-PHY Driver"
+	depends on ARCH_MEDIATEK && OF
+	select GENERIC_PHY
+	help
 	  Enable this to support the SuperSpeedPlus XS-PHY transceiver for
 	  USB3.1 GEN2 controllers on MediaTek chips. The driver supports
 	  multiple USB2.0, USB3.1 GEN2 ports.
-- 
1.9.1

