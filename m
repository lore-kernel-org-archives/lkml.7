Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A4AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE655218D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbfCUQW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:22:57 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:21383 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfCUQW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:22:57 -0400
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x2LGMmIE020525;
        Fri, 22 Mar 2019 01:22:48 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp);
 Fri, 22 Mar 2019 01:22:48 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp)
Received: from localhost.localdomain (118.153.231.153.ap.dti.ne.jp [153.231.153.118])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x2LGMjlf020509
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 22 Mar 2019 01:22:48 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: [PATCH v2] arm64: dts: rockchip: add rk3399 UART DMAs
Date:   Fri, 22 Mar 2019 01:22:44 +0900
Message-Id: <20190321162244.10080-1-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add UART dma channels as specified by the rk3399 TRM.

Refer:
RK3399 TRM V1.4: Chapter 12 DMA Controller

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>

---

Changes from v1:
  - Add dma property for UART4
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 0301e3e01b38..31e487202676 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -635,6 +635,8 @@
 		clocks = <&cru SCLK_UART0>, <&cru PCLK_UART0>;
 		clock-names = "baudclk", "apb_pclk";
 		interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH 0>;
+		dmas = <&dmac_peri 0>, <&dmac_peri 1>;
+		dma-names = "tx", "rx";
 		reg-shift = <2>;
 		reg-io-width = <4>;
 		pinctrl-names = "default";
@@ -648,6 +650,8 @@
 		clocks = <&cru SCLK_UART1>, <&cru PCLK_UART1>;
 		clock-names = "baudclk", "apb_pclk";
 		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH 0>;
+		dmas = <&dmac_peri 2>, <&dmac_peri 3>;
+		dma-names = "tx", "rx";
 		reg-shift = <2>;
 		reg-io-width = <4>;
 		pinctrl-names = "default";
@@ -661,6 +665,8 @@
 		clocks = <&cru SCLK_UART2>, <&cru PCLK_UART2>;
 		clock-names = "baudclk", "apb_pclk";
 		interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH 0>;
+		dmas = <&dmac_peri 4>, <&dmac_peri 5>;
+		dma-names = "tx", "rx";
 		reg-shift = <2>;
 		reg-io-width = <4>;
 		pinctrl-names = "default";
@@ -674,6 +680,8 @@
 		clocks = <&cru SCLK_UART3>, <&cru PCLK_UART3>;
 		clock-names = "baudclk", "apb_pclk";
 		interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH 0>;
+		dmas = <&dmac_peri 6>, <&dmac_peri 7>;
+		dma-names = "tx", "rx";
 		reg-shift = <2>;
 		reg-io-width = <4>;
 		pinctrl-names = "default";
@@ -1152,6 +1160,8 @@
 		clocks = <&pmucru SCLK_UART4_PMU>, <&pmucru PCLK_UART4_PMU>;
 		clock-names = "baudclk", "apb_pclk";
 		interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH 0>;
+		dmas = <&dmac_peri 8>, <&dmac_peri 9>;
+		dma-names = "tx", "rx";
 		reg-shift = <2>;
 		reg-io-width = <4>;
 		pinctrl-names = "default";
-- 
2.20.1

