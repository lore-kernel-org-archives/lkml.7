Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913F1C43215
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 16:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A2F92075E
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 16:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574008508;
	bh=x9Uwa43i7faAYOn78cswT+M2Jz0cWWb1rgtsuTk1Gj0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=bh2p0L9VhYCY8DwHv6RmAO/9DWfovxkavEpDQX8/jaiwE9qR+KN1XxdBzep3o3512
	 s8uSXRavyTNZ2Yn9rINdW6akIdKZip0WLngU7Mkv3HZCnEVWz08PLJ8xOf6TsFPMV2
	 t5/FS/dnY19cAiYpTX2grawhuiyQDRs7czN+YN6I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfKQQfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 11:35:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:41074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbfKQQfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 11:35:05 -0500
Subject: Re: [GIT PULL v2] scheduler fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574008505;
        bh=x9Uwa43i7faAYOn78cswT+M2Jz0cWWb1rgtsuTk1Gj0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pPmaXFrbVagC3j/uAJgjuLVZ0crl0GPSSqdBoGL7N5M22prDLIf4V1zQIYNaI3lEV
         yGE2aVfrtTsYvasX7nL2qzcETm88w+omey1LEnPw/RBo3c6UOJbohq6wFsromRBIDW
         9Y5bxMamYQ3vv7ofWL3w1h8OUVUZ9V0l2qZbq7Ls=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191117104112.GB56088@gmail.com>
References: <20191116213742.GA7450@gmail.com>
 <ab6f2b5a-57f0-6723-c62f-91a8ce6eddac@arm.com>
 <CAHk-=wiFvP0idYrvWVtEwt6FM9jZ9TRF5yQhT1-X3vx31GRHTg@mail.gmail.com>
 <20191117104112.GB56088@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191117104112.GB56088@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-urgent-for-linus
X-PR-Tracked-Commit-Id: 6e1ff0773f49c7d38e8b4a9df598def6afb9f415
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cbb104f91dfec8ae5bc67ff6dc67b824330a0919
Message-Id: <157400850524.10370.1888326033412991098.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Nov 2019 16:35:05 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 Nov 2019 11:41:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cbb104f91dfec8ae5bc67ff6dc67b824330a0919

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
