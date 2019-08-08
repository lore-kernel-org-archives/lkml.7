Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F40C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D37D2173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389988AbfHHK0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 06:26:14 -0400
Received: from inva021.nxp.com ([92.121.34.21]:41132 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389751AbfHHK0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 06:26:13 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4D8F8200921;
        Thu,  8 Aug 2019 12:26:11 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 359BA2000E0;
        Thu,  8 Aug 2019 12:26:06 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B0CAF402D8;
        Thu,  8 Aug 2019 18:25:59 +0800 (SGT)
From:   Hui Song <hui.song_1@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Song Hui <hui.song_1@nxp.com>
Subject: [PATCH v1 1/3] gpio: mpc8xxx: add ls1088a platform gpio node DT binding description
Date:   Thu,  8 Aug 2019 18:16:26 +0800
Message-Id: <20190808101628.36782-1-hui.song_1@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Hui <hui.song_1@nxp.com>

ls1088a and ls1028a platform share common gpio node.

Signed-off-by: Song Hui <hui.song_1@nxp.com>
---
 Documentation/devicetree/bindings/gpio/gpio-mpc8xxx.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-mpc8xxx.txt b/Documentation/devicetree/bindings/gpio/gpio-mpc8xxx.txt
index baf95d9..cd28e93 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-mpc8xxx.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-mpc8xxx.txt
@@ -4,7 +4,7 @@ Required properties:
 - compatible : Should be "fsl,<soc>-gpio"
   The following <soc>s are known to be supported:
 	mpc5121, mpc5125, mpc8349, mpc8572, mpc8610, pq3, qoriq,
-	ls1021a, ls1043a, ls2080a, ls1028a.
+	ls1021a, ls1043a, ls2080a, ls1028a, ls1088a.
 - reg : Address and length of the register set for the device
 - interrupts : Should be the port interrupt shared by all 32 pins.
 - #gpio-cells : Should be two.  The first cell is the pin number and
@@ -39,10 +39,10 @@ gpio0: gpio@2300000 {
 };
 
 
-Example of gpio-controller node for a ls1028a SoC:
+Example of gpio-controller node for a ls1028a/ls1088a SoC:
 
 gpio1: gpio@2300000 {
-	compatible = "fsl,ls1028a-gpio","fsl,qoriq-gpio";
+	compatible = "fsl,ls1028a-gpio", "fsl,ls1088a-gpio", "fsl,qoriq-gpio";
 	reg = <0x0 0x2300000 0x0 0x10000>;
 	interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 	gpio-controller;
-- 
2.9.5

