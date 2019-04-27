Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94478C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 18:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C87D208CA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 18:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556390706;
	bh=QJ/hp6cl5x3tmgG/NjFXIpcnlvWTEn29b9ekkvZNXQ4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=jSF7BYh1wKnX3xYhqes6KuN7Ase8N7V9Hp9mH09RJBKTbcSbyBfStTf3tBbdwIFA3
	 mnwhQ29py1ZSkl36kH5vX/L3YrZkoXsGz4isITu5RAQD/yhqfkeR5vzc+6tYcoaKU9
	 dMHfTcmxl4r2noR7AolGcwqEn51Zcc3oDCYAU67s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfD0SpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 14:45:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:49718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbfD0SpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 14:45:04 -0400
Subject: Re: [GIT PULL] scheduler fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556390703;
        bh=QJ/hp6cl5x3tmgG/NjFXIpcnlvWTEn29b9ekkvZNXQ4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=m6z+EmfGUKyIUTCzsgIzLfezNp8yQ6e4xhDuB2e2ZHgs8OpOEEvcwneaoJl++jCcr
         1BkCH5pbs8IqIHkvGrIyN4cLgXfHJZVvkoD7a78V+Uede6zLkclmVnpeIyORKf8b2V
         Y7RvaI7PbR8Tj+6vlMyI/eim8Ke0UcIqn9Ljqoy8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190427143926.GA56189@gmail.com>
References: <20190427143926.GA56189@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190427143926.GA56189@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-urgent-for-linus
X-PR-Tracked-Commit-Id: a860fa7b96e1a1c974556327aa1aee852d434c21
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 15d4e26b816a39f2d1ba40bacb8e8ecf8884477c
Message-Id: <155639070385.28176.15378072188476988485.pr-tracker-bot@kernel.org>
Date:   Sat, 27 Apr 2019 18:45:03 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 27 Apr 2019 16:39:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/15d4e26b816a39f2d1ba40bacb8e8ecf8884477c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
