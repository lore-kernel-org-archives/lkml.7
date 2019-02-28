Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4DDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B5CA218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366544;
	bh=5pWmnEXUIZhcIa1/J7ri5v85TwVVoOiZnUAyJD2I0LE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QxP9KSPaj00q6ML7xG6qlHBRXBSScJQRb2tw4wukXzKgZXBImo5FACLMH9/USaQzU
	 S3bB+UwhZuQn7L3enruLZkXIW7rpR/5iTP53488g2VbFC6fpBICoE9TqywqMLuyDnj
	 uTsZMvJRUOSCRIg0tzJRL1Qo2R++f7z/EAQauzM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387419AbfB1PJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:09:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:41264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733099AbfB1PIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:08:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54A63218B0;
        Thu, 28 Feb 2019 15:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366532;
        bh=5pWmnEXUIZhcIa1/J7ri5v85TwVVoOiZnUAyJD2I0LE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z/exKk5yCTd7B63+z7B2Azu0hDQLVx7NFCJAvpUHeJ8CedEDv3Y7kc+FOjf7QgREN
         wxVdl7AmDDrUI9QobsNd9GaBNnJUOkg0b5VebvYrtbaPLJs/vucbFoKKzCSE//gtvb
         1bA9Ejv1/2sdPNDHnT+Ed/drR72PIINAm7CDfYhg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Paul Burton <paul.burton@mips.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 24/81] MIPS: DTS: jz4740: Correct interrupt number of DMA core
Date:   Thu, 28 Feb 2019 10:07:16 -0500
Message-Id: <20190228150813.10256-24-sashal@kernel.org>
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

From: Paul Cercueil <paul@crapouillou.net>

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
index 6fb16fd240353..2beb78a62b7dc 100644
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

