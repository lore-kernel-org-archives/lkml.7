Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D31CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C041218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366519;
	bh=Crh+1a83igD6xXKKizyGkRXio+hd1RulNcHhL9yqiUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pswZCE3CiNoet76XCIFRNOG33sm8mRY/x1L/JcWGTNvpCK69kXxXb8b8ibpAnINqe
	 Mv7grzDTUNRXt3A+Lms4anCPasDOEhn4UKv6gk5BUOQR3OVZ8cySu0WqnS1lQ5BO20
	 uZ74KMGX2pV+3iyrFJmxi7Rtfwk0baPJ08CPb/jE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732973AbfB1PIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:08:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:40656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732830AbfB1PIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:08:30 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7216B218CD;
        Thu, 28 Feb 2019 15:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366509;
        bh=Crh+1a83igD6xXKKizyGkRXio+hd1RulNcHhL9yqiUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x5gpEkkJcbtA4OlbJzdydb1RPU19kT3Y6vL3u3+hyWP//LeXdQ+/j+ASDdWuxrRFk
         dQn1qd6T5genaTEwLts0FYQreNB/jYKGW3wLL9knV+/vRG8NEPFP9OEqlZTUW+Aosc
         71VYNWdy79JJvZi0+qp9Wqe3eWUV8yaLuGH2IKjw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 11/81] arm64: dts: renesas: r8a77965: Enable DMA for SCIF2
Date:   Thu, 28 Feb 2019 10:07:03 -0500
Message-Id: <20190228150813.10256-11-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
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
index 83946ca2eba5d..d59dada137223 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -1028,6 +1028,9 @@
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

