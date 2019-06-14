Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5194AC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B4C92084D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560544430;
	bh=9OXucFdFEJyjkGzQ1m2CR757d22Ftz0mneQ19j/3lvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wbwgklLf3jThC85frfYYsXARsW/i8AmCvWiNm8UzPNO0Y66d1JyU7j/FaFL2vKtYa
	 VptSOrLBM8vLi0BOF6YD8pfh/y2RnbHPCDcPrugIhpFjGpie6KUq6+AbqbrEQSHT1j
	 6VnoweG5K+LTyz58mFdLXFjG235+7RuXqxwhcYNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfFNUaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 16:30:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727495AbfFNUaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 16:30:20 -0400
Received: from sasha-vm.mshome.net (unknown [131.107.159.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA07221851;
        Fri, 14 Jun 2019 20:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560544219;
        bh=9OXucFdFEJyjkGzQ1m2CR757d22Ftz0mneQ19j/3lvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1y3MHoiqut1o6vo+y47a8HwkhFIqfjY0/daYIrH3mP41e5mFrCgm+gv2cqNzAIxnr
         1l3NsvdLhsnwCDPDZC0BLhBQdQk7uYUyflNkabEFPMUoqIRHKG3KwEu5l/fPId6b2D
         /wSsuV74bLML4I6yrc4Hm3vcrmjyaDKpiZmvlenE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jose Abreu <joabreu@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 03/27] ARC: [plat-hsdk]: Add missing FIFO size entry in GMAC node
Date:   Fri, 14 Jun 2019 16:29:52 -0400
Message-Id: <20190614203018.27686-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614203018.27686-1-sashal@kernel.org>
References: <20190614203018.27686-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <joabreu@synopsys.com>

[ Upstream commit 4c70850aeb2e40016722cd1abd43c679666d3ca0 ]

Add the binding for RX/TX fifo size of GMAC node.

Cc: Joao Pinto <jpinto@synopsys.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Vineet Gupta <vgupta@synopsys.com>
Tested-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Acked-by: Alexey Brodkin <abrodkin@synopsys.com>
Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arc/boot/dts/hsdk.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arc/boot/dts/hsdk.dts b/arch/arc/boot/dts/hsdk.dts
index c033ae45fe42..57d81c6aa379 100644
--- a/arch/arc/boot/dts/hsdk.dts
+++ b/arch/arc/boot/dts/hsdk.dts
@@ -170,6 +170,9 @@
 			resets = <&cgu_rst HSDK_ETH_RESET>;
 			reset-names = "stmmaceth";
 
+			tx-fifo-depth = <4096>;
+			rx-fifo-depth = <4096>;
+
 			mdio {
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
2.20.1

