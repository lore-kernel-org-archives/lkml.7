Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E3CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588FB20C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367637;
	bh=p1nk1bptIWpR0xUwnKFtinx6hZEgsQYkg0qsrM1SrqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D8MXxuYiHFVETeQv+iymoz7EOmz+vYSuaD/ohDGiWzc7ujVrq1AJM7JRBYlno0Bbh
	 NzGCE06UwmRByCaO6SkPFlo+0+PtQVp+Zk3TtSulI8hgQBw4zmVM9rPpMT3Ab806Mp
	 yb0KFVzR9dloKgn7qXJnRGZ6Z/az0EOMRSy54kkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389080AbfB1P1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:27:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:44360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387472AbfB1PLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:11:17 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 919AA218FC;
        Thu, 28 Feb 2019 15:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366676;
        bh=p1nk1bptIWpR0xUwnKFtinx6hZEgsQYkg0qsrM1SrqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LBmOKXaO6d33A4a9xJ/BDGSl5AiMPsmR+EIFEr+7jCyhpMg/5vVEMLFuSYIEr+Hs6
         cCsTazKxqYxE6QZhdeq581kkxlQ6UKTl+ygYmIwRmGWlafiz3PFn0y+rEF+v4KOPxM
         EOqksuQ2zBohFrRVccShZVv0l9fe1N4rMzEcSBbY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 09/64] arm64: dts: renesas: r8a77965: Enable DMA for SCIF2
Date:   Thu, 28 Feb 2019 10:10:10 -0500
Message-Id: <20190228151105.11277-9-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151105.11277-1-sashal@kernel.org>
References: <20190228151105.11277-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 05c8478abd485507c25aa565afab604af8d8fe46 ]

SCIF2 on R-Car M3-N can be used with both DMAC1 and DMAC2.

Fixes: 0ea5b2fd38db56aa ("arm64: dts: renesas: r8a77965: Add SCIF device nodes")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index 0cd44461a0bd2..f60f08ba1a6f9 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -951,6 +951,9 @@
 				 <&cpg CPG_CORE R8A77965_CLK_S3D1>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac1 0x13>, <&dmac1 0x12>,
+			       <&dmac2 0x13>, <&dmac2 0x12>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 310>;
 			status = "disabled";
-- 
2.19.1

