Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD1DC606CF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 01:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 556AB217F4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 01:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562636710;
	bh=oqN/JhEGISVX09s0AuKpX7cjRWniQ3KynGD9u/JKYiA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=aDK+yIb4I6lZ2jgM+CeLA5PZiwksPpVzfo+kT895vXblpN5FA+JaujK+fwtHEUZr1
	 yJTTtP2X/LULYeUmRtg/bSsokh0WrQcKrrBfWH6x8jFsHZ8cRo/tntGQktrG4wRKKK
	 kzIni7kMQkP2FnoYtLcAD3MGqPMOh4UmyGz7wNAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfGIBpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 21:45:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727167AbfGIBpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 21:45:07 -0400
Subject: Re: [GIT PULL] x86/asm changes for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562636707;
        bh=oqN/JhEGISVX09s0AuKpX7cjRWniQ3KynGD9u/JKYiA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VOlf0IARERtMvud2vv4Lnyc8KEIQ8gsXyEriCO9fst1LkW6M9JcObNfR7gkY9gIGR
         PI16cugIKE+MsniJWkNighZgtV2UA480BKqiFCjST4Ws0eHdbwo0kcwTcwLNuN+Gch
         OJBuQc23qI0/lKa2fzakO4urOeD4G1LWiy8gjtxE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190708122247.GA57237@gmail.com>
References: <20190708122247.GA57237@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190708122247.GA57237@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-for-linus
X-PR-Tracked-Commit-Id: 7457c0da024b181a9143988d740001f9bc98698d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a1aab6f3d295f078c008893ee7fa2c011626c46f
Message-Id: <156263670726.17382.8448182923476237899.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 01:45:07 +0000
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

The pull request you sent on Mon, 8 Jul 2019 14:22:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a1aab6f3d295f078c008893ee7fa2c011626c46f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
