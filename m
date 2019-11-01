Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB457CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 17:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCAD217D9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 17:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572628228;
	bh=NZUdxbJqX4Vuv0Q03FyiheKXm9a5jALxIO5LuoRJtes=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=d/qeAutymF4KBb5GBmhehLhXkAV1bhU5GzPu82RsKUGg1QV+AycWBjFFR69Owm2q4
	 xqahWcMXkFSbPgLO++rIh+EVo/Nys9iZgW4SkerIZ+LEgx8d9jHmZsWviwizZGWbK1
	 7lBXnFV0A0ZG583j+Jj0q4iV4+AyTk/JXvv+Cbuw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbfKARK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 13:10:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729078AbfKARKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 13:10:06 -0400
Subject: Re: [git pull] drm fixes for 5.4-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572628206;
        bh=NZUdxbJqX4Vuv0Q03FyiheKXm9a5jALxIO5LuoRJtes=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DaicA6/MbeKaBOWbfsgPHJbZ2ryFxoUQSFlKhl7c7ofJgEidsVQN1/Qac9kaxL07j
         qAalu7rIG+Gm6RqIDiLTYpVWeqiGtKwcARtNzu893ywr7xutdz5H7+lAmozEophhCO
         S8gLLo+grx6b43ctrl+TGbbS/zitxyDTUFFvz33E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tx7omDCD2SmOaX9H1mO8=bDZWHw8aTJbp57bGQubYaHtQ@mail.gmail.com>
References: <CAPM=9tx7omDCD2SmOaX9H1mO8=bDZWHw8aTJbp57bGQubYaHtQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tx7omDCD2SmOaX9H1mO8=bDZWHw8aTJbp57bGQubYaHtQ@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-11-01
X-PR-Tracked-Commit-Id: e54de91a24753da713b9bcf9fcd93eec246e45e7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 146162449186f95bf123f59fa57a2c28a8a075e5
Message-Id: <157262820616.11375.7758161907091851654.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Nov 2019 17:10:06 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Nov 2019 15:21:49 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-11-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/146162449186f95bf123f59fa57a2c28a8a075e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
