Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2246C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C65020657
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="uxTVy4kY";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="uxTVy4kY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391515AbfETOYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:24:01 -0400
Received: from node.akkea.ca ([192.155.83.177]:50732 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730549AbfETOXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:23:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id B93AF4E2051;
        Mon, 20 May 2019 14:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1558362217; bh=Ru5/wWVJ5n4Ox9lI7TeMXEImkM/yOICYH0UWN7Qj7CE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=uxTVy4kYJOzZkEzPz374r2smV5M0y26J54DkKtY8y5PaoDm43V1Gb7l4n6ug3m3B0
         i/ee/p+WwFTB29pEOif5L354FgTZim4BK7so1wR7f+XsBcBV4aDCMDfH3HeYm5Jh6t
         q3cdvVsoOwWgeMewWsmPCBoT4VN3fvfzSqtrZ/Xo=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id R2z0Wxzn4ig0; Mon, 20 May 2019 14:23:37 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id AB2FC4E204D;
        Mon, 20 May 2019 14:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1558362217; bh=Ru5/wWVJ5n4Ox9lI7TeMXEImkM/yOICYH0UWN7Qj7CE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=uxTVy4kYJOzZkEzPz374r2smV5M0y26J54DkKtY8y5PaoDm43V1Gb7l4n6ug3m3B0
         i/ee/p+WwFTB29pEOif5L354FgTZim4BK7so1wR7f+XsBcBV4aDCMDfH3HeYm5Jh6t
         q3cdvVsoOwWgeMewWsmPCBoT4VN3fvfzSqtrZ/Xo=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus.ainslie@puri.sm
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v13 1/4] MAINTAINERS: add an entry for for arm64 imx devicetrees
Date:   Mon, 20 May 2019 07:23:27 -0700
Message-Id: <20190520142330.3556-2-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190520142330.3556-1-angus@akkea.ca>
References: <20190520142330.3556-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an explicit reference to imx* devicetrees

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a2cd3690b6b1..019c945d308d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1630,6 +1630,7 @@ R:	NXP Linux Team <linux-imx@nxp.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
+F:	arch/arm64/boot/dts/freescale/imx*
 N:	imx
 N:	mxs
 X:	drivers/media/i2c/
-- 
2.17.1

