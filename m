Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E6BC31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 18:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC36217D6
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 18:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564856719;
	bh=LMthmdbM1K76gB+Mn9DMZMCihNDZ358uu0aC5W5rKXU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=DH9UWhW+AyDlWOJ+kTg79gf8InOmDjwF2eW3sb324tY7PfKv8eN6LubuXKL8PB+CA
	 FNIirK0rmaiOgmiho+dweq06+6Zc1eHx7wLzPv/0tCvRZgiXr8tTK8uKN77cp/DXag
	 77ZLK6yCG0WvAuGAQNL5fuEfA0I9fL8lNrMtLyIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbfHCSZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 14:25:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728701AbfHCSZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 14:25:12 -0400
Subject: Re: [GIT pull] timers/urgent for 5.3-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564856711;
        bh=LMthmdbM1K76gB+Mn9DMZMCihNDZ358uu0aC5W5rKXU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=saBVH2y5i/f6Jyh7+Ym2qnPZTTjl5QkQFG5BnyliYXqyre7kUnL9qS8XEHyRKg1ds
         /uvQ4UUxwlZ0emBtvoTDVfc8R7fSyPprDtji8BqYn56pOT/3jsKQjaPKfxiTn7JRSK
         7h6Y4bmKHrSV1A1vwxrcM2C3ve6Z4G5rCBdiVN/g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156485021326.28964.11252649669292370361.tglx@nanos.tec.linutronix.de>
References: <156485021326.28964.12573754498454150320.tglx@nanos.tec.linutronix.de>
 <156485021326.28964.11252649669292370361.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156485021326.28964.11252649669292370361.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-urgent-for-linus
X-PR-Tracked-Commit-Id: 33a58980ff3cc5dbf0bb1b325746ac69223eda0b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0432a0a066b05361b6d4d26522233c3c76c9e5da
Message-Id: <156485671141.25774.6566940390178800355.pr-tracker-bot@kernel.org>
Date:   Sat, 03 Aug 2019 18:25:11 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 03 Aug 2019 16:36:53 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0432a0a066b05361b6d4d26522233c3c76c9e5da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
