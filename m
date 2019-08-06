Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DFCC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 18:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 699A12075B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 18:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565117712;
	bh=2kH8+HNOq/3ZK5BghWUQbzBYvHld2kamc/DstEI/2Lk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=A171u6OdmnEUDOQJuoU/XW8XRaGyif16vr0DD1nS4NBnk4cpjfn0YE4vp+XFMi8EB
	 AP+irUbbnBOplv8nb7ttnzzGHKSNSXQPdgKcmWm4Y6EVc3cwrII9FFOMCZen5XrXZY
	 h9hPCO7zxTF8rRNa89dgjlmV4pj6Z0f73FdGynTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfHFSzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 14:55:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfHFSzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 14:55:10 -0400
Subject: Re: [GIT PULL] HID fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565117709;
        bh=2kH8+HNOq/3ZK5BghWUQbzBYvHld2kamc/DstEI/2Lk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dxh0X9BeUZ5uST+r1ZzLd86Ilof04OKu7GM7SMfvlbPxAykAoz6raCRejKdUXpx//
         dXwy+6hOfk+Q1/YqsBmqqwkphPsXxU7bXZ1tBQXGeGAdhZUlVu4PLQUtlR3LO0EYxl
         5VzfpVnCCJjUg3r1N26rSWR2L66qH+gMKz5XYEh0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.1908061254440.27147@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1908061254440.27147@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.1908061254440.27147@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: e0f6974a54d3f7f1b5fdf5a593bd43ce9206ec04
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f4eb1423e43376bec578c5696635b074c8bd2035
Message-Id: <156511770987.3003.13863190060476325327.pr-tracker-bot@kernel.org>
Date:   Tue, 06 Aug 2019 18:55:09 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 6 Aug 2019 12:59:39 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f4eb1423e43376bec578c5696635b074c8bd2035

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
