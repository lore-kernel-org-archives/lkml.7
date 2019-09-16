Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92D6C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 23:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 992D22184D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 23:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568675118;
	bh=3PHRx9irOmcID9Dmfp3SQh2+IdbiGXiUb9w7cqBWLs0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=gJJs6JSPrOTXaT5a26PFb00eU3EgvspKOLwyj6ozH5ZA7vJDmKjFJPcAqU/hQMrQm
	 RON/1Xx3sMp0zWc6j91RsNkBqm828d36oeIf+iuEzBJMd6VKQa1DqlyygVbTdhELeN
	 NsTK1txDpDv74bivw6CtdIyklCeoSAid/NZjQN+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390077AbfIPXFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 19:05:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389940AbfIPXFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 19:05:17 -0400
Subject: Re: [git pull] m68k updates for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568675116;
        bh=3PHRx9irOmcID9Dmfp3SQh2+IdbiGXiUb9w7cqBWLs0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Fz7L5EGaOWHnjhrzCgOwsv6+Bx16wy9F+GWIAOtKu1oVq+mcbWHI00WhXDxGjWJXT
         lRAZWyY855sRwn4ShmNkSZKxD9RNjV+ukI/OZSJA0oKxK/ELTDRzEN64krkfQZpzcS
         qx0JQxah5Dth73I4HJ62/OPitfwLkev5SkDzKdeo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190916084215.14792-1-geert@linux-m68k.org>
References: <20190916084215.14792-1-geert@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190916084215.14792-1-geert@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git
 tags/m68k-for-v5.4-tag1
X-PR-Tracked-Commit-Id: 0f1979b402df5f0dd86425830ddaa191d70f3655
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dbcda58ad98936079c48728c12c27a2f333fb484
Message-Id: <156867511661.30760.4655808458959643517.pr-tracker-bot@kernel.org>
Date:   Mon, 16 Sep 2019 23:05:16 +0000
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 10:42:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.4-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dbcda58ad98936079c48728c12c27a2f333fb484

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
