Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19C5C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 00:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7AB20854
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 00:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555372807;
	bh=Ozz8BwKx4WM309cMku7xgEsukSfu4KXclYkMelFGBWE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=TGL7GD4Z660uN12sjAPlv1/erQx+uZSq227wXMFfb4N8GzF9Qm39Iba+Ojp07sTQb
	 YOigr/eoc7ibnU8TL5y/wM/rmRl1tTuPlCON1amp4VHNxCtm4iXm9SsLF8DCaP1NWL
	 X2QFK7WBWp5sa4HmH4uWNFwvZi47ua1zJst+e+oQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfDPAAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 20:00:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:56800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbfDPAAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 20:00:05 -0400
Subject: Re: [GIT PULL] libnvdimm fixes for 5.1-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555372805;
        bh=Ozz8BwKx4WM309cMku7xgEsukSfu4KXclYkMelFGBWE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2kMnX27qJ6AueKTVTHQvgJWE/x0eMkIdur/K+I5beq7m+rjycUZgjqrRibePolOdD
         zVInNsvDb6iXpFZeUwi1AOoqzUg6scm2sAru12u5f5H4bBQyK5TEiZM8MzT/8QqEeF
         If1iUU8eEe2PvpOJyLu/oxkSpDrHKite4adWW8yM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4gqXL4H8p-PB1196zx0Gm3+hCZcMUF5330eAGK6SWXoOw@mail.gmail.com>
References: <CAPcyv4gqXL4H8p-PB1196zx0Gm3+hCZcMUF5330eAGK6SWXoOw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4gqXL4H8p-PB1196zx0Gm3+hCZcMUF5330eAGK6SWXoOw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
 tags/libnvdimm-fixes-5.1-rc6
X-PR-Tracked-Commit-Id: 2170a0d53bee1a6c1a4ebd042f99d85aafc6c0ea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 618d919cae2fcaadc752f27ddac8b939da8b441a
Message-Id: <155537280525.2498.17068946114229367658.pr-tracker-bot@kernel.org>
Date:   Tue, 16 Apr 2019 00:00:05 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 15 Apr 2019 16:30:02 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-5.1-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/618d919cae2fcaadc752f27ddac8b939da8b441a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
