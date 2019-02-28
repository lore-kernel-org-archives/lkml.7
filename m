Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591E7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B93620C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366838;
	bh=hLEA00lgfO2702WMHeIiQDc/vaMICsiKJPqpsoynM9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jjWWfT+QLUyC7NSYsiyM5nRu7j4HnH3QFrm/wYc+tbu/H8YkwBFOmDXUUCqt57LMk
	 NWjsGXBUJ25Hn/YQRwNL7z1VtPG5FC4il2OAEe4+BR5gggAI2irj0WNW/2/1JthvuG
	 mkYVngMrS5G+RiMImw+cjS+N+5stUV5BDiyvjNSE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388567AbfB1PN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:13:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:48122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388545AbfB1PNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:13:52 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CF4F218D9;
        Thu, 28 Feb 2019 15:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366831;
        bh=hLEA00lgfO2702WMHeIiQDc/vaMICsiKJPqpsoynM9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ezneIJnM/OG5HDynexe4GjPuHXb0KnsbAXYcWntn5johdcvqCB3vwB/DElNqIXdMD
         VsgFtaGMTXk2zE0wN3KckF0iJNIDNpeNF5oE09wwoyyJDjNr28uF30v4t/10EhVzrU
         IRQiVDmtmGdR/O1v50XZN3w8KJZ21lhAcFS/Y0+I=
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
Subject: [PATCH AUTOSEL 4.14 07/36] DTS: CI20: Fix bugs in ci20's device tree.
Date:   Thu, 28 Feb 2019 10:13:08 -0500
Message-Id: <20190228151337.12176-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151337.12176-1-sashal@kernel.org>
References: <20190228151337.12176-1-sashal@kernel.org>
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
index a4cc52214dbdb..dad4aa0ebdd8c 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -54,7 +54,7 @@
 	status = "okay";
 
 	pinctrl-names = "default";
-	pinctrl-0 = <&pins_uart2>;
+	pinctrl-0 = <&pins_uart3>;
 };
 
 &uart4 {
@@ -174,9 +174,9 @@
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

