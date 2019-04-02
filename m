Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC4CC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736F52084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbfDBOWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:22:45 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:37335 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfDBOWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 10:22:44 -0400
Received: from stefan-Vostro-260.fritz.box ([109.104.50.84]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MMFdY-1hTPgS26Tu-00JHZt; Tue, 02 Apr 2019 16:22:10 +0200
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
Subject: [PATCH V4 1/3] dt-bindings: hwmon: Add tachometer interrupt to pwm-fan
Date:   Tue,  2 Apr 2019 16:21:48 +0200
Message-Id: <1554214910-29925-2-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554214910-29925-1-git-send-email-stefan.wahren@i2se.com>
References: <1554214910-29925-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:6zcyaBGoBWJesMoCk1uiSDRQ0oB7TE0AM8FJneaL3zD4PE++w65
 mqjbT0yqZsUsOGfmXvDqPxw+wpJy7HI3oYfYr2EFlyOVY4N+zssP+RUvcnKIhXMH3hy5H1c
 TV8m5PtR3YbmtU+xLKjWVflD6/kykOrcIStENuRHlX6Yg4F4ECOkr/YL78uUsGTvY+69v7E
 cgb7WZFjoR7bUtfs2uORg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l6nOhuu3VfY=:OWFjvLKg617JKUK1YEE8RJ
 Bx1LyHv0uTLgMc5niP9cvBy8kWt8J2lc45BrTBTe0PNATFrn0asVKadmSZ+0H/pxAXitXtaxu
 b3cU78lfMlYgnjjFcXjRjsJqrIJXKZSo2EMUf/oG0ZgkVQBpncANw6guSNkb50xesZD1Zvw26
 ktc10jb03cgZGTG1OCPUQgawI3YHYNPdmgDwiEoNRhbMYRzkWjAnvAq1jrobXU81j0vPhrzpV
 XmOomHSwfyF1jHvcysnnsMcSHG2cxqmfp+toZ9vxI9zjD6OI8nG5CoG5uZ227iuCz8dYm498D
 aQzc56JWHNZ+RpAFd04pNmDSeMVYme+xKJkQMBMtrNZc5C1ZumJ1VTTn6jjZu7zdqTP9XaR9I
 wc50rOHrc0GmXOmZmRQrhkqce6drk7HuFOsmGJ/nR+bHLafTvAujI7/l8y/9c3XoUG4Ddw9AY
 Vd3zEaUcxPYxUrPFRATp6C26xyr61HZgzgYuaD11nldHwcEJoM6KL48Bqqd4c8y2zNPDLciZb
 Ca+L5kJWK9Tk3/30jIft1ToPZxytZTzf8WYBwPQethQu8VTCBD/+AEBTmeja5xNJV9JCfPVhx
 91p+1TnRUZbzRADfBm6jCEf7SWutsuzGTQuaMpcZnsMGDJ9qBeCLrm+2XnHzG4Wqnm6CoivBN
 TrARlIjyu/rfTURUUYofCt9stVIks+TDa9NeETy2/aqp3FNybQ3sjgqk7l/o22EoASwe2ENJj
 6hHyy9HF16Hg3bdIzmBB1LT6EZgIpjY7TBJ8J5cRyS+G/EGDq7AlutylAzc=
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

