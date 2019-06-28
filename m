Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E548C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D1E20645
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561741004;
	bh=5pp1nH95z/dD1QQ+dMol6mNEbJExxFrM7gnMlCEvDIE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=zmVUyovu+1ir8QUmln4Ctwa/zrZO1ozNVCrUFrkPB2hUNHMESh3JVGQYOt9FneYUH
	 UD9VQtarav1o2LwHx64TMKJB+uLVsLN5YcxBf6L7rps1ZUxdGG1l3ir0DpwNCePcPK
	 aioCE1/9vfJGpjBrOdZk0PIdgDl+shnVtU/n7fr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfF1Q4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 12:56:43 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42616 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbfF1Q4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 12:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=iDKc40FydAHvdXLFNwmMjAx1GM+vsXmu1CM9PROUYY4=; b=sTFFxXe07FaF
        /Vb6DqwLJZ3Ir44c5J+ZPxdRp2YdrODpWMdm3ZaPBdOodXjmH+b7g2lEHhHmUejekBnxya3cNAE9L
        oYov+sWXYLdeMONNCYO1M7xn7s35IeUmIkdqnKmMyhfAh4qJ8ceEH05oYf2sA+4ldLSJIb4MW2kjb
        IGK+4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hguAs-0007D4-E1; Fri, 28 Jun 2019 16:56:34 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 0A62C440049; Fri, 28 Jun 2019 17:56:34 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Ludovic Barre <ludovic.barre@st.com>
Cc:     Alexandre Torgue <alexandre.torgue@st.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Marek Vasut <marek.vasut@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Applied "dt-bindings: spi: stm32-qspi: add dma properties" to the spi tree
In-Reply-To: <1561621439-7305-1-git-send-email-ludovic.Barre@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190628165634.0A62C440049@finisterre.sirena.org.uk>
Date:   Fri, 28 Jun 2019 17:56:34 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dt-bindings: spi: stm32-qspi: add dma properties

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From cae86eac98cd90934f94072028c362550338e084 Mon Sep 17 00:00:00 2001
From: Ludovic Barre <ludovic.barre@st.com>
Date: Thu, 27 Jun 2019 09:43:58 +0200
Subject: [PATCH] dt-bindings: spi: stm32-qspi: add dma properties

This patch adds description of dma properties (optional).

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-stm32-qspi.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-stm32-qspi.txt b/Documentation/devicetree/bindings/spi/spi-stm32-qspi.txt
index adeeb63e84b9..bfc038b9478d 100644
--- a/Documentation/devicetree/bindings/spi/spi-stm32-qspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-stm32-qspi.txt
@@ -19,8 +19,11 @@ Required properties:
 - reg: chip-Select number (QSPI controller may connect 2 flashes)
 - spi-max-frequency: max frequency of spi bus
 
-Optional property:
+Optional properties:
 - spi-rx-bus-width: see ./spi-bus.txt for the description
+- dmas: DMA specifiers for tx and rx dma. See the DMA client binding,
+Documentation/devicetree/bindings/dma/dma.txt.
+- dma-names: DMA request names should include "tx" and "rx" if present.
 
 Example:
 
-- 
2.20.1

