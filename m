Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E37C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 23:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48012146E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 23:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569538826;
	bh=rekAVS77A29RYibuAXzRrjCxmuNFHOltY8RnRfZqxeo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=yvHRpu2G3SyFBFYkcHJaBfnh2ubBVBlTiVF+e3PczsADadprzCXyvoFI1ZVZ6m2hw
	 Rs2jfWxaPZI2DVKwX//6+7m7vr9klLCssQgiyjv63j+VhifM8cOAMSlyhieQB2DnYE
	 b1uZ/UD8v6oFX9FlASrB0oLrmuNLGVQT3SSuEX40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbfIZXA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 19:00:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728705AbfIZXAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 19:00:25 -0400
Subject: Re: [GIT PULL] perf updates
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569538825;
        bh=rekAVS77A29RYibuAXzRrjCxmuNFHOltY8RnRfZqxeo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=J5RW93KChy9Go6kkzDtkOO1ZSPaLYmv4wQKs4l0aLDOPcwt/H3vOjla1QQy/r1p3i
         x8XCtcGotJ5sXiI3JjLSCCR+BeEty8CcwYxA3dibCYJAbyLqT+Qp0cTGsUpRUIqtv9
         8J1zpAEVTcQkTimgGw8dXC169VdWpQvK09tnjGA8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190926200622.GA127468@gmail.com>
References: <20190926200622.GA127468@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190926200622.GA127468@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: 26acf400d2dcc72c7e713e1f55db47ad92010cc2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a7b7b772bb4abaa4b2d9df67b50bf7208203da82
Message-Id: <156953882525.9540.12160176987346575751.pr-tracker-bot@kernel.org>
Date:   Thu, 26 Sep 2019 23:00:25 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 26 Sep 2019 22:06:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a7b7b772bb4abaa4b2d9df67b50bf7208203da82

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
