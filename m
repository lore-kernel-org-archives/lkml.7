Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A042EC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 02:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B4C2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 02:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552012241;
	bh=QzKc8DQK/MBMnrEgQGyMXtQkDOxvn5GZeR41XeuOU5I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=f/VHyjbui60nUMB8nKA3eliyzmTtrNys3dnXHB3jaoYQDai8J0Yw5WJFX+W3FQp67
	 LE16M63hE53dWrcDRb2imH2COAicejeGvzadeE6ThQc19H5l9Rq1KWu7Jp5N50NTLJ
	 cTPqYrIVDRRDnT77AoDiskEGBT+dx9Cm8pojjMgc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfCHCaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 21:30:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:39718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbfCHCaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 21:30:19 -0500
Subject: Re: [GIT PULL] x86/kdump changes for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552012218;
        bh=QzKc8DQK/MBMnrEgQGyMXtQkDOxvn5GZeR41XeuOU5I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OJ9a8N2G/SIWYYLis5hGwQZ0tOpfRYFSspMUZjW8tkyEDW9Z1O9E7HXHIS0e0TY6m
         Pqm8Q5ttR6RDJpLsY4to3HYeDLKV6ZeaBwcPwMdFlmaNAotCQgJCsfMFg5NjLOO1Oi
         YSKt4ojjXPuDIMxux4PSgw8EZcPz7biYMl5wP9cY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190307192305.GA33711@gmail.com>
References: <20190307192305.GA33711@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190307192305.GA33711@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-kdump-for-linus
X-PR-Tracked-Commit-Id: f263245a0ce2c4e23b89a58fa5f7dfc048e11929
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d2cb698f6896d4b3fc6794142a902d2647f7dbae
Message-Id: <155201221860.3231.12941507867963462063.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Mar 2019 02:30:18 +0000
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

The pull request you sent on Thu, 7 Mar 2019 20:23:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-kdump-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d2cb698f6896d4b3fc6794142a902d2647f7dbae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
