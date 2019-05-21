Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D77C072B5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 20:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AFD12183F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 20:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558470791;
	bh=TIcKgynxpLjOkAkLhXuF0I06RPYW9kcwrOGQ3n04aEo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=AwhSJFnI8iCHDqCwGPS7SYU6aHzfBBmONSTkwKIF6meGvKCOb64vGGMkM21FHRgf/
	 dxHGGXmcF8BA85uPze+GymkTribFGkv76Mrv4roGKMuBRwAcZXew0Bi6DAAdYYlQJK
	 HM5gIMWWTp5zwna0PHsfcoVlAsWKETjS+oZoxCig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfEUUdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 16:33:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38620 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727911AbfEUUdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 16:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=7t01hKARnYEqKrxLkzCGU8GKhNFY7FCn6M/pLrWr+JI=; b=MhGxENPA2/if
        pBdP3Qc8EQZV6g4KoECATFBSykE1AgjMgSh4fPIITPVNQbMPKnIVGL1bLs0wLcS6srbfE/Qq0ADzj
        RdpdYVxL+CThV0J9esLtQGv0c6KYDqdNScsj6yKXxxFXXB/IOaVTdyLemAeLR8V/uR5Qke2G7wkmF
        8xSLE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hTBRX-00021z-Nl; Tue, 21 May 2019 20:33:03 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1463A1126D17; Tue, 21 May 2019 21:33:00 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     broonie@kernel.org, devicetree@vger.kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, mark.rutland@arm.com,
        patches@opensource.cirrus.com, robh+dt@kernel.org
Subject: Applied "regulator: arizona: Update device tree binding to support Madera CODECs" to the regulator tree
In-Reply-To: <20190521100439.27383-1-ckeepax@opensource.cirrus.com>
X-Patchwork-Hint: ignore
Message-Id: <20190521203300.1463A1126D17@debutante.sirena.org.uk>
Date:   Tue, 21 May 2019 21:33:00 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: arizona: Update device tree binding to support Madera CODECs

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.3

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

From 46f4050a6587ea3e59e6f47f06513c00689b9d40 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Tue, 21 May 2019 11:04:37 +0100
Subject: [PATCH] regulator: arizona: Update device tree binding to support
 Madera CODECs

The Arizona regulator drivers are now also used by the Cirrus Logic
Madera audio CODECs, update the binding document to link to the primary
binding document for these as well as the existing Arizona document.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/regulator/arizona-regulator.txt        | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/arizona-regulator.txt b/Documentation/devicetree/bindings/regulator/arizona-regulator.txt
index 443564d7784f..69bf41949b01 100644
--- a/Documentation/devicetree/bindings/regulator/arizona-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/arizona-regulator.txt
@@ -5,7 +5,8 @@ of analogue I/O.
 
 This document lists regulator specific bindings, see the primary binding
 document:
-  ../mfd/arizona.txt
+  For Wolfson Microelectronic Arizona codecs: ../mfd/arizona.txt
+  For Cirrus Logic Madera codecs: ../mfd/madera.txt
 
 Optional properties:
   - wlf,ldoena : GPIO specifier for the GPIO controlling LDOENA
-- 
2.20.1

