Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A298BC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 13:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77CE9208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 13:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565615439;
	bh=hx2J1ExO95luFnSwxGwH13TEpKroSIa8DC18gzTj2bA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=XdhHVzQezejvpmbtimqEbjwuv5VSy8QsAeLaxkBNLOrV94kHCNsOaKMZJiaBrmwHc
	 J7I9+lnOoRL6A0G7vrufj3NnyS82376LpZhpIU9o//UpQ3+3NH3q0bsHyaNOUhpVg2
	 oHJ0YFTQsscDFc35o/D8yfCO5ZXPzU67QyB5Ce/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbfHLNKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 09:10:38 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40152 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfHLNKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 09:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Q9qcnlkxDXzQ76coxQL/CdrXQ/CkPfBxp6V88YMLlQI=; b=LdlKbGc7EU4i
        ze96X1m3Zp+EPrzGQLJ2Nho6DedV4JwLZGHGG76uyiUlIOpLiVkqRJHZQ4XK/WQMPPQFLI3ccZToJ
        uWovDRVa9xJKbqXAiCW0b9zIBQW5pR/M+F1EfV1mbOvvXyzs4juE/0dhgQmfYLmA68Rtc0RxKTPXI
        z91Nw=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hxA59-0001M4-Ff; Mon, 12 Aug 2019 13:09:51 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id DBD082740CB7; Mon, 12 Aug 2019 14:09:50 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        devicetree@vger.kernel.org, festevam@gmail.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Mark Brown <broonie@kernel.org>, mark.rutland@arm.com,
        nicoleotsuka@gmail.com, Nicolin Chen <nicoleotsuka@gmail.com>,
        robh+dt@kernel.org, timur@kernel.org, Xiubo.Lee@gmail.com
Subject: Applied "ASoC: fsl_esai: Add new compatible string for imx6ull" to the asoc tree
In-Reply-To: <1565346467-5769-2-git-send-email-shengjiu.wang@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20190812130950.DBD082740CB7@ypsilon.sirena.org.uk>
Date:   Mon, 12 Aug 2019 14:09:50 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: fsl_esai: Add new compatible string for imx6ull

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

From 9ea08f2a6d27b6a26d33dae5c58e4099672d6bb3 Mon Sep 17 00:00:00 2001
From: Shengjiu Wang <shengjiu.wang@nxp.com>
Date: Fri, 9 Aug 2019 18:27:47 +0800
Subject: [PATCH] ASoC: fsl_esai: Add new compatible string for imx6ull

Add new compatible string "fsl,imx6ull-esai" in the binding document.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Link: https://lore.kernel.org/r/1565346467-5769-2-git-send-email-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/fsl,esai.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,esai.txt b/Documentation/devicetree/bindings/sound/fsl,esai.txt
index 5b9914367610..0e6e2166f76c 100644
--- a/Documentation/devicetree/bindings/sound/fsl,esai.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,esai.txt
@@ -7,8 +7,11 @@ other DSPs. It has up to six transmitters and four receivers.
 
 Required properties:
 
-  - compatible		: Compatible list, must contain "fsl,imx35-esai" or
-			  "fsl,vf610-esai"
+  - compatible		: Compatible list, should contain one of the following
+			  compatibles:
+			  "fsl,imx35-esai",
+			  "fsl,vf610-esai",
+			  "fsl,imx6ull-esai",
 
   - reg			: Offset and length of the register set for the device.
 
-- 
2.20.1

