Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA44C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 23:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9EE92070D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 23:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="kZrN88Pe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfG1X4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 19:56:17 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.178]:45098 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726203AbfG1X4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 19:56:17 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 77A613F1D95
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 18:56:16 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id rt1Uh1m00dnCert1UhVHVZ; Sun, 28 Jul 2019 18:56:16 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3KsSCEb6Km1Yj7+6lKrHE7C6XEmon8NCW2WRRXKbJ8g=; b=kZrN88PeaAUc4SGFOYQXL6P6Ny
        ae0HgZKOUZX+DcwN3xo4Y4bpXXq6vtCubC2vF1mqUAo1znCJ2OySjyMA8ATzARfR5FTCuWF5oeuBK
        YHI4rykUPdL6BFjMw7rz2ULzZ+DOHlw6dtl3v9UwkuTnBmFLx49G5ShXKwlaNXuTfS4kqk0B5dems
        OD1/X5oyzTyG5SzlXqTQYS3hYY5mTq7lKSQ/UhjmKnujjrjReG219Lob+kuBlVWHA5px3uSHxIQnV
        rrzUM3+BPfBekRXREnVCYzdwlCpSIJLFHrP0AgVLHqp2Nx2t0BWKKLhF3999NaTBaeBZuNn6NLxe/
        /TuPmrjw==;
Received: from [187.192.11.120] (port=39596 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hrt1T-003lh5-Dr; Sun, 28 Jul 2019 18:56:15 -0500
Date:   Sun, 28 Jul 2019 18:56:14 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] mfd: db8500-prcmu: Mark expected switch fall-throughs
Message-ID: <20190728235614.GA23618@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1hrt1T-003lh5-Dr
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:39596
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 52
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warnings:

drivers/mfd/db8500-prcmu.c: In function 'dsiclk_rate':
drivers/mfd/db8500-prcmu.c:1592:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
   div *= 2;
   ~~~~^~~~
drivers/mfd/db8500-prcmu.c:1593:2: note: here
  case PRCM_DSI_PLLOUT_SEL_PHI_2:
  ^~~~
drivers/mfd/db8500-prcmu.c:1594:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
   div *= 2;
   ~~~~^~~~
drivers/mfd/db8500-prcmu.c:1595:2: note: here
  case PRCM_DSI_PLLOUT_SEL_PHI:
  ^~~~

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/mfd/db8500-prcmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 3f21e26b8d36..90e0f21bc49c 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -1590,8 +1590,10 @@ static unsigned long dsiclk_rate(u8 n)
 	switch (divsel) {
 	case PRCM_DSI_PLLOUT_SEL_PHI_4:
 		div *= 2;
+		/* Fall through */
 	case PRCM_DSI_PLLOUT_SEL_PHI_2:
 		div *= 2;
+		/* Fall through */
 	case PRCM_DSI_PLLOUT_SEL_PHI:
 		return pll_rate(PRCM_PLLDSI_FREQ, clock_rate(PRCMU_HDMICLK),
 			PLL_RAW) / div;
-- 
2.22.0

