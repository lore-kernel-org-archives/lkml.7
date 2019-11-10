Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F943C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50764208C3
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573355424;
	bh=8zJoHrLNn5sbwSXWJeAMxdvWZEyDAJiM8C5G+GLVnno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qIVQ590T3kvzpbDMW/XPR7fa6kkJHB0YDCYl8svGLKf9H3eBAzCwauxRPccuIqxcx
	 4MaYd2HmHnOH/7TWomp0l++00OV9xLpQrfFT+B2ZfTflByYyEcddUgBr2QcmH/Hmbv
	 PWds4+YGiiT+vkI9RWvdnupxhJ9wfVsc+dcDF3wI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfKJDKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 22:10:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:43046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbfKJCoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:44:05 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 080E2222CB;
        Sun, 10 Nov 2019 02:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353844;
        bh=8zJoHrLNn5sbwSXWJeAMxdvWZEyDAJiM8C5G+GLVnno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=niPk+tr1KnHx10X88ZCaGGz0CCImSxhLNkFBQ5d6GYogPMse063+Jzuau96ifCZ6/
         d79ZacreCpNr5JxbeLRwXkDoK6VL3wM+tSyz2OUk18qKkdlIr08CDWeakkqH3Pay2K
         huXJCXvDZaTRE82l0AGkM03mOXV1+/e20to3JKfQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 132/191] ARM: dts: imx51-zii-rdu1: Fix the rtc compatible string
Date:   Sat,  9 Nov 2019 21:39:14 -0500
Message-Id: <20191110024013.29782-132-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com>

[ Upstream commit 1c5f335f61ffb838fc3cc1cec9464067663eb8c8 ]

According to Documentation/devicetree/bindings/rtc/rtc-ds1307.txt the
original compatible "maxim,ds1341" is not a valid entry.

Switch to the documented "dallas,ds1341" compatible.

Reported-by: Chris Healy <cphealy@gmail.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Tested-by: Chris Healy <cphealy@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx51-zii-rdu1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
index 6e80254c4562a..3fb66ddfe93a5 100644
--- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
+++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
@@ -514,7 +514,7 @@
 	};
 
 	ds1341: rtc@68 {
-		compatible = "maxim,ds1341";
+		compatible = "dallas,ds1341";
 		reg = <0x68>;
 	};
 
-- 
2.20.1

