Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E02C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC63821D7B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573213324;
	bh=ypa3wOs131kORiY+6JAWO3HBW3gIyp6YubYc/0p5glQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jmt96UteGxspVMtzRJ/4qGfEsS/Wj6uR1tUEEhDFqecEMZEU/Or51vn3kvwHNUDMZ
	 v3e8q/mHlEnZJOgIahJ7V6dar/vQ1ZP1i2COw1nwDB59Yt04Tj6i8RgTPrsKRPPD1P
	 D0ngeAVSYqLSsnf5a75dWi//r87mORaGd+bvOzr8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389752AbfKHLmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:42:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:55588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389727AbfKHLmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:42:00 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB9BD222C5;
        Fri,  8 Nov 2019 11:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213319;
        bh=ypa3wOs131kORiY+6JAWO3HBW3gIyp6YubYc/0p5glQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jgQFdD6FIjxxD50NenAKo5J9DY47ASepMhQkAWC29TCB48waRVy4O1GxHoDm83t3A
         qDSy7tIkSfIDbHW6gEy4UD1G/F8neMWHd0foiUhX/tc/YBoke5KWd67TLVXKLmZBuS
         DE9SZVLvMJhuogv5XgpHyTL6L5uSh3T5l3a0uR5k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>, Da Xue <da@lessconfused.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 163/205] arm64: dts: meson: libretech: update board model
Date:   Fri,  8 Nov 2019 06:37:10 -0500
Message-Id: <20191108113752.12502-163-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit b7eb0e26cc4a212fde09144cd49d4103170d2b9e ]

There is actually several different libretech board with the CC suffix
so the model name is not appropriate here. Update to something more
specific

Reported-by: Da Xue <da@lessconfused.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index f63bceb88caaf..90a56af967a7f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -13,7 +13,7 @@
 
 / {
 	compatible = "libretech,cc", "amlogic,s905x", "amlogic,meson-gxl";
-	model = "Libre Technology CC";
+	model = "Libre Computer Board AML-S905X-CC";
 
 	aliases {
 		serial0 = &uart_AO;
-- 
2.20.1

