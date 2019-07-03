Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71147C06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D04218CA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562142010;
	bh=MVzVJpInDUh/t/Kb8aZnmgv6ClflOSu5uyQi6/Lcuog=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=J4XT60w3zt2FPGvXYfb6ORKDY9bcQl7F2MBgMqQz0rebM5WpAI+AoX1zo94Y9FodI
	 Dp5OK9G6hebTsbKBOokcDAiiQ6Q3U56QupvOYikjA6WvUDJCqyprhGGxDcBbUuXnqJ
	 FceR4qHsGAeUJ5oOxT6eO/mspkzbqUa8e7LMIMYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfGCIUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 04:20:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727045AbfGCIUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 04:20:04 -0400
Subject: Re: [GIT PULL] arm64: fixes for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562142004;
        bh=MVzVJpInDUh/t/Kb8aZnmgv6ClflOSu5uyQi6/Lcuog=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=u1BW0RZ9SK+zQEhM1AhIMQG7IZzWK5f0r5dowdJ0REZi6qW/pqlUIuTGUefLi4uN7
         cBk9VC4naKZwGqoV1E6m4lvFx45+8/NezHhaayBgjEH9efEzbgariPPDZDon/KcCiw
         v0XM7gx49OW266s8qNaEF0UdjI4RgTeShvdmUTmI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190701130212.ifn7d7p2mqvquq6u@willie-the-truck>
References: <20190701130212.ifn7d7p2mqvquq6u@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190701130212.ifn7d7p2mqvquq6u@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: aa69fb62bea15126e744af2e02acc0d6cf3ed4da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b1fe9b58e9d20f23f6b07d1c2e0dbd921da67bf
Message-Id: <156214200394.4530.7499382598792922115.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Jul 2019 08:20:03 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        gregkh@linuxfoundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Jul 2019 14:02:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b1fe9b58e9d20f23f6b07d1c2e0dbd921da67bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
