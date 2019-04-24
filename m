Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA6AC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6C5214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556149212;
	bh=bvikAQIxjxqUnFzp3d3GzA3nGfMzzq+I0hegiB3+8ZM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=KoqsNnF7t69oPzQSdtMEPkobX0x7YahRtYkESvrzGnyjXSFbFH6hlutP2VjQmPEbz
	 VUgYU7ocyBs6seCrKU+YFkihsoJDfzRcjW5Du/jgb99K3DsUn2rG5SfzbJ0l7sNEdK
	 r+ERdwuV0s0YNJcyALFiRd3rZFCWnAxksHJtQlVM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387951AbfDXXkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:40:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:44540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727944AbfDXXkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:40:05 -0400
Subject: Re: [GIT PULL] LED update for 5.1-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556149204;
        bh=bvikAQIxjxqUnFzp3d3GzA3nGfMzzq+I0hegiB3+8ZM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Lz5qCl31o8h5bExCSHyFAJhdz/E17/HrhRA7H80gSiJ9A55ZJ3hrm5TMwdHfJII6v
         6wKryDp3NqQFER5YazcrSZSz4146sU0pGHp2aAwn3iEOM4N1dDNWeK7I6gbGch44K/
         KeMLVP0yezD9zcGGQF7rDTvrfY8/J8sdI88rbgY8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190424193413.8135-1-jacek.anaszewski@gmail.com>
References: <20190424193413.8135-1-jacek.anaszewski@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190424193413.8135-1-jacek.anaszewski@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds.git
 tags/leds-for-5.1-rc7
X-PR-Tracked-Commit-Id: 52fb56f7b5a9cc23a07b2c237bad91180263a492
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 11bfe6473bf2c83e4cc44fe97d95a8b0dae1e419
Message-Id: <155614920464.7038.16723125529070373196.pr-tracker-bot@kernel.org>
Date:   Wed, 24 Apr 2019 23:40:04 +0000
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, dmurphy@ti.com,
        jacek.anaszewski@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 24 Apr 2019 21:34:13 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds.git tags/leds-for-5.1-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/11bfe6473bf2c83e4cc44fe97d95a8b0dae1e419

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
