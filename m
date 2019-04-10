Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAFAC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F17C217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbfDJKjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:39:45 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:49561 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbfDJKjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:39:45 -0400
Received: from localhost (alyon-652-1-42-177.w109-213.abo.wanadoo.fr [109.213.33.177])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 725D3100008;
        Wed, 10 Apr 2019 10:39:41 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Vladimir Zapolskiy <vz@mleia.com>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 1/3] dt-bindings: gpio: lpc32xx: document interrupt bindings
Date:   Wed, 10 Apr 2019 12:39:24 +0200
Message-Id: <20190410103926.8781-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190410103926.8781-1-alexandre.belloni@bootlin.com>
References: <20190410103926.8781-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the LPC32xx gpios are wired directly to one of the interrupt
controllers while port 0 and port 1 share the same interrupt for their
interrupt capable gpios.

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 Documentation/devicetree/bindings/gpio/gpio_lpc32xx.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio_lpc32xx.txt b/Documentation/devicetree/bindings/gpio/gpio_lpc32xx.txt
index 49819367a011..e7957a17e4db 100644
--- a/Documentation/devicetree/bindings/gpio/gpio_lpc32xx.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio_lpc32xx.txt
@@ -16,6 +16,10 @@ Required properties:
    3) optional parameters:
       - bit 0 specifies polarity (0 for normal, 1 for inverted)
 - reg: Index of the GPIO group
+- interrupts: Should be the interrupt shared by port 0 and port 1 and the
+  interrupts for individual pins from port 3.
+- interrupt-names : Should be the names of irq resources. The shared port
+  interrupt is named "p01", the other use the pin names.
 
 Example:
 
-- 
2.20.1

