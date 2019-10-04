Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52131C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27DF5215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570213533;
	bh=I3meC0D4SSP1ojMNRT+f4wq7ynZ2JD/PYtvvsgoqGug=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=VBlMPJpLA21GCQLPOBafvEyt4OR31fSLCKx6i3yuQzgwPmatGZJygmbpaI/HHIUAY
	 C7jboqBn+TmDdhs6b9d4y39Lvq8rIUua4+Ji3lxW1xoMmdGq8wl2OztP2CwYWbcQVk
	 w3W9jn8+NtISgWDXuFLhJVsThGSrIJkHWeQ+peqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbfJDSZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 14:25:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729291AbfJDSZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 14:25:17 -0400
Subject: Re: [git pull] drm fixes for 5.4-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570213516;
        bh=I3meC0D4SSP1ojMNRT+f4wq7ynZ2JD/PYtvvsgoqGug=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VEpXIjghWcqoA4nYUZCJg7aceyWlcAormrg0FJm4Te7Ap/kNwKkLcL+F+teoEJZcW
         dkdtRRzOb6YUMqOQhGZvzo+n4prVxB19VLZ/uImOtuz2ZO7XqYCObojJWdKOSvCa+8
         J9JHgNBbBmxRYKYC7s3nmTnJZZLjJNWRBdnLb9Uw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txgjvF2366P7_Sj-sLdS0rjdnsyFEg7xKF35sEG7ZTXBQ@mail.gmail.com>
References: <CAPM=9txgjvF2366P7_Sj-sLdS0rjdnsyFEg7xKF35sEG7ZTXBQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txgjvF2366P7_Sj-sLdS0rjdnsyFEg7xKF35sEG7ZTXBQ@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-10-04
X-PR-Tracked-Commit-Id: 07bba341c99694a4fe6b07edfa4f97ca90c8784c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 768b47b7a9bca52101ff48081cfcecd3ebc5351a
Message-Id: <157021351670.30669.388731916988528975.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Oct 2019 18:25:16 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 4 Oct 2019 17:55:16 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-10-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/768b47b7a9bca52101ff48081cfcecd3ebc5351a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
