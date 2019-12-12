Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA3CC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 03:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C95214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 03:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfLLDlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 22:41:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:58618 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727698AbfLLDkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 22:40:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 601BDAD5F;
        Thu, 12 Dec 2019 03:40:03 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org, linux-leds@vger.kernel.org
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [RFC 14/25] arm64: dts: realtek: rtd1295-xnano-x5: Add regular LEDs to FD628
Date:   Thu, 12 Dec 2019 04:39:41 +0100
Message-Id: <20191212033952.5967-15-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191212033952.5967-1-afaerber@suse.de>
References: <20191212033952.5967-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add child nodes for individual LED indicators plus the half-second colon.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 arch/arm64/boot/dts/realtek/rtd1295-xnano-x5.dts | 52 ++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/realtek/rtd1295-xnano-x5.dts b/arch/arm64/boot/dts/realtek/rtd1295-xnano-x5.dts
index ea9e9a96f1d3..9d678b300c7b 100644
--- a/arch/arm64/boot/dts/realtek/rtd1295-xnano-x5.dts
+++ b/arch/arm64/boot/dts/realtek/rtd1295-xnano-x5.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
 
 #include "rtd1295.dtsi"
 
@@ -43,6 +44,57 @@
 			spi-rx-delay-us = <1>;
 			spi-max-frequency = <500000>;
 			#grids = <7>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+
+			apps@1,4 {
+				reg = <1 4>;
+				color = <LED_COLOR_ID_WHITE>;
+				function = LED_FUNCTION_INDICATOR;
+				function-enumerator = <1>;
+			};
+
+			setup@2,4 {
+				reg = <2 4>;
+				color = <LED_COLOR_ID_WHITE>;
+				function = LED_FUNCTION_INDICATOR;
+				function-enumerator = <2>;
+			};
+
+			usb@3,4 {
+				reg = <3 4>;
+				color = <LED_COLOR_ID_WHITE>;
+				function = LED_FUNCTION_INDICATOR;
+				function-enumerator = <3>;
+			};
+
+			card@4,4 {
+				reg = <4 4>;
+				color = <LED_COLOR_ID_WHITE>;
+				function = LED_FUNCTION_INDICATOR;
+				function-enumerator = <4>;
+			};
+
+			colon@5,4 {
+				reg = <5 4>;
+				color = <LED_COLOR_ID_WHITE>;
+				function = LED_FUNCTION_STATUS;
+				function-enumerator = <5>;
+			};
+
+			hdmi@6,4 {
+				reg = <6 4>;
+				color = <LED_COLOR_ID_WHITE>;
+				function = LED_FUNCTION_INDICATOR;
+				function-enumerator = <6>;
+			};
+
+			cvbs@7,4 {
+				reg = <7 4>;
+				color = <LED_COLOR_ID_WHITE>;
+				function = LED_FUNCTION_INDICATOR;
+				function-enumerator = <7>;
+			};
 		};
 	};
 };
-- 
2.16.4

