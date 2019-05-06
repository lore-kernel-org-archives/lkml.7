Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C754C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB5B2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557186101;
	bh=3kL0VKEB1fJor6VwpBY91mdUetauqEeCY2sc4RE/szo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=oGyYUorFuFnz6XxgS9F6lTVaCU2aMsnMpZGsQDrBJNRTBpOtPGnsMFD7ZfBCnevnR
	 1PSBLrVCQ0jj2Dh/2qGspik/fLDcMRK1fib/Cr8Ai8mdu3CGPfpZ2lhWQ/xSVGQvMS
	 Jj9xnP2pi9xnCFEsESaFUXJpJZSNVd0y28+O8tnA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfEFXkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 19:40:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbfEFXkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 19:40:06 -0400
Subject: Re: [GIT PULL] core/speculation updates for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557186005;
        bh=3kL0VKEB1fJor6VwpBY91mdUetauqEeCY2sc4RE/szo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0FjA/qtuHu6nkt/ubyfVOpTyRHeTECwI5/RUxvh/g+ZXPSZQqc1EftrGq5c0extG0
         0InlLj79m/NhT+dUVeUO4vT5b+dmCO/dIYM21S7kxE6Us+TiCeGwlLrLWPw3DNezYI
         rw+tPqfZoEYJg7CSe/CM9kYcMGDblGeMNO5CLVMk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506080335.GA25701@gmail.com>
References: <20190506080335.GA25701@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506080335.GA25701@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 core-speculation-for-linus
X-PR-Tracked-Commit-Id: 0336e04a6520bdaefdb0769d2a70084fa52e81ed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0a499fc5c37e6db096969a83534fd98a2bf2b36c
Message-Id: <155718600565.9113.4983156691207788741.pr-tracker-bot@kernel.org>
Date:   Mon, 06 May 2019 23:40:05 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Borislav Petkov <bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 10:03:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-speculation-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0a499fc5c37e6db096969a83534fd98a2bf2b36c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
