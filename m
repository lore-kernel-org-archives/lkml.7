Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A457C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 23:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB832086A
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 23:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565479211;
	bh=I1H+yv4T0IXqCoS+Q6XifhW8TmV/c5Ar4pq/hA/L+zw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=x6i/Yx86gC7+ehNKy0RMoU6k0RYomlxoif4CMKxsUwggvAz5L1q4IZb1ZC3jhyAYk
	 KI7x9MXokQ1PYENJXYQqWcWRgNoCnXLqxiH3KPIm5JNX0eO33bi4LMYF8ZdlPKLCTM
	 pClsGCmBea2qudqRKFRrhciKP4CrAzOg9h80CI6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfHJXUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 19:20:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbfHJXUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 19:20:08 -0400
Subject: Re: [GIT pull] core/urgent for 5.3-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565479207;
        bh=I1H+yv4T0IXqCoS+Q6XifhW8TmV/c5Ar4pq/hA/L+zw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=M8jQLMP4afU497NmihidcX+AUJUXegdwRu0LQ0v3sXFdGs4BfekQuAeO9F84+tVPA
         DHmCg4nwcNWlOAm7fonZGRljq27epZdEXHr2soFLb+m+MSWi4sUdEWdAd9QiabiI6+
         mtL9JCz2iRFbKDJ511X1JlcwGuJGr3Cd1O+mfQo0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156546731194.17538.17422312639927927426.tglx@nanos.tec.linutronix.de>
References: <156546731194.17538.17422312639927927426.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156546731194.17538.17422312639927927426.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 core-urgent-for-linus
X-PR-Tracked-Commit-Id: e6a9522ac3ff59980ea00e070b6b8573aface36a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6054f4ecdc116ce64bd5c50df8edd01d2c105e69
Message-Id: <156547920786.21687.7784231944447152746.pr-tracker-bot@kernel.org>
Date:   Sat, 10 Aug 2019 23:20:07 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 10 Aug 2019 20:01:51 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6054f4ecdc116ce64bd5c50df8edd01d2c105e69

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
