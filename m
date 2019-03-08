Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC682C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD2920868
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552063818;
	bh=pFaPrYiP5zcyS8iE8pdoIJClocXtCEGRIQflcS9DP44=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=FSCVoW3jOTiw+l6nJXibK7pzIrhyL8K6lAWoUpRb5LvacIUQ1VpFfq5J17n+FwrPN
	 aumQDIh+t+Tb3imZ2qSLisiPdBOWKBxDqm6feJrJ/3VdRt3tn3h4QMCh5Zl8ESxLEW
	 hmXOIVJpHOqTz3aZyh5+8fV+R+sWOBQX5BKsg4x8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfCHQuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 11:50:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:59338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbfCHQuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 11:50:17 -0500
Subject: Re: [git pull] drm for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552063816;
        bh=pFaPrYiP5zcyS8iE8pdoIJClocXtCEGRIQflcS9DP44=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IdXs+Q3Wx9Ymmu3HfE+rIYETdgrluGHxAkQBGM1kbTpiTp/twF0wCiOdrgqwxVOwB
         4RVXKSU/PBEz0DI0Wd7I2e12TOlwsPgesV5nlsROQHBmT859UQgOfoRx0VZspV+35q
         8T1sxtuiTuk9bcVbsRC9Zj5q3u9bdWsPBwEpu8cY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzmc2fiodNUtM_2BqE-BhFTQKze6vgJ9bG4y1gegHZcwg@mail.gmail.com>
References: <CAPM=9tzmc2fiodNUtM_2BqE-BhFTQKze6vgJ9bG4y1gegHZcwg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzmc2fiodNUtM_2BqE-BhFTQKze6vgJ9bG4y1gegHZcwg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-next-2019-03-06
X-PR-Tracked-Commit-Id: 4b057e73f28f1df13b77b77a52094238ffdf8abd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 851ca779d110f694b5d078bc4af06d3ad37169e8
Message-Id: <155206381637.4398.622563084672015695.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Mar 2019 16:50:16 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 6 Mar 2019 13:35:00 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2019-03-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/851ca779d110f694b5d078bc4af06d3ad37169e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
