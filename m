Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE3AC4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 23:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B9F21A4C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 23:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570057220;
	bh=zFuGBNC6txhVkoeDp4cux6kblxAd8DRr6HfvP8l7kHw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Il4NhoVxSPFX3+eJVHjb+Yn3jvFzc3oDStODQfC0j7ApqrWBEJ4Vx8hjLTrS4+MNV
	 TB0GsRyJjfIiuctfd7FJNhAAmtQ0crgSesiRD3T1jtKd7wSMPF2X9MNWqFvYxLgimh
	 92b0dgW9bvH2/tCKwVQTSnSzLT1FKHcti7CgdiVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbfJBXAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 19:00:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727723AbfJBXAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 19:00:18 -0400
Subject: Re: [GIT PULL] timer fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570057217;
        bh=zFuGBNC6txhVkoeDp4cux6kblxAd8DRr6HfvP8l7kHw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=m66Cthv+q25RJeLc2dTBwZisdka4vMnkrRZzs3Txz6zqfmsByZeVPj5D27lb0GQfK
         /V8oUAfBdpbHaWbPnzcA9/+NEewm2koCwLnwrKxOrrLAUv2+y2BfkhpI5M6dUvNsqx
         frtlM8tti3zrm7viTU7yqFtM3XbNnsecBCkWQ6sc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191002220607.GA50607@gmail.com>
References: <20191002220607.GA50607@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191002220607.GA50607@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-urgent-for-linus
X-PR-Tracked-Commit-Id: b9023b91dd020ad7e093baa5122b6968c48cc9e0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5021b9182ee805603e3b180220a929af7bd4b960
Message-Id: <157005721778.372.16726963278854408423.pr-tracker-bot@kernel.org>
Date:   Wed, 02 Oct 2019 23:00:17 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 3 Oct 2019 00:06:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5021b9182ee805603e3b180220a929af7bd4b960

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
