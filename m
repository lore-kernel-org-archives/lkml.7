Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECEEC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 23:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FCF9206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 23:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="L76xr757"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfLIXoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 18:44:13 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:36543 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbfLIXoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 18:44:10 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 97F9923D22;
        Tue, 10 Dec 2019 00:44:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1575935047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kIL6zdpKQ1u4IWNIaa7uOSa38Zl21eYDKcDmSAfwrRI=;
        b=L76xr757ZVtv8p29f+LttwVKqgz/q/0rpmie84KpW8aXek5m/c2zZIcae7MPmj3Dy07NXF
        /Y5iWcp6I30fvlyitrfKyFN1IkT0ZL1FxXk5A3HCmyJhRvzb4kbKH1Tb44+Gpz7gNkxQIw
        kZbRydHqnX8RKpU9eCVkJ+YlpvVY0rI=
From:   Michael Walle <michael@walle.cc>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Yuantian Tang <andy.tang@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 2/5] arm64: dts: ls1028a: add missing sai nodes
Date:   Tue, 10 Dec 2019 00:43:47 +0100
Message-Id: <20191209234350.18994-3-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191209234350.18994-1-michael@walle.cc>
References: <20191209234350.18994-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 97F9923D22
X-Spamd-Result: default: False [6.40 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[9];
         MID_CONTAINS_FROM(1.00)[];
         NEURAL_HAM(-0.00)[-0.696];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:31334, ipnet:2a02:810c::/31, country:DE];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LS1028A has six SAI cores.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 06082c932531..7a55314e9c8d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -545,6 +545,20 @@
 			status = "disabled";
 		};
 
+		sai3: audio-controller@f120000 {
+			#sound-dai-cells = <0>;
+			compatible = "fsl,vf610-sai";
+			reg = <0x0 0xf120000 0x0 0x10000>;
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
+				 <&clockgen 4 1>, <&clockgen 4 1>;
+			clock-names = "bus", "mclk1", "mclk2", "mclk3";
+			dma-names = "tx", "rx";
+			dmas = <&edma0 1 8>,
+			       <&edma0 1 7>;
+			status = "disabled";
+		};
+
 		sai4: audio-controller@f130000 {
 			#sound-dai-cells = <0>;
 			compatible = "fsl,vf610-sai";
@@ -559,6 +573,34 @@
 			status = "disabled";
 		};
 
+		sai5: audio-controller@f140000 {
+			#sound-dai-cells = <0>;
+			compatible = "fsl,vf610-sai";
+			reg = <0x0 0xf140000 0x0 0x10000>;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
+				 <&clockgen 4 1>, <&clockgen 4 1>;
+			clock-names = "bus", "mclk1", "mclk2", "mclk3";
+			dma-names = "tx", "rx";
+			dmas = <&edma0 1 12>,
+			       <&edma0 1 11>;
+			status = "disabled";
+		};
+
+		sai6: audio-controller@f150000 {
+			#sound-dai-cells = <0>;
+			compatible = "fsl,vf610-sai";
+			reg = <0x0 0xf150000 0x0 0x10000>;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
+				 <&clockgen 4 1>, <&clockgen 4 1>;
+			clock-names = "bus", "mclk1", "mclk2", "mclk3";
+			dma-names = "tx", "rx";
+			dmas = <&edma0 1 14>,
+			       <&edma0 1 13>;
+			status = "disabled";
+		};
+
 		tmu: tmu@1f80000 {
 			compatible = "fsl,qoriq-tmu";
 			reg = <0x0 0x1f80000 0x0 0x10000>;
-- 
2.20.1

