Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A9DC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5293F218AE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733259AbfIQI1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 04:27:14 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46906 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729496AbfIQI1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 04:27:11 -0400
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iA8pJ-0005ZY-A5; Tue, 17 Sep 2019 10:27:09 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-rockchip@lists.infradead.org,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 08/13] arm64: dts: rockchip: remove unused pin settings from px30
Date:   Tue, 17 Sep 2019 10:26:54 +0200
Message-Id: <20190917082659.25549-8-heiko@sntech.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190917082659.25549-1-heiko@sntech.de>
References: <20190917082659.25549-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are unused gpio-settings for specific function pins, that
are not used by anything and only clutter up the dtsi.
They can be re-added when a relevant user is added.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/px30.dtsi | 40 --------------------------
 1 file changed, 40 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index f2bbdfa0e4aa..63499d27994c 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -1159,11 +1159,6 @@
 				rockchip,pins =
 					<0 RK_PB5 1 &pcfg_pull_none>;
 			};
-
-			uart0_rts_gpio: uart0-rts-gpio {
-				rockchip,pins =
-					<0 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
-			};
 		};
 
 		uart1 {
@@ -1182,11 +1177,6 @@
 				rockchip,pins =
 					<1 RK_PC3 1 &pcfg_pull_none>;
 			};
-
-			uart1_rts_gpio: uart1-rts-gpio {
-				rockchip,pins =
-					<1 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
-			};
 		};
 
 		uart2-m0 {
@@ -1221,11 +1211,6 @@
 				rockchip,pins =
 					<0 RK_PC3 2 &pcfg_pull_none>;
 			};
-
-			uart3m0_rts_gpio: uart3m0-rts-gpio {
-				rockchip,pins =
-					<0 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
-			};
 		};
 
 		uart3-m1 {
@@ -1244,11 +1229,6 @@
 				rockchip,pins =
 					<1 RK_PB5 2 &pcfg_pull_none>;
 			};
-
-			uart3m1_rts_gpio: uart3m1-rts-gpio {
-				rockchip,pins =
-					<1 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
-			};
 		};
 
 		uart4 {
@@ -1597,16 +1577,6 @@
 					<1 RK_PD4 1 &pcfg_pull_up_8ma>,
 					<1 RK_PD5 1 &pcfg_pull_up_8ma>;
 			};
-
-			sdmmc_gpio: sdmmc-gpio {
-				rockchip,pins =
-					<1 RK_PD2 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
-					<1 RK_PD3 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
-					<1 RK_PD4 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
-					<1 RK_PD5 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
-					<1 RK_PD6 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
-					<1 RK_PD7 RK_FUNC_GPIO &pcfg_pull_up_4ma>;
-			};
 		};
 
 		sdio {
@@ -1627,16 +1597,6 @@
 					<1 RK_PD0 1 &pcfg_pull_up>,
 					<1 RK_PD1 1 &pcfg_pull_up>;
 			};
-
-			sdio_gpio: sdio-gpio {
-				rockchip,pins =
-					<1 RK_PC6 RK_FUNC_GPIO &pcfg_pull_up>,
-					<1 RK_PC7 RK_FUNC_GPIO &pcfg_pull_up>,
-					<1 RK_PD0 RK_FUNC_GPIO &pcfg_pull_up>,
-					<1 RK_PD1 RK_FUNC_GPIO &pcfg_pull_up>,
-					<1 RK_PC4 RK_FUNC_GPIO &pcfg_pull_up>,
-					<1 RK_PC5 RK_FUNC_GPIO &pcfg_pull_up>;
-			};
 		};
 
 		emmc {
-- 
2.20.1

