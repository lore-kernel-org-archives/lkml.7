Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48AFC73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F85E216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562695505;
	bh=tQLIkCVsL/J5QqNbdtb5HHhnVyuLo2ONICaIVpCZ1LE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=FnxTcsxWgsxuXFGI3K33uSR8U8LZstVeIbsw4L0tU2cabZnSiFP1r8XrJVPAKwRK9
	 3+1o2aZMZDYSvxTss8Qg7fd53hb8NUpwclwi/VdC3j38t8/wikwmz/H6mOLeTpOuAE
	 LElKM8HkYTWPWEPRWJY5RuG4pYOu37VCzcF7jAF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfGISFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:05:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727305AbfGISFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:05:03 -0400
Subject: Re: [GIT PULL for v5.3-rc1] media updates
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562695502;
        bh=tQLIkCVsL/J5QqNbdtb5HHhnVyuLo2ONICaIVpCZ1LE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lNUx5ElQxidJzgtme7oyS3OcJFt/yi19y1gXDFzOBO8/woy32nhGOWaySBtjFPKXH
         UMgau/fWLllIiMsI3Ejel6Z27dNbfxB4KqvRUl5Ttvvwx4A+fPzuNqzfiDOJ2Lxzan
         egmLDAV+wVClwyy9biDf3N2JvPYlzM9r6sBkbE+A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190709081735.3d642186@coco.lan>
References: <20190709081735.3d642186@coco.lan>
X-PR-Tracked-List-Id: <linux-media.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190709081735.3d642186@coco.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
 tags/media/v5.3-1
X-PR-Tracked-Commit-Id: f81cbfc4f82a75ca0a2dc181a9c93b88f0e6509d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ed63b9c873601ca113da5c7b1745e3946493e9f3
Message-Id: <156269550241.14383.417129534534296641.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 18:05:02 +0000
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 9 Jul 2019 08:17:35 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v5.3-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ed63b9c873601ca113da5c7b1745e3946493e9f3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
