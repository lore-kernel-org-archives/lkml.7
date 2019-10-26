Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA45C47E49
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 20:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB2721D80
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 20:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572122708;
	bh=1yEfWkUQ81QReqjCe5r9WDQC4GCyZWtjgcW+Z+C0efg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=g9qBUTpTpblrNJeKe7n/6W2wWT2NmwYTxpTCIhX1eRYsEQNVj6XdGN2q2oV9LH06B
	 g0+5LgjFz2L3ep1yj1iuOtkoHknTwNAWHuOk5aIjd/3U6eDwovJ2iVCz1dlaBULJeN
	 6Nb7rkLUnHGi76iALk2p1cyzonUfrGhveBOjag5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfJZUpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 16:45:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbfJZUpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 16:45:07 -0400
Subject: Re: [GIT PULL] Char/Misc driver fix for 5.4-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572122706;
        bh=1yEfWkUQ81QReqjCe5r9WDQC4GCyZWtjgcW+Z+C0efg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZFNrwF49oIbhj4pX8d3DXSGENQjzWEOlKZwFxtWVmRqGYMRKdNTzG1+k3ZyAokjE9
         F13sFiSJPqcnyowThAZLhm859A52gqD2ANf3tIQ64z7dcbvQM0RLY53NvGT6zzSrvh
         Xdw1mLiqsh3eBOH/9WVAgXxt/mILj9PClVkZvxIk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191026181756.GA648966@kroah.com>
References: <20191026181756.GA648966@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191026181756.GA648966@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.4-rc5
X-PR-Tracked-Commit-Id: 45d02f79b539073b76077836871de6b674e36eb4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a03885d596a622e25f655e280a3fcd9e754a37bd
Message-Id: <157212270655.6077.3302201345003286764.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Oct 2019 20:45:06 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 26 Oct 2019 20:17:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.4-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a03885d596a622e25f655e280a3fcd9e754a37bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
