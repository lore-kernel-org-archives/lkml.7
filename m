Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FCDCA9EB0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 18:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B4A20B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 18:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571680856;
	bh=XM+FygnugCQee4JxAth0vGJ2t52VZLAJMmBqZuGFwU4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=xhhH1p7GwWz+3Wyy52q2xX7GBi9y5FPNvL2isp2WEXdd1Uzu9tLZbd+QJE+bfsJ6l
	 R9+4zLqcdSmu8HW3Rw/mc5fisyqYBQA9q7ZTKoK8/ZR0oiXR4S1dzoaCgpiaKpWUxt
	 FNVaoqSL0IvISmmQOQRcdEPSurBmlNd+eTbJuCP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbfJUSAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 14:00:55 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38986 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728196AbfJUSAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 14:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=uq0cbL+MVqRsyuw0sPQS5GA0v05y+bqGq3kL9K0P2h8=; b=PGEycT3N3lTQ
        NSSgmXX+NrJZnmMPp0DDgf3TJ5vpiZ60E/A5h7/jh7v9/BlffeXg/8qSJZDhUVO94BoiVkdBKZIA6
        oHFGZxOgPxsjFb2uNM5ycbXGiYwo6ZffM4e2i8UHOVbaL6uUVM1svJMDhy6F5RQfWvgyT7vK5Cl+k
        9gRQU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iMbz5-0004bf-DO; Mon, 21 Oct 2019 18:00:47 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 8052B2743293; Mon, 21 Oct 2019 19:00:46 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Maciej Falkowski <m.falkowski@samsung.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Applied "ASoC: samsung: i2s: Document clocks macros" to the asoc tree
In-Reply-To: <20190926110219.6144-1-m.szyprowski@samsung.com>
X-Patchwork-Hint: ignore
Message-Id: <20191021180046.8052B2743293@ypsilon.sirena.org.uk>
Date:   Mon, 21 Oct 2019 19:00:46 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: samsung: i2s: Document clocks macros

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5

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

From 6cc23ed2ceab880e96ad287d9c85b53659050510 Mon Sep 17 00:00:00 2001
From: Maciej Falkowski <m.falkowski@samsung.com>
Date: Thu, 26 Sep 2019 13:02:19 +0200
Subject: [PATCH] ASoC: samsung: i2s: Document clocks macros

Document clocks macros with their description
from 'Documentation/devicetree/bindings/sound/samsung-i2s.txt'

Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Link: https://lore.kernel.org/r/20190926110219.6144-1-m.szyprowski@samsung.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/dt-bindings/sound/samsung-i2s.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/dt-bindings/sound/samsung-i2s.h b/include/dt-bindings/sound/samsung-i2s.h
index 77545f14c379..250de0d6c734 100644
--- a/include/dt-bindings/sound/samsung-i2s.h
+++ b/include/dt-bindings/sound/samsung-i2s.h
@@ -2,8 +2,14 @@
 #ifndef _DT_BINDINGS_SAMSUNG_I2S_H
 #define _DT_BINDINGS_SAMSUNG_I2S_H
 
-#define CLK_I2S_CDCLK		0
-#define CLK_I2S_RCLK_SRC	1
-#define CLK_I2S_RCLK_PSR	2
+#define CLK_I2S_CDCLK		0 /* the CDCLK (CODECLKO) gate clock */
+
+#define CLK_I2S_RCLK_SRC	1 /* the RCLKSRC mux clock (corresponding to
+				   * RCLKSRC bit in IISMOD register)
+				   */
+
+#define CLK_I2S_RCLK_PSR	2 /* the RCLK prescaler divider clock
+				   * (corresponding to the IISPSR register)
+				   */
 
 #endif /* _DT_BINDINGS_SAMSUNG_I2S_H */
-- 
2.20.1

