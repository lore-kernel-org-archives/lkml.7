Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921B4C10F14
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 17:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67923222C3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 17:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570038255;
	bh=MZYQ5QLRxsH5Lm/zp4Xs3ZdRx+OF3lS8A4Qr/ENHFmY=;
	h=From:To:Subject:Date:List-ID:From;
	b=1eBliFtsqOLb7BzAiUEUBdKUe/XbKqezZlAL87nDGVZmjB4M1Le/AbHmd0C0bfmzH
	 uUyJm+EMCM8iDHE/8Pe8cX84FUHk+/zzHgaEOS8JnBocOoIbM+uLnKgik3PMjX5yzd
	 oI+2arPysLbEzUJBn3gc4jtZtplHFk5qME98heyo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbfJBRoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 13:44:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfJBRoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 13:44:14 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA15221D81;
        Wed,  2 Oct 2019 17:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570038253;
        bh=MZYQ5QLRxsH5Lm/zp4Xs3ZdRx+OF3lS8A4Qr/ENHFmY=;
        h=From:To:Subject:Date:From;
        b=B6EQLsiyV2WDt8tyVi5J3ORL9Qfx9JZa0Vniop0dnsfyqz4zo0SEzy7rAOTqu3E+h
         vEGELl6rkQy2Vb5oNtHGMWmp213uVAdOmqAed0SL/6IUulw+ufw8irmG3PKg5dq/rw
         9ltiv4qOVeqc9733aEdZuhclwmwyTNJNUQwOf3sY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: memory-controllers: exynos5422-dmc: Correct example syntax and memory region
Date:   Wed,  2 Oct 2019 19:44:01 +0200
Message-Id: <20191002174401.17590-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After adding the interrupt properties to Exynos5422 DMC bindings
example, the mapped memory region must be big enough to access
performance counters registers.

Fix also syntax errors (semicolons) and adjust indentation.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Rebased on top of my for-next branch as exynos5422-dmc.txt bindings were
applied by me.
---
 .../bindings/memory-controllers/exynos5422-dmc.txt        | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
index e2434cac4858..02e4a1f862f1 100644
--- a/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
@@ -55,7 +55,7 @@ Example:
 
 	dmc: memory-controller@10c20000 {
 		compatible = "samsung,exynos5422-dmc";
-		reg = <0x10c20000 0x100>, <0x10c30000 0x100>,
+		reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>;
 		clocks = <&clock CLK_FOUT_SPLL>,
 			 <&clock CLK_MOUT_SCLK_SPLL>,
 			 <&clock CLK_FF_DOUT_SPLL2>,
@@ -63,7 +63,7 @@ Example:
 			 <&clock CLK_MOUT_BPLL>,
 			 <&clock CLK_SCLK_BPLL>,
 			 <&clock CLK_MOUT_MX_MSPLL_CCORE>,
-			 <&clock CLK_MOUT_MCLK_CDREX>,
+			 <&clock CLK_MOUT_MCLK_CDREX>;
 		clock-names = "fout_spll",
 			      "mout_sclk_spll",
 			      "ff_dout_spll2",
@@ -71,10 +71,10 @@ Example:
 			      "mout_bpll",
 			      "sclk_bpll",
 			      "mout_mx_mspll_ccore",
-			      "mout_mclk_cdrex",
+			      "mout_mclk_cdrex";
 		operating-points-v2 = <&dmc_opp_table>;
 		devfreq-events = <&ppmu_event3_dmc0_0>,	<&ppmu_event3_dmc0_1>,
-				<&ppmu_event3_dmc1_0>, <&ppmu_event3_dmc1_1>;
+				 <&ppmu_event3_dmc1_0>, <&ppmu_event3_dmc1_1>;
 		device-handle = <&samsung_K3QF2F20DB>;
 		vdd-supply = <&buck1_reg>;
 		samsung,syscon-clk = <&clock>;
-- 
2.17.1

