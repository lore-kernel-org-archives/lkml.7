Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D13C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 03:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B38218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 03:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="Q8i8QmTu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731330AbfCAD72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 22:59:28 -0500
Received: from mail.nic.cz ([217.31.204.67]:53129 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728588AbfCAD7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 22:59:20 -0500
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id AE4C1634EE;
        Fri,  1 Mar 2019 04:59:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1551412756; bh=gQzCFDpw6LQDk+30j6M7CtjXTPXzqPIOki1c1ljLtAc=;
        h=From:To:Date;
        b=Q8i8QmTuVRrFObcVcnzO/ND9SBpBGX3nuGMj2jsMoOfN1UbeopfeVahjSAcwYpXpK
         9EuWovnnpFHs74ZnaJkqNdcFSFmfzjWDGs2AhacEUe9/Djy6E3v3V5G1VdeRylYB6O
         of5YsZin3wwcVIGt8wILKnpx1yrE0v8ndSGNpMqk=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Tony Lindgren <tony@atomide.com>, Shawn Guo <shawnguo@kernel.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v3 bus+gpio 5/5] dt-bindings: gpio: Document GPIOs via Moxtet bus
Date:   Fri,  1 Mar 2019 04:58:52 +0100
Message-Id: <20190301035852.26780-6-marek.behun@nic.cz>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190301035852.26780-1-marek.behun@nic.cz>
References: <20190301035852.26780-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds documentation of the device tree bindings for GPIOs
on the devices connected via Moxtet bus.

Signed-off-by: Marek Behún <marek.behun@nic.cz>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
---
 .../devicetree/bindings/gpio/gpio-moxtet.txt   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-moxtet.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-moxtet.txt b/Documentation/devicetree/bindings/gpio/gpio-moxtet.txt
new file mode 100644
index 000000000000..410759de9f09
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-moxtet.txt
@@ -0,0 +1,18 @@
+Turris Mox Moxtet GPIO expander via Moxtet bus
+
+Required properties:
+ - compatible		: Should be "cznic,moxtet-gpio".
+ - gpio-controller	: Marks the device node as a GPIO controller.
+ - #gpio-cells		: Should be two. For consumer use see gpio.txt.
+
+Other properties are required for a Moxtet bus device, please refer to
+Documentation/devicetree/bindings/bus/moxtet.txt.
+
+Example:
+
+	moxtet_sfp: gpio@0 {
+		compatible = "cznic,moxtet-gpio";
+		gpio-controller;
+		#gpio-cells = <2>;
+		reg = <0>;
+	}
-- 
2.19.2

