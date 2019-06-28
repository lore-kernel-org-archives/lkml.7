Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4B7C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 102342084B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561683310;
	bh=o13rGM6vMulkP8kdptU6Ib8+Sz0AFNP2C5JcJSAx74k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=FXMrULFdrSsU+0imkNyXSGI0qeyAvqP86TFz53372vjbYNJtKSqP3mJoAmEas473B
	 5edxrvdDEuowvmGJK2sFKcecv3Kl03m3/COTEZoJf4iSQZG2LoyBAa4ENNj1lQxo40
	 kKVQzGNn5GfJQIzuRFuHDJ7F0Z6DL8NkGe0nQU+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfF1AzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 20:55:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbfF1AzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 20:55:04 -0400
Subject: Re: [GIT PULL] clk fixes for v5.2-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561683304;
        bh=o13rGM6vMulkP8kdptU6Ib8+Sz0AFNP2C5JcJSAx74k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MjYoVMLt6cZxv1Aw4RUNt0fES5yaD0W1sLgr3Z+2hU89dZ067vH/VuyHG6fXRCQ05
         VsaDcH3faw8SBfR63eJIVDtCDf5AK1AaIyHjhI2zgRmM9kDhfuXIVTtnsrcobO2yMR
         dF0YjkhvfkhbKOOaHF+LYGQFVl1ifgYNLBifpL94=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190627202549.45667-1-sboyd@kernel.org>
References: <20190627202549.45667-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190627202549.45667-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
 tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: 74684cce5ebd567b01e9bc0e9a1945c70a32f32f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 556e2f6020bf90f63c5dd65e9a2254be6db3185b
Message-Id: <156168330422.8716.170645861291830293.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Jun 2019 00:55:04 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Jun 2019 13:25:49 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/556e2f6020bf90f63c5dd65e9a2254be6db3185b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
