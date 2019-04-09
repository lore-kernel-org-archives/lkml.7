Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBF6C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B5E2084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfDIQF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:05:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38890 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfDIQFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:05:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id k11so21661357wro.5;
        Tue, 09 Apr 2019 09:05:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9cJ2xggIQ10EEJlcOcEZo7u6Y3LMnwZixAy7yTQnY0c=;
        b=jjmJFUR7wBEo+nGrbthEfKSuiAolWLEJxM8vzfIbdwnrbAthpwVBSDDMjAXsRVVAAO
         FWXWt0CsepIslu+OCakYtxWHixSc4mcxA0sL70O7MZaBb+TsNDDeILBZnsL7evC9OgLQ
         lofne0E+sbPNEVBjzo+o3+6vV6LakI5oQ//WhL/6rCB+t6EOIaFAjjXESUMF4yv3/SXv
         K1SFTDJbf6oW0kmxPzh9JZmSg+M2UQJ37Rie2lDE10xnwTR7sTlVRvrGeep0JKTITO/V
         68r22TDgXmOHzBITRAiWCFFFpSCbd8HjiMwEn/mp3IW1sdUjivc7/uFgFLyhtsoDywJk
         FxGg==
X-Gm-Message-State: APjAAAWsPZgq4RxG/oQzCfem1RMww+bIzIeq8RwT/t6ECxZfHco889YH
        dEHL/PzmJyhqt+fd3IQ3ZU0=
X-Google-Smtp-Source: APXvYqyOfOLVpNrP2WV4aCeXia4fl30eac715Vgw4Rp6mNhPUOoevUNznBJbkAMutrMvBp2h7WoFFg==
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr23090702wro.232.1554825953101;
        Tue, 09 Apr 2019 09:05:53 -0700 (PDT)
Received: from localhost ([90.85.130.193])
        by smtp.gmail.com with ESMTPSA id y1sm96517572wrd.34.2019.04.09.09.05.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 09:05:52 -0700 (PDT)
From:   Christina Quast <cquast@hanoverdisplays.com>
To:     tony@atomide.com
Cc:     Christina Quast <cquast@hanoverdisplays.com>,
        Benoit Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/15] ARM: dts: am335x: bonegreen-common: Replaced register offsets with defines
Date:   Tue,  9 Apr 2019 18:03:40 +0200
Message-Id: <20190409160346.25599-10-cquast@hanoverdisplays.com>
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
 arch/arm/boot/dts/am335x-bonegreen-common.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bonegreen-common.dtsi b/arch/arm/boot/dts/am335x-bonegreen-common.dtsi
index 853e6d3a028d..71317e372ec7 100644
--- a/arch/arm/boot/dts/am335x-bonegreen-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bonegreen-common.dtsi
@@ -27,8 +27,8 @@
 &am33xx_pinmux {
 	uart2_pins: uart2_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x950, PIN_INPUT | MUX_MODE1)	/* spi0_sclk.uart2_rxd */
-			AM33XX_IOPAD(0x954, PIN_OUTPUT | MUX_MODE1)	/* spi0_d0.uart2_txd */
+			AM33XX_PADCONF(AM335X_PIN_SPI0_SCLK, PIN_INPUT, MUX_MODE1)	/* spi0_sclk.uart2_rxd */
+			AM33XX_PADCONF(AM335X_PIN_SPI0_D0, PIN_OUTPUT, MUX_MODE1)	/* spi0_d0.uart2_txd */
 		>;
 	};
 };
-- 
2.20.1

