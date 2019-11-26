Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA194C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DD220835
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574796646;
	bh=UgMaUYoIK8dPAKJto5xGhqRewgw61BkbIL0aadTaOFs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kGwckDqClq8pX5rNqEa0zlu65zJbktMB5+ZWOEUYSvo5gnkZYRT3pasnoEQqb0IJb
	 GaOtuEZI4rwpRXKFBEQxd50JtS6wrM7No9M2H3PTlhB9WSrd5Gn3GB+fif7hi9KlhP
	 RSWwy1HyBvdRNAp/Kpy6/P45dIEjui7lFKMNdWU0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfKZTap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 14:30:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:34076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbfKZTaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 14:30:18 -0500
Subject: Re: [GIT PULL] x86/mm changes for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574796617;
        bh=UgMaUYoIK8dPAKJto5xGhqRewgw61BkbIL0aadTaOFs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0yVqswPoeEuojqa3q3EaPYmJoh47gUgesawsjlhOt6lZC91c5akyOZHHPjQExAa2y
         Uo15jXbLl77lESIFu0GVjBMtatKIBTZnZVCNtk/btmvOBzvfP6JKPwpFk0g43YPNOd
         zwPqjdQoeT44j7J1LgcxPOfPEZflLIjKmftTdZUc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125142130.GA25523@gmail.com>
References: <20191125142130.GA25523@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125142130.GA25523@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-for-linus
X-PR-Tracked-Commit-Id: 7f264dab5b60343358e788d4c939c166c22ea4a2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c134b198daa81cb689f881dcf2900061914085a
Message-Id: <157479661767.2359.11161708196018142777.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Nov 2019 19:30:17 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 15:21:30 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c134b198daa81cb689f881dcf2900061914085a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
