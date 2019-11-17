Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86933C43215
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 00:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA4120815
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 00:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573950932;
	bh=7ew15bySSGAHoCTsDKktwkw5pd2lLQljbvVuf9XqWII=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=m8q59olCbOPN7Potz9bVag+uviHLIubbAsX0Pk/d2hDf6fjD/Sl71FZIWs6FVnEAw
	 HinaKncSeDdpdSHir54JnGFuHY7Pemt+U2RDQD0uOZAbSU+ltXFTp6L0l8Ese8H8v8
	 FGUq1zI3pZ6TK1/+06RdwHr3qDZKlj1UZt469lfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfKQAfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 19:35:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:52988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727677AbfKQAfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 19:35:06 -0500
Subject: Re: [GIT PULL] x86 fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573950906;
        bh=7ew15bySSGAHoCTsDKktwkw5pd2lLQljbvVuf9XqWII=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=H7on4DFq57ZQtZqplKpgVZT+ez+WEnZCUwwoDTEP2q69uHPzTMuwzoEpTK88DwHAU
         OpUsY8g3N8pxhriP2VSCMyE9S678yIDrMt6Bm0GD3IMIzKMjZeXjnlNRpwtEc6yVJc
         KnLuTgPdGxayY7cQXbSFMIUJxFxMrbj38a0b/Pjk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191116214243.GA81282@gmail.com>
References: <20191116214243.GA81282@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191116214243.GA81282@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: c8eafe1495303bfd0eedaa8156b1ee9082ee9642
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fe30021c36fbfb71d6ff25a424342149e58bba52
Message-Id: <157395090607.15664.9418362550444247934.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Nov 2019 00:35:06 +0000
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

The pull request you sent on Sat, 16 Nov 2019 22:42:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fe30021c36fbfb71d6ff25a424342149e58bba52

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
