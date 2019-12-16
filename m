Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD0FC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2588821775
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576518753;
	bh=Baj24eQ/7ZedPE3KYRQs3tANG4h9wHQN0oWST1EaHtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hre/zM/BtGxWDCuanct+g+7O/GbLQgkhbTiKcSTz4rn5wS18Pr44MhYDJyTagIHW2
	 66hxriYzYpugoZQDf+mG5CM6zlrIhClt5mD4FLIGrXnuv9TJ30C/hEQVnQFitZrs9O
	 5IHeAYgY3An2c1xsZu8l2hJEglxGpFQk4kUf9k2I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfLPRwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:52:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:43960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727425AbfLPRwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:52:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFBBA2072D;
        Mon, 16 Dec 2019 17:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576518741;
        bh=Baj24eQ/7ZedPE3KYRQs3tANG4h9wHQN0oWST1EaHtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0cuW7CbhIirBKuzoqkHhO0hoaCHqJLh4Pj/SBAiYXB/ydQxrzhhzDPsynzytErsfk
         BSISPzk0WUad/RnYWXSkwk317D2lYnHr9XoMBk9Orx1MrZHCnFdt3ilVxpQV3nrl6X
         hNjLhXOepLP4EmyHuWYzvJ4xB80dKiAY3FgsTlC4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 047/267] clk: rockchip: fix ID of 8ch clock of I2S1 for rk3328
Date:   Mon, 16 Dec 2019 18:46:13 +0100
Message-Id: <20191216174853.797965453@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Katsuhiro Suzuki <katsuhiro@katsuster.net>

[ Upstream commit df7b1f2e0a4ae0fceff261e29cde63dafcf2360f ]

This patch fixes mistakes in HCLK_I2S1_8CH for running I2S1
successfully.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/dt-bindings/clock/rk3328-cru.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/rk3328-cru.h b/include/dt-bindings/clock/rk3328-cru.h
index d2b26a4b43ebd..4a9db1b2669b8 100644
--- a/include/dt-bindings/clock/rk3328-cru.h
+++ b/include/dt-bindings/clock/rk3328-cru.h
@@ -178,7 +178,7 @@
 #define HCLK_TSP		309
 #define HCLK_GMAC		310
 #define HCLK_I2S0_8CH		311
-#define HCLK_I2S1_8CH		313
+#define HCLK_I2S1_8CH		312
 #define HCLK_I2S2_2CH		313
 #define HCLK_SPDIF_8CH		314
 #define HCLK_VOP		315
-- 
2.20.1



