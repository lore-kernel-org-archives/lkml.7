Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48994C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25B8B21848
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733119AbfHZPi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 11:38:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43894 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733054AbfHZPiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 11:38:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id y8so15758989wrn.10;
        Mon, 26 Aug 2019 08:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C68wfOK/1whk3hXx2aI+LZu/B14qolQqF5YsPbhywYw=;
        b=JyQoopayi0NQ+uMrbKNFrchy8ctwzvEhEnsYqUCRJdOSjNXkDan0KQMx8RROZFS9fD
         S27mYjoJWszoWgv7icA7Ur/cAphRDBwtKQ2Qn//9ARlxry6+xcZ3QeRKcIO401xncFga
         HLXEveqxaV/kKIlu0KmHjrKNvZeh5seKsyU3I72kGpf7ytwC9qnhpRXMg4CPP2XybMiT
         9ghetOsel/Jro8pT46uYPDcbQQ7EqdZPpumdeP2FrTemUKJPeAC3UwwnSWKGjz3BNTml
         9RnS/U/T3gfUfa23Fk7iGZfJpr2R6Clt4yY1BvEqIN/OaqIjjcGnK24mJ6FCZFl4NoXt
         ejRw==
X-Gm-Message-State: APjAAAUe/h/QaM5JPbLMhI7YbiKkUtOYz9EtK37c+XZDqr30QC5vexJ5
        06BT5UTIUMTKVqBm24Uyr8a5oDwjS30=
X-Google-Smtp-Source: APXvYqzSfSRNF+1JuaMYWeM7Zw0bN2vHYxbspqB/4JqdONbprhgfE3ickBcc/rF94i6b4+TlH5xkhA==
X-Received: by 2002:adf:c803:: with SMTP id d3mr24148095wrh.130.1566833927742;
        Mon, 26 Aug 2019 08:38:47 -0700 (PDT)
Received: from 1aq-andre.garage.tyco.com ([77.107.218.170])
        by smtp.gmail.com with ESMTPSA id z8sm11580798wru.13.2019.08.26.08.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 08:38:47 -0700 (PDT)
From:   =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>,
        Ilya Ledvich <ilya@compulab.co.il>,
        Igor Grinberg <grinberg@compulab.co.il>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 05/12] ARM: dts: imx7d: cl-som-imx7: update pfuze3000 max voltage
Date:   Mon, 26 Aug 2019 16:37:53 +0100
Message-Id: <20190826153800.35400-5-git@andred.net>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190826153800.35400-1-git@andred.net>
References: <20190826153800.35400-1-git@andred.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The max voltage of SW1A is 3.3V on PF3000 as per
http://cache.freescale.com/files/analog/doc/data_sheet/PF3000.pdf?fsrch=1&sr=1&pageNum=1

While at it, remove the unnecessary leading zero from
the i2c address.

Signed-off-by: André Draszik <git@andred.net>
Cc: Ilya Ledvich <ilya@compulab.co.il>
Cc: Igor Grinberg <grinberg@compulab.co.il>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index 481bd3971c55..78046633d91b 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -81,12 +81,12 @@
 
 	pmic: pmic@8 {
 		compatible = "fsl,pfuze3000";
-		reg = <0x08>;
+		reg = <0x8>;
 
 		regulators {
 			sw1a_reg: sw1a {
 				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1475000>;
+				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
 				regulator-always-on;
 				regulator-ramp-delay = <6250>;
-- 
2.23.0.rc1

