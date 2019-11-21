Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0216C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 777B4206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574368207;
	bh=sJJn2vX4vMaJu9A/XD+d4rdqtYnxXzVNfjsJmHGkXf4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=LfY/qfxeXsfnwzupvhrXSc+7G1HD9LThJ54iIs1SoUCgxlA4h3elzyYvWGv61fd3w
	 YKkVnk8z/3O0ssZHL0R7fB/+6ZPoI+bxVY3Gdp4QOc9eobtS65c+mV+5Qh5ILNJPv+
	 yy6lx3JVrEBJBK5cTO/B3/CH4rC+EdLkMm2RH3/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfKUUaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 15:30:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:37376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbfKUUaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 15:30:05 -0500
Subject: Re: [GIT PULL] thread fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574368205;
        bh=sJJn2vX4vMaJu9A/XD+d4rdqtYnxXzVNfjsJmHGkXf4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TIdN300KmSmpSWGQUKFdWJQU7mK0RWZsy7cT6VkD0oDsFzVuKahivseXVPxtoSRVS
         fxmwt/O13aQROTA/bmPWKmEOrVIJWh1flOSrB2Ky9i9FGnlxlBbWCZ1KOOIQ9dSNQf
         ibCqv7iXtzwVecOEtqjtkgETszzU+OvrEnpAvaUI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191121143133.14913-1-christian.brauner@ubuntu.com>
References: <20191121143133.14913-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191121143133.14913-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux
 tags/for-linus-2019-11-21
X-PR-Tracked-Commit-Id: 9e77716a75bc6cf54965e5ec069ba7c02b32251c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d324810acded7003c955c7c6faf4c57cd40e6000
Message-Id: <157436820515.3070.2863898083173574277.pr-tracker-bot@kernel.org>
Date:   Thu, 21 Nov 2019 20:30:05 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 21 Nov 2019 15:31:33 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-2019-11-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d324810acded7003c955c7c6faf4c57cd40e6000

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
