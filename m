Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82619C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C4220869
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574796618;
	bh=byQIi+HbsCOzM+i7IEdMPnB3sn6YrYQJvAezISVV9kA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=d+JZiNUybZF7qobSvHBp6tL93fVoWXPhh5E6BACcaj5uFXpg/+OdJhu8YRqy8Q3Ty
	 wHVrWuCXiAYNzgDceO9lLW0cN02vApDPB35XtF00qWUeX44iAILPeO87549/9Xm/8i
	 QeQaGIyVJr+K2iQQWPuReHRLiWVByUQlT3QDFt9Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfKZTaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 14:30:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:33938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbfKZTaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 14:30:13 -0500
Subject: Re: [GIT PULL] x86/entry changes for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574796612;
        bh=byQIi+HbsCOzM+i7IEdMPnB3sn6YrYQJvAezISVV9kA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GSefI8SYIEC3VxYtXd6bQ39IoYTGnmN5L/bb2LyjkYch1s+e1ScSGKBTETfAR5aCF
         1uRhRYAFsnCQH+tkfGbm0dJLasGnKCRsrYCGx3yNtAQPBo5UofsI2sJtADKSO1Nwgk
         SYfbHwlnGNeAppmNX/NpAPFAKZ9PSLNoobI/B0HU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125134922.GA5532@gmail.com>
References: <20191125134922.GA5532@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125134922.GA5532@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-for-linus
X-PR-Tracked-Commit-Id: f53e2cd0b8ab7d9e390414470bdbd830f660133f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cd4771f7709211082cbc41dc1f5b2be774ef1604
Message-Id: <157479661251.2359.2999823608035580617.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Nov 2019 19:30:12 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 14:49:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cd4771f7709211082cbc41dc1f5b2be774ef1604

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
