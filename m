Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11D8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EADE218D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366683;
	bh=9m+nmkz3CRwtqaO95PT4gDIoFWZNdlIn0LthJLPgpl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2bHP9X2Qd1L64VvEb6d0DcGwyLVyemMN6uK/Wg4Z9Xykp+YAqLpNBAL07iD90+pGD
	 9EW4Dp0RbR1eMYhmvEvakv4mhr98tRVF+r0ZstvshHLXPkj/mvl+Bwp8RBfG9J5m8W
	 9mqWExo8xbVFTQgiIZqpb7+Q+Y9hof5mwj0dpk6A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387966AbfB1PLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:11:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:44338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387935AbfB1PLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:11:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72812218EA;
        Thu, 28 Feb 2019 15:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366675;
        bh=9m+nmkz3CRwtqaO95PT4gDIoFWZNdlIn0LthJLPgpl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vCURjuVTwf/XV7k5eIj7tyOu2uumeyFwEzb2r2FSRYz6/S/4B2XZkEQaZUnugvIzc
         +ScrFbEzNj3QRALBpzVVqcFkS2jtqTxr42WYanFsRLneds1NJnJSBsJgA7w9x+ausM
         aAh+xjwMf+YKm26gOtsizn4azqSt6HQ1+lnEO7yY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 08/64] arm64: dts: renesas: r8a7796: Enable DMA for SCIF2
Date:   Thu, 28 Feb 2019 10:10:09 -0500
Message-Id: <20190228151105.11277-8-sashal@kernel.org>
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

[ Upstream commit 97f26702bc95b5c3a72671d5c6675e4d6ee0a2f4 ]

SCIF2 on R-Car M3-W can be used with both DMAC1 and DMAC2.

Fixes: dbcae5ea4bd27409 ("arm64: dts: r8a7796: Enable SCIF DMA")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index cbd35c00b4af6..33cb0281c39c8 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -1161,6 +1161,9 @@
 				 <&cpg CPG_CORE R8A7796_CLK_S3D1>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac1 0x13>, <&dmac1 0x12>,
+			       <&dmac2 0x13>, <&dmac2 0x12>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
 			resets = <&cpg 310>;
 			status = "disabled";
-- 
2.19.1

