Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D976EC43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 22:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B3224679
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 22:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575759325;
	bh=5XzSFmIU7PVbmSshNy7EZ1NML47wHN86RFr0A/PoRQM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=MK6x42FOkX5tvBhnpYULJ+Mxzer+eQjjwDjRdzEiZ6aTQDysAgDGo2NkgzKl2cnN0
	 Xn/ixNEDJRDoZ+3VdyZ+JdyhH8T0QDYmTSDhHH9llmgrLiqMwzUiUru3KLc1UJ4/5f
	 Pd2XJ7+9l6Pd/X7KiW1nLLTu1g60dsiJvhAFqxjo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfLGWzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 17:55:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:46414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbfLGWzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 17:55:24 -0500
Subject: Re: [GIT PULL] xen: branch for v5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575759323;
        bh=5XzSFmIU7PVbmSshNy7EZ1NML47wHN86RFr0A/PoRQM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gDOVCVvIOUuw09yzMbNCCi1CGdykKlhtNlv/Ja1urANyNJYBEY7JnX11jB9ehPIAW
         csvMWylu0t+YdRDURZq8AFMGJIuqOEe9q8gkXk0xHYOcVVKFhoJraJ/P/mWyHZiRkn
         Tzfcz2Dh6FPX8dXJHq8m9fKkEehsiMumQofEYENs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191206165511.14749-1-jgross@suse.com>
References: <20191206165511.14749-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191206165511.14749-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git
 for-linus-5.5b-rc1-tag
X-PR-Tracked-Commit-Id: 14855954f63608c5622d5eaa964d3872ce5c5514
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f74fd13f4585e418a3e630a82468be58bf1d98c1
Message-Id: <157575932368.19906.7832606302436981258.pr-tracker-bot@kernel.org>
Date:   Sat, 07 Dec 2019 22:55:23 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  6 Dec 2019 17:55:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.5b-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f74fd13f4585e418a3e630a82468be58bf1d98c1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
