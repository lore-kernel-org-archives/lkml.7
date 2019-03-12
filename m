Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF77C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2EA2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413148;
	bh=rEIOtqErgSa+Q5w2Pk9UbYJ4gITvMVw7bTMRTVZ9Ikc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ExB8xCSEJDdwUFjS3OHKSZz8FptNyE2wJHrIZwHtC7O2iYSZWgMDc4Mef5xZI5s9T
	 Up4hjbmLcbnOmcyZG5978Yd2QlNecyKhVpvmAeLnR0JCFYfsZ96B+Vj32LYi4e+zaK
	 Mr0lSerssMMwq4iC6Y/BOnfdFzYV+scKzKDoup+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfCLRwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:52:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:53230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728366AbfCLRO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:14:28 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 485682171F;
        Tue, 12 Mar 2019 17:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410868;
        bh=rEIOtqErgSa+Q5w2Pk9UbYJ4gITvMVw7bTMRTVZ9Ikc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gRxD47iAF2vKIRFoxCwGGcFF9AR6IJv5QBeprSHevt3+xmKodMOA/xk7GTnA+9O8Q
         crVNnm9+uRxvC+lSUhnJtbwXm5E3thywOsZladsDXBOyKMCNSkGxlDmrzmS48nvqI9
         jq3KfjmmB6ss/2xXAxjmkLhzz7KI/2TgGV+4B5aE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 069/149] arm64: dts: renesas: r8a7796: Enable DMA for SCIF2
Date:   Tue, 12 Mar 2019 10:08:07 -0700
Message-Id: <20190312170355.460838623@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index cbd35c00b4af..33cb0281c39c 100644
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



