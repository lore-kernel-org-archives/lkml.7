Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF625C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 19:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C490B2183F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 19:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553974212;
	bh=TMvZyEmx3L7lHoVtxdquC51GRcEP3MdHrkAHIOU4OHo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ZOJAzFk/pkpt1/Q8P0QvFA7V+Cfj53zNDAOL3hvlNWOOcFCbpCzyC3FnGvg/2Yc3+
	 0bfJLC7pSBXEeRxr8pmwy8f45uu5uTv1ir/6xtat6DfppPj1/M6H8uGocsJOyYpW7D
	 nVXjDmbsglhfKoxsmcv1Z9oKplqllmkMQ9sApyaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730973AbfC3TaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 15:30:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730937AbfC3TaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 15:30:11 -0400
Subject: Re: [GIT PULL] LED fixes for 5.1-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553974210;
        bh=TMvZyEmx3L7lHoVtxdquC51GRcEP3MdHrkAHIOU4OHo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Ad5Xrx19yUyRoFUcPGQkZExs0RcX4Oq2klpsUyFyaI6bgQbkx0zj+6RYkbHxlH72B
         krHGdXhh1J5kzNNp5IaBapxR9srMB2wIrqrTW5QT5VAG3/6prwxvhKy7KcJpRwYweL
         1synXcsK/+3mm5LT/gnr13zeL9swV7Z7Uhgc+cvo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190330183942.6589-1-jacek.anaszewski@gmail.com>
References: <20190330183942.6589-1-jacek.anaszewski@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190330183942.6589-1-jacek.anaszewski@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds.git
 tags/led-fixes-for-5.1-rc3
X-PR-Tracked-Commit-Id: 909346433064b8d840dc82af26161926b8d37558
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b5c8314f0ebadb6d8a9789cb2d646cbef8448073
Message-Id: <155397421059.28298.16007022333271928515.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Mar 2019 19:30:10 +0000
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, jacek.anaszewski@gmail.com,
        kjlu@umn.edu, linux@rasmusvillemoes.dk, rafal@milecki.pl
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 30 Mar 2019 19:39:42 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds.git tags/led-fixes-for-5.1-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b5c8314f0ebadb6d8a9789cb2d646cbef8448073

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
