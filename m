Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF80BC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 09:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76C8214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 09:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557306103;
	bh=J+lTId5Jw0PaXBSQUDJf2TtyCVbbsYx9XyZ34EEvT8A=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=SLXBbVMdBQmFwFB2/Th4fG38Tk3ymZVgrlBnScOzhkYa22w89aZSUFJKv3CJ+syXl
	 HfqJlOUynT9bupaIPo9dJu7YzXPh0IxPy74q7K1LfbZsp3wAJuKWjfnaglKLuVoJLa
	 6mTtQ21Xa9D5etTzOK++1rw522ER8enfcmyQVaq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfEHJBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 05:01:42 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44756 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfEHJBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 05:01:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=bwHhshSS/kbfWXI+gsQyuvdaNlF4NdaPvcOqb1oDAdo=; b=bsWwKanjClyz
        3Q9U6F/VocjQtO/23y2c9tlFDgFhqXBiGnFtBEHU/dJYlV3dP1j2bgg8Bk6D6wCZnPj6Tf+kCXAQD
        hoNGpgQF/9zNWx9PFWMKEkNNEKceL1N4jLyGKKvmd3v6dzjvnJVyeCMsn22Zwf9I5hCtLMUe58Z9k
        N7pE8=;
Received: from [61.199.190.11] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hOISA-0007dM-I7; Wed, 08 May 2019 09:01:31 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 34D1C44000C; Wed,  8 May 2019 10:01:24 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "sound: soc-acpi: fix implicit header use of module.h/export.h" to the asoc tree
In-Reply-To: <1555168518-15287-1-git-send-email-paul.gortmaker@windriver.com>
X-Patchwork-Hint: ignore
Message-Id: <20190508090124.34D1C44000C@finisterre.sirena.org.uk>
Date:   Wed,  8 May 2019 10:01:24 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   sound: soc-acpi: fix implicit header use of module.h/export.h

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

From 473849e7f208b2d7de004c6c6c0eabe037d125ac Mon Sep 17 00:00:00 2001
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Sat, 13 Apr 2019 11:15:18 -0400
Subject: [PATCH] sound: soc-acpi: fix implicit header use of module.h/export.h

This file is implicitly relying on an instance of including
module.h from <linux/acpi.h>.

Ideally, header files under include/linux shouldn't be adding
includes of other headers, in anticipation of their consumers,
but just the headers needed for the header itself to pass
parsing with CPP.

The module.h is particularly bad in this sense, as it itself does
include a whole bunch of other headers, due to the complexity of
module support.

Here, we make the include explicit, in order to allow the future
removal of module.h from linux/acpi.h without causing build breakage.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-acpi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/soc-acpi.c b/sound/soc/soc-acpi.c
index 4fb29f0e561e..444ce0602f76 100644
--- a/sound/soc/soc-acpi.c
+++ b/sound/soc/soc-acpi.c
@@ -4,6 +4,8 @@
 //
 // Copyright (c) 2013-15, Intel Corporation.
 
+#include <linux/export.h>
+#include <linux/module.h>
 #include <sound/soc-acpi.h>
 
 struct snd_soc_acpi_mach *
-- 
2.20.1

