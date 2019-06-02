Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC488C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 17:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF5627999
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 17:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559496316;
	bh=jlcMWVzdPq3NOzQ6G/XPuPxeSqD9ynDnnBzWdfLQygk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ZIkD3sAdTD9Rqz/CI28qRGCLYqzOc7i4LjWPQ+2svvhVOPRAHjKT7AI2xQMs6qLP7
	 ng6nTekr4yD2TvDniTTSXzZZj76mLC5MOEvunx2a+KW9a+28UY/26VG01JjbC+yBk+
	 +yXfZCCniXcvbgketyIZTwld7xPdxCllJOjdTJto=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfFBRZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 13:25:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbfFBRZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 13:25:13 -0400
Subject: Re: [GIT PULL] LED fix for 5.2-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559496313;
        bh=jlcMWVzdPq3NOzQ6G/XPuPxeSqD9ynDnnBzWdfLQygk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gFWtRCnQvNbt8onbCekloKuslXbWumn/a+Ja9lTGgJKIlTbuTsuEdV1hZ7JhfYuQ2
         KIRiprqebrliQSWuaTj/YABXfi2koqbu///IFkddDFCbr0xFQxFYu+1hyWCMrakUYF
         WrU5uQvNnblGam02T06POvtBnPhHc+e2uQ66tkH8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190601175944.21297-1-jacek.anaszewski@gmail.com>
References: <20190601175944.21297-1-jacek.anaszewski@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190601175944.21297-1-jacek.anaszewski@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds.git
 tags/led-fixes-for-5.2-rc3
X-PR-Tracked-Commit-Id: 8c0f693c6effbc3f42f77a9e81209af9af20910c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f58c356ea74feef8c2bb774dd19ded91567a5cf2
Message-Id: <155949631296.24242.20021876127476850.pr-tracker-bot@kernel.org>
Date:   Sun, 02 Jun 2019 17:25:12 +0000
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat,  1 Jun 2019 19:59:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds.git tags/led-fixes-for-5.2-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f58c356ea74feef8c2bb774dd19ded91567a5cf2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
