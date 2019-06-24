Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AE4C4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC61920679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561413304;
	bh=YT7OK1srs0W1BEZs43ydwLwMJoXy0wysoghnXVExrg8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=a6zyu2bv2gOyl7NY7HLUrxA56716ddcmLZyMP60OQtBrPd8XcPu6W8pZwFM4Gcoxd
	 vBs8MIJUI5clZghct6HPYwRQuG4WoHwqH2fwIwp7R4Y/vdlddOj2AQwenHRCxl9Fsi
	 Bn3NjWSHpffIA041eDiRNACU3chseGahM6gEbWAU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbfFXVzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 17:55:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbfFXVzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 17:55:02 -0400
Subject: Re: [GIT PULL] parisc architecture fix for kernel v5.2-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561413301;
        bh=YT7OK1srs0W1BEZs43ydwLwMJoXy0wysoghnXVExrg8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=INRl4mfljjaKo7RjRCUxPditwS2tqxQzc3UHAOuose5oSHwcW+eT2HrlR/ReJMyRW
         97CUJj6UpL6Mv2yKLKN4LxTnv6QuyPYG798Y0lFGS17BlxSw16dzRV+dGo9L77MGq/
         ZqFP8bfkb8OcDKqge0CuUzi/XzDl0yyDttckuGX0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190624214408.GA9531@ls3530.dellerweb.de>
References: <20190624214408.GA9531@ls3530.dellerweb.de>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190624214408.GA9531@ls3530.dellerweb.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
 parisc-5.2-4
X-PR-Tracked-Commit-Id: d2ba3b1714d754f190ac0527713f9b44513b5857
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 249155c20f9b0754bc1b932a33344cfb4e0c2101
Message-Id: <156141330192.8327.11764310601122582696.pr-tracker-bot@kernel.org>
Date:   Mon, 24 Jun 2019 21:55:01 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Jeroen Roovers <jer@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Jun 2019 23:44:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.2-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/249155c20f9b0754bc1b932a33344cfb4e0c2101

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
