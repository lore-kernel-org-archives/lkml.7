Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40533C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 11:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D9C2341C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 11:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567165528;
	bh=9kNljC9XMYr7dXVWEv1xXqO7ualwZiWqhksSqYZesI0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=GVbaDy1B+44q3fFikJ3HVxjIm2/WSOpYRE7e8rbgroeOMdpvzinZYYq4bye1purhZ
	 4e5vgyzC7xcvwF1pcCGcEJpluE1egXR9t8ArNW2doDaVLXvpL/GPEY9E237ZKvTsnx
	 mWRydhg9c11NaJPcF86+30q2L8o+FSE9awSPOpos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbfH3Lp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 07:45:27 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42500 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbfH3Lp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 07:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=V1TyM4JysH3c/+Cijsih56/+aPk5aLc+ONEJpYmXimg=; b=EK40vcog6pbQ
        sUHzaEY8X90zABDdQkJje5fiLbWVcWzFXMUhRJtacJufz1ou1EKKREaJxUKv1Y/QefTeWi7vZSO1Q
        saZnKalBZNkJIEQf2if4of2oFK+zpQynZVcf5F+uRvqrWigEcL/4S2j562m4UQCxLSXJkBGfhpsCt
        e7dhM=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i3fLJ-0006Js-3e; Fri, 30 Aug 2019 11:45:25 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 9739D2742B61; Fri, 30 Aug 2019 12:45:24 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Applied "MAINTAINERS: Add keyword pattern on regulator_get_optional()" to the regulator tree
In-Reply-To: <20190829125435.48770-1-broonie@kernel.org>
X-Patchwork-Hint: ignore
Message-Id: <20190830114524.9739D2742B61@ypsilon.sirena.org.uk>
Date:   Fri, 30 Aug 2019 12:45:24 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   MAINTAINERS: Add keyword pattern on regulator_get_optional()

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

From baedad4c35ce35973263f8991d288c280f4bd05d Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Thu, 29 Aug 2019 13:54:35 +0100
Subject: [PATCH] MAINTAINERS: Add keyword pattern on regulator_get_optional()

In an effort to try to contain abuses of regulator_get_optional() add a
keyword entry to the MAINTAINERS stanza for the regulator API so that the
regulator maintainers get CCed on new usages.

Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20190829125435.48770-1-broonie@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 783569e3c4b4..6cfb528d0a2e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17234,6 +17234,7 @@ F:	Documentation/power/regulator/
 F:	drivers/regulator/
 F:	include/dt-bindings/regulator/
 F:	include/linux/regulator/
+K:	regulator_get_optional
 
 VRF
 M:	David Ahern <dsa@cumulusnetworks.com>
-- 
2.20.1

