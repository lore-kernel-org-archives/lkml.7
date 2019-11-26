Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C68C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0E820836
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574796643;
	bh=TG58CUHpui7JJpSrGqNtArO9yBcut07cIglTkrYKLCI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ue6CQJ/VJLgbtH1u+dNCGvlECkIF5KX54f9/NIsujCa7Kb1/SofyiBHi73GBJomUb
	 Ao3UNsvOoD28Dw6ZASb1WHmoZf/hMk0aopyoQRRm62pvSWm4nPmRmBR+zM4PRcNE3n
	 mOwOfv5asFa0Vip5UZlPKdy1EpA4l/qTqet3fv+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfKZTam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 14:30:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:34152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727165AbfKZTaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 14:30:19 -0500
Subject: Re: [GIT PULL] x86/platform changes for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574796619;
        bh=TG58CUHpui7JJpSrGqNtArO9yBcut07cIglTkrYKLCI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=I9DjQ5KNIv6MrZdoQ5O8YBmVbO0VsqMI+EKXQ1SA4MgtfCtQOMtP778macasZHB2N
         9SpC+xKo9UQJ8eB788fDgRtmDONn+dGU21i86raOKGSuRQOZp+64UBSX+TCtAwO1iC
         vZrz8w7knq8+GOKncMl/SEZlXzRmHP6zdZ7xbMgM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125143022.GA113303@gmail.com>
References: <20191125143022.GA113303@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125143022.GA113303@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-platform-for-linus
X-PR-Tracked-Commit-Id: 7a56b81c474619fa84c60d07eaa287c8fc33ac3c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: da42761df5ceed2f8b0527bc4c1b2760be45ddb9
Message-Id: <157479661901.2359.14992378658864041575.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Nov 2019 19:30:19 +0000
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

The pull request you sent on Mon, 25 Nov 2019 15:30:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-platform-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/da42761df5ceed2f8b0527bc4c1b2760be45ddb9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
