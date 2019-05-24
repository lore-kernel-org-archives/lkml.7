Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1919C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B227B2184E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558719394;
	bh=LTE8uBOABCG4qBCl59UATf23t5+kQowRZNSGB1asVNM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=zKv9BjTAlklTmE9fa6kaOUmS8my8cQzuCaeeLAJKJPD97FxUtAogVusfQvvO7VKjs
	 k8lqddyn5dWozLyOhThZtw4Wz7c8JLGHUV9DOWwl7Oknhqlj8m4DpiaFVX6oqOUg+R
	 GifRouv1rEOLk0jn9idP7a4hxUfsBx72wIGNQF04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404213AbfEXRg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:36:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391637AbfEXRfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:35:19 -0400
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.2-2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558719318;
        bh=LTE8uBOABCG4qBCl59UATf23t5+kQowRZNSGB1asVNM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BgySbZ8CthgSwsswGCoL/yW/AZ8MK+bzjle3ydlCJ77FKyHGaErbzvAiudSyqbkVu
         Jdefy88JpWkGIsekyXz5zug4ieAzKUUvxEX/mYQW9RonHBkNjZnB0abenEsitBgGPl
         ynMKpFxUMAzEPVGA7qIcnY1wfmzh9l1qhLTzsxbM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190524161119.GA21220@smile.fi.intel.com>
References: <20190524161119.GA21220@smile.fi.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190524161119.GA21220@smile.fi.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/linux-platform-drivers-x86.git
 tags/platform-drivers-x86-v5.2-2
X-PR-Tracked-Commit-Id: d6423bd03031c020121da26c41a26bd5cc6d0da3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c50bbf615f2f0028ad1771506ef8807130ccc2ce
Message-Id: <155871931840.20356.1249231899125641768.pr-tracker-bot@kernel.org>
Date:   Fri, 24 May 2019 17:35:18 +0000
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 May 2019 19:11:19 +0300:

> git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.2-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c50bbf615f2f0028ad1771506ef8807130ccc2ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
