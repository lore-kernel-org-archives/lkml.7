Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B91C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 19:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892202166E
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 19:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565465435;
	bh=PWDohFDSasxyksialntFaoZcEWNbiK/iivGkfeWr1uw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=bP7VK1+w6OZQTvqBvY8lYq684uOqMm/LmvDnNAc+UQNFaxO8jZovQ5Gy9tAJki9ab
	 dVtdX9px/htB8N5TXYLvHRclYrLCyKlioAuimHFvVj46qQKAxQwlkmpr3xQVy/YFat
	 dwAhch8YU9AweF9Tia39OyzAsDYDNtphef4vXz3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfHJTae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 15:30:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfHJTaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 15:30:09 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.3-4 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565465409;
        bh=PWDohFDSasxyksialntFaoZcEWNbiK/iivGkfeWr1uw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZEhBTphYgbfQJIXsjm+jBFittizsX8pMRQoOOP2HyNsclJ8qoh3L7ypNpY+dYsi4f
         wrdCQtmpLmqENY+Dg3TM0lskv6gx8KfbgFy6LEgw173FcIHMixoOQd040gp4bmoNVI
         PZTyROBEazVP3N2APSwsOsFhFhpSB1WCBUjEv7PQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87imr5s522.fsf@concordia.ellerman.id.au>
References: <87imr5s522.fsf@concordia.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87imr5s522.fsf@concordia.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.3-4
X-PR-Tracked-Commit-Id: ed4289e8b48845888ee46377bd2b55884a55e60b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 23df57afe8eebff6ece05a815934f2f70a851e0a
Message-Id: <156546540923.17840.11502066907929648245.pr-tracker-bot@kernel.org>
Date:   Sat, 10 Aug 2019 19:30:09 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 10 Aug 2019 20:11:49 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.3-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/23df57afe8eebff6ece05a815934f2f70a851e0a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
