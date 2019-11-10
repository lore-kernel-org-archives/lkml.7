Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C16BC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57DF1215EA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573355484;
	bh=VnAEBOD27XWMulR9/EeVPCt6n+USTqJyjGRRcoqKhTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=acD3FDTLjya9nGH8mAhkbe157EgooDUObm4jLmdCvSZ/xiqlC2QKeQnvPdGDycsJU
	 B7x+Ggng80X/lyzNJUskpc280ZZozYuMQeVkqPsh5CgiJkZqthviMtPtHw5ng/8R3P
	 VXrq59u9sBPa/iOfdotTCKyNuov+7EWAiNUb18pg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbfKJCnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:43:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:41764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728337AbfKJCnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:43:31 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C0A121924;
        Sun, 10 Nov 2019 02:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353811;
        bh=VnAEBOD27XWMulR9/EeVPCt6n+USTqJyjGRRcoqKhTc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RWqIi6lgT/206GyfOSwSI29dJIwMbnohOShfnwsrQF4ApdXVQxEv+R/NeZf2E/JnZ
         tJXJVFWY6aZ7dqtT28iyrC2K2f1ZSYljB3YUBqMAFO/pzX71R7PFsGv7aNeVlAVVJH
         pzmji7kW4mNHlF0oAR32nzqtx14gjBNTGxRiqeQo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anson Huang <Anson.Huang@nxp.com>,
        =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 107/191] ARM: dts: imx6ull: update vdd_soc voltage for 900MHz operating point
Date:   Sat,  9 Nov 2019 21:38:49 -0500
Message-Id: <20191110024013.29782-107-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

[ Upstream commit 245f880c25dbd8927af0f33aa5d1404370013957 ]

Update VDD_SOC voltage to 1.25V for 900MHz operating point
according to datasheet Rev. 1.3, 08/2018, 25mV is added to
the minimum allowed values to cover power supply ripple.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx6ull.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6ull.dtsi b/arch/arm/boot/dts/imx6ull.dtsi
index cd1776a7015ac..796ed35d4ac9a 100644
--- a/arch/arm/boot/dts/imx6ull.dtsi
+++ b/arch/arm/boot/dts/imx6ull.dtsi
@@ -22,7 +22,7 @@
 	>;
 	fsl,soc-operating-points = <
 		/* KHz	uV */
-		900000	1175000
+		900000	1250000
 		792000	1175000
 		528000	1175000
 		396000	1175000
-- 
2.20.1

