Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927EAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698362077B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552586132;
	bh=rD7U/B3huyVyL12NTVpKOhGreADdF912mzGiqlfClCI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kSckq7DnPXW1dSieFvk2D6DWcnG2DHei0Wi53//d/UTPNtjJqBY5cXtZz6EaEpEjk
	 zPQJqGeWF44mrDHis/hRtSZ3yFI1ajvsyIHu2V9NU3odMkL9qE9T7L586U9P52O7jK
	 b5ddNut72TyHdf/Qk07RaSvoplZqU9IJo5GqPx7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfCNRzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 13:55:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728132AbfCNRzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 13:55:21 -0400
Subject: Re: [GIT PULL] More ACPI updates for v5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552586121;
        bh=rD7U/B3huyVyL12NTVpKOhGreADdF912mzGiqlfClCI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=10Tue2CokQwcmud4TpI9PKpiQbYDK3SmORJTllrD1kJkov9JpkhACpBPaax2Cskt2
         DVLYtG57s/0O+ohtt72UyAujKUMZzvW1wNl/7KMJVqiybmhJJnTvR4wM33iXhBnySL
         +g71Thb7E37OKtjInhttBba0tr4K+gZNrJPmQ98U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iLKAVM0Ftv8LhS0cS=XPHXRx7sCMMtRJ9PLymGhgh4uQ@mail.gmail.com>
References: <CAJZ5v0iLKAVM0Ftv8LhS0cS=XPHXRx7sCMMtRJ9PLymGhgh4uQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iLKAVM0Ftv8LhS0cS=XPHXRx7sCMMtRJ9PLymGhgh4uQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.1-rc1-2
X-PR-Tracked-Commit-Id: b6e88119f1edcdc1fa3fd3a168310ac2d433a873
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b319ee220a8795406852a897299dbdfc1b09911
Message-Id: <155258612116.11723.2158020966140173379.pr-tracker-bot@kernel.org>
Date:   Thu, 14 Mar 2019 17:55:21 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 14 Mar 2019 12:36:13 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.1-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b319ee220a8795406852a897299dbdfc1b09911

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
