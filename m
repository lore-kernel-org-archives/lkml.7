Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC045ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 20:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9528621479
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 20:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="U7mWq69C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbfJGUcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 16:32:09 -0400
Received: from vps.xff.cz ([195.181.215.36]:46262 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729212AbfJGUcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 16:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1570480327; bh=y/VyM0hZNMJuHkjWlJoe2Ll8Mns+SaZDNjGgFDEV18I=;
        h=From:To:Cc:Subject:Date:References:From;
        b=U7mWq69C5aY5UbL5IUH5mlWMNXL0uskF1Tstjk+xrzodsueFjYSuV5veHA2a3rISH
         xhxnrdtLhDqetLQLJrG7g6uHG7nQmidwsuRUl9/BLEt233uhubXarE03aKX1REfddb
         nl67Dl0TEbmuBlCMDrgE/0gQ8+yeCNpseyVi4jzw=
From:   megous@megous.com
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ondrej Jirman <megous@megous.com>
Subject: [RESEND PATCH 1/2] arm64: dts: allwinner: h6: Add pin configs for uart1
Date:   Mon,  7 Oct 2019 22:31:51 +0200
Message-Id: <20191007203152.3889947-2-megous@megous.com>
In-Reply-To: <20191007203152.3889947-1-megous@megous.com>
References: <20191007203152.3889947-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

Orange Pi 3 uses UART1 for bluetooth. Add pinconfigs so that we can use
them.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 67f920e0fc33..7657e816096b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -298,6 +298,16 @@
 				pins = "PH0", "PH1";
 				function = "uart0";
 			};
+
+			uart1_pins: uart1-pins {
+				pins = "PG6", "PG7";
+				function = "uart1";
+			};
+
+			uart1_rts_cts_pins: uart1-rts-cts-pins {
+				pins = "PG8", "PG9";
+				function = "uart1";
+			};
 		};
 
 		gic: interrupt-controller@3021000 {
-- 
2.23.0

