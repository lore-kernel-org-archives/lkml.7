Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D47AC4332F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 23:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9AA02173B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 23:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567897333;
	bh=XDIo+Hwz4oIoUUbQhahTifml4wkcSYCMHOgALDPpRWY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Ym1/dWx8rSIOeNXw2kkztr8xUwan82c1+irdHY2pDyTipbmakIN9z/wzGs4qYKBJJ
	 mk6++wGDufCxuvUs1bEPWYUHlzBHNk7rBYHRn5WRnCFuXEbsYv+hVLINlDDBiqjTj0
	 KzMi27rIwwsd8EUa37pIgn8+Jur7vfqZKfUeKbuI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393417AbfIGWzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 18:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727736AbfIGWzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 18:55:06 -0400
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.3-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567896906;
        bh=XDIo+Hwz4oIoUUbQhahTifml4wkcSYCMHOgALDPpRWY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UQc5FZ4KD/syLdkjlKv63/bjKE3wunzXxU2sC8YHXjCjlfvzCZlIOerOklSB8hqlO
         e1ItU3hg8h2R0OTWFnFeLWfxLKFdRHcvtO4OcSlfMvUX5XDZaR7m8YyuB/I2DuXICA
         kCvOL2spWB65AKDSjxASZnZUYUkldMTvXOUu/rNQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190907184033.GA29833@kroah.com>
References: <20190907184033.GA29833@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190907184033.GA29833@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.3-rc8
X-PR-Tracked-Commit-Id: a8e0abae2fe0e788fa3d92c043605d1211c13735
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b3a9964cfa690150e49ae75ba16416ccaac3a8ba
Message-Id: <156789690608.22328.15231426646920271750.pr-tracker-bot@kernel.org>
Date:   Sat, 07 Sep 2019 22:55:06 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 7 Sep 2019 19:40:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.3-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b3a9964cfa690150e49ae75ba16416ccaac3a8ba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
