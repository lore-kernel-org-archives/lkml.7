Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC56FFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C250521D7F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239970;
	bh=3Yhs3WqnnkrvAAFYoJ4Y+AVbVYIMGkIaxwp46Lt48+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PJwa3MqzFYp6oKWYAyxZJtMKQMbfRSBeVbkOusU9WM39W1FleNrgZJ2RVGMneuZOC
	 v8e1EnikyHQPkpSRSiGtH4OyrOGKeB+wIwMW3k9ypFvYEh0IrbGf+Cn8amV5aXftfd
	 TiCmsr0xH6txeuH3Z38+2Sg8wB4v43QbxDsNkezo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391218AbfKHTGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:06:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:36386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732959AbfKHTGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:06:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FC77222C4;
        Fri,  8 Nov 2019 19:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239964;
        bh=3Yhs3WqnnkrvAAFYoJ4Y+AVbVYIMGkIaxwp46Lt48+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jxVDBHRIaO6YrYnOLhqlF10Fn8oz+4/QUdQHU34DD/lXXOSEdnPwWhVxQ6dDquQsO
         SJTL/oNB/KngGOVRbqGI1clZKOz5ZHtgzHuDUKxJC8idxy/iRtbpDKeNo0RKkUE6y9
         CN3yFet96UBzjR0a0wI/959N0f7WdJZ2g4ew5PDA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ran Wang <ran.wang_1@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 043/140] arm64: dts: lx2160a: Correct CPU core idle state name
Date:   Fri,  8 Nov 2019 19:49:31 +0100
Message-Id: <20191108174908.170989654@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174900.189064908@linuxfoundation.org>
References: <20191108174900.189064908@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ran Wang <ran.wang_1@nxp.com>

[ Upstream commit 07159f67c77134dfdfdbdf3d8f657f5890de5b7f ]

lx2160a support PW15 but not PW20, correct name to avoid confusing.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
Fixes: 00c5ce8ac023 ("arm64: dts: lx2160a: add cpu idle support")
Acked-by: Li Yang <leoyang.li@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 36 +++++++++----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index e6fdba39453c3..228ab83037d0e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -33,7 +33,7 @@
 			i-cache-line-size = <64>;
 			i-cache-sets = <192>;
 			next-level-cache = <&cluster0_l2>;
-			cpu-idle-states = <&cpu_pw20>;
+			cpu-idle-states = <&cpu_pw15>;
 		};
 
 		cpu@1 {
@@ -49,7 +49,7 @@
 			i-cache-line-size = <64>;
 			i-cache-sets = <192>;
 			next-level-cache = <&cluster0_l2>;
-			cpu-idle-states = <&cpu_pw20>;
+			cpu-idle-states = <&cpu_pw15>;
 		};
 
 		cpu@100 {
@@ -65,7 +65,7 @@
 			i-cache-line-size = <64>;
 			i-cache-sets = <192>;
 			next-level-cache = <&cluster1_l2>;
-			cpu-idle-states = <&cpu_pw20>;
+			cpu-idle-states = <&cpu_pw15>;
 		};
 
 		cpu@101 {
@@ -81,7 +81,7 @@
 			i-cache-line-size = <64>;
 			i-cache-sets = <192>;
 			next-level-cache = <&cluster1_l2>;
-			cpu-idle-states = <&cpu_pw20>;
+			cpu-idle-states = <&cpu_pw15>;
 		};
 
 		cpu@200 {
@@ -97,7 +97,7 @@
 			i-cache-line-size = <64>;
 			i-cache-sets = <192>;
 			next-level-cache = <&cluster2_l2>;
-			cpu-idle-states = <&cpu_pw20>;
+			cpu-idle-states = <&cpu_pw15>;
 		};
 
 		cpu@201 {
@@ -113,7 +113,7 @@
 			i-cache-line-size = <64>;
 			i-cache-sets = <192>;
 			next-level-cache = <&cluster2_l2>;
-			cpu-idle-states = <&cpu_pw20>;
+			cpu-idle-states = <&cpu_pw15>;
 		};
 
 		cpu@300 {
@@ -129,7 +129,7 @@
 			i-cache-line-size = <64>;
 			i-cache-sets = <192>;
 			next-level-cache = <&cluster3_l2>;
-			cpu-idle-states = <&cpu_pw20>;
+			cpu-idle-states = <&cpu_pw15>;
 		};
 
 		cpu@301 {
@@ -145,7 +145,7 @@
 			i-cache-line-size = <64>;
 			i-cache-sets = <192>;
 			next-level-cache = <&cluster3_l2>;
-			cpu-idle-states = <&cpu_pw20>;
+			cpu-idle-states = <&cpu_pw15>;
 		};
 
 		cpu@400 {
@@ -161,7 +161,7 @@
 			i-cache-line-size = <64>;
 			i-cache-sets = <192>;
 			next-level-cache = <&cluster4_l2>;
-			cpu-idle-states = <&cpu_pw20>;
+			cpu-idle-states = <&cpu_pw15>;
 		};
 
 		cpu@401 {
@@ -177,7 +177,7 @@
 			i-cache-line-size = <64>;
 			i-cache-sets = <192>;
 			next-level-cache = <&cluster4_l2>;
-			cpu-idle-states = <&cpu_pw20>;
+			cpu-idle-states = <&cpu_pw15>;
 		};
 
 		cpu@500 {
@@ -193,7 +193,7 @@
 			i-cache-line-size = <64>;
 			i-cache-sets = <192>;
 			next-level-cache = <&cluster5_l2>;
-			cpu-idle-states = <&cpu_pw20>;
+			cpu-idle-states = <&cpu_pw15>;
 		};
 
 		cpu@501 {
@@ -209,7 +209,7 @@
 			i-cache-line-size = <64>;
 			i-cache-sets = <192>;
 			next-level-cache = <&cluster5_l2>;
-			cpu-idle-states = <&cpu_pw20>;
+			cpu-idle-states = <&cpu_pw15>;
 		};
 
 		cpu@600 {
@@ -225,7 +225,7 @@
 			i-cache-line-size = <64>;
 			i-cache-sets = <192>;
 			next-level-cache = <&cluster6_l2>;
-			cpu-idle-states = <&cpu_pw20>;
+			cpu-idle-states = <&cpu_pw15>;
 		};
 
 		cpu@601 {
@@ -241,7 +241,7 @@
 			i-cache-line-size = <64>;
 			i-cache-sets = <192>;
 			next-level-cache = <&cluster6_l2>;
-			cpu-idle-states = <&cpu_pw20>;
+			cpu-idle-states = <&cpu_pw15>;
 		};
 
 		cpu@700 {
@@ -257,7 +257,7 @@
 			i-cache-line-size = <64>;
 			i-cache-sets = <192>;
 			next-level-cache = <&cluster7_l2>;
-			cpu-idle-states = <&cpu_pw20>;
+			cpu-idle-states = <&cpu_pw15>;
 		};
 
 		cpu@701 {
@@ -273,7 +273,7 @@
 			i-cache-line-size = <64>;
 			i-cache-sets = <192>;
 			next-level-cache = <&cluster7_l2>;
-			cpu-idle-states = <&cpu_pw20>;
+			cpu-idle-states = <&cpu_pw15>;
 		};
 
 		cluster0_l2: l2-cache0 {
@@ -340,9 +340,9 @@
 			cache-level = <2>;
 		};
 
-		cpu_pw20: cpu-pw20 {
+		cpu_pw15: cpu-pw15 {
 			compatible = "arm,idle-state";
-			idle-state-name = "PW20";
+			idle-state-name = "PW15";
 			arm,psci-suspend-param = <0x0>;
 			entry-latency-us = <2000>;
 			exit-latency-us = <2000>;
-- 
2.20.1



