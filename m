Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49F5C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D372175B
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962129;
	bh=t+6ETsTZ0B9We1lnFh7jxVq6+Unsc8KkkIxTkdd/8lk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=FrlRxV9soR5cnKNAgMo2Wec7Rt8ZY35PpJkta8kbOMH5nm+vKTBXUOj5Ss/Sr62q3
	 GTMKaM4OZK2jzdOzAAExx5eFSTaqyKG+7GgSA8WolR4PibnxDIwYCMSpO3gyhh/ruG
	 vklzlUTZwjgRm/sW6nH+HVHbrK0tIJb4zV0xP2Lg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbfDVTmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:42:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbfDVTmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:42:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DA5A214AE;
        Mon, 22 Apr 2019 19:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962127;
        bh=t+6ETsTZ0B9We1lnFh7jxVq6+Unsc8KkkIxTkdd/8lk=;
        h=From:To:Cc:Subject:Date:From;
        b=PSgkm9z+XEnlAHD0wZEYARy2wfK7GlD8QR6prYWoOckX6aE7epORP+RoL3DI67xLG
         vZeIjtv7eBq7VWMfeEMksB/U/AoUMlbfEFh45I2tyhdDYQdshcEUptEUL24+n8rTyQ
         99P3pY0qWZDXUhvAI+J+t6+WgQDZaqh7sSOe8I/0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takeshi Kihara <takeshi.kihara.df@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 01/98] arm64: dts: renesas: r8a77990: Fix SCIF5 DMA channels
Date:   Mon, 22 Apr 2019 15:40:28 -0400
Message-Id: <20190422194205.10404-1-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

[ Upstream commit e20119f7eaaaf6aad5b44f35155ce500429e17f6 ]

According to the R-Car Gen3 Hardware Manual Errata for Rev 1.50 of Feb
12, 2019, the DMA channels for SCIF5 are corrected from 16..47 to 0..15
on R-Car E3.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Fixes: a5ebe5e49a862e21 ("arm64: dts: renesas: r8a77990: Add SCIF-{0,1,3,4,5} device nodes")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 arch/arm64/boot/dts/renesas/r8a77990.dtsi | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77990.dtsi b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
index b2f606e286ce..327d12097643 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for the R-Car E3 (R8A77990) SoC
  *
- * Copyright (C) 2018 Renesas Electronics Corp.
+ * Copyright (C) 2018-2019 Renesas Electronics Corp.
  */
 
 #include <dt-bindings/clock/r8a77990-cpg-mssr.h>
@@ -1040,9 +1040,8 @@
 				 <&cpg CPG_CORE R8A77990_CLK_S3D1C>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
-			dmas = <&dmac1 0x5b>, <&dmac1 0x5a>,
-			       <&dmac2 0x5b>, <&dmac2 0x5a>;
-			dma-names = "tx", "rx", "tx", "rx";
+			dmas = <&dmac0 0x5b>, <&dmac0 0x5a>;
+			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
 			resets = <&cpg 202>;
 			status = "disabled";
-- 
2.19.1

