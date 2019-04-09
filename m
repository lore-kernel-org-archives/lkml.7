Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF28C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624422133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfDIQFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:05:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41661 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfDIQFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:05:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id r4so21617023wrq.8;
        Tue, 09 Apr 2019 09:05:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bZRH8BQvQfqJ8PuhiUKhkZgAtd/Nrxrzl3i103OLtxE=;
        b=TjummLROe6NbbCavXULIU2TiL9atx6mJ4SIvfpsnswRTEiSqfpP97Cyt5PJ1xu8D7N
         V6q4arBZF1oQW9J62BXYeS/sZ4RuCXw3dYsX4IwssvePV1yFrvZtzVXPj5lXMLUd6MIO
         tFzprT2KYH7nbwUSWzl84fr7kHLb3KuoXR32jWGFBnSwQNNTQY+eo3VFTYx9Kr7LnhCY
         MZuEjOYPHWnY0wMo3URoJ6mLruEI/vRObb/0RJdQ+KmM/CDfi4NJ3d8EzijPXMFmAgkh
         l/LdMF18wSlUDAwnfCxHLcFRoNnIPxqFHEg4x2dIaXzEpfmDtGhlNJvI9ieaGqmoaEwz
         ri+w==
X-Gm-Message-State: APjAAAXiV8YF4LRxDtEDifV8PoQO7b+8RCARygrevrADIqJtTXrj/101
        wfnx6gKNNOYOxPTQRbSNg+Q=
X-Google-Smtp-Source: APXvYqyIp+uXNwiaeMyidwNWQbOPJQMMmcV8t/nBDZ7sM5FOETvM+fxTMLozxjVTv9ZT8fk0xvLBGQ==
X-Received: by 2002:a5d:448b:: with SMTP id j11mr22712480wrq.218.1554825907697;
        Tue, 09 Apr 2019 09:05:07 -0700 (PDT)
Received: from localhost ([90.85.130.193])
        by smtp.gmail.com with ESMTPSA id x18sm19287664wmi.6.2019.04.09.09.05.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 09:05:07 -0700 (PDT)
From:   Christina Quast <cquast@hanoverdisplays.com>
To:     tony@atomide.com
Cc:     Christina Quast <cquast@hanoverdisplays.com>,
        Benoit Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/15] ARM: dts: am335x: baltos-leds: Replaced register offsets with defines
Date:   Tue,  9 Apr 2019 18:03:35 +0200
Message-Id: <20190409160346.25599-5-cquast@hanoverdisplays.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190409160346.25599-1-cquast@hanoverdisplays.com>
References: <20190409160346.25599-1-cquast@hanoverdisplays.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The defines are taken from dt-bindings/pinctrl/am33xx.h

Signed-off-by: Christina Quast <cquast@hanoverdisplays.com>
---
 arch/arm/boot/dts/am335x-baltos-leds.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-baltos-leds.dtsi b/arch/arm/boot/dts/am335x-baltos-leds.dtsi
index 3ab1767d5c13..fe75050c016f 100644
--- a/arch/arm/boot/dts/am335x-baltos-leds.dtsi
+++ b/arch/arm/boot/dts/am335x-baltos-leds.dtsi
@@ -42,9 +42,9 @@
 &am33xx_pinmux {
 	user_leds: pinmux_user_leds {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x908, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* mii1_col.gpio3_0 PWR LED */
-			AM33XX_IOPAD(0x91c, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* mii1_txd3.gpio0_16 WLAN LED */
-			AM33XX_IOPAD(0x920, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* mii1_txd2.gpio0_17 APP LED */
+			AM33XX_PADCONF(AM335X_PIN_MII1_COL, PIN_OUTPUT_PULLDOWN, MUX_MODE7)	/* mii1_col.gpio3_0 PWR LED */
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD3, PIN_OUTPUT_PULLDOWN, MUX_MODE7)	/* mii1_txd3.gpio0_16 WLAN LED */
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD2, PIN_OUTPUT_PULLDOWN, MUX_MODE7)	/* mii1_txd2.gpio0_17 APP LED */
 		>;
 	};
 };
-- 
2.20.1

