Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3587BC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127492077B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570211572;
	bh=Ad2nS83ksoWY94exUubRGqGW552s6iVe9HD5zwJ3nkA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=pja/DTPtTpHHmd8JPaviqInX024zUpnLK6yuVngNZSHhOis9qJAFPN/HOamtaQwn9
	 8bgEj4Sf+8ckS/iwcdMZ8L2zwLPIJCMlyScuCMYHOSIPFYcZ6Lqudec7Q5+E8rOSY8
	 DUhrGEiGpdWNbzyhcshpbXLTkUhhfeoZOpOFXRU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388905AbfJDRwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 13:52:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51038 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388814AbfJDRwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 13:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=EV6mJV9fbq+0/IGUxZm9F6zPrU/8DDn5KRx+8Yb0f8c=; b=A5o4qkr7WfjT
        HSjlWPPegxn56c5LCBWgEfCS9G5JWLdse+J5hdcb5ld9U9dE4Q35edLC45X8HZvcrGisGpm0ucBJz
        J1clEYjbBE8EPPHV1bCVUQcSnK4u8El2Sk2J5k1ueIySnr2HIjbXVsnSOERi1UCjMpydm3jGbMxZg
        gBVIQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iGRky-0003wa-0S; Fri, 04 Oct 2019 17:52:44 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 843C82741EF2; Fri,  4 Oct 2019 18:52:43 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     ckeepax@opensource.cirrus.com, devicetree@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Marco Felsch <m.felsch@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, zhang.chunyan@linaro.org
Subject: Applied "regulator: Document "regulator-boot-on" binding more thoroughly" to the regulator tree
In-Reply-To: <20191001124531.v2.1.Ice34ad5970a375c3c03cb15c3859b3ee501561bf@changeid>
X-Patchwork-Hint: ignore
Message-Id: <20191004175243.843C82741EF2@ypsilon.sirena.org.uk>
Date:   Fri,  4 Oct 2019 18:52:43 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: Document "regulator-boot-on" binding more thoroughly

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.5

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

From 87fd0db6d7df1cf4cc6e9b09e2155d1f324bf836 Mon Sep 17 00:00:00 2001
From: Douglas Anderson <dianders@chromium.org>
Date: Tue, 1 Oct 2019 12:45:54 -0700
Subject: [PATCH] regulator: Document "regulator-boot-on" binding more
 thoroughly

The description of "regulator-boot-on" was a little unclear, at least
to me.  Did this property mean that we should turn the regulator on at
boot?  Or perhaps it was intended only to be used for regulators where
we couldn't read the state at bootup to indicate what state we should
assume?  The answer, it turns out, is both [1].

Let's document this.

[1] https://lore.kernel.org/r/20190923181431.GU2036@sirena.org.uk

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/r/20191001124531.v2.1.Ice34ad5970a375c3c03cb15c3859b3ee501561bf@changeid
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/regulator/regulator.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/regulator.yaml b/Documentation/devicetree/bindings/regulator/regulator.yaml
index 02c3043ce419..92ff2e8ad572 100644
--- a/Documentation/devicetree/bindings/regulator/regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/regulator.yaml
@@ -38,7 +38,12 @@ properties:
     type: boolean
 
   regulator-boot-on:
-    description: bootloader/firmware enabled regulator
+    description: bootloader/firmware enabled regulator.
+      It's expected that this regulator was left on by the bootloader.
+      If the bootloader didn't leave it on then OS should turn it on
+      at boot but shouldn't prevent it from being turned off later.
+      This property is intended to only be used for regulators where
+      software cannot read the state of the regulator.
     type: boolean
 
   regulator-allow-bypass:
-- 
2.20.1

