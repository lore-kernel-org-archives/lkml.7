Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40941C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 04:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C69320869
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 04:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555128327;
	bh=5SKdDrHSkA0OAfcYOzRGSGr88OFHOVKDax+/n2OCDWg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=i8DsIiw+ywRP03TNRy2W/iBX6rcQcfgbjz6xegg/bbUcv5FpxLN5UAmbomo3ucTTx
	 xyd3hKDSvCw3QzFOZYJWvbe8QvkGZhmkC3pu5QZQzUftXRlYhtvJp9FxT4CeWvDa5k
	 bC/+nwodPlyzhgNy4gmnw+v+kWlSUyCczhuakAQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfDMEFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 00:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbfDMEFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 00:05:05 -0400
Subject: Re: [GIT PULL] locking fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555128305;
        bh=5SKdDrHSkA0OAfcYOzRGSGr88OFHOVKDax+/n2OCDWg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Oqjq0TY6aOW2jWQjkfx6H36+DwzuUWmJsfwNm1N7i/jGrUQ4L9nxV5UL/7si/33G1
         R6YCDd/CZbSf3gC4FbvhguGs0eoTLpdXr96AJ+lxVlSFB4Hotn4zFUfCQqRZ6wSXMo
         SJOOCnVgL73CDrg9WZyklyXjC1qWPafPVkJUUpp8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190412115343.GA125948@gmail.com>
References: <20190412115343.GA125948@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190412115343.GA125948@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 locking-urgent-for-linus
X-PR-Tracked-Commit-Id: 90c1cba2b3b3851c151229f61801919b2904d437
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 26e2b81977bb1ad70ff9b2acb4d4cb13c23facfd
Message-Id: <155512830528.12181.4969849750418752666.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Apr 2019 04:05:05 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Apr 2019 13:53:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/26e2b81977bb1ad70ff9b2acb4d4cb13c23facfd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
