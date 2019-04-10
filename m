Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DADC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29BC20830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbfDJKj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:39:59 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:40861 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbfDJKj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:39:58 -0400
X-Originating-IP: 109.213.33.177
Received: from localhost (alyon-652-1-42-177.w109-213.abo.wanadoo.fr [109.213.33.177])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 41D7020010;
        Wed, 10 Apr 2019 10:39:54 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Vladimir Zapolskiy <vz@mleia.com>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/3] ARM: dts: lpc32xx: add GPIO interrupts
Date:   Wed, 10 Apr 2019 12:39:26 +0200
Message-Id: <20190410103926.8781-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190410103926.8781-1-alexandre.belloni@bootlin.com>
References: <20190410103926.8781-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the interrupts for the GPIO controller.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/boot/dts/lpc32xx.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index 20b38f4ade37..9c61b1856291 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -392,6 +392,31 @@
 				reg = <0x40028000 0x1000>;
 				gpio-controller;
 				#gpio-cells = <3>; /* bank, pin, flags */
+				interrupts-extended = <&sic2 8 IRQ_TYPE_NONE>,
+						<&sic2 22 IRQ_TYPE_NONE>,
+						<&sic2 23 IRQ_TYPE_NONE>,
+						<&sic2 24 IRQ_TYPE_NONE>,
+						<&sic2 25 IRQ_TYPE_NONE>,
+						<&sic2 26 IRQ_TYPE_NONE>,
+						<&sic2 27 IRQ_TYPE_NONE>,
+						<&sic2 28 IRQ_TYPE_NONE>,
+						<&sic2 15 IRQ_TYPE_NONE>,
+						<&sic2 9 IRQ_TYPE_NONE>,
+						<&sic2 10 IRQ_TYPE_NONE>,
+						<&sic1 4 IRQ_TYPE_NONE>,
+						<&sic2 0 IRQ_TYPE_NONE>,
+						<&sic2 1 IRQ_TYPE_NONE>,
+						<&sic2 2 IRQ_TYPE_NONE>,
+						<&sic2 3 IRQ_TYPE_NONE>,
+						<&sic2 4 IRQ_TYPE_NONE>,
+						<&sic2 5 IRQ_TYPE_NONE>;
+				interrupt-names = "p01",
+						"gpi00", "gpi01", "gpi02",
+						"gpi03", "gpi04", "gpi05",
+						"gpi06", "gpi07", "gpi08",
+						"gpi09", "gpi19", "gpi28",
+						"gpio00", "gpio01", "gpio02",
+						"gpio03", "gpio04", "gpio05";
 			};
 
 			timer4: timer@4002c000 {
-- 
2.20.1

