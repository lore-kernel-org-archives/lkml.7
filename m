Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F239C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 19:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A25217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 19:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558468532;
	bh=40mEgpsTgK2M9KXIl8T+ds2KGBpi9Y3W4DWFUhEppyE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=CCNK6DWVCBVgQF2FQwBssDdwqZSSegtCbnBbiMjQxfkM/zD7hbj3AuM0/NM6UOTDL
	 hUFltuvDt6OWqbOVcLs4SKYRiiJ0DyYTqpg0/3zALiWA/bNEsm807+qqlaFbJzlpM3
	 YaFdYg2OGZAYwr2xKoSgEAeh8aBlyjedrcfHjj5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfEUTzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 15:55:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727376AbfEUTzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 15:55:21 -0400
Subject: Re: [GIT PULL] SPDX update for 5.2-rc1 - round 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558468521;
        bh=40mEgpsTgK2M9KXIl8T+ds2KGBpi9Y3W4DWFUhEppyE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fmGRszpHcKZojRbWoxKDyZ9zRw+SY1uCtJ2gb7iIEDLosqtR8/wzlhRbPcEfV9IQP
         kFsEsIxzipICCZ/PCkP8CZ2orFcI82bU+4duGigDhrtEIZ2WPZyF+4J6Iaaa7YXWVq
         M9dQXgUdTiYxC0pcYl7KoluO7OBR+Rj+otLRX0bo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190521133257.GA21471@kroah.com>
References: <20190521133257.GA21471@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190521133257.GA21471@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
 tags/spdx-5.2-rc2
X-PR-Tracked-Commit-Id: 7170066ecd289cd8560695b6f86ba8dc723b6505
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2c1212de6f9794a7becba5f219fa6ce8a8222c90
Message-Id: <155846852094.2650.2370747673430410671.pr-tracker-bot@kernel.org>
Date:   Tue, 21 May 2019 19:55:20 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 21 May 2019 15:32:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/spdx-5.2-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2c1212de6f9794a7becba5f219fa6ce8a8222c90

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
