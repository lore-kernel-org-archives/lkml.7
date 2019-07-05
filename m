Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E49CC5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 05:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 631DD21721
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 05:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562304306;
	bh=45d3n2/9QobIgyxW4ebDdgA2oQ65jZidNaSA30Xgj5E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=eZlZY20JZoF0KAQeH8n6QTlb6mCtoaxHXIGA1QX06jwnTUVcb1I4gQNu0eqtVMYXH
	 oZGYJ5C2x/1DdXWTzUfjsxyPYZsBZi87DxqGHvkd5E4v5+erPOs3pfPrkJ+QBCRRQh
	 1++8TjLqO5Mvd8PqhvS7e5bQUo0ODWT4Exco0Xdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfGEFZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 01:25:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbfGEFZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 01:25:04 -0400
Subject: Re: [git pull] drm fixes for 5.2 final
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562304303;
        bh=45d3n2/9QobIgyxW4ebDdgA2oQ65jZidNaSA30Xgj5E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Fv9G5oqhfOrd9j0gOhBCpeoFzZMfpfy0uSvh30nj7EG4yKjl5rZclVOjKzTIPaLQE
         K4ilYOa//hyqf6GtmDy2UaULrQnhKecaa2COWXX0GjCB8ZH2r/NSqsqJNnhW0tJ5IA
         RWNBL68dVtjtIkH/xcj+jY3OOLFtYM9mozyrte4g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tz2nw3eu-5HXdA9iaMck34pOL=ZZimrVBStK9WUYKsNAQ@mail.gmail.com>
References: <CAPM=9tz2nw3eu-5HXdA9iaMck34pOL=ZZimrVBStK9WUYKsNAQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tz2nw3eu-5HXdA9iaMck34pOL=ZZimrVBStK9WUYKsNAQ@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-07-05-1
X-PR-Tracked-Commit-Id: a0b2cf792ac9db7bb73e599e516adfb9dca8e60b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f9c4dc63309286a6513a86aac35ffc445cb9d1a
Message-Id: <156230430379.17573.4119970529169149467.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Jul 2019 05:25:03 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 5 Jul 2019 14:59:26 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-07-05-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f9c4dc63309286a6513a86aac35ffc445cb9d1a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
