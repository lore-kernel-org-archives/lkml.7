Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0046AC04AB3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 02:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C583A2183F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 02:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557456003;
	bh=gwWdGm+lzGwS6EDLPFlG0owva6ZzrylLJimFAezPCh4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mpsLwj+yO23LxIQAmlqMXcFDvABSQ2TiWmyke9SLCJKkzk//8QNz1Hy/Ev8ngqVI5
	 NJkq203wX/W4czWCwHp56NFxBfIBZKS4S2COJ/1j0ixtywI/DitQyPcIU4/UK9HZb+
	 Erjf8bpxhKjPuVYznUW6bidGw4/KfnR2np0cwPSc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfEJCkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 22:40:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbfEJCkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 22:40:02 -0400
Subject: Re: [git pull] vfs.git braino fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557456002;
        bh=gwWdGm+lzGwS6EDLPFlG0owva6ZzrylLJimFAezPCh4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0fwkl7dH3wgkNAKMM5SVTPIpcZM0t5YwSQGD+hgq714tjlPqM9bsWoJeZOEZdSlf1
         /Bjvhcr67YiD4r18AnmivwP/8IM056k+QG8WyZhmXZQucccp0W/gwFGFVldewEPGsU
         XGVaNylsN62CzcFvxLViV8D7yU+uH/6PkmbCRTbo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190510023333.GS23075@ZenIV.linux.org.uk>
References: <20190510023333.GS23075@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190510023333.GS23075@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: 05883eee857eab4693e7d13ebab06716475c5754
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8ea5b2abd07e2280a332bd9c1a7f4dd15b9b6c13
Message-Id: <155745600207.30349.746499813986574941.pr-tracker-bot@kernel.org>
Date:   Fri, 10 May 2019 02:40:02 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 May 2019 03:33:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8ea5b2abd07e2280a332bd9c1a7f4dd15b9b6c13

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
