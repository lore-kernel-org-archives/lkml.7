Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA03C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 02:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A555B218AC
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 02:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575255025;
	bh=Ngm88Vn47q3+JCtBxY7Z4f7bWcz0C52gFay2C09tmL8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=WcNr/q6fRH4Me2qgZ1p7tPxzQ59m036TQgJKqtlLsdj/43u//Jaog9jHZaZ6shE9u
	 XjoyeU2nu9XM2/rBiaY+JeW98DCwE79P4X6VCne50ACw/1BYRDViVYowAaBULpyXjl
	 6cQpCNl5DHBhshHxzhDnSW0ls3aKKCye02Bo8KgA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfLBCuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 21:50:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:34108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727541AbfLBCuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 21:50:21 -0500
Subject: Re: [PULL REQUEST] i2c for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575255021;
        bh=Ngm88Vn47q3+JCtBxY7Z4f7bWcz0C52gFay2C09tmL8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jB3Ir4lF8W/txWQJjW5eB1k1ZDoY5452d4RQqoA0MGDfRDEwy7ZoYzJDBitilzJZL
         TvJ/6gp9nfp3V9Loe7y4Rj8cglZ1bccuMa9ar6KYNLeZYZF5fp8EBlpM4aqvqjcI4T
         AOpZQn+s45uZpUGlnR64sNSn96O2Im1fGGRUeKCQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191130154442.GA7415@kunai>
References: <20191130154442.GA7415@kunai>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191130154442.GA7415@kunai>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-5.5
X-PR-Tracked-Commit-Id: a72e27f7a47069b1b4942051bffa7dc77b4aee0c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3265568db8c37d391ee8ad2afa8b0fd7257f4526
Message-Id: <157525502117.1709.10014095402050557086.pr-tracker-bot@kernel.org>
Date:   Mon, 02 Dec 2019 02:50:21 +0000
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 30 Nov 2019 16:44:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3265568db8c37d391ee8ad2afa8b0fd7257f4526

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
