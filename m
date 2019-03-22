Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D71C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF11721873
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfCVIZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:25:11 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:59849 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfCVIZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 04:25:10 -0400
Received: from stefan-Vostro-260.fritz.box ([109.104.35.112]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MIyiY-1hRehm3YK2-00KPMi; Fri, 22 Mar 2019 09:24:24 +0100
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
Subject: [PATCH V3 1/3] dt-bindings: hwmon: Add tachometer interrupt to pwm-fan
Date:   Fri, 22 Mar 2019 09:24:01 +0100
Message-Id: <1553243043-19486-2-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553243043-19486-1-git-send-email-stefan.wahren@i2se.com>
References: <1553243043-19486-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:nq8OyT1wg7dcG8eHRnTrK/K41jzHU5JOzyyFlAgAFvZJqsHNxSM
 warCX7BwYqtO5bkset+71PibLpJ4SnOLUSr+F/IXPQ2HNmW7et5Oe6gijrOu7Ud+YKuKO/f
 CZcKJBmGldl3Ja6cG7pYGofzo6ZtYgxRNb5N3O/eCODkUZDtiiNSQxVilN02V6ur6xeQrp2
 1tVt/dOBgaHNfpxHNhqBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OL9dj5Zfnz4=:0doaADnROYYwKRP+Besd91
 K84IYNCCY/Y0CdcsfNKipoRZPbitoC4WEw1Y6ECuSqgjbzEliDu3oWMC2D1Aq2afxoRHIxV2O
 eIZ0sjJltLVJwWEJj+YewNN3uqg4+u3v19aFeAOTf7+3gLtY88X9Df9g+oRemHwaDv/WQfdu2
 Wf25jeuNJt1cfGB8r++gU8DLmMB2vZjiAMb6wGl2xtQjrwxteWCga+C+0B0uJlz7XM7dt2yng
 T77gMKLRNiR/TkSeuv7BnrAfJfbeuxYRKAiCtvw69ww/+xX67iI28aSaI1a6ImRSdiW3zL5dv
 WRANPOChY2AaJUXVPED2VF8htuPE4pnuGi6Ovk2Z9ZlOFUFWdhpVqWgIrniRc4si5zcXEfZlX
 o9A9uUpw3UyXxF3H2tu6cb3P8ZAUlP/kSqwn0TuRYeN3JfBAv5CoY1KBEE8v6pg1mj5BcHnwG
 WcxsKcM1GkhvB8YMaJc2TC554fTpFdkS2zs1Gl4dN5Qxjt9e/eNhZS0mCViz0IEWAhaZH/gwy
 o1TxBOeVmXc5ViPkfNpjVujAwYxMCEteQNKTiCgrjAAu7mW8AUGay/jizaQdpGrbwQRvXWABu
 6GfR+y8g853qQTHKVWLfYy3vwAer7CTeS1agxzVOBFyABUvw8Tk+KDCwl2rvh915b14UwQ8yN
 n1bW3rUDNYkzC7JfiwZl0OoF3uJGlOFgXpPoEgs7G1WKOh3orDsoQrkE5LkIzdx7+r2E6YMKD
 KnZ9+8JNWdcfI1QXwvNAc3qYSXEe1OnA9M9QAT8YDRC5Q/yBnChV67S4hP+qEPbGmkh48X4di
 rX6TjW6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the tachometer interrupt to the pwm-fan binding, which is
necessary for RPM support.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../devicetree/bindings/hwmon/pwm-fan.txt          | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
index 49ca5d8..722005f 100644
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
@@ -38,3 +47,14 @@ Example:
 					};
 			     };
 		};
+
+Example 2:
+	fan0: pwm-fan {
+		fan0: pwm-fan {
+		compatible = "pwm-fan";
+		pwms = <&pwm 0 40000 0>;
+		fan-supply = <&reg_fan>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+		pulses-per-revolution = <2>;
+	};
-- 
2.7.4

