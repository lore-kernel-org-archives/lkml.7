Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C7DC28CC6
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 18:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE482794D
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 18:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559499327;
	bh=LhFAH5+v8SOykJcLeDWBvWHGBPO5D9ujKg3irRywv5g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=y6Qn34KBOVBkYRqAAVc4zFqWjkYTG5X2ZyCJr+C6bXUFVQr8Nx+X2HNMVXaZ6bv7Q
	 g04APoITZt83gbP7WL60lfaer/6pczd0QIVKd7pLM8lT0MIVu8uPTHps2qPhOC237M
	 LOKJ8WU1dpA7CZSjE3PmEPWfx8hdMTk3lx8CZ7IU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfFBSPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 14:15:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727075AbfFBSPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 14:15:16 -0400
Subject: Re: [GIT PULL] x86 fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559499316;
        bh=LhFAH5+v8SOykJcLeDWBvWHGBPO5D9ujKg3irRywv5g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NvkePuCPOA82MmKMxQqhv8523RnhLWtFjg+YuxgGWfBPlCUCfWHnkX5MvWBRQEhAM
         PMMFVY4rfEu3DXvaXWYS8g5XNsyEfNXBtOVD0EIAAEnez1Qe6oSlS8zhnLZqcjdtq6
         1YUKoW6KuoEakamyI/b33nIRmuwCHqZlZ0DADLpM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190602174442.GA34993@gmail.com>
References: <20190602174442.GA34993@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190602174442.GA34993@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: 2ac44ab608705948564791ce1d15d43ba81a1e38
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7bd1d5edd0160b615ab8748cf94dabcab1fb01cb
Message-Id: <155949931615.4617.2248347050051536322.pr-tracker-bot@kernel.org>
Date:   Sun, 02 Jun 2019 18:15:16 +0000
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

The pull request you sent on Sun, 2 Jun 2019 19:44:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7bd1d5edd0160b615ab8748cf94dabcab1fb01cb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
