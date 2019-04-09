Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFBCC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 854B92084C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfDIQGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:06:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36683 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfDIQGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:06:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id y13so21642707wrd.3;
        Tue, 09 Apr 2019 09:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5E8og7+kAyjR1pPX5DfarjP/jI8RDpJq8gZJvRoC08U=;
        b=mdcjFuASggxptP0R7cyTOIxlA9IVnMbN3D7qQL4nPvFlPeJdduiRjFipsB28lszoYS
         iSMfANReeKsXB50Jl6sT2ApqYpB7qqIJRnEv48t3jdJstU94AkQ0pp4zrri6Ei9hTsHr
         OB1rcbBKbsY4FQaeuZgGIgyHgYgLYk+bDT+pcSApKakLT7rLSTNKidfCk/57iCaqA5G9
         IKZ7xVnEuCwew4mmmz/Tl5CgeU5CjOKSJPls7zMNjEnX/pF2FnDr6hFmMu/wADKqP8XI
         Yl9CB4Fj4rHr/Ja3fJVwNFr6eR2ZIcfJF0rxjrOLy63uMRawOaBlwNUyV4ImMArprHOM
         068g==
X-Gm-Message-State: APjAAAVxjnrsNQDeJVoqHmEyV/6SO1yzvYboZSvFEENdZ4wamKnOYFgO
        hN6s2KXLXkoa7ZUJTJ/AVDQ=
X-Google-Smtp-Source: APXvYqwSp7ph/TgNiHGP4/TICssXgoGxmakLFZ8bTyVjWYPEgSYSLEwAprGWJNU1vvROdwncpxHg8Q==
X-Received: by 2002:adf:f7c2:: with SMTP id a2mr23308022wrq.242.1554825962923;
        Tue, 09 Apr 2019 09:06:02 -0700 (PDT)
Received: from localhost ([90.85.130.193])
        by smtp.gmail.com with ESMTPSA id s10sm19467340wmh.0.2019.04.09.09.06.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 09:06:02 -0700 (PDT)
From:   Christina Quast <cquast@hanoverdisplays.com>
To:     tony@atomide.com
Cc:     Christina Quast <cquast@hanoverdisplays.com>,
        Benoit Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/15] ARM: dts: am335x: chilisom: Replaced register offsets with defines
Date:   Tue,  9 Apr 2019 18:03:42 +0200
Message-Id: <20190409160346.25599-12-cquast@hanoverdisplays.com>
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
 arch/arm/boot/dts/am335x-chilisom.dtsi | 32 +++++++++++++-------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-chilisom.dtsi b/arch/arm/boot/dts/am335x-chilisom.dtsi
index 1b43ebd08b38..8b88bf6dafc4 100644
--- a/arch/arm/boot/dts/am335x-chilisom.dtsi
+++ b/arch/arm/boot/dts/am335x-chilisom.dtsi
@@ -30,28 +30,28 @@
 
 	i2c0_pins: pinmux_i2c0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x988, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
-			AM33XX_IOPAD(0x98c, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
+			AM33XX_PADCONF(AM335X_PIN_I2C0_SDA, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_I2C0_SCL, PIN_INPUT_PULLUP, MUX_MODE0)
 		>;
 	};
 
 	nandflash_pins: nandflash_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x800, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
-			AM33XX_IOPAD(0x804, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
-			AM33XX_IOPAD(0x808, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
-			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
-			AM33XX_IOPAD(0x810, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
-			AM33XX_IOPAD(0x814, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
-			AM33XX_IOPAD(0x818, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
-			AM33XX_IOPAD(0x81c, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD0, PIN_INPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD1, PIN_INPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD2, PIN_INPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD3, PIN_INPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD4, PIN_INPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD5, PIN_INPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD6, PIN_INPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD7, PIN_INPUT_PULLDOWN, MUX_MODE0)
 
-			AM33XX_IOPAD(0x870, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
-			AM33XX_IOPAD(0x87c, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* gpmc_csn0.gpmc_csn0 */
-			AM33XX_IOPAD(0x890, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* gpmc_advn_ale.gpmc_advn_ale */
-			AM33XX_IOPAD(0x894, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* gpmc_oen_ren.gpmc_oen_ren */
-			AM33XX_IOPAD(0x898, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* gpmc_wen.gpmc_wen */
-			AM33XX_IOPAD(0x89c, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* gpmc_be0n_cle.gpmc_be0n_cle */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_WAIT0, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN0, PIN_OUTPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_ADVN_ALE, PIN_OUTPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_OEN_REN, PIN_OUTPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_WEN, PIN_OUTPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_BEN0_CLE, PIN_OUTPUT_PULLUP, MUX_MODE0)
 		>;
 	};
 };
-- 
2.20.1

