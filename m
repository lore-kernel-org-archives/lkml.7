Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9407DC04AB3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 22:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F5F2182B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 22:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557440105;
	bh=HR9k27RukiNS7295rpPWPj8IBMw3MQXBHVTb19a7odc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=WGQ55VNzBRq1gvctsCw+5P2ufTph9pPusPq43hfpdVd+sP1gnUSymdklOGg/LHf19
	 uo6gCcufjTk69Yw7bNNMoRA9FHVpfmcasxk4bLNtDE8wMw3V6srlMxXfeq7Tixgtsb
	 faQy6uIvkno7ZuHRdUv7DgW1APo16Hm73Wv82akw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfEIWPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 18:15:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727215AbfEIWPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 18:15:04 -0400
Subject: Re: [GIT PULL] RTC for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557440103;
        bh=HR9k27RukiNS7295rpPWPj8IBMw3MQXBHVTb19a7odc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KZ2PGvlOmCDCiHkOYvP82sAv6hZmBwfmdhhxyAACA8Xfk+I4rP8ivzfgNFQxALl2k
         AD1zsiP0KN36AbmwePw9KwKszdAWySG8FCxAuuD9UbclPTgaQiLk7gXdG06zumIY/8
         gYr5Sj7ac3kIXqP9Gccy6OX8rawOfNL+wMwB4oUU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190509210340.GA23061@piout.net>
References: <20190509210340.GA23061@piout.net>
X-PR-Tracked-List-Id: <linux-rtc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190509210340.GA23061@piout.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-5.2
X-PR-Tracked-Commit-Id: dacb6a4035a010e41abaf81c1cfe2beadfb05ec8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8e4ff713ce313dcabbb60e6ede1ffc193e67631f
Message-Id: <155744010342.23477.10954246669924043219.pr-tracker-bot@kernel.org>
Date:   Thu, 09 May 2019 22:15:03 +0000
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 9 May 2019 23:03:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8e4ff713ce313dcabbb60e6ede1ffc193e67631f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
