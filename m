Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62AACA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B684222C2
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571674723;
	bh=3vY2pIjyYjAUhRAyST8D3WoCMrO68dPHRpC8oVEgtkA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=HptOEIx7Gen6cb13kD/FfbNB9I7HHaTKybIU55/Q8OKOrufNHLuKQ+fo5dEyHYftu
	 44MEnA4LVfgyngd4M0AjEeEOqjQCiYPa6SLdpomg/73gRN/cZV19ybB3O0ihMxKL+Y
	 v5Dxrf4HYGdEOzs8CAotQKyrW0d5IN7fjS626n5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbfJUQSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:18:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729488AbfJUQSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:18:40 -0400
Received: from localhost.localdomain (unknown [194.230.155.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE866214B2;
        Mon, 21 Oct 2019 16:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571674719;
        bh=3vY2pIjyYjAUhRAyST8D3WoCMrO68dPHRpC8oVEgtkA=;
        h=From:To:Cc:Subject:Date:From;
        b=VZqWrp4seF30I+DlEuqKw1SKhfjvnQFQ6zifiz9FS3APtR1PZYLQD45l75W6Gm2I+
         p8sZOFAgS9Z2JnOK9OZsEeMyWN7ikPcN2F9ebivqgXWmDHDgZRz+SXTPYXRpB3DQPu
         PnZsUzEtHTvocGkMY6ILwkqXJA+Ajw+cNwpMOgEY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v4] ARM: dts: keystone: Rename "msmram" node to "sram"
Date:   Mon, 21 Oct 2019 18:18:23 +0200
Message-Id: <20191021161823.21624-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device node name should reflect generic class of a device so rename
the "msmram" node and its children to "sram".  This will be also in sync
with upcoming DT schema.  No functional change.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v3:
1. Rename also children.

v3 is here:
https://lore.kernel.org/linux-arm-kernel/20191002164316.14905-7-krzk@kernel.org/
---
 arch/arm/boot/dts/keystone-k2e.dtsi  | 4 ++--
 arch/arm/boot/dts/keystone-k2g.dtsi  | 4 ++--
 arch/arm/boot/dts/keystone-k2hk.dtsi | 4 ++--
 arch/arm/boot/dts/keystone-k2l.dtsi  | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/keystone-k2e.dtsi b/arch/arm/boot/dts/keystone-k2e.dtsi
index 085e7326ea8e..2d94faf31fab 100644
--- a/arch/arm/boot/dts/keystone-k2e.dtsi
+++ b/arch/arm/boot/dts/keystone-k2e.dtsi
@@ -86,14 +86,14 @@
 			};
 		};
 
-		msm_ram: msmram@c000000 {
+		msm_ram: sram@c000000 {
 			compatible = "mmio-sram";
 			reg = <0x0c000000 0x200000>;
 			ranges = <0x0 0x0c000000 0x200000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-			sram-bm@1f0000 {
+			bm-sram@1f0000 {
 				reg = <0x001f0000 0x8000>;
 			};
 		};
diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index 1c833105d6c5..33acf7ddb1c8 100644
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -95,14 +95,14 @@
 		ranges = <0x0 0x0 0x0 0xc0000000>;
 		dma-ranges = <0x80000000 0x8 0x00000000 0x80000000>;
 
-		msm_ram: msmram@c000000 {
+		msm_ram: sram@c000000 {
 			compatible = "mmio-sram";
 			reg = <0x0c000000 0x100000>;
 			ranges = <0x0 0x0c000000 0x100000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-			sram-bm@f7000 {
+			bm-sram@f7000 {
 				reg = <0x000f7000 0x8000>;
 			};
 		};
diff --git a/arch/arm/boot/dts/keystone-k2hk.dtsi b/arch/arm/boot/dts/keystone-k2hk.dtsi
index ca0f198ba627..8a9447703310 100644
--- a/arch/arm/boot/dts/keystone-k2hk.dtsi
+++ b/arch/arm/boot/dts/keystone-k2hk.dtsi
@@ -57,14 +57,14 @@
 &soc0 {
 		/include/ "keystone-k2hk-clocks.dtsi"
 
-		msm_ram: msmram@c000000 {
+		msm_ram: sram@c000000 {
 			compatible = "mmio-sram";
 			reg = <0x0c000000 0x600000>;
 			ranges = <0x0 0x0c000000 0x600000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-			sram-bm@5f0000 {
+			bm-sram@5f0000 {
 				reg = <0x5f0000 0x8000>;
 			};
 		};
diff --git a/arch/arm/boot/dts/keystone-k2l.dtsi b/arch/arm/boot/dts/keystone-k2l.dtsi
index 374c80124c4e..dff5fea72b2f 100644
--- a/arch/arm/boot/dts/keystone-k2l.dtsi
+++ b/arch/arm/boot/dts/keystone-k2l.dtsi
@@ -255,14 +255,14 @@
 			};
 		};
 
-		msm_ram: msmram@c000000 {
+		msm_ram: sram@c000000 {
 			compatible = "mmio-sram";
 			reg = <0x0c000000 0x200000>;
 			ranges = <0x0 0x0c000000 0x200000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-			sram-bm@1f8000 {
+			bm-sram@1f8000 {
 				reg = <0x001f8000 0x8000>;
 			};
 		};
-- 
2.17.1

