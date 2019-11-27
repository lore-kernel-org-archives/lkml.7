Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70703C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 18:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D07020866
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 18:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574880315;
	bh=IPtP5k7X95cv/apnP30/g95MUTKS4T3C9d8Zjt0M0/I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=2PE5wxWj0qn5J/E9lQoKucSWHELyrp1ChtiSHnBpw9j/n1EOOTZbGAuc4SJrXadSs
	 Of2mMO2Ng/zg8hsg93SSdFIftnuJOnCIx/SyNvhqxPPxqJhvKL50KLfAQ7MPQ/Rn+o
	 2eGVSxLntXgEEbkjqj5FyHUAiaERkt+lBBtVvxV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfK0SpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 13:45:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:57732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbfK0SpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 13:45:13 -0500
Subject: Re: [GIT PULL] hwmon updates for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574880312;
        bh=IPtP5k7X95cv/apnP30/g95MUTKS4T3C9d8Zjt0M0/I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=C/c+EHDJw6jPF4M+bxxol2qlDwRRd6HQBFc7xttCmQMpo6EaecMvvZGPNvYDOsa52
         w1qZ5ReIhhoDgNYjAHIQNzHS+mQpAKfmxr2wgJy6DCi2VYlivUjS0AK7hg+KGJFw7r
         u5rej5GGSxAsqX6lSOemlNWd7IlLb4go4d/Zc17c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191126123101.7353-1-linux@roeck-us.net>
References: <20191126123101.7353-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191126123101.7353-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
 hwmon-for-v5.5
X-PR-Tracked-Commit-Id: 4a1288f1c1cf5829f90c30f9d1af67f526ba4d85
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3d9e3501a064eff90274f1ce927fe71ca1ff4205
Message-Id: <157488031267.21185.10961846698473106.pr-tracker-bot@kernel.org>
Date:   Wed, 27 Nov 2019 18:45:12 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 26 Nov 2019 04:31:01 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3d9e3501a064eff90274f1ce927fe71ca1ff4205

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
