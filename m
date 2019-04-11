Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5E7C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46B8217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfDKNb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:31:26 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:51765 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbfDKNbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:31:15 -0400
Received: from stefan-Vostro-260.fritz.box ([109.104.50.113]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M2fHt-1hASur3XuJ-004Epe; Thu, 11 Apr 2019 15:30:34 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V5 1/3] dt-bindings: hwmon: Add tachometer interrupt to pwm-fan
Date:   Thu, 11 Apr 2019 15:30:09 +0200
Message-Id: <1554989411-23666-2-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554989411-23666-1-git-send-email-stefan.wahren@i2se.com>
References: <1554989411-23666-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:PsCpnIbDmYyadjYtyuCDYERvLwlE1+qgamUhOm27R72Y72OTRYX
 IY83JXWpQFjyxmt/DpGXZK4on9mtDsd/5Jp3diCfdx3eHHBDGll+xoZeqnZSFMHVT2s0FtF
 CB1QwRZD6xzZwQe719ocYdyWyvDy16uLNlrPfeikx18LgbT+7mbX9ZG52ooKR/xU7Sqvw6e
 qdyHO6EWyYU5LLVFPjmBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:okX84hxT2BU=:Jc10rmYeGb4EB1xyV6rfYJ
 21yjCxN8JPGzK3vA0X+yYH0OOIeFYnVfSacr3A7swhOfPpxtqyCqZnjJyAGZJq2jGl3LnM1pW
 bc9h5tVyX2ulxlhRmfTnLYbWu1Vm2LBLvDVHTWAkarM4EeNd8hGwzC8X61TPAR+N2I+m+55Hc
 h6AHXaanZdIzvjdqjGe429sSU9SG6s2NKcvSi6zIUQXpb18f9RJlV9kuG0lZq5l9N2pEjkMJH
 H/JIoYXoaL+JFN1hKg39JLXsEV6sG9aSS/6TlxaiENI3DmzZkR3GGg8oRRjBtrQ5Dh3j/VV1C
 EBPZx2diTwsFHlQXacWgv0xqmW27qycjy0xfpr1qpuVz6F3KKRLsyWAcqfOFjuYMnPHDoFnX7
 nn4bCPOFY11uVh2pVpJaWNvczB+s4sdTFiao4HqkeXwnLdYZQfg40p2A6mW57YYzPDmBBwrnN
 a79ru7iDtISpr5YlRndzRqBBOzRtu27nxEjTF6TuE6bAEUa/oY5wuSWfKtutehScZiNchZmw/
 GzCH4ebqfOOaphUnzQoX0GmSqNeTOHJMpgMyxir590iwIOZhpqfxSPrfyixoQJFSiWWXPj4Tq
 8XY+ofYzr37PzjWAGV+8TaSwX6/sfJm85r0Bqo0t6m6nIfynDKB2Rb//cxOFYFwGpNPxkDOJn
 CSxJ4+pKrqWY6ClnBXSnsL4HryFo67chEAj0hUqHg8acTigUIgEUftGyGB0kvrzMhSRZtGJNK
 LuO9DgJzEE3dO14L35kTSwossXmdu8iFsV4cGL34XmBPDffQUiR8bB2MsHI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the tachometer interrupt to the pwm-fan binding, which is
necessary for RPM support.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/hwmon/pwm-fan.txt | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
index 49ca5d8..6ced829b 100644
--- a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
+++ b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
@@ -7,7 +7,16 @@ Required properties:
 			which correspond to thermal cooling states
 
 Optional properties:
-- fan-supply    : phandle to the regulator that provides power to the fan
+- fan-supply		: phandle to the regulator that provides power to the fan
+- interrupts		: This contains a single interrupt specifier which
+			  describes the tachometer output of the fan as an
+			  interrupt source. The output signal must generate a
+			  defined number of interrupts per fan revolution, which
+			  require that it must be self resetting edge interrupts.
+			  See interrupt-controller/interrupts.txt for the format.
+- pulses-per-revolution : define the tachometer pulses per fan revolution as
+			  an integer (default is 2 interrupts per revolution).
+			  The value must be greater than zero.
 
 Example:
 	fan0: pwm-fan {
@@ -38,3 +47,13 @@ Example:
 					};
 			     };
 		};
+
+Example 2:
+	fan0: pwm-fan {
+		compatible = "pwm-fan";
+		pwms = <&pwm 0 40000 0>;
+		fan-supply = <&reg_fan>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+		pulses-per-revolution = <2>;
+	};
-- 
2.7.4

