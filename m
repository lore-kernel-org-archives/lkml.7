Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEA0C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750FC2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556117953;
	bh=onpR2GDw+ztw8qHP0YBz40mRTYAzUE3y0pEI1q9vYVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w0YKzlTLT/H5sG/6IIf1z7u1QPk1EDLXTv6y2Wt0yWYgCAfcZ4FvTBDVOb+Ity8Zt
	 ow1Nr9FIiwnJ4v7qABTpM30cXYkOmoaZ1dS2gWhhfpXH1l1FXDAejBjbje/YBBiuWc
	 g0RlIQ3kpjucickVcMCIEgENTSmF+unFaRy8mlc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732840AbfDXO7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:59:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731604AbfDXOr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:47:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 168ED21900;
        Wed, 24 Apr 2019 14:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556117246;
        bh=onpR2GDw+ztw8qHP0YBz40mRTYAzUE3y0pEI1q9vYVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HtpkYEzpt8fiJcMRa1wZt5/CIZW2lmu1uWUf7Ohl+aTsxrYQAvfcdHkjrBZVX/3D4
         AIejoW+NlXtoDQaAHNqRCEfxKw1MvBoMnA2c6aZWlR6k4ajYanakbbSMbz1Y9SjGuc
         AuGP60/Mp4lgeII4M771frMtoh6jo3cAR5en/wzA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 07/35] ARM: dts: rockchip: Fix gpu opp node names for rk3288
Date:   Wed, 24 Apr 2019 10:46:41 -0400
Message-Id: <20190424144709.30215-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424144709.30215-1-sashal@kernel.org>
References: <20190424144709.30215-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit d040e4e8deeaa8257d6aa260e29ad69832b5d630 ]

The device tree compiler yells like this:
  Warning (unit_address_vs_reg):
  /gpu-opp-table/opp@100000000:
  node has a unit name, but no reg property

Let's match the cpu opp node names and use a dash.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/rk3288.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index f7a951afd281..5a7888581eea 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -1181,27 +1181,27 @@
 	gpu_opp_table: gpu-opp-table {
 		compatible = "operating-points-v2";
 
-		opp@100000000 {
+		opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 			opp-microvolt = <950000>;
 		};
-		opp@200000000 {
+		opp-200000000 {
 			opp-hz = /bits/ 64 <200000000>;
 			opp-microvolt = <950000>;
 		};
-		opp@300000000 {
+		opp-300000000 {
 			opp-hz = /bits/ 64 <300000000>;
 			opp-microvolt = <1000000>;
 		};
-		opp@400000000 {
+		opp-400000000 {
 			opp-hz = /bits/ 64 <400000000>;
 			opp-microvolt = <1100000>;
 		};
-		opp@500000000 {
+		opp-500000000 {
 			opp-hz = /bits/ 64 <500000000>;
 			opp-microvolt = <1200000>;
 		};
-		opp@600000000 {
+		opp-600000000 {
 			opp-hz = /bits/ 64 <600000000>;
 			opp-microvolt = <1250000>;
 		};
-- 
2.19.1

