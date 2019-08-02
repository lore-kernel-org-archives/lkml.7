Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571A8C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B0F8216C8
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564761928;
	bh=nNfxQ3LeaZy1JyT2KzGA6o7ez4MUlxUNvob7XFdzf7E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=OSK+iMICFIjKAEs5LT/iRrnCPFauAWu7j+dLKQ9dSMbAA/w30CpoAfeUVrgqddFHk
	 oWcCm15mm3+n7+MPELgHgDTaFC/e2ihwoipqFXraPll6ADcKXWEW8x22fnrlLoTkq4
	 1ONE912KjTcMMXcHInFuze5FGg+StakSXPRIT2h0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389299AbfHBQF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 12:05:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388975AbfHBQFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 12:05:13 -0400
Subject: Re: [GIT PULL] clk fixes for v5.3-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564761912;
        bh=nNfxQ3LeaZy1JyT2KzGA6o7ez4MUlxUNvob7XFdzf7E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=q67NSI0khVOSe85n18va1xodNGlUYqFOD+wsCF1LqOlro145FKDnlslb4WTA70gMZ
         BfN+VN2aeRlZmD3sG3KmlMKxbjq62RPsp5scjzvp3FxeWR+rj4p0AfMWyLeYNpUgrV
         mJopXWG/zqHP10jpC986/14oLJkqLs0Ez7FCWiuA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190801173618.245393-1-sboyd@kernel.org>
References: <20190801173618.245393-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190801173618.245393-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
 tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: e1f1ae8002e4b06addc52443fcd975bbf554ae92
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 42d21900b39ceebf7be1512d02d915280ba2bba5
Message-Id: <156476191206.27663.12542038119266553921.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Aug 2019 16:05:12 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  1 Aug 2019 10:36:18 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/42d21900b39ceebf7be1512d02d915280ba2bba5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
