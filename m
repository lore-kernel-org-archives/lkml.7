Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EDDC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 11:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A651214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 11:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561808721;
	bh=T17d8BzSJlirUWyUDKwoG1YMHgJYZ8Wp+xCSXMl2jFA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=t8A1Br6SwqF9ul0sBqScc+kxcug6m6l3ADTdpX1JqCM+BneOgcwnPYz12ukRH1QWj
	 lgkuD03uBpQoH6Cn8LBYl5xV4qQrUC7pPn6cW8hH6ecgIqWsDED2KTz/wpwkaVcHrE
	 YZP+Y0kug/ztcokDIaVsYJHRjXxDtN053P+MXgfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfF2LpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 07:45:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727080AbfF2LpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 07:45:08 -0400
Subject: Re: [GIT PULL] x86 fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561808707;
        bh=T17d8BzSJlirUWyUDKwoG1YMHgJYZ8Wp+xCSXMl2jFA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ncbkCu7gWTMOtQnkFbt67Gzsi0UNq1Sznrf7gAHtxx4Aj/s1TwtBhTcmlsmDJCZgh
         7PdOr9gvOCM+x4k4s+LJzQu1g5ADEcphpzoTnBT1uDXBEPw8jij/a9zHYCLBrVVOr2
         06mNXpG2IHhHTT9Nvaxx9dbt+gEFBhErIfmnmPpA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190629091407.GA104355@gmail.com>
References: <20190629091407.GA104355@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190629091407.GA104355@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: ae6a45a0868986f69039a2150d3b2b9ca294c378
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 728254541ebcc7fee869c3c4c3f36f96be791edb
Message-Id: <156180870778.30344.17530150555963607105.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Jun 2019 11:45:07 +0000
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

The pull request you sent on Sat, 29 Jun 2019 11:14:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/728254541ebcc7fee869c3c4c3f36f96be791edb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
