Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D82C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A132B205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413836;
	bh=3b5ndDRnNHw1sBQ6Do28qcLRFUD28gNhvaxmL/uN6GI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HTmIx4m3CjQOInv5VGZSRKH5VJ5pKyH9f5iKMdITVTpAMQrwFJLUR+mta1z6ln1Mo
	 bB8+780Ig45L4v7zpk6NChKN0dYgopRQsbouC9PLuyinr4CtN0YMMsv94m3Dh6kFd6
	 bEDQ4DtQ4T8LtD/gMdXszTRtxs+pUTJA1jtNX9Wc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfCLRMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:12:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:47618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727473AbfCLRM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:12:26 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72B9C2171F;
        Tue, 12 Mar 2019 17:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410746;
        bh=3b5ndDRnNHw1sBQ6Do28qcLRFUD28gNhvaxmL/uN6GI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CxVaooejBjF0ElhPhhU9geXwUCciVasX/Tm9H/uV2JPZS02v/0SGxQAitog5NTEy0
         dYRVzkJ5z19BTv837QE3veLxb5/7olbb0p8YspRAbfScf35doEztXPNbfbUwhWd0l/
         Vugb21VXS7/VkBaxnoQe6sbUOKcpoeoTVioNniQY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 073/171] ARM: dts: sun8i: h3: Add ethernet0 alias to Beelink X2
Date:   Tue, 12 Mar 2019 10:07:33 -0700
Message-Id: <20190312170354.405607725@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit cc4bddade114b696ab27c1a77cfc7040151306da ]

Because "ethernet0" alias is missing, U-Boot doesn't generate board
specific MAC address. Effect of this is random MAC address every boot
and thus new IP address is assigned to the board.

Fix this by adding alias.

Fixes: 7389172fc3ed ("ARM: dts: sun8i: h3: Enable dwmac-sun8i on the Beelink X2")
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
[Maxime: Removed unneeded comment]
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
index 5d23667dc2d2..25540b7694d5 100644
--- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
@@ -53,7 +53,7 @@
 
 	aliases {
 		serial0 = &uart0;
-		/* ethernet0 is the H3 emac, defined in sun8i-h3.dtsi */
+		ethernet0 = &emac;
 		ethernet1 = &sdiowifi;
 	};
 
-- 
2.19.1



