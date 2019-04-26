Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A0BC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4461E2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556271969;
	bh=AWM2xjXldOjEwxbDJrUSFC7/DqrSfOsVkR0OsJgurLQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=LC2zhGdt7cIrVj9bb2tyTYVu7cDNpodnWCEMVQYvjhZJwbh5o6yP85vMZQNj5SQcZ
	 L0/qi2SeKcooxE0a6CTNpilABmjiCdDhoQXqxi1m8q/zmhiFFYVLIRHj4bqc13Icsl
	 BaPfLUTlHVbRu5rnNNqNehr27Y+HLImB6K9bgjtA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfDZJqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:46:07 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55550 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbfDZJqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=+Kjanl0NisFIjQWftyRzb6yNyG09hJNTfoZBhQmXj1E=; b=IMdv/zQPswRo
        aPotTI5AsKAb/LhX+fNNeR6l5cAc8CN/e8UqDrxyI6cvAsRTHkiele/agmZtviclm6sE+hsSQuegP
        RXcUhmPjvsADXSXerDzmUH6tLa1W5za1XoNzCXNzaac5oY8F/9hXHP3gyF79gVmjIhYNgoKlCF2Vr
        nXapE=;
Received: from [37.205.61.202] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJxQe-0003Su-WA; Fri, 26 Apr 2019 09:46:01 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id E0B48441D3B; Fri, 26 Apr 2019 10:45:59 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: s2mpa01: Remove unused define for S2MPA01_REGULATOR_CNT" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190426094559.E0B48441D3B@finisterre.ee.mobilebroadband>
Date:   Fri, 26 Apr 2019 10:45:59 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: s2mpa01: Remove unused define for S2MPA01_REGULATOR_CNT

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

From 6e1f22ee7e4874c357a95a87f3ebc6eb093562dc Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 9 Apr 2019 21:00:42 +0800
Subject: [PATCH] regulator: s2mpa01: Remove unused define for
 S2MPA01_REGULATOR_CNT

The S2MPA01_REGULATOR_CNT is no longer used after converted to use
simplified DT parsing.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/s2mpa01.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/regulator/s2mpa01.c b/drivers/regulator/s2mpa01.c
index da11ac5c09f2..51f7e8b74d8c 100644
--- a/drivers/regulator/s2mpa01.c
+++ b/drivers/regulator/s2mpa01.c
@@ -17,8 +17,6 @@
 #include <linux/mfd/samsung/core.h>
 #include <linux/mfd/samsung/s2mpa01.h>
 
-#define S2MPA01_REGULATOR_CNT ARRAY_SIZE(regulators)
-
 struct s2mpa01_info {
 	int ramp_delay24;
 	int ramp_delay3;
-- 
2.20.1

