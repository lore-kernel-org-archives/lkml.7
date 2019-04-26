Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1049CC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D160F216C4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556297408;
	bh=fSu5ScgY3jOyrrJ4aRzJgnscSkCX1QG7iH7/mMpvHdI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=zg0lia92imoF/h9QHpmuzg1uKqfrMmwEXG81BC4MB3iSECwEIGR83YcMjPM9D3iO9
	 JjTyk9jqWnZwap0F4UvrUqvK/jyTpyB64ME68C/P6vDrskUSWshNB51UjgYimENW3L
	 9X/muBRoMefmIUo3sUPTa8TyBgOD8SJhs1UtL+t0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfDZQuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:50:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfDZQuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 12:50:05 -0400
Subject: Re: [GIT PULL] Btrfs fix for 5.1-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556297404;
        bh=fSu5ScgY3jOyrrJ4aRzJgnscSkCX1QG7iH7/mMpvHdI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=inQscKr//DieEbXEWXgDDqZzz3cVzSAiOsaq8WvBwWRTWPIL68NwVuvj6MBjzoHJQ
         Xnp+x6788rBEh0xrvJOJF75WLWnFGInNdjCgVNyhHbYwglfrF+heNN68OWYsCRtcBJ
         PlPL3ai3yq5HmDwBtjIY3PiWenZLU3dCtQT5UZGI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1556276662.git.dsterba@suse.com>
References: <cover.1556276662.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1556276662.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.1-rc6-tag
X-PR-Tracked-Commit-Id: a3d46aea46f99d134b4e0726e4826b824c3e5980
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d0473f978e61557464daa8547008fa2cd0c63a17
Message-Id: <155629740484.7104.10455981929718210416.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Apr 2019 16:50:04 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        clm@fb.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Apr 2019 13:20:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.1-rc6-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d0473f978e61557464daa8547008fa2cd0c63a17

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
