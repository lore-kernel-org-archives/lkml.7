Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18F0C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725D620842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551757219;
	bh=LcothqgJsMgUfaaN3zxjjc/zuNXhcbUZP19K5sEy4iY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=enBOGoVEjSR3BqrAm2AWWGDJPsgWyRqCweCbwNM6wM5ZZBRQ1t/Pqg2tBiwu5Pq8A
	 YyfnoGGtTvTH8dMXbpuRBHGpyR+wDQdqx+V6YoTZ5DqnNboDTHyw2xQBNDkYrAv0se
	 JYsuHg6UdIYwak432GDQ8kzBqcg7MTZseCBFZyAQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfCEDkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 22:40:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:35622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727849AbfCEDkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 22:40:06 -0500
Subject: Re: [GIT PULL] SPI updates for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551757206;
        bh=LcothqgJsMgUfaaN3zxjjc/zuNXhcbUZP19K5sEy4iY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NZiyafbG9FTb6WllsjclNEsBk8QL+4877wJcCaaiqa6Rhxi7c7meKaAXRoYgWK6ck
         PtZlNGC6mFkscg2moNyHWTOnPq0npq0ID8MXNe9DR6/L+DtRaIG7vP8Bm7dQh2C5Yu
         Y5gyWQYgI3ampfG/oQKrNsW4UhIZ2zGXLVobOA0c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190304170734.GC8877@sirena.org.uk>
References: <20190304170734.GC8877@sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190304170734.GC8877@sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.1
X-PR-Tracked-Commit-Id: 14dbfb417bd80c96ec700c7a8414bb6f5db7ecd2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dcc75ddea1c3dde05db2f485d617dc8431177e33
Message-Id: <155175720621.14960.2637687829712618325.pr-tracker-bot@kernel.org>
Date:   Tue, 05 Mar 2019 03:40:06 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 4 Mar 2019 17:07:34 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dcc75ddea1c3dde05db2f485d617dc8431177e33

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
