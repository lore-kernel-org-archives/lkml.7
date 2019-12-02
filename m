Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C34C43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 04:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203632231B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 04:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575261618;
	bh=sreJi2OTxr2OsSIOMiSkF5pqs/q/JH7RL6y+dn7rfHg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=X/SOFPYlU+2/BaVsSO0E6+K+n7QynIXhB2dPrSDD77renRrnlCiybYY1yavFaQOMO
	 H+OtxXwHtYxj2o87qktPDYe/NuRA3KY+DWghNwH2jEUYi0EHYHLg6bUmfsFDEe6CfP
	 uidrYBe9FO7Q9oG6TiwKqSYOXkm51np2AuiSX1KM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfLBEkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 23:40:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:53216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727308AbfLBEkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 23:40:16 -0500
Subject: Re: [GIT PULL] x86 fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575261616;
        bh=sreJi2OTxr2OsSIOMiSkF5pqs/q/JH7RL6y+dn7rfHg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=eONshp7WcAsO5ufEXsxhMzYd8cfy8jMw1TyPOenUwkHZvmfsU0mHNUdYFioBPaIH2
         jTIVN6yVnx5QTuskJ+FfVNYlQ6oo6r5L+2+GdXzjthbsQWDgQxmSv9B4SDVtM9PbLy
         6Hcj8K3Wl2py0Zn7dzeYO6FUYUkYsZt5zRlbmcTk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191201222208.GA109470@gmail.com>
References: <20191201222208.GA109470@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191201222208.GA109470@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: 91298f1a302dad0f0f630413c812818636faa8a0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e5b3fc125d768eacd73bb4dc5019f0ce95635af4
Message-Id: <157526161638.3812.5119508132122819100.pr-tracker-bot@kernel.org>
Date:   Mon, 02 Dec 2019 04:40:16 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 1 Dec 2019 23:22:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e5b3fc125d768eacd73bb4dc5019f0ce95635af4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
