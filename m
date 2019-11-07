Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCCCC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587E3214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389211AbfKGPez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 10:34:55 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:34321 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729698AbfKGPex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 10:34:53 -0500
Received: from localhost (alyon-657-1-975-54.w92-137.abo.wanadoo.fr [92.137.17.54])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 81AAC100012;
        Thu,  7 Nov 2019 15:34:50 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Cristian Birsan <cristian.birsan@microchip.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 3/3] ARM: dts: at91: Remove the USB EP child node
Date:   Thu,  7 Nov 2019 16:31:28 +0100
Message-Id: <20191107153128.11038-4-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191107153128.11038-1-gregory.clement@bootlin.com>
References: <20191107153128.11038-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The endpoint configuration used to be stored in the device tree,
however the configuration depend on the "version" of the controller
itself.

Then the EP child node are useless and describe as deprecated in the
documentation binding: remove all the nodes from the SoC device tree
file.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/arm/boot/dts/at91sam9g45.dtsi |  52 -------------
 arch/arm/boot/dts/at91sam9rl.dtsi  |  52 -------------
 arch/arm/boot/dts/at91sam9x5.dtsi  |  52 -------------
 arch/arm/boot/dts/sama5d2.dtsi     | 118 -----------------------------
 arch/arm/boot/dts/sama5d3.dtsi     | 105 -------------------------
 arch/arm/boot/dts/sama5d4.dtsi     | 118 -----------------------------
 6 files changed, 497 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 691c95ea6175..63bfe546cd8d 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -1204,58 +1204,6 @@
 				clocks = <&udphs_clk>, <&utmi>;
 				clock-names = "pclk", "hclk";
 				status = "disabled";
-
-				ep@0 {
-					reg = <0>;
-					atmel,fifo-size = <64>;
-					atmel,nb-banks = <1>;
-				};
-
-				ep@1 {
-					reg = <1>;
-					atmel,fifo-size = <1024>;
-					atmel,nb-banks = <2>;
-					atmel,can-dma;
-					atmel,can-isoc;
-				};
-
-				ep@2 {
-					reg = <2>;
-					atmel,fifo-size = <1024>;
-					atmel,nb-banks = <2>;
-					atmel,can-dma;
-					atmel,can-isoc;
-				};
-
-				ep@3 {
-					reg = <3>;
-					atmel,fifo-size = <1024>;
-					atmel,nb-banks = <3>;
-					atmel,can-dma;
-				};
-
-				ep@4 {
-					reg = <4>;
-					atmel,fifo-size = <1024>;
-					atmel,nb-banks = <3>;
-					atmel,can-dma;
-				};
-
-				ep@5 {
-					reg = <5>;
-					atmel,fifo-size = <1024>;
-					atmel,nb-banks = <3>;
-					atmel,can-dma;
-					atmel,can-isoc;
-				};
-
-				ep@6 {
-					reg = <6>;
-					atmel,fifo-size = <1024>;
-					atmel,nb-banks = <3>;
-					atmel,can-dma;
-					atmel,can-isoc;
-				};
 			};
 
 			clk32k: sckc@fffffd50 {
diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index 8643b7151565..e118bacb7d7c 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -308,58 +308,6 @@
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 22>, <&pmc PMC_TYPE_CORE PMC_UTMI>;
 				clock-names = "pclk", "hclk";
 				status = "disabled";
-
-				ep@0 {
-					reg = <0>;
-					atmel,fifo-size = <64>;
-					atmel,nb-banks = <1>;
-				};
-
-				ep@1 {
-					reg = <1>;
-					atmel,fifo-size = <1024>;
-					atmel,nb-banks = <2>;
-					atmel,can-dma;
-					atmel,can-isoc;
-				};
-
-				ep@2 {
-					reg = <2>;
-					atmel,fifo-size = <1024>;
-					atmel,nb-banks = <2>;
-					atmel,can-dma;
-					atmel,can-isoc;
-				};
-
-				ep@3 {
-					reg = <3>;
-					atmel,fifo-size = <1024>;
-					atmel,nb-banks = <3>;
-					atmel,can-dma;
-				};
-
-				ep@4 {
-					reg = <4>;
-					atmel,fifo-size = <1024>;
-					atmel,nb-banks = <3>;
-					atmel,can-dma;
-				};
-
-				ep@5 {
-					reg = <5>;
-					atmel,fifo-size = <1024>;
-					atmel,nb-banks = <3>;
-					atmel,can-dma;
-					atmel,can-isoc;
-				};
-
-				ep@6 {
-					reg = <6>;
-					atmel,fifo-size = <1024>;
-					atmel,nb-banks = <3>;
-					atmel,can-dma;
-					atmel,can-isoc;
-				};
 			};
 
 			dma0: dma-controller@ffffe600 {
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 7c2eb93f8cac..685a1b9f3ae5 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -876,58 +876,6 @@
 				clocks = <&pmc PMC_TYPE_CORE PMC_UTMI>, <&pmc PMC_TYPE_PERIPHERAL 23>;
 				clock-names = "hclk", "pclk";
 				status = "disabled";
-
-				ep@0 {
-					reg = <0>;
-					atmel,fifo-size = <64>;
-					atmel,nb-banks = <1>;
-				};
-
-				ep@1 {
-					reg = <1>;
-					atmel,fifo-size = <1024>;
-					atmel,nb-banks = <2>;
-					atmel,can-dma;
-					atmel,can-isoc;
-				};
-
-				ep@2 {
-					reg = <2>;
-					atmel,fifo-size = <1024>;
-					atmel,nb-banks = <2>;
-					atmel,can-dma;
-					atmel,can-isoc;
-				};
-
-				ep@3 {
-					reg = <3>;
-					atmel,fifo-size = <1024>;
-					atmel,nb-banks = <3>;
-					atmel,can-dma;
-				};
-
-				ep@4 {
-					reg = <4>;
-					atmel,fifo-size = <1024>;
-					atmel,nb-banks = <3>;
-					atmel,can-dma;
-				};
-
-				ep@5 {
-					reg = <5>;
-					atmel,fifo-size = <1024>;
-					atmel,nb-banks = <3>;
-					atmel,can-dma;
-					atmel,can-isoc;
-				};
-
-				ep@6 {
-					reg = <6>;
-					atmel,fifo-size = <1024>;
-					atmel,nb-banks = <3>;
-					atmel,can-dma;
-					atmel,can-isoc;
-				};
 			};
 
 			watchdog: watchdog@fffffe40 {
diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 2e2c1a7b1d1d..daafcffbe033 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -122,124 +122,6 @@
 			clocks = <&pmc PMC_TYPE_PERIPHERAL 42>, <&pmc PMC_TYPE_CORE PMC_UTMI>;
 			clock-names = "pclk", "hclk";
 			status = "disabled";
-
-			ep@0 {
-				reg = <0>;
-				atmel,fifo-size = <64>;
-				atmel,nb-banks = <1>;
-			};
-
-			ep@1 {
-				reg = <1>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <3>;
-				atmel,can-dma;
-				atmel,can-isoc;
-			};
-
-			ep@2 {
-				reg = <2>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <3>;
-				atmel,can-dma;
-				atmel,can-isoc;
-			};
-
-			ep@3 {
-				reg = <3>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-dma;
-				atmel,can-isoc;
-			};
-
-			ep@4 {
-				reg = <4>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-dma;
-				atmel,can-isoc;
-			};
-
-			ep@5 {
-				reg = <5>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-dma;
-				atmel,can-isoc;
-			};
-
-			ep@6 {
-				reg = <6>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-dma;
-				atmel,can-isoc;
-			};
-
-			ep@7 {
-				reg = <7>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-dma;
-				atmel,can-isoc;
-			};
-
-			ep@8 {
-				reg = <8>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-isoc;
-			};
-
-			ep@9 {
-				reg = <9>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-isoc;
-			};
-
-			ep@10 {
-				reg = <10>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-isoc;
-			};
-
-			ep@11 {
-				reg = <11>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-isoc;
-			};
-
-			ep@12 {
-				reg = <12>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-isoc;
-			};
-
-			ep@13 {
-				reg = <13>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-isoc;
-			};
-
-			ep@14 {
-				reg = <14>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-isoc;
-			};
-
-			ep@15 {
-				reg = <15>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-isoc;
-			};
 		};
 
 		usb1: ohci@400000 {
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index f770aace0efd..dfd095f33f95 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -1402,111 +1402,6 @@
 			clocks = <&udphs_clk>, <&utmi>;
 			clock-names = "pclk", "hclk";
 			status = "disabled";
-
-			ep@0 {
-				reg = <0>;
-				atmel,fifo-size = <64>;
-				atmel,nb-banks = <1>;
-			};
-
-			ep@1 {
-				reg = <1>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <3>;
-				atmel,can-dma;
-				atmel,can-isoc;
-			};
-
-			ep@2 {
-				reg = <2>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <3>;
-				atmel,can-dma;
-				atmel,can-isoc;
-			};
-
-			ep@3 {
-				reg = <3>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-dma;
-			};
-
-			ep@4 {
-				reg = <4>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-dma;
-			};
-
-			ep@5 {
-				reg = <5>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-dma;
-			};
-
-			ep@6 {
-				reg = <6>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-dma;
-			};
-
-			ep@7 {
-				reg = <7>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-dma;
-			};
-
-			ep@8 {
-				reg = <8>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-			};
-
-			ep@9 {
-				reg = <9>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-			};
-
-			ep@10 {
-				reg = <10>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-			};
-
-			ep@11 {
-				reg = <11>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-			};
-
-			ep@12 {
-				reg = <12>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-			};
-
-			ep@13 {
-				reg = <13>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-			};
-
-			ep@14 {
-				reg = <14>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-			};
-
-			ep@15 {
-				reg = <15>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-			};
 		};
 
 		usb1: ohci@600000 {
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 6ab27a7b388d..0ece6b22d287 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -105,124 +105,6 @@
 			clocks = <&pmc PMC_TYPE_PERIPHERAL 47>, <&pmc PMC_TYPE_CORE PMC_UTMI>;
 			clock-names = "pclk", "hclk";
 			status = "disabled";
-
-			ep@0 {
-				reg = <0>;
-				atmel,fifo-size = <64>;
-				atmel,nb-banks = <1>;
-			};
-
-			ep@1 {
-				reg = <1>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <3>;
-				atmel,can-dma;
-				atmel,can-isoc;
-			};
-
-			ep@2 {
-				reg = <2>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <3>;
-				atmel,can-dma;
-				atmel,can-isoc;
-			};
-
-			ep@3 {
-				reg = <3>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-dma;
-				atmel,can-isoc;
-			};
-
-			ep@4 {
-				reg = <4>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-dma;
-				atmel,can-isoc;
-			};
-
-			ep@5 {
-				reg = <5>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-dma;
-				atmel,can-isoc;
-			};
-
-			ep@6 {
-				reg = <6>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-dma;
-				atmel,can-isoc;
-			};
-
-			ep@7 {
-				reg = <7>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-dma;
-				atmel,can-isoc;
-			};
-
-			ep@8 {
-				reg = <8>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-isoc;
-			};
-
-			ep@9 {
-				reg = <9>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-isoc;
-			};
-
-			ep@10 {
-				reg = <10>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-isoc;
-			};
-
-			ep@11 {
-				reg = <11>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-isoc;
-			};
-
-			ep@12 {
-				reg = <12>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-isoc;
-			};
-
-			ep@13 {
-				reg = <13>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-isoc;
-			};
-
-			ep@14 {
-				reg = <14>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-isoc;
-			};
-
-			ep@15 {
-				reg = <15>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-isoc;
-			};
 		};
 
 		usb1: ohci@500000 {
-- 
2.24.0.rc1

