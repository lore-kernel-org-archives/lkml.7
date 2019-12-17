Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D3DC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C2021775
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576610422;
	bh=hsI+K00C/XUXdUZMCwdfw50jpkue20JInqsCtPp4c/A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=vhEKljn7WHm6Rth1sq0/KStXkIsvvzgRpbDS6OXdiOZKSzLSb9a9OTbKoqiZJLjJx
	 LtadmY4innBDDWJ7e9xQtNzV/b0N0vVNP8NqmFZZCPaTAfc+GNYQ7Pc3HSCaCuK2ji
	 VfZf2NPX1JVG6I3CtctJmOZKV0JijU9dcgMaeyZw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfLQTUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 14:20:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:47138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727896AbfLQTUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 14:20:17 -0500
Subject: Re: [GIT PULL] x86 fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576610417;
        bh=hsI+K00C/XUXdUZMCwdfw50jpkue20JInqsCtPp4c/A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GXKMCBNg4OB1HnvV695XfYUFqRr6HrOJiKKulGrWXjRr+cR/jDO/Yf/L2s7fM7YIu
         I2BJ7vF9oKdCmFWWpI792kEZnQ0E2RIKnn0dG+NB8D/3wEfo8qi8ef9PbnLwT0pOZk
         gzVukMtHjO186VOy19zDhDcf/wR6ybO7m6YlyX6o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191217115835.GA100231@gmail.com>
References: <20191217115835.GA100231@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191217115835.GA100231@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: af164898482817a1d487964b68f3c21bae7a1beb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9065e0636036e4f8a6f65f9c34ed384e4b776273
Message-Id: <157661041717.14288.13756738899830131468.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Dec 2019 19:20:17 +0000
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

The pull request you sent on Tue, 17 Dec 2019 12:58:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9065e0636036e4f8a6f65f9c34ed384e4b776273

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
