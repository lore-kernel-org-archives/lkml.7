Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5537C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C5321783
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573611161;
	bh=0PiJltGkCCUSn6b6SczZyBlHFzdXyCOaUGSaDBXebiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zaALs/hWnfJ+Jxi4YYt9jaSNyKHYdF89DafiygZpvuMZarsNmFsNQTT2PIHoF5WZG
	 JqNHTaZGm1zuz613VxIjpayCLiCVa9ufpapWxOCrT7aw8lqG+sU8ljkjI99ytK+awW
	 wThKSrkQZv0CIEdUClkwpUGxn/qZBXR2NKd1OSKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbfKMB6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:58:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:51656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729936AbfKMB6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:58:06 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EC462245C;
        Wed, 13 Nov 2019 01:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610286;
        bh=0PiJltGkCCUSn6b6SczZyBlHFzdXyCOaUGSaDBXebiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0NckyA2oJHjZGsXaSmTWpcz0hoyAD0LRcwVnulI5O+ousEUVZl/yzIPXJxYsRMbnU
         dY4uyxgJGHo+jGJ0K6G8HCwWP88rVz6cQs5xCaeACZp+AXR9zkBfIUvsNlROIOckKP
         bnB+Fnawq2fvvHGjU6BXkW8zuCH/9KdD4PI2XgNs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Joonyoung Shim <jy0922.shim@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 063/115] clk: samsung: exynos5420: Define CLK_SECKEY gate clock only or Exynos5420
Date:   Tue, 12 Nov 2019 20:55:30 -0500
Message-Id: <20191113015622.11592-63-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015622.11592-1-sashal@kernel.org>
References: <20191113015622.11592-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonyoung Shim <jy0922.shim@samsung.com>

[ Upstream commit d32dd2a1a0f80edad158c9a1ba5f47650d9504a0 ]

The bit of GATE_BUS_PERIS1 for CLK_SECKEY is just reserved on
exynos5422/5800, not exynos5420. Define gate clk for exynos5420 to
handle the bit only on exynos5420.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
[m.szyprow: rewrote commit subject]
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Sylwester Nawrocki <snawrocki@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/samsung/clk-exynos5420.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 500a55415e900..a882f7038bcec 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -633,6 +633,7 @@ static const struct samsung_div_clock exynos5420_div_clks[] __initconst = {
 };
 
 static const struct samsung_gate_clock exynos5420_gate_clks[] __initconst = {
+	GATE(CLK_SECKEY, "seckey", "aclk66_psgen", GATE_BUS_PERIS1, 1, 0, 0),
 	GATE(CLK_MAU_EPLL, "mau_epll", "mout_mau_epll_clk",
 			SRC_MASK_TOP7, 20, CLK_SET_RATE_PARENT, 0),
 };
@@ -1167,8 +1168,6 @@ static const struct samsung_gate_clock exynos5x_gate_clks[] __initconst = {
 	GATE(CLK_TMU, "tmu", "aclk66_psgen", GATE_IP_PERIS, 21, 0, 0),
 	GATE(CLK_TMU_GPU, "tmu_gpu", "aclk66_psgen", GATE_IP_PERIS, 22, 0, 0),
 
-	GATE(CLK_SECKEY, "seckey", "aclk66_psgen", GATE_BUS_PERIS1, 1, 0, 0),
-
 	/* GEN Block */
 	GATE(CLK_ROTATOR, "rotator", "mout_user_aclk266", GATE_IP_GEN, 1, 0, 0),
 	GATE(CLK_JPEG, "jpeg", "aclk300_jpeg", GATE_IP_GEN, 2, 0, 0),
-- 
2.20.1

