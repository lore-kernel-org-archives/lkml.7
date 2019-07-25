Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E3AC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE3F22BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564071927;
	bh=cfY8bCJ/OuwGmvvnpu0ntokwPjSgMK2lslzCSKYKiTY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=YXTYD7WPhNIESAYoWg8vMupkwz7FWoBio6u3GWI9j4tNeKB3stHPaGyrTYgsCzR8f
	 cyLRSIFj+c4auT4tLaFq3ZWNg/Wk9NA3tU9rBBulYcgLJspigmvBl9Sv8OuNZG2Z3R
	 sVD/385vbqlqGJj9dhEq67Yi/ev8cvcpJ2fzLfN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390574AbfGYQZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:25:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387917AbfGYQZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:25:20 -0400
Subject: Re: [GIT PULL] Power management fixes for v5.3-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564071919;
        bh=cfY8bCJ/OuwGmvvnpu0ntokwPjSgMK2lslzCSKYKiTY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Xa/EoouE/KUDscXwTHDOIuzC0UDnazY10rQoUtRyrBS35fCsFyAJfJM2JgL312NoK
         DJuHdevSlM2SCaNN4KUMN0ojogopLZ7u7m3FRJwUMVK0e3AdoXjD/WMhov/Cj/IvNo
         bbWOIR9h1GHDXIp8fJyGt+dhrnX3ZBLIhmend0Lc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0h5ZR9EhER_J1Qn9PJL-OAWbFvUb1rjTJkBg22p+Db6Kg@mail.gmail.com>
References: <CAJZ5v0h5ZR9EhER_J1Qn9PJL-OAWbFvUb1rjTJkBg22p+Db6Kg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0h5ZR9EhER_J1Qn9PJL-OAWbFvUb1rjTJkBg22p+Db6Kg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.3-rc2
X-PR-Tracked-Commit-Id: fdc75701578269f6931975aebf4069d9d8c77d34
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6789f873ed373319cbf83b56455baf00769bb79a
Message-Id: <156407191963.26857.17535064372378613610.pr-tracker-bot@kernel.org>
Date:   Thu, 25 Jul 2019 16:25:19 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 25 Jul 2019 11:26:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.3-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6789f873ed373319cbf83b56455baf00769bb79a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
