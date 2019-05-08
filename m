Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9D9C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 04:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2ED20850
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 04:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557291335;
	bh=Fa5PEkQkcyCCRgrZVIJYt21TcqWYpRNs1Dqlga3DerU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=lv5gMXNr8OBt0nczxvsOGVvtnyJH5CXQ80lLeD0RY0wYLL2yqSc46YRy1cFt75CmQ
	 4UtFRAE2o/ZKF0McsV9wASxp0YFYz2kr0bExSNmzgmFrbDrADSwh0XBcpf4NUG/aUs
	 HsspUPnY0ayJazMpwBfSB9OZutjd4Rds403v2QCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfEHEze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 00:55:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbfEHEzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 00:55:05 -0400
Subject: Re: [git pull] vfs.git next bits of mount ABI stuff (syscalls,
 this time)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557291304;
        bh=Fa5PEkQkcyCCRgrZVIJYt21TcqWYpRNs1Dqlga3DerU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NWy1DZc1LrAeNMBF4/4HFGOqbw3rdtyQdGEhvp8AfWLocUqswyU1ZO/0q1KYjlEEY
         Trc9HdrJKg7fmq/aTgUHTRYQKrT0hNqcTVFj6i2mSMkDnchuHrHsOOVL2QO84UXRug
         GlRsnm6bcTiLV9S7wL7VXvbCroXvANXc3qWSpMT8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190507204921.GL23075@ZenIV.linux.org.uk>
References: <20190507204921.GL23075@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190507204921.GL23075@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git
 work.mount-syscalls
X-PR-Tracked-Commit-Id: f1b5618e013af28b3c78daf424436a79674423c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 400913252d09f9cfb8cce33daee43167921fc343
Message-Id: <155729130461.10324.290999203071466889.pr-tracker-bot@kernel.org>
Date:   Wed, 08 May 2019 04:55:04 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 7 May 2019 21:49:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.mount-syscalls

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/400913252d09f9cfb8cce33daee43167921fc343

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
