Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484FDC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 17:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2335321882
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 17:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567443914;
	bh=QYsGIBhIUPEH748g2PRCo3RmVuWu7d0tVoxdorccQIQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=uXOpebFr9q4hAp/PUGQRQDWka7x/C+a3cqFiZIJ/dnA7NWFoFcoGn4pmMLFO2mnTB
	 CSpcKnYOyYanY8XLp7njzvsTyzVPxkakSaCI8BqInZcwnf8i5QDp8RoqZESAAKRVk9
	 LmsuYId4K67p7PBgA5T36vOsKBJzrLICB+s5d+qE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfIBRFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 13:05:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbfIBRFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 13:05:08 -0400
Subject: Re: [GIT PULL] USB fixes for 5.3-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567443908;
        bh=QYsGIBhIUPEH748g2PRCo3RmVuWu7d0tVoxdorccQIQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=W5rvoYBGHRT5BPyBqEO18/QxUhmpdUhu8NMHrpqZ20IltbKOA2rZkxLRJw+3euHnu
         l6HcKgSvicT18T9zi3tpyCl+3y8xCxpDFb/WRmRPjB7GpyuJta3yZn+bV1pxrWnxbh
         l/hjEazNWANuTGcYPe/v6DceQHapP3x7uJx8GWRA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190902153351.GA9779@kroah.com>
References: <20190902153351.GA9779@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190902153351.GA9779@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.3-rc7
X-PR-Tracked-Commit-Id: 1426bd2c9f7e3126e2678e7469dca9fd9fc6dd3e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2c248f92fa4fae3036e656da2f9a077020a99f6e
Message-Id: <156744390795.11156.15723859971178759975.pr-tracker-bot@kernel.org>
Date:   Mon, 02 Sep 2019 17:05:07 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 2 Sep 2019 17:33:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.3-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2c248f92fa4fae3036e656da2f9a077020a99f6e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
