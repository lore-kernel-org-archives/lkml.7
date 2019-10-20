Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78F2CA9EA0
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 15:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8700A21928
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 15:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfJTPgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 11:36:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:42548 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726482AbfJTPgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 11:36:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 69453AE35;
        Sun, 20 Oct 2019 15:36:22 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] arm64: dts: realtek: Add oscillator for RTD129x
Date:   Sun, 20 Oct 2019 17:36:11 +0200
Message-Id: <20191020153612.29889-2-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191020153612.29889-1-afaerber@suse.de>
References: <20191020153612.29889-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 27 MHz oscillator clock node.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v3: New (from previously blocking clk patch series)
 
 arch/arm64/boot/dts/realtek/rtd129x.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/realtek/rtd129x.dtsi b/arch/arm64/boot/dts/realtek/rtd129x.dtsi
index a26c375ee1bb..4fb16611159b 100644
--- a/arch/arm64/boot/dts/realtek/rtd129x.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd129x.dtsi
@@ -23,6 +23,13 @@
 		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	osc27M: osc {
+		compatible = "fixed-clock";
+		clock-frequency = <27000000>;
+		#clock-cells = <0>;
+		clock-output-names = "osc27M";
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.16.4

