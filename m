Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3951DC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 114F620673
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570531975;
	bh=IIa8hyd77hE3SxEdp6AB1JlDOJd3s6R1xvbN3GyJzk0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=LVc+LZkxvQ+LmM82HY4/ymB1hTyEjNVhvh0Zy7nENrcgBqQdui04nHYobzBUklQUD
	 Ej87vhIkEn8zvJ8a2gA5stPRJrepuiUuty1gugF1NzLlfeJHy0mHukIyWpdtzsYamY
	 I/YQ11JX0ZX1uxt+WcTX6a8nIG4iqtJw3/9Rbpto=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbfJHKwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 06:52:54 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47626 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730063AbfJHKwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ul8ns9r6ws/iQLKhPCURq0GxvyPGJtbgzbQoZ2Ssn2s=; b=Ia8FcXHsiEle
        HIBta3YV8NajED6o1oEY68nBb+u8UwY8tb1ty+bzgwkcOcmijW9+pDWjlcAULuXR1WkL1sAf5xZhq
        EA4TabaEAyo6H/vF3BcSifzF+I/LWT83axglodYFf5pfzXrSfQv7e2ZN7N7gPqBMetXD1SLYVj+iU
        4Blhs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iHn6n-00083X-4Z; Tue, 08 Oct 2019 10:52:49 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 9086E274299B; Tue,  8 Oct 2019 11:52:48 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Tony Xie <tony.xie@rock-chips.com>
Subject: Applied "regulator: rk808: Fix warning message in rk817_set_ramp_delay" to the regulator tree
In-Reply-To: <20191008010628.8513-2-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20191008105248.9086E274299B@ypsilon.sirena.org.uk>
Date:   Tue,  8 Oct 2019 11:52:48 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: rk808: Fix warning message in rk817_set_ramp_delay

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

From cc37038fe344e6000d30879c27521ee47c534fc8 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 8 Oct 2019 09:06:27 +0800
Subject: [PATCH] regulator: rk808: Fix warning message in rk817_set_ramp_delay

The default in rk817_set_ramp_delay is 25MV rather than 10MV.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Link: https://lore.kernel.org/r/20191008010628.8513-2-axel.lin@ingics.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/rk808-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index eda056fce65f..d0d1b868b0cd 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -388,7 +388,7 @@ static int rk817_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
 		break;
 	default:
 		dev_warn(&rdev->dev,
-			 "%s ramp_delay: %d not supported, setting 10000\n",
+			 "%s ramp_delay: %d not supported, setting 25000\n",
 			 rdev->desc->name, ramp_delay);
 	}
 
-- 
2.20.1

