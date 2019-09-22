Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B799C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 16:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2284E20869
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 16:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569170725;
	bh=vYxYLVwvcO0LQ0L0z0BoQXmDoJE6GRqLqkT9hzsdKck=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=x0UZXZQfEwFzKaF2WTm4M35QBC14RaC4VMOzJWH3mlTf7jW9aFKxLfhLCfu2T9tWR
	 vHPvciZfxqfY1/v4CqSgPCnxXHRfwczCRSWU4Ab6uZVllszv2xB8oHD+a7ILW027Dw
	 A0f2tmVMzy1lHF4Dg5X5OIPTb8n2PReF4gAy+GK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388050AbfIVQpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 12:45:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387634AbfIVQpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 12:45:24 -0400
Subject: Re: [GIT PULL] MIPS changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569170723;
        bh=vYxYLVwvcO0LQ0L0z0BoQXmDoJE6GRqLqkT9hzsdKck=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FUGKhACtHyLamXBNPcnUVFLV0Ci6r/d3pb7tVbSA7V5iW9g1NflHEzmhWRnhd2Sfo
         lT0UJ7Ub6wm4Un35RKpggMtmhNHfHVZWwg7Z0gU2DSl794a9SEKX39Aq7rKOIGDWf1
         NVwpR+a2otoufhslKOoaXLg4GEPHyc+zkWXAHpqY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190921231022.kawfomtmka737arq@pburton-laptop>
References: <20190921231022.kawfomtmka737arq@pburton-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190921231022.kawfomtmka737arq@pburton-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_5.4
X-PR-Tracked-Commit-Id: 05d013a0366d50f4f0dbebf8c1b22b42020bf49a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c6bd5de3c2e5bc8a17451e281ed2613375a7fd5
Message-Id: <156917072346.28578.17503186343264480522.pr-tracker-bot@kernel.org>
Date:   Sun, 22 Sep 2019 16:45:23 +0000
To:     Paul Burton <paul.burton@mips.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Sep 2019 23:10:24 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c6bd5de3c2e5bc8a17451e281ed2613375a7fd5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
