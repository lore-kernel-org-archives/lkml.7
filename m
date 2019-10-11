Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43A1ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 16:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E20F218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 16:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570810207;
	bh=EHe1DVQKdCmISqd9rDP9OzdB7C6HqG58pl0sFURpOG0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=iEgeJRsn6eqEQyPh5sc7jy6CznMIdyvwlA8aU/JwKCwmCIJ4K5PXUaYqvuDJH98np
	 wRiqq3wrrENozH7edMP29OU746DNaCBSwqOpxUwwF7dUvJkUy0tD6ylzUd9s1CUPFl
	 6mijib0gTAz5rTnpCrratFZ+8JlHEHNJezGtAd5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbfJKQKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 12:10:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbfJKQKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 12:10:06 -0400
Subject: Re: [git pull] drm fixes for 5.4-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570810205;
        bh=EHe1DVQKdCmISqd9rDP9OzdB7C6HqG58pl0sFURpOG0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QXLyhwokECuevFtWeqxSlwtK7/L+8IUw8HyZJpzSbBGU45h4JAwGiVoao7NMJIcSo
         t/lYsQZGE72SHLlw1la8SLJoRP4ufcxCX9maSoAJmqaedp8/WKC7Sxw9B7Z0etrTy5
         3M10DxV8DUymP0rsfbUH8+k6ZTZmEdW++udFTOnw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9ty05BvFP8P0UB+uNupSbe7XTwO8My7XnXQC0iucBxw=rQ@mail.gmail.com>
References: <CAPM=9ty05BvFP8P0UB+uNupSbe7XTwO8My7XnXQC0iucBxw=rQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9ty05BvFP8P0UB+uNupSbe7XTwO8My7XnXQC0iucBxw=rQ@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-10-11
X-PR-Tracked-Commit-Id: 4adbcff22e676d28de185dfd391a6fe56b3e6284
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9892f9f6cf83e8ecaacc5ec7847cf5ba033119d2
Message-Id: <157081020565.21776.7490614053068406440.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Oct 2019 16:10:05 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Oct 2019 14:36:03 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-10-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9892f9f6cf83e8ecaacc5ec7847cf5ba033119d2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
