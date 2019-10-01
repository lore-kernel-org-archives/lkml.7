Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CA6ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E208320B7C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569952621;
	bh=4xVtMspTTwuG8tdPkCWzc+croVH5UbxupUzCcUeuMag=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=vLzNsvyjefySBakAaUsaz15PRxycJX/xLRlIIEAkpmb19utBO3BFQ3xjlMxHWK5wC
	 1O3cDmWNd13PcvHeVIt2l7Kvhp26yKJdPy2/UJnC47oAp3XX6mtZSww5errNaZi+vq
	 X/GaHAqrUplaiZvH9MIQGWJygaaqAH9LOImmwcxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731269AbfJAR5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:57:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52000 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfJAR47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=A9NXcxONWzpkY7EVknteVVyY6INRrwaQt7ZlwSZ2Peg=; b=vfz1qphHJ2oj
        Sd6DqyVHWYYFEaWQMt5RtcdNX37MT1URP3fDfqY4Pz4sKyO8XXM9uOmMF9MjkKjSoYJf2x8Flgttx
        YxyVrLE3MTG8UcdVLVpgqHkD/WPkrEpllPE/6Nna9O8NQSlTbth0UQKAcdPkC5Ps/N7qVY5ZjUzUk
        hrcvw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iFMOO-0005uj-CN; Tue, 01 Oct 2019 17:56:56 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id CA01E2742A31; Tue,  1 Oct 2019 18:56:55 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        patches@opensource.cirrus.com
Subject: Applied "regulator: lochnagar: Add on_off_delay for VDDCORE" to the regulator tree
In-Reply-To: <20191001132017.1785-1-ckeepax@opensource.cirrus.com>
X-Patchwork-Hint: ignore
Message-Id: <20191001175655.CA01E2742A31@ypsilon.sirena.org.uk>
Date:   Tue,  1 Oct 2019 18:56:55 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: lochnagar: Add on_off_delay for VDDCORE

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.4

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

From f75841aa3b4bf02fcc7941af2d3e00ff74a93bdb Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Tue, 1 Oct 2019 14:20:17 +0100
Subject: [PATCH] regulator: lochnagar: Add on_off_delay for VDDCORE

The VDDCORE regulator takes a good length of time to discharge down, so
add an on_off_delay to ensure DCVDD is removed before it is powered on
again.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20191001132017.1785-1-ckeepax@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/lochnagar-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/lochnagar-regulator.c b/drivers/regulator/lochnagar-regulator.c
index ff97cc50f2eb..9b05e03ba830 100644
--- a/drivers/regulator/lochnagar-regulator.c
+++ b/drivers/regulator/lochnagar-regulator.c
@@ -210,6 +210,7 @@ static const struct regulator_desc lochnagar_regulators[] = {
 
 		.enable_time = 3000,
 		.ramp_delay = 1000,
+		.off_on_delay = 15000,
 
 		.owner = THIS_MODULE,
 	},
-- 
2.20.1

