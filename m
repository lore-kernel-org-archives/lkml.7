Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9FFC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 02:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29A820851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 02:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552012245;
	bh=NHg1i7HETl8ePrra3N3j2Zge8MUF20auc5czPwEtJAo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=y8NGdog+8ChV8W0//Vqj99YR6tMM/oPbyEVWh+rNzIM3hkPKtGFVQTnPn0BekY+jO
	 7LsRikO3MdDQHHLmfot97bcTdqokxbN51WZv7oDzJlYM0TdGLHWu2AOfw+Q6zMAHyk
	 seZFPKXkRSfB4uY/fBu1Fmj6ed5O8sYr9mc1qX+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfCHCao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 21:30:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:39636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfCHCaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 21:30:17 -0500
Subject: Re: [GIT PULL] x86/cleanups for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552012216;
        bh=NHg1i7HETl8ePrra3N3j2Zge8MUF20auc5czPwEtJAo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2sdV3edFVcVSaTnD/2mgHXYKxkF43inYaTwSCe87Mc3aQWOr/ptNIhNpoOKnkkiwj
         Mgk0MUDOXZMBC28E3isoFMszGcQeI7raOwSMEtzZUmsD5YGS9EBtgMZ57QedHDxmw/
         rZf36etnqQ9xCFNBZ35krDmlPUgoYweNZWN8pecw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190307171709.GA85168@gmail.com>
References: <20190307171709.GA85168@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190307171709.GA85168@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-cleanups-for-linus
X-PR-Tracked-Commit-Id: 2e7614c0736de93c8796bb2d58debb8871a59db8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bcd49c3dd172c38e14faf151adca63c8db4c9557
Message-Id: <155201221693.3231.9248885442714187848.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Mar 2019 02:30:16 +0000
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

The pull request you sent on Thu, 7 Mar 2019 18:17:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bcd49c3dd172c38e14faf151adca63c8db4c9557

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
