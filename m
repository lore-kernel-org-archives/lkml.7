Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3CDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DEF421773
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553896213;
	bh=zmjGyToqiDy20fzP9y2hFrQL4EYycmgycYJ4GmGKeDo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ehZVpily6uU31oy2YRl6dnk9O8ORoVOIybPneGzfFYpMsr8X9PyhzhZqGIlJh7/eX
	 x08rcFsa5V217B9qPfYcVw6IFBazUxom848HvHgnWUGYWRX+qPaY2/Z1R8CrfkPeMm
	 vXB11TAaSo6yB62zgHNWBLpGcA6o7hOp5nhgqoW0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbfC2VuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 17:50:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729771AbfC2VuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 17:50:11 -0400
Subject: Re: [git pull] drm fixes for 5.1-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553896210;
        bh=zmjGyToqiDy20fzP9y2hFrQL4EYycmgycYJ4GmGKeDo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Qvn7OtmOsgvUr9JfDvZ7U06L+wPSfe9UmktiT9vB56+AlorCbS3Psvjpf85UCgVGF
         j0+TvhKaHz+zJQbeeWUu0GfBz8axjrJQkFN9xeEvOX7TZhAeG/lDA6jwv2z1K8JRGf
         HDzT0XBd4kxD0JFnGSsl2vV3TnD3Zly9J3z0z1fk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tw-yPL8ZOxNO7zu3scG8PjAuKOwR=7JMDJ_93M8avVkOA@mail.gmail.com>
References: <CAPM=9tw-yPL8ZOxNO7zu3scG8PjAuKOwR=7JMDJ_93M8avVkOA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tw-yPL8ZOxNO7zu3scG8PjAuKOwR=7JMDJ_93M8avVkOA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-03-29
X-PR-Tracked-Commit-Id: 0271ab11790cd5ab8ec38e0e669e13c1009f271a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9df0ef6ca9ee7c04113d598f15e7875ebfaa7bf4
Message-Id: <155389621059.28625.13259343964880773915.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Mar 2019 21:50:10 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Mar 2019 13:56:02 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-03-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9df0ef6ca9ee7c04113d598f15e7875ebfaa7bf4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
