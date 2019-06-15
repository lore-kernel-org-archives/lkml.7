Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC705C31E47
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 04:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD392168B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 04:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560571507;
	bh=1ukOZZGAEs0BqwHmgc/wwwlmaTI8YBYbMmWhkj1EHSQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=SuH0M4jJj5qXavptPigQl9tl8KhrOa0LG+S3thBuB0Odc9rog+JV0DmLTRJwtt8C3
	 wZFIId7WMSGH6DHyeMaFINGBYqvWHL7tOgT7DTa66rhUyHD1LPONglml9nKnUnOpfz
	 vtzf9MPKLR6gz4opSi8ef2kGj7vQKPmoDu2tPKow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbfFOEFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 00:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbfFOEFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 00:05:05 -0400
Subject: Re: [GIT PULL] gfs2: Fix rounding error in gfs2_iomap_page_prepare
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560571505;
        bh=1ukOZZGAEs0BqwHmgc/wwwlmaTI8YBYbMmWhkj1EHSQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kaG6bUzU6Ikg5WKyTmICva3c3J8cxo7ECCimX3xdix3NaGJIlDuf9tKgGACTVx9tz
         50qazRBijAZ7Ukm3FTSNaFmJB2/8+cycx6Ur/bwS2pTuu2xPgrgo2zsDR8vIxB7AWf
         zivz2ge81+3J73+Zpo52jrZQ4TwHbhwfA0ekAS9g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHc6FU7aKs3bUwjnPeLn4Nw82ojGcQxkJbDsgtVdXYVRjVW0bQ@mail.gmail.com>
References: <CAHc6FU7aKs3bUwjnPeLn4Nw82ojGcQxkJbDsgtVdXYVRjVW0bQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHc6FU7aKs3bUwjnPeLn4Nw82ojGcQxkJbDsgtVdXYVRjVW0bQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
 tags/gfs2-v5.2.fixes2
X-PR-Tracked-Commit-Id: 2741b6723bf6f7d92d07c44bd6a09c6e37f3f949
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4066524401724babc5710b0a6be88021a081874a
Message-Id: <156057150507.28747.7815529893071983386.pr-tracker-bot@kernel.org>
Date:   Sat, 15 Jun 2019 04:05:05 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Jun 2019 18:55:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.2.fixes2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4066524401724babc5710b0a6be88021a081874a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
