Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0199C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 19:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC07C206DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 19:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556998505;
	bh=GU4ScgusiOEf/ZF97uHI8n+5Qy72/XWeE3wdUA8cT9c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=a4cZxmF+c/j0U0J4Omrjw9PNUG2h4xO81ivptD8SvYic+6FSe39oZwnikKEYNOeqj
	 K7p5xiHEV4XDnLAdt/lS0BC5iFpKmq6plj6oyjd9qEqSUH+zxa4kKq2f4t8jz3vydH
	 G8i7BP7q7Tre4MizZZlT6t20spw049HrBEudJ7ew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfEDTfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 15:35:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbfEDTfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 15:35:04 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.1-7 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556998503;
        bh=GU4ScgusiOEf/ZF97uHI8n+5Qy72/XWeE3wdUA8cT9c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yrzulXij+iZCIZA+545EmCcBgFn8MDp01m5rbkVe450WlidB6DUFvreY7jR41O+9k
         GZ5sI5HC/qsgrtqUrrPQ/4+WG6Nwa2F/SBcvIPzG+WOr285O1eUz3aijPdXFATrlI1
         VriPk6DHjNYnwCrwxBJ65Usi+ECT4YomFcQ+0Sxc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <877eb6xp1q.fsf@concordia.ellerman.id.au>
References: <877eb6xp1q.fsf@concordia.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <877eb6xp1q.fsf@concordia.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.1-7
X-PR-Tracked-Commit-Id: 12f363511d47f86c49b7766c349989cb33fd61a8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6203838dec05352bc357625b1e9ba0a10d3bca35
Message-Id: <155699850379.8395.12786832199940442596.pr-tracker-bot@kernel.org>
Date:   Sat, 04 May 2019 19:35:03 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        christophe.leroy@c-s.fr, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, segher@kernel.crashing.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 05 May 2019 00:38:41 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.1-7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6203838dec05352bc357625b1e9ba0a10d3bca35

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
