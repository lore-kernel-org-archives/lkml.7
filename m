Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35BCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB312173C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552410798;
	bh=RxoVr3NNArYjefw/eIyUMv4Q2mJEAXzWNOidQLNllAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eFyBmqfo03HROEqn2Wau1CyJREugwwi1xzXQmWk4Dx3Tnq1A81KFJ5KA+FopQgjhD
	 07uWdWk6Pgk8adICDAWaIHTpKcSTewyj1spAbmoUzxfM56xeLpEO4LkNdt9470ERB6
	 5iH8cHK3rIDVn5GuxpSVYEJSM8cOg1R0YouiUl1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfCLRNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:13:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727627AbfCLRMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:12:45 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 120062177E;
        Tue, 12 Mar 2019 17:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410765;
        bh=RxoVr3NNArYjefw/eIyUMv4Q2mJEAXzWNOidQLNllAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bZwQah+Mudk2LYgRjzCX3PjBmGH/iduJUTwgOhC9sCQKzVL+/tiyk4nQva8Y4iVLS
         9Ja9edxmPQat8qNBPh6ZdFWJ/jCXYR/hn9hwIL+l92p6r/UpWu6s0DdfC8bA3JGdfS
         4jScogamXw6q5fJXr9LqpSm6C2Ni2dcAAcBBqSyQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 081/171] arm64: dts: renesas: r8a77965: Enable DMA for SCIF2
Date:   Tue, 12 Mar 2019 10:07:41 -0700
Message-Id: <20190312170355.025888367@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 83946ca2eba5..d59dada13722 100644
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



