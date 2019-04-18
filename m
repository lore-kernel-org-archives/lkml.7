Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D43C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2782217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555600805;
	bh=WfVDfxM3O/3lUzN66buNrKNBG+kYFP9/X7C+M8qyU78=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=l0nG+PKu9A015ddSFH32++jb+5IJ82BKXxIZT+NuFp4RQe1NtXpCODjc+DqbneAwP
	 4x+6+qCDKD/qrzjpLt2JWcmFaV6r0tBNUOkPkAV8B1awimGKZWshm40iKdv/gSdJTc
	 kxx2dQNUqenl9bQSj0P75DLAqCvIqJx0LkZ0dfGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389530AbfDRPUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:20:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388842AbfDRPUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:20:04 -0400
Subject: Re: [git pull] drm fixes for 5.1-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555600803;
        bh=WfVDfxM3O/3lUzN66buNrKNBG+kYFP9/X7C+M8qyU78=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TeWjS0Am9h43XiclD7h74jdDAzL3RnPnCuIK1jEyBebGl0CCT6ivNiaDEpbXPUDcH
         y+d+fr8yhzM+/4okZ4jizSmgKMiwXJrJLlhIOBXPqK1bwJEk24KrHho5eqQxcxdIMT
         haxccW8LHhcXpmpqQKghe1HzpEjMTQ5tXH7NLSr0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twvtLWe=Z8uMHG47H7NSSYQWEpD+yvs-Dt-FMzcZMZpCg@mail.gmail.com>
References: <CAPM=9twvtLWe=Z8uMHG47H7NSSYQWEpD+yvs-Dt-FMzcZMZpCg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twvtLWe=Z8uMHG47H7NSSYQWEpD+yvs-Dt-FMzcZMZpCg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-04-18
X-PR-Tracked-Commit-Id: 00fd14ff3017f64a9a03a08291e4be0d87bedc17
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 95ea55291e35107f6cc1838e499e57d236a45d44
Message-Id: <155560080371.14770.179992344736295681.pr-tracker-bot@kernel.org>
Date:   Thu, 18 Apr 2019 15:20:03 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 18 Apr 2019 13:40:53 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-04-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/95ea55291e35107f6cc1838e499e57d236a45d44

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
