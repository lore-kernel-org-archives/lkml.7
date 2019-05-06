Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6F3C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7495820B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557186005;
	bh=YxVnyWFf/s9s2/ogZuPEUHHSBB4NhIOigoUf/negIr4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=I1X2qlndd+XvsEVl3bbRohRaIbPCGuvSwYII2cgJ72Qa79+n185/HPLx2nsAC5REU
	 YqMToUYEU+SsL0hyeS3VQlsv7QAtKcA2opjNhe0AQR8pQiJuWG2OyD7QIDvS4Ed6OB
	 BqZ9s/qj3y1Rnhhx8nuXMHAzUJbAQpBR4WCR9PyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfEFXkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 19:40:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbfEFXkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 19:40:04 -0400
Subject: Re: [GIT PULL] core/mm changes for v5.2: Unify TLB flushing across
 architectures
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557186003;
        bh=YxVnyWFf/s9s2/ogZuPEUHHSBB4NhIOigoUf/negIr4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1vUAbk+op+4s5zB1/exUu4YX3q6zAAmJsFSKuesVeX/VCCYPMgyi7lMxeT2IHz8Xb
         KhErkLG68CApMhmCZmc4FohppR+NO4V7/PZGxXbLpvdzB+TsfTRv/MAXwD853ja+e/
         d8cPzXDKLrIZpwjedr1gHE/li8QgCA4VPPLJHtqs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506065746.GA105888@gmail.com>
References: <20190506065746.GA105888@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506065746.GA105888@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-mm-for-linus
X-PR-Tracked-Commit-Id: f6c6010a07734103a31faa0cc977641b358c45b0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 171c2bcbcb58a6699dad64d0c0b615af4f6ecb74
Message-Id: <155718600354.9113.10323381034050372571.pr-tracker-bot@kernel.org>
Date:   Mon, 06 May 2019 23:40:03 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 08:57:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-mm-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/171c2bcbcb58a6699dad64d0c0b615af4f6ecb74

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
