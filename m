Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144E8C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB14924672
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576610419;
	bh=0OPFf+89XH8UEoLyAOxwk2Vw2t3HB6k5sp4pojbYdMM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0cQwlFgHPHTF+7rIu1wS4VknaEzUKwUpLtuDLehRv4A7dmFpQVa2b4kWz3RZDY8jC
	 SKXgITMi5eo43FDw8zlTxhcz9nCPhIi3z3+1O2KvaVB2pPsC3XYMLAfnf2HBR+0L+P
	 0KPO3OIV9VfW/V6WpfVqvf1KMTWh0drikjNekyO8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbfLQTUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 14:20:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:47114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727036AbfLQTUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 14:20:17 -0500
Subject: Re: [GIT PULL] timer fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576610416;
        bh=0OPFf+89XH8UEoLyAOxwk2Vw2t3HB6k5sp4pojbYdMM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=g/DszB8TT6Gcwo31GKPAsp11WuAblEZG0VLgOfOFifqL4V2xzqEmCSWHzZOZz3uKj
         J5onAfNweIg4tuM0ijJaPRlFAMwqHtluQxL5AkxWAwU4nyqSHTqm4ae5SyAm0ecdjb
         1jiCsD7LMkTaQsaDMavzQHWVmvThmMWQ0bQu3iAE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191217115547.GA68104@gmail.com>
References: <20191217115547.GA68104@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191217115547.GA68104@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-urgent-for-linus
X-PR-Tracked-Commit-Id: e0748539e3d594dd26f0d27a270f14720b22a406
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2abf193275768ac89f5d93eec7bcacb238168151
Message-Id: <157661041651.14288.6729474257548807953.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Dec 2019 19:20:16 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 17 Dec 2019 12:55:47 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2abf193275768ac89f5d93eec7bcacb238168151

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
