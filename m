Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F740C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 06:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A452133F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 06:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfE1GYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 02:24:49 -0400
Received: from muru.com ([72.249.23.125]:51466 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727815AbfE1GYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 02:24:47 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id C9800810D;
        Tue, 28 May 2019 06:25:05 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 12/13] ARM: dts: Drop legacy custom hwmods property for omap4 uart
Date:   Mon, 27 May 2019 23:24:13 -0700
Message-Id: <20190528062414.27192-13-tony@atomide.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190528062414.27192-1-tony@atomide.com>
References: <20190528062414.27192-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With recent ti-sysc driver changes, we can now finally probe most
modules without needing the custom ti,hwmods property.

Let's start with omap4 uart as we can test that for runtime PM
for core retention idle mode.

Cc: devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap4-l4.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-l4.dtsi b/arch/arm/boot/dts/omap4-l4.dtsi
--- a/arch/arm/boot/dts/omap4-l4.dtsi
+++ b/arch/arm/boot/dts/omap4-l4.dtsi
@@ -1371,7 +1371,6 @@
 
 		target-module@20000 {			/* 0x48020000, ap 3 06.0 */
 			compatible = "ti,sysc-omap2", "ti,sysc";
-			ti,hwmods = "uart3";
 			reg = <0x20050 0x4>,
 			      <0x20054 0x4>,
 			      <0x20058 0x4>;
@@ -1728,7 +1727,6 @@
 
 		target-module@6a000 {			/* 0x4806a000, ap 26 18.0 */
 			compatible = "ti,sysc-omap2", "ti,sysc";
-			ti,hwmods = "uart1";
 			reg = <0x6a050 0x4>,
 			      <0x6a054 0x4>,
 			      <0x6a058 0x4>;
@@ -1758,7 +1756,6 @@
 
 		target-module@6c000 {			/* 0x4806c000, ap 28 20.0 */
 			compatible = "ti,sysc-omap2", "ti,sysc";
-			ti,hwmods = "uart2";
 			reg = <0x6c050 0x4>,
 			      <0x6c054 0x4>,
 			      <0x6c058 0x4>;
@@ -1788,7 +1785,6 @@
 
 		target-module@6e000 {			/* 0x4806e000, ap 30 1c.1 */
 			compatible = "ti,sysc-omap2", "ti,sysc";
-			ti,hwmods = "uart4";
 			reg = <0x6e050 0x4>,
 			      <0x6e054 0x4>,
 			      <0x6e058 0x4>;
-- 
2.21.0
