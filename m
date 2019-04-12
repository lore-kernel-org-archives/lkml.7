Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDA9C282CE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6535218D2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfDLQ3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:29:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45376 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfDLQ22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 12:28:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so12694747wra.12;
        Fri, 12 Apr 2019 09:28:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6KRRAV7lqAKO4FwA9baYWGgaroxL3Gz5MxnRaP1tZdw=;
        b=Olcus2xrCeBGiIMG+CU1KxOdGTCc0mFsnvK3TMcmoKcN8MZJtwVMMbt1xIJQra9ds6
         jHKIUHcIi2j3tYxdkzUvMlzI0zoD3rgQeyx3kZOrR26dIye1zPaYd9aMyWlAELY1m6ed
         0L1CA3JqO4IFbg7TSZJuGBIGPR1N08dxS7kqqZ10CxfhIz7WamFoRdP2UZ7RRu+ue19J
         gPwL9QFrpKiZHjrxsd/SvsvRtHzzNwT4RHxgLRgKqinYCxEMJaVPi7tqi2cGoyDgueY1
         tMm1FaXmpPSmT5ZKhupDanJpi94PdN+TmgGYVeM9iMKdTVfcYB3ubpsttPYLjtLwWPWM
         cWow==
X-Gm-Message-State: APjAAAXO0M4+4KnXfS5vOZYzXjZFrLnTxUC7oewKJWkNEs6/6ugv/azi
        nsFrNKdnj2mEXF1Iu4jnPAo=
X-Google-Smtp-Source: APXvYqz7DPQ6YgqWB9DkC8dU2RnzxxtzzDL3mWaniW52UeeLKVTgRWZ1/PGzPu3+vFTAHrc8BWPY9A==
X-Received: by 2002:adf:cd90:: with SMTP id q16mr16918456wrj.75.1555086506424;
        Fri, 12 Apr 2019 09:28:26 -0700 (PDT)
Received: from localhost ([90.85.130.193])
        by smtp.gmail.com with ESMTPSA id a4sm16848817wmf.45.2019.04.12.09.28.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 09:28:25 -0700 (PDT)
From:   Christina Quast <cquast@hanoverdisplays.com>
Cc:     Christina Quast <cquast@hanoverdisplays.com>,
        Benoit Cousson <bcousson@baylibre.com>,
        Mark Jackson <mpfj@newflow.co.uk>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/17] ARM: dts: am335x: osd335x-common: Replaced register offsets with defines
Date:   Fri, 12 Apr 2019 18:26:18 +0200
Message-Id: <20190412162627.24518-9-cquast@hanoverdisplays.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190412162627.24518-1-cquast@hanoverdisplays.com>
References: <20190412162627.24518-1-cquast@hanoverdisplays.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The defines are taken from dt-bindings/pinctrl/am33xx.h

Signed-off-by: Christina Quast <cquast@hanoverdisplays.com>
---
 arch/arm/boot/dts/am335x-osd335x-common.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-osd335x-common.dtsi b/arch/arm/boot/dts/am335x-osd335x-common.dtsi
index f8ff473f94f0..a8b6842489f7 100644
--- a/arch/arm/boot/dts/am335x-osd335x-common.dtsi
+++ b/arch/arm/boot/dts/am335x-osd335x-common.dtsi
@@ -36,8 +36,8 @@
 &am33xx_pinmux {
 	i2c0_pins: pinmux-i2c0-pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x988, PIN_INPUT_PULLUP | MUX_MODE0)	/* (C17) I2C0_SDA.I2C0_SDA */
-			AM33XX_IOPAD(0x98c, PIN_INPUT_PULLUP | MUX_MODE0)	/* (C16) I2C0_SCL.I2C0_SCL */
+			AM33XX_PADCONF(AM335X_PIN_I2C0_SDA, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_I2C0_SCL, PIN_INPUT_PULLUP, MUX_MODE0)
 		>;
 	};
 };
-- 
2.20.1

