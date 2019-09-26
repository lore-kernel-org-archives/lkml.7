Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041B7C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 15:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB43921D56
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 15:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569511484;
	bh=C7fd2pMn6+qd65ES1SK+hysUCnbgH9eM/RFTkISjhtE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=cA0yxwQTGYgz084Fa+t/owBp5cDUvDtjUbZoFluavxjfBHJ5dpkIQNG9MBYCRp2+u
	 4ec6Ap03tiSIaLbCgE3AKvto+/83SVNSIdrK8THI5Sn2BVxxK1Dl6GIHv8nnIdC/P9
	 cXCx/5eHYV1/5EVAvIzNrnFyK0XNlTaxjRdqWGw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfIZPYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 11:24:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59564 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfIZPYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 11:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=E727gRyNX9kxA81FhcRZtHXMEwd8teBeba4q7vIju5Y=; b=NSe5s2xVJDCv
        UTEy2da6R96Nh0QdEnUkmXAPBlkkKkyEUTDmJQxpjKLXxbbiBe9AFovgnKJC+2PG+62ZWNJRlAaZs
        vPqp5CRt25N/+NrqJX6MaC3fbAREH4x/cDZJwxMrvvgHIeg3dUnL7UuYEZkYg3iZKo6GqTx0/PKST
        fZna0=;
Received: from [12.157.10.118] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iDVcp-0003vC-Ni; Thu, 26 Sep 2019 15:24:11 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 14838D02CFF; Thu, 26 Sep 2019 16:24:10 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        kernel-janitors@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: topology: Fix a signedness bug in soc_tplg_dapm_widget_create()" to the asoc tree
In-Reply-To: <20190925110624.GR3264@mwanda>
X-Patchwork-Hint: ignore
Message-Id: <20190926152410.14838D02CFF@fitzroy.sirena.org.uk>
Date:   Thu, 26 Sep 2019 16:24:10 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: topology: Fix a signedness bug in soc_tplg_dapm_widget_create()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

From 752c938a5c14b8cbf0ed3ffbfa637fb166255c3f Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 25 Sep 2019 14:06:24 +0300
Subject: [PATCH] ASoC: topology: Fix a signedness bug in
 soc_tplg_dapm_widget_create()

The "template.id" variable is an enum and in this context GCC will
treat it as an unsigned int so it can never be less than zero.

Fixes: 8a9782346dcc ("ASoC: topology: Add topology core")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/r/20190925110624.GR3264@mwanda
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index b8690715abb5..c25939c5611b 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1588,7 +1588,7 @@ static int soc_tplg_dapm_widget_create(struct soc_tplg *tplg,
 
 	/* map user to kernel widget ID */
 	template.id = get_widget_id(le32_to_cpu(w->id));
-	if (template.id < 0)
+	if ((int)template.id < 0)
 		return template.id;
 
 	/* strings are allocated here, but used and freed by the widget */
-- 
2.20.1

