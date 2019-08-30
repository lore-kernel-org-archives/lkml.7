Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89171C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 11:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED7721721
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 11:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567165532;
	bh=b8OhThB0z7Qbi1bWBbfRq+650PNiI+4yBaz685uduYg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=hnNCqwNNaCyIzgAKf3aGtviGNTKZNhVxaE4+19wVG/HA9clhcT21eMQ0XsVffRq8D
	 cwulCtaN+Aac4yahsGFGAEifylin6JAGNyzmpAV2MXYNOmt6YXb+4d1+Ic6Mi3kPtv
	 u2Gxegot+xlaVeT0ZtSnBEn86977XcGiN+DhVZaQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbfH3Lpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 07:45:31 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42628 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbfH3Lpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 07:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=qOFpB5UPbiKiX8RMxbq6Ldvho7XhUA2d06eEcpddECA=; b=HVRtwbF/1Ipo
        6RUmKgxKBk0Jfa6aE+v7H6V4U57Cjo8jVOqZ1VsVNNIHVU4yeUhfO8DARYU99du+IyDc+27M3slWO
        WTMFmILHh5KGoM0YvglmonoOkNo+Afk6QVx5rYhJWBxvRX0dnZp05/cUELahPEtmDjc2294+ye4Bb
        O4zlo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i3fLL-0006KA-7u; Fri, 30 Aug 2019 11:45:27 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id B4D282742BD3; Fri, 30 Aug 2019 12:45:26 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Applied "regulator: mt6358: Add BROKEN dependency while waiting for MFD to merge" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190830114526.B4D282742BD3@ypsilon.sirena.org.uk>
Date:   Fri, 30 Aug 2019 12:45:26 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: mt6358: Add BROKEN dependency while waiting for MFD to merge

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

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

From 50bc5731f7fc086693d78e42b7d252b97a35cda1 Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Fri, 30 Aug 2019 12:29:22 +0100
Subject: [PATCH] regulator: mt6358: Add BROKEN dependency while waiting for
 MFD to merge

The mt6358 driver was merged in error, it depends on an existing MFD
rather than a newly added one and needs updates to that driver.  Disable
the build until those are merged.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index d6d8785630b1..3ee63531f6d5 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -621,7 +621,7 @@ config REGULATOR_MT6323
 
 config REGULATOR_MT6358
 	tristate "MediaTek MT6358 PMIC"
-	depends on MFD_MT6397
+	depends on MFD_MT6397 && BROKEN
 	help
 	  Say y here to select this option to enable the power regulator of
 	  MediaTek MT6358 PMIC.
-- 
2.20.1

