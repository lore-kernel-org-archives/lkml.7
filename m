Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7C3C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3FB2177E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551897019;
	bh=3aKOEDynyfjmXSTYfyJ8IRyoiGU+JwCvGQfgx32BzO0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ug26i2b6e1jSEH09E3Yb4Tn2R3AYNuYDfWFihIVFjTPjjtpTNnViduTaYWpURMCFW
	 8DfILPHfP0uSewugOb8ajwNlObbDeAPYz7oBr3kFK8rnFWDCAR1vuKEJpUhj2iH7D6
	 PugaV2B3DS4xK2S7XMtoxw/s6rgxeb4/fBEqX48U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfCFSaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:30:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:45826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727226AbfCFSaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:30:15 -0500
Subject: Re: [GIT PULL] x86/alternatives changes for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551897014;
        bh=3aKOEDynyfjmXSTYfyJ8IRyoiGU+JwCvGQfgx32BzO0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=avsSf8uz33Iaz9NEyObuyPSEbEDT8VdSMjKkthaMyKbMIpAGTTjJnxrl9Y10mDWC9
         Wh4l6QS7/TMNP/QiLwx4QvHleq5GS3WE0R6zsYORNMkRkF6DFAslW6w6Hx/GyLLx2j
         3cqblHCXPMy8BEL75CgG5uvOeDhZXEC/SRDf2j/E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190306092211.GA61063@gmail.com>
References: <20190306092211.GA61063@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190306092211.GA61063@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-alternatives-for-linus
X-PR-Tracked-Commit-Id: 093ae8f9a86a974c920b613860f1f7fd5bbd70ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6ea98b4baa1c9089d7a035ebccb993e03d1ac57f
Message-Id: <155189701465.14612.3227505581823090753.pr-tracker-bot@kernel.org>
Date:   Wed, 06 Mar 2019 18:30:14 +0000
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

The pull request you sent on Wed, 6 Mar 2019 10:22:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-alternatives-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6ea98b4baa1c9089d7a035ebccb993e03d1ac57f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
