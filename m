Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60739C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 20:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021CE2083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 20:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559852405;
	bh=Wh4GqJ1QrWwH3h82KZyFsR/7ezT9IgfqAPS0MThe3Yc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=HS9RWXofwTi9QWq2DDK8OO1PGIaDlqTg6uzhue0WOGecve7BYoQWyO1qptnDYA2gm
	 vc9xAHwpV/PwGHsZ7Rtzv3RV7fRfdVSWkvU7JbS+IW/MZDFrIoDLcA0tYQTGDIQGgR
	 Jw+s7BcM1toPzKPOY9m9q85kHcDYwGOTrcNLf6Xo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfFFUUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 16:20:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbfFFUUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 16:20:02 -0400
Subject: Re: [GIT PULL] parisc architecture fixes for kernel v5.2-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559852401;
        bh=Wh4GqJ1QrWwH3h82KZyFsR/7ezT9IgfqAPS0MThe3Yc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Z+qQ3KUA2rM06nWeKJr5cuRZWCQ71rwOCAwI7xcnC2pxPK0wvK51lZR5WXNz24dPm
         fDGtxPNfw1K6Fhc8zBWNjKZ6cvRHN/84ujGY7Twef9ReX4edxUxk7TWpWAAb/Bc3q6
         hOUsbV6mJ+aw94tXK5zZE6+2+hMyj7naYCAeyN0s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190606154015.GA13868@ls3530>
References: <20190606154015.GA13868@ls3530>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190606154015.GA13868@ls3530>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
 parisc-5.2-3
X-PR-Tracked-Commit-Id: 527a1d1ede98479bf90c31a64822107ac7e6d276
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 16d72dd4891fecc1e1bf7ca193bb7d5b9804c038
Message-Id: <155985240168.29387.12528687456834222878.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Jun 2019 20:20:01 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 6 Jun 2019 17:40:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.2-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/16d72dd4891fecc1e1bf7ca193bb7d5b9804c038

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
