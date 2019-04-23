Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF27C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9784217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556052904;
	bh=QOzFdnt1icuM3XptZjZeJC4OEbIA/3YEwDSraUjgy9w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=FBntwsOvj5Rc2EZSMe0nuH8fztv09wdlNcMB0b1PzFeerqbm3Lv67MgjRt2OiFiDy
	 crTXNmkEA9xNcK7+Em+v7k4cX+v7fpHr5io0dvyobjxUzwYna/atp1xpGIxBoC7TA0
	 L5OMUiPmbh2sl2L0w+cvvj+VrCLpq3Bw0Fo9OzjE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfDWUzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 16:55:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfDWUzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 16:55:02 -0400
Subject: Re: [GIT PULL] nfsd bugfixes for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556052902;
        bh=QOzFdnt1icuM3XptZjZeJC4OEbIA/3YEwDSraUjgy9w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KB6fxj4NgQJBII9kgV0WHTU9nQtmZuDAb/f1PpxdQdFcIDIiOlTkDgPOVIe0ZJ2+k
         B8QewFygRqisPXIlLiWmvpRKH/Y5maXiY/AeuaWNucGCqNEBREO8lY2xEjYJyJp/qg
         3IohNo5xwAzEIyMbmNUFdUU9FxK1/6O7n5IkU4zI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190423201139.GB10017@fieldses.org>
References: <20190423201139.GB10017@fieldses.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190423201139.GB10017@fieldses.org>
X-PR-Tracked-Remote: git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.1-1
X-PR-Tracked-Commit-Id: f456458e4d25a8962d0946891617c76cc3ff5fb9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 12a54b150fb5b6c2f3da932dc0e665355f8a5a48
Message-Id: <155605290227.7507.2089986292748608832.pr-tracker-bot@kernel.org>
Date:   Tue, 23 Apr 2019 20:55:02 +0000
To:     bfields@fieldses.org (J. Bruce Fields)
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 23 Apr 2019 16:11:39 -0400:

> git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.1-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/12a54b150fb5b6c2f3da932dc0e665355f8a5a48

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
