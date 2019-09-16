Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBB3C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 23:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B3D2184D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 23:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568675117;
	bh=SptJ/ZIVVhHBVFYaNHYBsKO4gD6Eb3M+lYvRsBt4SfU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=lqAdeZgWGsgOxHxANGwyWFUyNdhlDst3PBx8UOUoGAiZYcrjfesu8gdasUEOPXNRW
	 ZKFZsdbpzAu7YkZjO9P6fDpYBjaCuqZspUh+iCj3wqvQluJEVPMDvs6jiD3bgsntIi
	 WF9nUE7do9842Z92270iZIemEujm49xxRHx0L7XU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389925AbfIPXFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 19:05:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389816AbfIPXFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 19:05:16 -0400
Subject: Re: [GIT PULL] arm64 updates for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568675115;
        bh=SptJ/ZIVVhHBVFYaNHYBsKO4gD6Eb3M+lYvRsBt4SfU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pRI9KLRzDxQd3xN5dcyoWdXOptNSTg0n0WkXxfEbG++xsn269xzb97L8FkYgvZ+X6
         88qrUpIizli1yjMAaZHHgOWyH3D/sP7a5Z6ZylZUxVfUyp6JHUHAwiB0DvkG+cLizN
         3fokBX9TTqSJRnJTg7e4tiSeRL7r9hcwSC4E0akI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190913102014.vi4cwe6mifbsmrri@willie-the-truck>
References: <20190913102014.vi4cwe6mifbsmrri@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190913102014.vi4cwe6mifbsmrri@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-upstream
X-PR-Tracked-Commit-Id: e376897f424a1c807779a2635f62eb02d7e382f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e77fafe9afb53b7f4d8176c5cd5c10c43a905bc8
Message-Id: <156867511577.30760.5402289724585423931.pr-tracker-bot@kernel.org>
Date:   Mon, 16 Sep 2019 23:05:15 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Sep 2019 11:20:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e77fafe9afb53b7f4d8176c5cd5c10c43a905bc8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
