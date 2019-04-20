Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306BBC282E4
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 01:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0262421855
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 01:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555722606;
	bh=IaPxTf9/I/b3n71r/gnRqeuIZFVa60ZtQU4mry22hu8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Sc6WUqZJJIZbB3+7y06Q6ZGbb7NOGtHef2PsbIZkWqgC5AyQEF+mioqxlVMSMjMp8
	 bDkinRdcxO6DIEUSVYwVNFi7iKzvqV/7xwtrOnsOlCYdy0hN3Iaaw0HfmK8607Ph5x
	 DfWATrg/fPQ9Uybh2YWDyKgMy+Kvf7hdR3fzuXY4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfDTBKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 21:10:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:49562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbfDTBKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 21:10:04 -0400
Subject: Re: [GIT PULL] cgroup fix for v5.1-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555722604;
        bh=IaPxTf9/I/b3n71r/gnRqeuIZFVa60ZtQU4mry22hu8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=avKrYvHyS60C0vtYRlKrzK40PGS1ndiAcbme90WdpRJm7Syfy+UGLLFz5Ob5ylG4Z
         e77R3jEMYFZyvOS6AHkaAJ4GexnQ3m7yrpp4s7/rP6Kuz79nYONOAGaY0u6KK2x0Xc
         D1jwGXBlaeKSZ9C8RatrpV7p2K95JdP1aiXl6k5A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190420002834.GJ374014@devbig004.ftw2.facebook.com>
References: <20190420002834.GJ374014@devbig004.ftw2.facebook.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190420002834.GJ374014@devbig004.ftw2.facebook.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.1-fixes
X-PR-Tracked-Commit-Id: 0fcc4c8c044e117ac126ab6df4138ea9a67fa2a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 371dd432ab39f7bc55d6ec77d63b430285627e04
Message-Id: <155572260418.2444.9252829961339784073.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Apr 2019 01:10:04 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Apr 2019 17:28:34 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/371dd432ab39f7bc55d6ec77d63b430285627e04

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
