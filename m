Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3F0C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 21:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE6E222C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 21:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573419618;
	bh=lYsgtyyzhtyyTVQrIAZ3Dy/ONZpi5L0c6PYcGD/UNVA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=bk7/r5dg89k0S6lENnC8IPBMyItR0InZ+2YzbPdgitZBz2SWIDcMhsFhcEEAzmq9G
	 hh1Riz+U5aN7ZTJBpRfiwoCELbxaoUxYdZC0HyyGpBoJrzRWz0hZtyUd/wjPw1I+oC
	 m+iSrAqnBLeNPUFuKgO9DvI8yu+WJ3xbgeS+dUzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfKJVAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 16:00:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:46564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727164AbfKJVAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 16:00:12 -0500
Subject: Re: [GIT pull] sched/urgent for v5.4-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573419611;
        bh=lYsgtyyzhtyyTVQrIAZ3Dy/ONZpi5L0c6PYcGD/UNVA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DnbSZvSXtsVRBC/nAFF7Yczl+UEgFgydM4oQeovSg1K0aENqsqoAfL62OadqydvHQ
         z4ALzdP7eR4+oQEuWKMBNKEWrurAUtMyHKhlx66/juZz9bA1VRXRGV44cqQs6LJLeL
         3Zv4rHeaugrCnvh+sGAlHDHHGVOGz4dRhj9Fpacw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <157338131324.14789.7419190771030534276.tglx@nanos.tec.linutronix.de>
References: <157338131323.14789.2179255265964358886.tglx@nanos.tec.linutronix.de>
 <157338131324.14789.7419190771030534276.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <157338131324.14789.7419190771030534276.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-urgent-for-linus
X-PR-Tracked-Commit-Id: 6e2df0581f569038719cf2bc2b3baa3fcc83cab4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 81388c2b3fb16972c699aab8a4f80ba85d0f9360
Message-Id: <157341961163.30887.2718920238137478640.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Nov 2019 21:00:11 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Nov 2019 10:21:53 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/81388c2b3fb16972c699aab8a4f80ba85d0f9360

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
