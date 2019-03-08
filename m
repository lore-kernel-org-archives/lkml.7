Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E806BC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 02:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9BC1214AE
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 02:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552012217;
	bh=Vypf8OVFNy7oyn7Z/86yVLjSYHnz3UH5Zz3wVN8/aec=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=QfdVL0JX+Zoi6VEGT98hd5UmjGmEt6SS7Jhj8OLbsESnKaZ6nmLuqMew6NGxdwK1D
	 6tTV7mN0ZNd3lQYJl52nA0LdctnUFm9exPSp/LzXhrw1pDjH1PtrUKQ8TalwX3rShC
	 xssnBJ6B7OR8exhJrOnPu7a9iA6epaxiW9SR+KP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfCHCaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 21:30:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:39602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbfCHCaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 21:30:15 -0500
Subject: Re: [GIT PULL] x86/boot changes for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552012215;
        bh=Vypf8OVFNy7oyn7Z/86yVLjSYHnz3UH5Zz3wVN8/aec=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Xy4qBE57Sr+/bcikzwn6XVHYe9gMewWoHABJZkv/FkVxY2bySRLi44qdJWbS5xiHH
         bLgs5+/P/edF4S0Tu+lYyT9qYyM0iktXskk/XG0pyHmJh+shCBpnsR/FE8S3kwlOTi
         6kMoSyEYmzkTW6E7Thll9XNzBu0Yf3+BW3TTNKcI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190307084250.GA122542@gmail.com>
References: <20190307084250.GA122542@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190307084250.GA122542@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-for-linus
X-PR-Tracked-Commit-Id: 6f913de3231e1d70a871135b38219da7810df218
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 37d18565e4c2d691286b88a5a4e70bcf563768f4
Message-Id: <155201221522.3231.9052720536945787547.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Mar 2019 02:30:15 +0000
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

The pull request you sent on Thu, 7 Mar 2019 09:42:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/37d18565e4c2d691286b88a5a4e70bcf563768f4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
