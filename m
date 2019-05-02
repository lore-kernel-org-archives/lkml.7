Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7E1C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 02:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E2221734
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 02:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556763568;
	bh=7t/1N7F9FqxY1DuzoEbUQbcgJ7Y7srLpfvPEEdhnGkU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Y806RAIhuyXbsPBdzzuTCvpP+kLZqx72rgBpNUbvAR/UdP3+tdWIMM8fL0VBV0PBb
	 P9d3moE3MvDEOH63by04raPF9PFInFRI9CSIdrgO6U3nYHfBnUt2ZdQVX12NpDDSNr
	 sUynOnUNUkYVAjk3l4eunZPo3A+Bmicunao0ElN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfEBCT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 22:19:27 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57236 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfEBCTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 22:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=MS1QOIzunXomYID48sunfBjS80NfFtkOyiO7X8198WQ=; b=hmeOarK2EAp+
        OrRY0LIZ1San+orD97cOS0mkWrykbTDCwIm3C0m6V/kbRkD5LiOtnGtCW0OedzN245qlKnloW6C61
        1AJ0OHH7V1gBDDqQSTAD5EydATm55hK7tIvdpRpMAtyynHVS1oH08J4apHVJO5E/M617S+oFZwfqa
        fBSLI=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hM1JW-0005wV-W3; Thu, 02 May 2019 02:19:11 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id C4AF8441D3D; Thu,  2 May 2019 03:19:07 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Leilk Liu <leilk.liu@mediatek.com>
Cc:     devicetree@vger.kernel.org, fparent@baylibre.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Applied "dt-bindings: spi: spi-mt65xx: add support for MT8516" to the spi tree
In-Reply-To:  <1555490836-13382-1-git-send-email-leilk.liu@mediatek.com>
X-Patchwork-Hint: ignore
Message-Id: <20190502021907.C4AF8441D3D@finisterre.ee.mobilebroadband>
Date:   Thu,  2 May 2019 03:19:07 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dt-bindings: spi: spi-mt65xx: add support for MT8516

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

From bf6e839657598b77e40eb18225f8660c4778cb19 Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu@mediatek.com>
Date: Wed, 17 Apr 2019 16:47:16 +0800
Subject: [PATCH] dt-bindings: spi: spi-mt65xx: add support for MT8516

Add binding documentation of spi-mt65xx for MT8516 SOC.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-mt65xx.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
index 69c356767cf8..c0f6c8ecfa2e 100644
--- a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
+++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
@@ -10,6 +10,7 @@ Required properties:
     - mediatek,mt8135-spi: for mt8135 platforms
     - mediatek,mt8173-spi: for mt8173 platforms
     - mediatek,mt8183-spi: for mt8183 platforms
+    - "mediatek,mt8516-spi", "mediatek,mt2712-spi": for mt8516 platforms
 
 - #address-cells: should be 1.
 
-- 
2.20.1

