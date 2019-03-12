Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA47DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02BA214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413667;
	bh=l64l3qvKN0bwfV1xBefE4uinW/cMvfop+Im88zymUro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TwqIMInnci0DnmLY/MqABUFIvBHCjHLSweEg3c/0YHhMRnXqpJ9tlukoWA2hpfh4I
	 QPUk4q6pNJl/iFF3t7Uq1MT8HO8hVK7UAPtQGUmWUaBhoR0doPVi+bBsjYARVfV6WM
	 XqUDuZcO1Nzy4A29BIoeLlrxE6bHoeCHDHbH5DcY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbfCLRNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:13:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:48364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727597AbfCLRMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:12:42 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AFEE21741;
        Tue, 12 Mar 2019 17:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410761;
        bh=l64l3qvKN0bwfV1xBefE4uinW/cMvfop+Im88zymUro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dRraTN9pwGWg1glQUa3fMcUEBQV5yQW1YGPXe7ftOQWO8TihtGclY4UZJUQ69NpcH
         Qlc5FqBmK/7bzp66np77Xcf5pKZkqJBl/SeT1YdXTNC+wWu3goUZs1IW6xAbeSLunn
         TWF44m5LorxZii3kl20JxJHzVCF0yc23DLydbQJ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Paul Burton <paul.burton@mips.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 094/171] MIPS: DTS: jz4740: Correct interrupt number of DMA core
Date:   Tue, 12 Mar 2019 10:07:54 -0700
Message-Id: <20190312170356.078923649@linuxfoundation.org>
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

[ Upstream commit 70999ec1c9d3f783a7232973cfc26971e5732758 ]

The interrupt number set in the devicetree node of the DMA driver was
wrong.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/boot/dts/ingenic/jz4740.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi b/arch/mips/boot/dts/ingenic/jz4740.dtsi
index 6fb16fd24035..2beb78a62b7d 100644
--- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
@@ -161,7 +161,7 @@
 		#dma-cells = <2>;
 
 		interrupt-parent = <&intc>;
-		interrupts = <29>;
+		interrupts = <20>;
 
 		clocks = <&cgu JZ4740_CLK_DMA>;
 
-- 
2.19.1



