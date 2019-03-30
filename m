Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F5EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 17:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0F9218A3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 17:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553967020;
	bh=7eDuhpz1IJSeE4D1I1/3fRmF+aTN35W9Ki1qU2hcBr4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=H5VyGTd4ve/SYFCfJ5dXT7guYOm5BRDnhBLx9vt70fyku+/mjWDAfCpYPN1QgO58c
	 pmd8n/bAQd1LcqQBFQV1LGTJaRKTK3MQb3v2zZKUQwvJFgeaRxhpJfat5F4EERMp5I
	 aCSbovVkv/BEaGCTtotbSIXauEQzJZzXdW3VDq0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730979AbfC3RaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 13:30:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730669AbfC3RaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 13:30:11 -0400
Subject: Re: [GIT PULL][UPDATED] security: yama and LSM config fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553967011;
        bh=7eDuhpz1IJSeE4D1I1/3fRmF+aTN35W9Ki1qU2hcBr4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NwtgSq3XPZ9Uw7Nul/Vdy//F3pY6UOxz3qd5rLdO5NN2Ln1JA8JduMdPoW9Q72lSS
         AqYDI2xUQdUAUKNefeoC1itw/0JQ7YgkL6sYKUTHtfE9mxh+fJb8VbxPVdZjt+Ijma
         gaZWWDoJgze3xMnQ/bRItbzfyUE8d5hzg/vsx+MY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.LRH.2.21.1903300811170.5953@namei.org>
References: <alpine.LRH.2.21.1903300509370.689@namei.org>
 <alpine.LRH.2.21.1903300811170.5953@namei.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.LRH.2.21.1903300811170.5953@namei.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
 fixes-v5.1-a
X-PR-Tracked-Commit-Id: 2623c4fbe2ad1341ff2d1e12410d0afdae2490ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 12195302ee6c32cf3c0fa947e17303ce583d41c9
Message-Id: <155396701116.21865.1726672361806443113.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Mar 2019 17:30:11 +0000
To:     James Morris <jmorris@namei.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 30 Mar 2019 08:12:07 +1100 (AEDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git fixes-v5.1-a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/12195302ee6c32cf3c0fa947e17303ce583d41c9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
