Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E0DC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C247621882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389164AbfKGPew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 10:34:52 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:46547 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388901AbfKGPev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 10:34:51 -0500
X-Originating-IP: 92.137.17.54
Received: from localhost (alyon-657-1-975-54.w92-137.abo.wanadoo.fr [92.137.17.54])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 160B640005;
        Thu,  7 Nov 2019 15:34:48 +0000 (UTC)
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
Subject: [PATCH 2/3] dt-bindings: usb: atmel: Mark EP child node as deprecated
Date:   Thu,  7 Nov 2019 16:31:27 +0100
Message-Id: <20191107153128.11038-3-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191107153128.11038-1-gregory.clement@bootlin.com>
References: <20191107153128.11038-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to describe the end point in the deice tree. These
properties won't be use anymore, so mark them as deprecated to keep
the old device tree documented.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 .../devicetree/bindings/usb/atmel-usb.txt     | 56 +------------------
 1 file changed, 3 insertions(+), 53 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/atmel-usb.txt b/Documentation/devicetree/bindings/usb/atmel-usb.txt
index 44e80153b148..423b99a8fd97 100644
--- a/Documentation/devicetree/bindings/usb/atmel-usb.txt
+++ b/Documentation/devicetree/bindings/usb/atmel-usb.txt
@@ -88,13 +88,15 @@ Required properties:
  - clock-names: Should contain two strings
 		"pclk" for the peripheral clock
 		"hclk" for the host clock
+
+Deprecated property:
  - ep childnode: To specify the number of endpoints and their properties.
 
 Optional properties:
  - atmel,vbus-gpio: If present, specifies a gpio that allows to detect whether
    vbus is present (USB is connected).
 
-Required child node properties:
+Deprecated child node properties:
  - name: Name of the endpoint.
  - reg: Num of the endpoint.
  - atmel,fifo-size: Size of the fifo.
@@ -112,56 +114,4 @@ usb2: gadget@fff78000 {
 	clocks = <&utmi>, <&udphs_clk>;
 	clock-names = "hclk", "pclk";
 	atmel,vbus-gpio = <&pioB 19 0>;
-
-	ep@0 {
-		reg = <0>;
-		atmel,fifo-size = <64>;
-		atmel,nb-banks = <1>;
-	};
-
-	ep@1 {
-		reg = <1>;
-		atmel,fifo-size = <1024>;
-		atmel,nb-banks = <2>;
-		atmel,can-dma;
-		atmel,can-isoc;
-	};
-
-	ep@2 {
-		reg = <2>;
-		atmel,fifo-size = <1024>;
-		atmel,nb-banks = <2>;
-		atmel,can-dma;
-		atmel,can-isoc;
-	};
-
-	ep@3 {
-		reg = <3>;
-		atmel,fifo-size = <1024>;
-		atmel,nb-banks = <3>;
-		atmel,can-dma;
-	};
-
-	ep@4 {
-		reg = <4>;
-		atmel,fifo-size = <1024>;
-		atmel,nb-banks = <3>;
-		atmel,can-dma;
-	};
-
-	ep@5 {
-		reg = <5>;
-		atmel,fifo-size = <1024>;
-		atmel,nb-banks = <3>;
-		atmel,can-dma;
-		atmel,can-isoc;
-	};
-
-	ep@6 {
-		reg = <6>;
-		atmel,fifo-size = <1024>;
-		atmel,nb-banks = <3>;
-		atmel,can-dma;
-		atmel,can-isoc;
-	};
 };
-- 
2.24.0.rc1

