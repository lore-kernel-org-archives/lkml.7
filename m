Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB856C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E4A20855
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552161323;
	bh=al15/8SuNusjjtwDcL512VzDE5MiFCwyFZhXVi9FnP8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=2NiF3OzvOwnUiyNI4GQj6PDyPzYjGpCgrjtFMS5uPfXSpGo+Ur5a9hKYieMQUlUgm
	 Kb72nuMhHVaKY8RXHu1kiTgQfh1WmN6lgRU4NcjJrgB4YnAES+suo2TBsvyxF2DCwQ
	 V5vFKpbRb58aa3+gE/LXoCPAxHwVnwlx7o2zRd2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfCITzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 14:55:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:56648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbfCITzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 14:55:20 -0500
Subject: Re: [GIT PULL] Documentation for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552161320;
        bh=al15/8SuNusjjtwDcL512VzDE5MiFCwyFZhXVi9FnP8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=E+hSBNx8yJvoNXF0hvec4fs04j09JPV6zoeze97Kva8dhrn6/XohtEfdY/hw5OwM7
         3txSEffZuunh4JBXakpBk0kPVT4/pSMYJtdZE0N7zynsKKKOwGIAYvC9sUPLZxHPzH
         Kun6WCADMQJidrsIGnzYcXh4Ge7gO5e7APdNvf/s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190307151820.1fdd73b7@lwn.net>
References: <20190307151820.1fdd73b7@lwn.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190307151820.1fdd73b7@lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-5.1
X-PR-Tracked-Commit-Id: 4064174becc09a5a2385a27c8a6fd40888b0e13c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1a29e857507046e413ca7a4a7c9cd32fed9ea255
Message-Id: <155216132031.23333.12855437492532761373.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Mar 2019 19:55:20 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 7 Mar 2019 15:18:20 -0700:

> git://git.lwn.net/linux.git tags/docs-5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1a29e857507046e413ca7a4a7c9cd32fed9ea255

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
