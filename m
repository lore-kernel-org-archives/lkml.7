Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36C0C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 22:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB05F2067B
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 22:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570919716;
	bh=ugcqHNytv2Q3vfS0TJjEYZFf5ZestxPEgi9sk60ciak=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=wmFrUnICPCbOZnGeYLPEfacFMHNQDnuTEEuO/m0pqojKtSRwCn7nq3ZecBT3oFite
	 B+mmvEC2zeiF9abJeqZ67tzPM+jn4UXzjWRF76pBBCFFdUBWqU44q4yIPn2fS6220X
	 nqbi1IOUo9erhBQEQzGwAYj2ScF27S4LtGo7N3Js=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbfJLWfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 18:35:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727188AbfJLWfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 18:35:05 -0400
Subject: Re: [GIT PULL] x86 license updates
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570919705;
        bh=ugcqHNytv2Q3vfS0TJjEYZFf5ZestxPEgi9sk60ciak=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hY2ikw9PDtpieYzCi/TdvtCtI2PvoeJx7bLaFF8CAbkvi87sioeGqymqvmxs6JkSX
         cuJsSGtdX5pwd0Hz80PCNgV3+vZd6JJbkdFOPtJQcXwuPmkMx5CXQUvvBPmpXWzXz0
         sYlVb/slu9lb77qhIYk8viLFgHOaXBIfovjnHXT8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191012115257.GA95775@gmail.com>
References: <20191012115257.GA95775@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191012115257.GA95775@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 core-urgent-for-linus
X-PR-Tracked-Commit-Id: 6184488a19be96d89cb6c36fb4bc277198309484
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e9ec3588a9372dfb9b04afcddb199ad9e2be0044
Message-Id: <157091970499.17047.5783303918228667628.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Oct 2019 22:35:04 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Oct 2019 13:52:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e9ec3588a9372dfb9b04afcddb199ad9e2be0044

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
