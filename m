Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E186C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708BB2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574796625;
	bh=wTZi+p/R5x6sV8481JeQIu4e1Poga4TAHSSwxmJxACY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0IvC/IGvUqAAFCoROH52sey2425ZOPZ+IaiovTr3CDfqMYfIPUqnGdhSDQStTKX/v
	 dPDozVcnIPQfMy/O5nPtWEJ7cdsm0lRaivHelnTFElaCjNII05zX+fxMK1sdR5Odlm
	 4kCAn28UrEAYuyLMxtfIKGDMFPTq31ewM7UmwPWY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfKZTaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 14:30:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:34054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727127AbfKZTaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 14:30:16 -0500
Subject: Re: [GIT PULL] x86/kdump changes for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574796616;
        bh=wTZi+p/R5x6sV8481JeQIu4e1Poga4TAHSSwxmJxACY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VZUGu6Nzwu4NXIIU3sYjyvGNOQbTCKbCoSHsGwCjm+l6qJKpWttqGerrPT0JInF4s
         ZaTkhn8gw1r6Ls8Evfwsumz4HJn1iUPzpvEkEwygWdZNKG7SHjKm831nJoe9u9lk3N
         BpMQAea0yCuKcsXDSUsMEDAaY3/gB1+2qQuxT3X4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125141651.GA21990@gmail.com>
References: <20191125141651.GA21990@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125141651.GA21990@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-kdump-for-linus
X-PR-Tracked-Commit-Id: 9eff303725da6530b615e9258f696149baa51df6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 24ee25a6da84d83a25d93af52b5fef7407030b20
Message-Id: <157479661639.2359.481820005759349199.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Nov 2019 19:30:16 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 15:16:51 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-kdump-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/24ee25a6da84d83a25d93af52b5fef7407030b20

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
