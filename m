Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D653C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E806821537
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561137919;
	bh=Ty7w7R6n5/avMNng/79ouFBUkzccQTSl/vySiTQFMcc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=NBoLLKBImhD4Woiy3Gx6BWLA14i/Pqt+ugXktgdtP0f70WXHwiCYDA340ZgAc08u5
	 yGWpQESh+S9y6184ZNZIPbXL91eqBD9eNd4YieNoEpk+lVMR874+LUx/yZAJVzKcnD
	 Z8FL9vHiEDUfbQLrYT/gEjvTzwn79gOADnx+8n+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfFURZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 13:25:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfFURZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:25:07 -0400
Subject: Re: [GIT PULL] SPDX update for 5.2-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561137906;
        bh=Ty7w7R6n5/avMNng/79ouFBUkzccQTSl/vySiTQFMcc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mvW10JWmApTpdZhOp0y0HZAWCd7mUvkGQUB4b89PlkI59x/pD+JQD6XyuFDwKHELE
         EBAL9+MsvhwhklKGYExjraO3SxOvj3HSxw79Hj3lf7YRf+4TjpIrgCA2RyE5tHXMAZ
         BIvrWhkgd4956l6rQyMTE9K/XQxDrZ2XpcQYEWzw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190621081001.GA27858@kroah.com>
References: <20190621081001.GA27858@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190621081001.GA27858@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git
 tags/spdx-5.2-rc6
X-PR-Tracked-Commit-Id: c891f3b97964a07c5797569126c90a3865a6ba18
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c884d8ac7ffccc094e9674a3eb3be90d3b296c0a
Message-Id: <156113790656.2072.5726497451909584751.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Jun 2019 17:25:06 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Jun 2019 10:10:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git tags/spdx-5.2-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c884d8ac7ffccc094e9674a3eb3be90d3b296c0a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
