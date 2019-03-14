Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740CAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A9222077B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552586124;
	bh=s8/tGYp2THgX8Q/8HFH1uHsnZ2Yuz6jP+LhrCYphHas=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=aPnvlOCkoUCHymwNoFE8U3Pw+CtKuKj6Z3P6YmwdHF8iJK0SvMyMohyJNX4giOHNS
	 0M9hFZ/EZP62IMJczVfBTjuleZC7bNbEsaKhCKsCHSS7Gc+Cmf8KdFNIIqDhBhxWb4
	 wOl+Y5chh3oX63GR/KIhRXMqHFENAZr9P8nEIxV8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfCNRzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 13:55:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728140AbfCNRzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 13:55:19 -0400
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552586118;
        bh=s8/tGYp2THgX8Q/8HFH1uHsnZ2Yuz6jP+LhrCYphHas=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bvQEl5jsg55Nf0v0GYTXovVchTRrUhg1jxXz+H/1n7fhuloqb8guFzoJ63C9ZmBsS
         aGj4UjMm/sqiHXVNPZth7Rp3r7tuYdmKGYcFwn49bxLySVesz1ozt375JPD3+P0PcZ
         k5mOZcgBsGeS5UsBeh9N85Ude+74nFeYim2OpeC8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190313.180804.1057329630088536833.davem@davemloft.net>
References: <20190313.180804.1057329630088536833.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190313.180804.1057329630088536833.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
 refs/heads/master
X-PR-Tracked-Commit-Id: 9417d81f4f8adfe20a12dd1fadf73a618cbd945d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f3ca4c55a6581c46e9f4a592dd698a7c67a713dd
Message-Id: <155258611838.11723.18199274547895583337.pr-tracker-bot@kernel.org>
Date:   Thu, 14 Mar 2019 17:55:18 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 13 Mar 2019 18:08:04 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f3ca4c55a6581c46e9f4a592dd698a7c67a713dd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
