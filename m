Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81536C2BBE2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 19:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A48524673
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 19:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575660327;
	bh=p9bveILx+cdu5fEA5I6KU1MFjK0cuP0E31/rezFRch8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=AFcMEOmyOZn1OfmAqUQ34SP2/sMUDDEpl6hVSi0p9mBwjTbDgM1PHih/ERzGSUJ95
	 dvzkzOzS9qjMUnw54BqatC2uW2xLKZ6jSw406c1ibmbO9suSQzgVVFaxoaCHppdq8E
	 vWgJfs1soEzdPQUMeP3+xdu+X+V6HDWQFvrrSrp4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfLFTZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 14:25:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:54310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbfLFTZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 14:25:25 -0500
Subject: Re: [git pull] drm msm-next and fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575660325;
        bh=p9bveILx+cdu5fEA5I6KU1MFjK0cuP0E31/rezFRch8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iTPXFcl9Z3w+qsIubse+kxvXnBGjqUrPgj7WuJ8WkPzwFDFE1zm1QRyruqKURmMJS
         fCxChS5RJJlqRqAHJhsG6GqC1utrYJgMZ4vawcOEIoV66e9uFFkBDSFLcQacn7KR3V
         zgGoId36bd4cv62zuwZPXbaHMHNJ9kz+Hm4h7M2w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzTYPTk9vBxyGruTO_NwYAqk6s+=LRPg2CX9-Zf55Q1sw@mail.gmail.com>
References: <CAPM=9tzTYPTk9vBxyGruTO_NwYAqk6s+=LRPg2CX9-Zf55Q1sw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzTYPTk9vBxyGruTO_NwYAqk6s+=LRPg2CX9-Zf55Q1sw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-next-2019-12-06
X-PR-Tracked-Commit-Id: 9c1867d730a6e1dc23dd633392d102860578c047
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ada90eb9c7ae4a8eb066f8e9b4d80122f0363db
Message-Id: <157566032527.16317.6029268358637804973.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Dec 2019 19:25:25 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 6 Dec 2019 13:31:06 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2019-12-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ada90eb9c7ae4a8eb066f8e9b4d80122f0363db

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
