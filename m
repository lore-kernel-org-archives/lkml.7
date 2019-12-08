Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D60C43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 21:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E51206D6
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 21:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575841207;
	bh=umapMgjzFdifXMaub73Vzko1vYJdt/80TYCnK1+df0w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=xz1/fbjJQPPLAK6x3FdbF7aC0zi8WtWvQ/khxQU6C2iVTwrXWFzyCaXv6tAjrGm8g
	 iW/NbPF6CEBr3HzZ0PoWO071BxvExnLP3xKzU1U5tW1osaZy/7qZufjrYjWmdpXief
	 /suiNWe/s7TiCMlSyrX2f28D0gtI13jyFhS/NceE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfLHVkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 16:40:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:57230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbfLHVkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 16:40:05 -0500
Subject: Re: [git pull] several misc cleanups
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575841204;
        bh=umapMgjzFdifXMaub73Vzko1vYJdt/80TYCnK1+df0w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xGPk4361ikXCGYvI0MnVsoZiMNe2ew3EJ8w9FG5QMUk4cV69o+0UAOoM0tk2j1IzR
         jTX58moygxC9JvRzlHWG2WDa/Es2B7pnhDngesBZnm2RENe1ZWqWMLxaaT/guTeOvu
         vGyrhI9NUzdGRCSh/HqFpuMm8JwHVqdcmfHI5n/o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191208044556.GR4203@ZenIV.linux.org.uk>
References: <20191208044556.GR4203@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191208044556.GR4203@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc
X-PR-Tracked-Commit-Id: 5c8b0dfc6f4a5e6c707827d0172fc1572e689094
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5bf9a06a5f7ca525621f4117257a49dc5a2786da
Message-Id: <157584120461.22418.2135503611127593336.pr-tracker-bot@kernel.org>
Date:   Sun, 08 Dec 2019 21:40:04 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 8 Dec 2019 04:45:56 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5bf9a06a5f7ca525621f4117257a49dc5a2786da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
