Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9723DC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 20:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC1D2178F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 20:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567800008;
	bh=aXnq8dWmlHaG21Ii/CwHkn00sgBGKwAKF9SD9ypIcpw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=pzm3aUV4DiUQ92IfuD9njn75EH5C02pnwuHI6hEknCk/vKSfyY0T9Fhze6RYkguDE
	 Tt6/pX6h71M1ewNadiWNNW2F8rmvDREr78EzZLtEFiWkZ0W8cLNcbirSZ1SKZRdnam
	 awHcCdyqGOPfs5Hu1ub11Kq/Lp9j4lIfIe16YHrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394091AbfIFUAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 16:00:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:38806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394012AbfIFUAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 16:00:07 -0400
Subject: Re: [GIT PULL] ARM: SoC fixes for -rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567800006;
        bh=aXnq8dWmlHaG21Ii/CwHkn00sgBGKwAKF9SD9ypIcpw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qXGRVrU6UFTAuHu4GRLOACoe4Y3x5qwyVtnQd3V8tKDpOzzOcPxoFa6dJb/hxYZBt
         q1j4OH8Jntppxfy2HMxbAdmpyIrHpIynrMGPtAld8AwWDwuVcYsWddtpP8k1yBfxQR
         CAMTg4woqzbpXdAfmhxhvVarSwi7DLy3EDuuR9Yg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a0MsTFjqChoz+DLSC8nVnBuvqQdYx6V0SuCybg7MZ79mQ@mail.gmail.com>
References: <CAK8P3a0MsTFjqChoz+DLSC8nVnBuvqQdYx6V0SuCybg7MZ79mQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a0MsTFjqChoz+DLSC8nVnBuvqQdYx6V0SuCybg7MZ79mQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes
X-PR-Tracked-Commit-Id: 8928e917aeafaf38d65cc5cbc1f11e952dbed062
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 36daa831b55538dc2e4a906de20c5d91033ebb21
Message-Id: <156780000658.21952.10294077592758190884.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Sep 2019 20:00:06 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Gross <agross@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 6 Sep 2019 21:48:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/36daa831b55538dc2e4a906de20c5d91033ebb21

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
