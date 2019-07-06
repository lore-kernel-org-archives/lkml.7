Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC84C0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 17:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CF8206A2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 17:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562434812;
	bh=DDGJyMOZp6RA66h0wOjZeXelwe+hP66LdsWVhq9eM/E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=GdIslkyqGN97nZQ53IiCjHQnOVoLqg0gFmSlLkE1WJ3RPWlIfvmV3nzvnXYVs9uq/
	 V/9I+iHwd/WhPV3zmF0ugvK2CwkGFSbN1YAqQtgDJg3XVhLwqPuY2DYiFEVYPlOtF2
	 wSt4Sm2ZWp7ZHxKJ9rxVa46Ps2XHn4j3ENxBzxcM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfGFRkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 13:40:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:39130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727130AbfGFRkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 13:40:07 -0400
Subject: Re: [GIT PULL] dmaengine fixes for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562434806;
        bh=DDGJyMOZp6RA66h0wOjZeXelwe+hP66LdsWVhq9eM/E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cR7DBsuIdEFT4W9eEvBrvyqTojKvslfsdidcKkXVrRKufxGr+tC5efq5DFd8tBnFB
         39MBXrvPN3dkxqRwF3qPRR0MuKP9rMMQleN4zF5vqNZth1ECddY3dYjWmwBL+Rbjxk
         6/Nums1JE2fUy98m41UPce9J6ccUUQ1ILFowmE6w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190706143142.GG2911@vkoul-mobl>
References: <20190706143142.GG2911@vkoul-mobl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190706143142.GG2911@vkoul-mobl>
X-PR-Tracked-Remote: git://git.infradead.org/users/vkoul/slave-dma.git
 tags/dmaengine-fix-5.2
X-PR-Tracked-Commit-Id: f6034225442c4a87906d36e975fd9e99a8f95487
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2692982b0800c6f6446e9edd4743239666e69f2e
Message-Id: <156243480674.9000.918287204310707655.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Jul 2019 17:40:06 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 6 Jul 2019 20:01:42 +0530:

> git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-fix-5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2692982b0800c6f6446e9edd4743239666e69f2e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
