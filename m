Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9934FC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 21:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB86320828
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 21:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567718111;
	bh=d/AVMf7pfDuxogO1xOwvshN2LzqSe270HoxEsmenE8s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=yoY7Qt/1AEjVJe6kc7oWL5JEd6vFKvg3ERev6Rpvzx8PlFbPN3HdFwtC/EhLRGPVl
	 +N7PBXNi1Cave22glymW75rBMkYabPaln3Mc0pXVGn4EnZ9HDOcB5NkVMTkLr8YWa0
	 1m+4OxUR/2SBGx5wznpe03/GolU45Bly7TRiyQYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391797AbfIEVPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 17:15:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733193AbfIEVPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 17:15:07 -0400
Subject: Re: [GIT PULL] x86 fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567718107;
        bh=d/AVMf7pfDuxogO1xOwvshN2LzqSe270HoxEsmenE8s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VN9NCfTDA2X75/5ZF53/4YuE31MbwxtHW0syUMFXOVp277OI1e+ktO7S0cgoTRiPK
         Yj98D8l1CFqJseb+GuIBkFLG8JR2A2Z92ISHcCko/yO9vdF7/8IY/MRRMwkNjhNkvH
         Axe/nbiM7ZykhqUsLAhEDFS3JKQX7gXMRaR0EEZU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190905080719.GA46542@gmail.com>
References: <20190905080719.GA46542@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190905080719.GA46542@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: 4030b4c585c41eeefec7bd20ce3d0e100a0f2e4d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 19e4147a04a43d210dbacda76e0988f90bb0ba45
Message-Id: <156771810713.8025.4947658068071161170.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Sep 2019 21:15:07 +0000
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

The pull request you sent on Thu, 5 Sep 2019 10:07:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/19e4147a04a43d210dbacda76e0988f90bb0ba45

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
