Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE31CC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 19:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E7C24673
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 19:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575660304;
	bh=PGQpDvt42R1DJDHfYDic+76P5cQTTcMg9LWqRGlb1EY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=J5MCL/QOeCbQvKUKVGz9joaz82MWB7wk7vBGf9dveNXNhiliuhqLs97/A0cki3cgX
	 HIh933THTDXuh0C78b585OZRDYKsvGmKGp/a/ly+/4RSo1FnTKPZvXl8+fISQ1oeFD
	 8rcMwWnVb0GggjxpvTkNNAn+wSZZxRCDgZSQU/Ec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfLFTZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 14:25:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:54120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbfLFTZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 14:25:03 -0500
Subject: Re: [git pull] vfs.git d_inode/d_flags barriers
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575660303;
        bh=PGQpDvt42R1DJDHfYDic+76P5cQTTcMg9LWqRGlb1EY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=nTmyTXKQLkRk3OUyzUh200QZztiZj/BhZabzOZvSVFUktOx/uqZA5R9LfvlhaUROy
         SXOpXFFGxPgG/5NV2DJoNrPumIJa1IRcWNk7FztmK0fuNJE4NpVzl+ZWlTtmVQIP/u
         ipCy6mreNxE1A2ZV1ccN5rHdXAoE3W9h/Aj1iyF0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191206013819.GL4203@ZenIV.linux.org.uk>
References: <20191206013819.GL4203@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191206013819.GL4203@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: 2fa6b1e01a9b1a54769c394f06cd72c3d12a2d48
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0aecba6173216931c436a03183f4759a4fd4c2f2
Message-Id: <157566030296.16317.15897821956117872121.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Dec 2019 19:25:02 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 6 Dec 2019 01:38:19 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0aecba6173216931c436a03183f4759a4fd4c2f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
