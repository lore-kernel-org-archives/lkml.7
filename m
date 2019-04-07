Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F914C10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 16:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3984220880
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 16:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554653714;
	bh=PsP36SaWgORdTRFa1HAJsMNHmQDQ9L/4jOzqW+oFFIo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=qB4D9cl51f1JKmXUekEFE3s04M/Ks7BHPG8Z6q/hwqofp0TcrIyreRQ189+m+Qtae
	 6ExQo27FVxZYZuOvPR5BrX53u7FBXwR9Xll64puFMNvzGxoHMnQXkCNjr7buarqmJ3
	 XuZXiEOMOoDqa08AoPwzcHuqiQnOdrlSJh9878tM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfDGQPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 12:15:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfDGQPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 12:15:07 -0400
Subject: Re: [GIT PULL] SCSI fixes for 5.1-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554653707;
        bh=PsP36SaWgORdTRFa1HAJsMNHmQDQ9L/4jOzqW+oFFIo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DVIVKTBkseSpVxZJoDjXoq0jzA/an1dZcJpqgKZFxf6Z9TBHF6x3dPf+Uz2RRluw7
         M4iYA4msOU1XaaUSS+Ya/lUFh4LXdjD1y8s2jP8wZuofNkDbifkKq4X40Wzl9DAdMG
         ++d5mmpmoP+82Da4tsIhg8zWEBPHuqWRBcctT8BY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1554612821.5053.22.camel@HansenPartnership.com>
References: <1554612821.5053.22.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1554612821.5053.22.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 4eb01535886644d79a58fe652e0782a194bc3402
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eccc58cb10fe09c32febc867d926159fa043cfbb
Message-Id: <155465370692.27442.14431203935249703393.pr-tracker-bot@kernel.org>
Date:   Sun, 07 Apr 2019 16:15:06 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 06 Apr 2019 21:53:41 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eccc58cb10fe09c32febc867d926159fa043cfbb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
