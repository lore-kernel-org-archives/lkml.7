Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A06BC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 15:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6C2206DB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 15:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="ZkXpJNna"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbfLEPpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 10:45:13 -0500
Received: from gateway34.websitewelcome.com ([192.185.148.204]:41177 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729540AbfLEPpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 10:45:12 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id A42859380B
        for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2019 09:45:11 -0600 (CST)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id ctJXiILVR3Qi0ctJXiXKtg; Thu, 05 Dec 2019 09:45:11 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TW+3zC7f5QFpsJZdkCGHzqRD76y7rl/5etwZN6tUe7A=; b=ZkXpJNnaoQLSMzlMN1GNXgvkiB
        yCFCqMjnqGxOROsJ3H0GYq309iPBYtSWcZLQwLeZQeNdq70GHwgQlCGLbhqjXourt/C9H0FAFNXFV
        hqKXn1oizT0sXQcIxF5ARki+FWTkt+25DSfcVHOhbXUWNbDyvmoAhwAklVA+XK/3wHIHD869nv60n
        JoG4UoUCo2Vg+95aQ6n70BfOrbeGsYgT6i72QbacJM93TSj1cOPYKZQoZuH9ePVlwQq26OaPNyAlu
        iXQyA4VKHm2ex1IHog1SI0yOKU79c6hRpqFVCTyloD6HCod+VeE1bjE1y+P1nXAQirfPPPBk64jc6
        Euj43QYw==;
Received: from [191.31.196.215] (port=35544 helo=castello.bz.toradex.local)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1ictJW-001jEH-Lu; Thu, 05 Dec 2019 12:45:11 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     sre@kernel.org, krzk@kernel.org, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v8 2/5] dt-bindings: power: supply: Max17040: Add DT bindings for max17040 fuel gauge
Date:   Thu,  5 Dec 2019 12:44:07 -0300
Message-Id: <20191205154410.29462-3-matheus@castello.eng.br>
X-Mailer: git-send-email 2.24.0.rc2
In-Reply-To: <20191205154410.29462-1-matheus@castello.eng.br>
References: <20191205154410.29462-1-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.31.196.215
X-Source-L: No
X-Exim-ID: 1ictJW-001jEH-Lu
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (castello.bz.toradex.local) [191.31.196.215]:35544
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 24
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation of max17040 based fuel gauge characteristics.
For configure low level state of charge threshold alert signaled from
max17043/max17044 we add "maxim,alert-low-soc-level" property.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../power/supply/max17040_battery.txt         | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/max17040_battery.txt

diff --git a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
new file mode 100644
index 000000000000..f2d0b22b5f79
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
@@ -0,0 +1,33 @@
+max17040_battery
+~~~~~~~~~~~~~~~~
+
+Required properties :
+ - compatible : "maxim,max17040" or "maxim,max77836-battery"
+ - reg: i2c slave address
+
+Optional properties :
+- maxim,alert-low-soc-level :	The alert threshold that sets the state of
+ 				charge level (%) where an interrupt is
+				generated. Can be configured from 1 up to 32
+				(%). If skipped the power up default value of
+				4 (%) will be used.
+- interrupts : 			Interrupt line see Documentation/devicetree/
+				bindings/interrupt-controller/interrupts.txt
+- wakeup-source :		This device has wakeup capabilities. Use this
+				property to use alert low SOC level interrupt
+				as wake up source.
+
+Optional properties support interrupt functionality for alert low state of
+charge level, present in some ICs in the same family, and should be used with
+compatible "maxim,max77836-battery".
+
+Example:
+
+	battery-fuel-gauge@36 {
+		compatible = "maxim,max77836-battery";
+		reg = <0x36>;
+		maxim,alert-low-soc-level = <10>;
+		interrupt-parent = <&gpio7>;
+		interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
+		wakeup-source;
+	};
--
2.24.0.rc2

