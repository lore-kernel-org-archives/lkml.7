Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770E5C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BADF2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367561;
	bh=OSmQ5vhrznVfvKMW0+PN1HUC0o9AgphD2pFkCMhXTMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Pc/46WnB7VKq6TWmUo8qOKMScl7nUEbAUQ8nULPzkGtD7sm8DfrYVwytcf4/5wZ0H
	 v/offaMKheArC9kRoUyWZvTwxi2UrDNtnmpmU8sxKmE9RgGAI8y/yigAuHct4QptKB
	 yuTALyFna8SGfOTw75OLsC5Kk8Tu9azHOv/FCnL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388081AbfB1PLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:11:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:45008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733264AbfB1PLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:11:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32519218AE;
        Thu, 28 Feb 2019 15:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366703;
        bh=OSmQ5vhrznVfvKMW0+PN1HUC0o9AgphD2pFkCMhXTMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=npcG6MN2BLCVOY6Cjvk3bppI1Y0V9+ETx4oFv9OlrBGc/OMBGLjBoHX0ejjtZIogG
         SZ+txtVcHiRfSKTZCZ4+HlG+T2RnGpVDJ1sYyd/hEtCX6YRiaT4OwAkIGvQ4AJZj+0
         gVBMq5+CPig2BwFe4UaReEXhf9cWFTct21RwgBRo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhou Yanjie <zhouyanjie@cduestc.edu.cn>,
        Paul Burton <paul.burton@mips.com>,
        linux-mips <linux-mips@vger.kernel.org>,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        ralf@linux-mips.org, jhogan@kernel.org, mark.rutland@arm.com,
        malat@debian.org, ezequiel@collabora.co.uk, ulf.hansson@linaro.org,
        syq <syq@debian.org>, "jiaxun . yang" <jiaxun.yang@flygoat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 19/64] DTS: CI20: Fix bugs in ci20's device tree.
Date:   Thu, 28 Feb 2019 10:10:20 -0500
Message-Id: <20190228151105.11277-19-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151105.11277-1-sashal@kernel.org>
References: <20190228151105.11277-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhou Yanjie <zhouyanjie@cduestc.edu.cn>

[ Upstream commit 1ca1c87f91d9dc50d6a38e2177b2032996e7901c ]

According to the Schematic, the hardware of ci20 leads to uart3,
but not to uart2. Uart2 is miswritten in the original code.

Signed-off-by: Zhou Yanjie <zhouyanjie@cduestc.edu.cn>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: linux-mips <linux-mips@vger.kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Cc: devicetree@vger.kernel.org
Cc: robh+dt@kernel.org
Cc: ralf@linux-mips.org
Cc: jhogan@kernel.org
Cc: mark.rutland@arm.com
Cc: malat@debian.org
Cc: ezequiel@collabora.co.uk
Cc: ulf.hansson@linaro.org
Cc: syq <syq@debian.org>
Cc: jiaxun.yang <jiaxun.yang@flygoat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/boot/dts/ingenic/ci20.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index 50cff3cbcc6de..4f7b1fa31cf53 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -76,7 +76,7 @@
 	status = "okay";
 
 	pinctrl-names = "default";
-	pinctrl-0 = <&pins_uart2>;
+	pinctrl-0 = <&pins_uart3>;
 };
 
 &uart4 {
@@ -196,9 +196,9 @@
 		bias-disable;
 	};
 
-	pins_uart2: uart2 {
-		function = "uart2";
-		groups = "uart2-data", "uart2-hwflow";
+	pins_uart3: uart3 {
+		function = "uart3";
+		groups = "uart3-data", "uart3-hwflow";
 		bias-disable;
 	};
 
-- 
2.19.1

