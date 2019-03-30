Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64832C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 356EA218E2
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553971812;
	bh=COnWi6nqAGv4ULw/0AJ6j+JviwkOTwD0wwDLqz2u2DE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Wh0sQttJ1d3gBPvl3mArzdobTAtEyQ29UQBkbRhUt0JHFqvcy4uFvNn1zpPqdrs6P
	 67IGa81lVGToaJtIvIQH6rum5bD+MZPWpfOczaryrPHzWKpzP0XdWm/vlteJO6aBsM
	 ZCYPj1wl1T80dEiAuDAL4F5vbk+Hl1WCbhPAeCHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730908AbfC3SuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 14:50:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730571AbfC3SuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 14:50:10 -0400
Subject: Re: [GIT PULL] USB fixes for 5.1-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553971810;
        bh=COnWi6nqAGv4ULw/0AJ6j+JviwkOTwD0wwDLqz2u2DE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pV4Rqhicc3c50xKSUKfSIwjn5OsP+r/YvZ4WVw2JGjjhL8hJoFxMe2qxB4Fjd0y7N
         cHsdDAzBoEXvh+W9deFszsn9d4uvox35vQ6iGVR21K4zN1rZsDtDy7mU3eTV2INRQd
         izPHN/0gRHV6w/J51VgLOTc17AP/pMYLCJp8i+nQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190330090323.GA5549@kroah.com>
References: <20190330090323.GA5549@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190330090323.GA5549@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.1-rc3
X-PR-Tracked-Commit-Id: d65d25b84f1f19cc35819a733576cafc54adc275
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8d02a9a89729605c3026674e4a245839be98c913
Message-Id: <155397181008.25047.18174393364882519582.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Mar 2019 18:50:10 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 30 Mar 2019 10:03:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.1-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8d02a9a89729605c3026674e4a245839be98c913

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
