Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4027C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2FE6217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555519352;
	bh=HeVVHpUszD56VIWjN2R7vu1E2MDYY1dW+pC9mjvMeSs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=wH3H2KOQHLLvjhx5L0OzWwDsqGFUBD5K09lG1MjUW/DNuHe4Lxga8Hw/MTzKHb0Sz
	 2ZaGiCDl+StPYYc/8nzXRqVjulS5QO48bPcTYvL/zboABTiTuARJMaTxvEYeUXGCdD
	 /qcansz8piiJOKP8weJ9mTneDky67KLBXX1fLN+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732968AbfDQQmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:42:31 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37322 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732793AbfDQQm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=eVKUx54Igy3r5M5d3rxJIA1r0PzkBCgyDt//z0UAYmc=; b=aNJ6CEmEU9OR
        OFEZNLT6lgTKMty8ho7nOLKgFhMYXWawuZwDMoGJTkXD/oMnGza/B7kJdAPv3yZmBz0J4vn5XoB7W
        u+mQxsFke6hZgiygEwZXg1sX0bj39hZuwDUaYiit9MSL1yPIXpR4uTs1VxNRfFeLUo2iIT1Cj4W7c
        vj2o0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hGndY-000154-Un; Wed, 17 Apr 2019 16:42:16 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id ABE661128FCC; Wed, 17 Apr 2019 17:42:16 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Leilk Liu <leilk.liu@mediatek.com>
Cc:     devicetree@vger.kernel.org, fparent@baylibre.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Applied "dt-bindings: spi: spi-mt65xx: add support for MT8516" to the spi tree
In-Reply-To: <1555490836-13382-1-git-send-email-leilk.liu@mediatek.com>
X-Patchwork-Hint: ignore
Message-Id: <20190417164216.ABE661128FCC@debutante.sirena.org.uk>
Date:   Wed, 17 Apr 2019 17:42:16 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dt-bindings: spi: spi-mt65xx: add support for MT8516

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.2

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

From bee5c20b7323a7af027d1b4ba538137b518ad232 Mon Sep 17 00:00:00 2001
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

