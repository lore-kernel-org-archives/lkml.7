Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF734C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990D62085A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551983417;
	bh=wAB1xHMMU4fHxsi5KqQjP/yCUVQqyEuKezc92R0L0lo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=PiHYhMunGqSTdbluThbI48I5cN4TuzCRSHBdcCpqnJSo7vufbRSkU5VkOfK5J8353
	 QfCcHIdX22+YgXf3aS/u23nNKVJkj8o+AcaHU399U+9FBqgbZJwx/iiSfe9qKMVfnG
	 sgPZBmAgm4R0yQO4WSY5cMz8ZJIB+HmTnICbvdiA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfCGSaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:30:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:40660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbfCGSaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 13:30:15 -0500
Subject: Re: [GIT PULL] percpu changes for v5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551983415;
        bh=wAB1xHMMU4fHxsi5KqQjP/yCUVQqyEuKezc92R0L0lo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=R662awv6AZmFpNTb0T6WxgzmzpBNBTLWR7eHvoo665vQdIfjf4RxdvTdndqAlmrWG
         LExqSEGeml3qDNtWixe5YbAljHG8ZaAG79B2htz9++17Xr2fRZjuqCwy0nSBqwwcDv
         GNLERQWCrRnPXiQ177cxpLxhWSJ70iV6BTKmEfl8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190305194600.GA4595@dennisz-mbp.dhcp.thefacebook.com>
References: <20190305194600.GA4595@dennisz-mbp.dhcp.thefacebook.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190305194600.GA4595@dennisz-mbp.dhcp.thefacebook.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.1
X-PR-Tracked-Commit-Id: 1b046b445c0f856c3c1eed38a348bd87cc2dc730
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8d521d94dacd2bcca5ef2054b6d9d9986da81423
Message-Id: <155198341496.27511.9318711392342592677.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Mar 2019 18:30:14 +0000
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 5 Mar 2019 14:46:00 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8d521d94dacd2bcca5ef2054b6d9d9986da81423

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
