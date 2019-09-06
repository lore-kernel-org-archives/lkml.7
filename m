Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B478C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF6D206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393243AbfIFLKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 07:10:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47029 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392255AbfIFLIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 07:08:24 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i6C6H-00073O-8q; Fri, 06 Sep 2019 13:08:21 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3FAE81C0744;
        Fri,  6 Sep 2019 13:08:15 +0200 (CEST)
Date:   Fri, 06 Sep 2019 11:08:15 -0000
From:   "tip-bot2 for Jerome Brunet" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] dt-bindings: interrupt-controller: New binding for
 the meson sm1 SoCs
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20190829161635.25067-2-jbrunet@baylibre.com>
References: <20190829161635.25067-2-jbrunet@baylibre.com>
MIME-Version: 1.0
Message-ID: <156776809521.24167.11608140259251300270.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     abc08aac82af0c71e30b446575f5810c9cc11640
Gitweb:        https://git.kernel.org/tip/abc08aac82af0c71e30b446575f5810c9cc11640
Author:        Jerome Brunet <jbrunet@baylibre.com>
AuthorDate:    Thu, 29 Aug 2019 18:16:34 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 30 Aug 2019 15:01:06 +01:00

dt-bindings: interrupt-controller: New binding for the meson sm1 SoCs

Update the dt-binding to add support for the sm1 SoC family in the
amlogic GPIO interrupt controller driver.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20190829161635.25067-2-jbrunet@baylibre.com
---
 Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
index 7d531d5..684bb1c 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
@@ -16,6 +16,7 @@ Required properties:
     "amlogic,meson-gxl-gpio-intc" for GXL SoCs (S905X, S912)
     "amlogic,meson-axg-gpio-intc" for AXG SoCs (A113D, A113X)
     "amlogic,meson-g12a-gpio-intc" for G12A SoCs (S905D2, S905X2, S905Y2)
+    "amlogic,meson-sm1-gpio-intc" for SM1 SoCs (S905D3, S905X3, S905Y3)
 - reg : Specifies base physical address and size of the registers.
 - interrupt-controller : Identifies the node as an interrupt controller.
 - #interrupt-cells : Specifies the number of cells needed to encode an
