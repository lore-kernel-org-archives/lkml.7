Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB8BC73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 19:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 580182080C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 19:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562702105;
	bh=sIK9ik4NBdLIu61cTvbc2e+JDjFYM52LBiy3g9tveNg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=X3hsxYLExrt92cnE3Rl3l7ze2ETl3m3C6II+KcpxU3maPIAq4aiDMxEBTaj17/x2N
	 j6vb3QZMyc5v6pibLpnDXWBUeh/64Sbbxp00HbK63U4uUQeriLYpGKaF4MSz8gUUYJ
	 zVaT5Yo+nTa2q+IuLcVmhi8jBdrtTNPK+vbJ1DAQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbfGITzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 15:55:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729535AbfGITzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 15:55:03 -0400
Subject: Re: [GIT PULL] parisc architecture patches for kernel v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562702102;
        bh=sIK9ik4NBdLIu61cTvbc2e+JDjFYM52LBiy3g9tveNg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SKe9ytFYljxkJnI6j4874+yrIOXrksdIObOpKM/JTRH+Hk89m/kzKCUANkaBrTHl1
         WORoiBYhHvlMQaAqq75hxib4z2guQTPiT7XFdN8Xy3ErIchKiBwqvAF0S96/v/voOr
         CItwkQ/0wY72zE+nrQqne9KOm39h/WW9rtZzccAE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190709054632.GA14843@ls3530.dellerweb.de>
References: <20190709054632.GA14843@ls3530.dellerweb.de>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190709054632.GA14843@ls3530.dellerweb.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
 parisc-5.3-1
X-PR-Tracked-Commit-Id: b3d5f311d3cfdea0b0e2373409e50423b130f847
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 593c75463ab6d6985cdc9916f3d1c28b5f6340cd
Message-Id: <156270210260.21525.16011441925472712046.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 19:55:02 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 9 Jul 2019 07:46:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.3-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/593c75463ab6d6985cdc9916f3d1c28b5f6340cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
