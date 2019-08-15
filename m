Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA1DC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A8720578
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565886407;
	bh=LUWi7OdKQ3fF7CIItzxfkuU1K9FXN70u6XiyxfBpZQc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=uVi8xt0Skr3r0E5omtYq+dYrYzA0PTMQtrBL/SvohTRNaoD2FXAC/rhaRGYgx1vWz
	 VbrejyCbgB7AjTQzrM2KdvS11GGPczwveb25mLamKWjNvtfggLq+habUzLsMEiQLsw
	 RulOKns4vjzPpENB7qc2pCtWlwPB3qWX71T5mGDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731895AbfHOQ0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 12:26:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731068AbfHOQZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 12:25:06 -0400
Subject: Re: [GIT PULL] auxdisplay for v5.3-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565886305;
        bh=LUWi7OdKQ3fF7CIItzxfkuU1K9FXN70u6XiyxfBpZQc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1pfMUCphz1Cy2ipKS/eOU4SyzxvaUAT1GdJbu/t/+g7okw/6a6gKAo9ccFB2SZ+39
         tNdi7ixzOhDVJNE2bslhxsV1I3/Pz7PrJjUiFgzIX+A0k2PnHIvYKlWYG1iDLTTiXG
         OWXyMOGF5hsl4mb4rYrqLnecugJRNYcu01wDATMk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190815153403.GA27385@gmail.com>
References: <20190815153403.GA27385@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190815153403.GA27385@gmail.com>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git
 tags/auxdisplay-for-linus-v5.3-rc5
X-PR-Tracked-Commit-Id: 6c4d6bc5486466e3a67cc47270001d0b4a26eed4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 329120423947e8b36fd2f8b5cf69944405d0aece
Message-Id: <156588630558.19165.11562944340118944443.pr-tracker-bot@kernel.org>
Date:   Thu, 15 Aug 2019 16:25:05 +0000
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Masanari Iida <standby24x7@gmail.com>,
        Mans Rullgard <mans@mansr.com>,
        zhengbin <zhengbin13@huawei.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 15 Aug 2019 17:34:03 +0200:

> https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.3-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/329120423947e8b36fd2f8b5cf69944405d0aece

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
