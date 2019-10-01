Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26823ECE589
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5D42133F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569930140;
	bh=juamc3+AGmTCn8Q8tKKnCnQEi3EBQYZReXaNqfWyZuM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=YZlA/eUkVzBaWF8DhbrsZXSEKB2peDABBh62li8lz/OGyhYHbQTPvE9Y+h658mf/L
	 sUHy3nD29zMG8HirwlhPUnFtbUa0d9MuVm9WgYnwydBqZaCxtzqGUBVs4SN9arab/B
	 fjxncJZ7ua4/MSqpKiGKHf0qZVI2hh4E60MgZwXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387797AbfJALmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:42:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40812 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387556AbfJALlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=63zJTbVH7lS8Trv4HBQFjRzzllGgjJHymJTri8Knfv4=; b=InsjyvrDB7a8
        RFjRE4bIxMfpFVjx3QH+g91DtnW5nDUH5JTC67RBn6bGDf28mhkCru3Vn06T/Fx45LzlDMIamXWiB
        rPReFf9xM32KmdgL+EwUhWBm+32q+g9eNJwdRY1AL5qqS/BzZqMED/d4zpRrK/i0TezB+E6RsfPdt
        3twz4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iFGWZ-0004Xc-UK; Tue, 01 Oct 2019 11:40:59 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 6B0572742A30; Tue,  1 Oct 2019 12:40:59 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Pragnesh Patel <pragnesh.patel@sifive.com>
Cc:     broonie@kernel.org, devicetree@vger.kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>
Subject: Applied "fixed-regulator: dt-bindings: Fixed building error for compatible property" to the regulator tree
In-Reply-To: <1568875145-2864-1-git-send-email-pragnesh.patel@sifive.com>
X-Patchwork-Hint: ignore
Message-Id: <20191001114059.6B0572742A30@ypsilon.sirena.org.uk>
Date:   Tue,  1 Oct 2019 12:40:59 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   fixed-regulator: dt-bindings: Fixed building error for compatible property

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

From 04a99ce605a780c275e2e9d2547d43fbba3f4d24 Mon Sep 17 00:00:00 2001
From: Pragnesh Patel <pragnesh.patel@sifive.com>
Date: Thu, 19 Sep 2019 12:09:04 +0530
Subject: [PATCH] fixed-regulator: dt-bindings: Fixed building error for
 compatible property

Compatible property is not of type 'string', so remove const:
from it.

Signed-off-by: Pragnesh Patel <pragnesh.patel@sifive.com>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/1568875145-2864-1-git-send-email-pragnesh.patel@sifive.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/regulator/fixed-regulator.yaml        | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
index a78150c47aa2..f32416968197 100644
--- a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
@@ -30,8 +30,8 @@ if:
 properties:
   compatible:
     enum:
-      - const: regulator-fixed
-      - const: regulator-fixed-clock
+      - regulator-fixed
+      - regulator-fixed-clock
 
   regulator-name: true
 
-- 
2.20.1

