Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B07C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 02:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C332081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 02:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552012238;
	bh=C7fpVh7PHO4g5wn5DCgmDqGO+foaMqFGgkeS9wYZiuM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=tkg5Yw9gkpWB0ivQGPBOlm8UeplqVfunUUq9s9auZ5EFIL0i1iYRV5ZsOgBffLvCU
	 3DRHwQ0IIZaqM5qqgCdhU9Jho7RbcKnFKhp8C44Uid43jTJN/frwD4Nd8raf+XgVgg
	 anqzos8Z3urneUXKOCc4HhAqMlMdJxL3n8kNsDBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfCHCaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 21:30:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:39690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbfCHCaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 21:30:18 -0500
Subject: Re: [GIT PULL] x86/fpu changes for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552012217;
        bh=C7fpVh7PHO4g5wn5DCgmDqGO+foaMqFGgkeS9wYZiuM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fzPPizstFEe8lkiqLMFRptCHNSg2Iu8CXcLiWVDzkLOULhMxyh5bKFEriX9aOgvSL
         JM/suh2tTGGnFf7tXYoo1oH3m0+8qjjFHsPjzzrwA6lXZy5fkNdbS+raxVC5Gbvkg1
         KM7UMS9udARvUF5901PFetxL+NhzYucN+iJ0s4Yk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190307183905.GA85249@gmail.com>
References: <20190307183905.GA85249@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190307183905.GA85249@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-for-linus
X-PR-Tracked-Commit-Id: 2f7726f955572e587d5f50fbe9b2deed5334bd90
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35a738fb5fd0fdd1cc7e749e3a45f1876ecd1db8
Message-Id: <155201221778.3231.9504794937825825484.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Mar 2019 02:30:17 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 7 Mar 2019 19:39:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35a738fb5fd0fdd1cc7e749e3a45f1876ecd1db8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
