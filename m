Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91114C0650F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 22:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617E32087E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 22:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564783817;
	bh=/iOPxyWeouZ47SDylD0tHyLLiM2ny/zqTTPoPgDNWD0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ynKZTX6eZ735GZyW6s9e2nlMs/FV3knfQaohTMynmwQmkYiyKeVKjzAvzTRi5iSrw
	 61dX3USnLZzMzypODgHVID259LUWEe93EpRG1nwzX3qVYQ9BFdwr/r1GEW/SihLTYd
	 QSQQcp6b52xFs1wNd00mQAbuZbQ/M9MbVGbFzYRU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437199AbfHBWKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 18:10:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730560AbfHBWKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 18:10:11 -0400
Subject: Re: [GIT PULL] SCSI fixes for 5.3-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564783810;
        bh=/iOPxyWeouZ47SDylD0tHyLLiM2ny/zqTTPoPgDNWD0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hN9kb+DuDU5kUSxO66xMtRsos9241j7yatz+6OT76f0iObPXcL1H+h2fKhHWstGiq
         L5A64/1xFvJHmxJ9WH1d7johvXC/igC7By2yeLe9qs7eE1wzcYZ+KdH8k0Qq70tPAX
         gG+54w1lShoKV+jTHB4VhEYrm9eOgaxzKb5k9IDg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1564760357.3413.22.camel@HansenPartnership.com>
References: <1564760357.3413.22.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1564760357.3413.22.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: e82f04ec6ba91065fd33a6201ffd7cab840e1475
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e6d05360b80f196ed07061327f03346b204abea
Message-Id: <156478381085.28292.10828021700660188706.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Aug 2019 22:10:10 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 02 Aug 2019 08:39:17 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e6d05360b80f196ed07061327f03346b204abea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
