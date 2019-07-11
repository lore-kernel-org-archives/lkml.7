Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A4FC742A1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 22:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E3D821537
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 22:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562885118;
	bh=wW2Z7vKv9HPPU5zCgp4XZDJAfOe9il/iGcygteq0wBQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kxBCegq1svxdREImfasfxdB99+v4ieRiedseFwmEp1MIEs1NdnUD12q4YLrjrDhjU
	 3J9FK1lZlde44T2eiFZVNxar4iAUzZXsSlftKiIukCSxD+G8l1/iC4yCNy0urCFmx4
	 t6PVNJ8S6WdJhgfAE/KbZznEggxg5KuwafZu5Cag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbfGKWpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 18:45:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729502AbfGKWpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 18:45:14 -0400
Subject: Re: [GIT PULL] USB patches for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562885114;
        bh=wW2Z7vKv9HPPU5zCgp4XZDJAfOe9il/iGcygteq0wBQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Y3RZyZYKYS0HgOVpxRmIrJS9q7Yf/xZE6f6aMB87aSoWsWLZZQq7xOkkbIcJnMspj
         +o9LNm0dXvUHZllgyVTS8lLoB5mqu1m7TWAgpG4vTzFYVhgWlgeLkrg7y5eUa53hhN
         OHaD3nkDMwoRgPAB6gQHHh7mHM9KA9n1q88OoFDE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190710133309.GA24176@kroah.com>
References: <20190710133309.GA24176@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190710133309.GA24176@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.3-rc1
X-PR-Tracked-Commit-Id: 2bc8bb813cba6e699b29fd0b30720288866a5e5d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 17a20acaf171124017f43bc70bb4d7ca88070659
Message-Id: <156288511458.25905.16581854341300927500.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jul 2019 22:45:14 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 10 Jul 2019 15:33:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/17a20acaf171124017f43bc70bb4d7ca88070659

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
