Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096BBC76191
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 17:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24FD205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 17:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563730525;
	bh=OHcHPedLAuCAg2iwgigF5vzrK9VUCL7DIw2gKTqreXg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kT970vKkT14Evy1cYr3K7Ib0l1Zzgvt1D8Ymjl10zbPXxjVt+QOWPGuVogYyvfk3E
	 9woCzUZo6x3tPpEifwRJqnxsZ0HAvfP53soP5FMPgie4HUvMpvcGviOYa8C8dvHvOS
	 4iwjTYLqHUL2BLt1eYGRZhJyBFhXXJQFZc8qFVzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfGURfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 13:35:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfGURfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 13:35:24 -0400
Subject: Re: [GIT PULL] NTB changes for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563730523;
        bh=OHcHPedLAuCAg2iwgigF5vzrK9VUCL7DIw2gKTqreXg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uh06qs0+bzy44AzqbOeJ49MVZLIaBozp1wRKviFs5knPcWRuvn9OwdqmUeReLY+2q
         sh4sRHOFDvQmiYWn9uwCHXdaW5Rfs1WQA86E2YuQ0Tkmzcr8VINHA++JuC68u/H25v
         W8RIjpBhTUijXZbfhNKZ6zFORDAgTsnXiCrqqZNU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190720215829.GA10213@graymalkin>
References: <20190720215829.GA10213@graymalkin>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190720215829.GA10213@graymalkin>
X-PR-Tracked-Remote: git://github.com/jonmason/ntb tags/ntb-5.3
X-PR-Tracked-Commit-Id: d9c53aa440b332059f7f0ce3f7868ff1dc58c62c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bec5545edef658f81cd9721dbe8fbebeb3c7534d
Message-Id: <156373052375.21043.14221658326083971620.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Jul 2019 17:35:23 +0000
To:     Jon Mason <jdmason@kudzu.us>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-ntb@googlegroups.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 20 Jul 2019 17:58:29 -0400:

> git://github.com/jonmason/ntb tags/ntb-5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bec5545edef658f81cd9721dbe8fbebeb3c7534d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
