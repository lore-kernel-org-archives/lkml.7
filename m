Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57730C2D0C3
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 18:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2078C20665
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 18:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576954512;
	bh=xTaS9ljGbkneGH+HxVh7wkuPZcg4MWFDbvxKjzmzSpA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=V9vc3oCjHgsgUQjdsdk2QTJcJ4XLgrud3E2s0Vj01hCp6mam0qGUxxP8JgMrw5Bht
	 Lr4PZcRyk+nTkeqSgnhp39HKuDCyuk1yEzAblVS4+2p4Z4/N1IeveqeERqhRdbylRM
	 XcQKJ9FYf7ZYtQEwcBsMCf3P53shXLJVJc+tKZ3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfLUSzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 13:55:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:39172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbfLUSzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 13:55:10 -0500
Subject: Re: [GIT PULL] Kbuild fixes for v5.5-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576954509;
        bh=xTaS9ljGbkneGH+HxVh7wkuPZcg4MWFDbvxKjzmzSpA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zeGiwKNRzfe6WdqxMxtNfnFHKUKeBXIcj0645+XFsKvsOTYGGtu1zqPNqrFn0qUkQ
         V62XOIPkaVFBRiU2FLLRbS94kr8qx9qpiitJFBGhgqPl8kEEvBPMvS0lkprvdHIXbt
         71bcfVzFlxQ6wzgTrIGXWZ+JIeeU1JlviJ+oGpTA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNAQG3Tp=q8XWABfopHgQ8nTa2OhKf=msy0m6SbgcyS67OQ@mail.gmail.com>
References: <CAK7LNAQG3Tp=q8XWABfopHgQ8nTa2OhKf=msy0m6SbgcyS67OQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNAQG3Tp=q8XWABfopHgQ8nTa2OhKf=msy0m6SbgcyS67OQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
 tags/kbuild-fixes-v5.5
X-PR-Tracked-Commit-Id: 28f94a44298c99c0db85539874b62f21d94fcaa7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6c1c79a5f4eead27465d4d1d97ce230163772a78
Message-Id: <157695450983.26122.3551174595058090770.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Dec 2019 18:55:09 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 22 Dec 2019 00:37:03 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6c1c79a5f4eead27465d4d1d97ce230163772a78

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
