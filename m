Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDADBCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A406320684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571912712;
	bh=UzI+IAzWutYkDbplIZTphZOhw2eynkxwPzee5D50VEk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=jorwQ5GHJhLN88bGEk4zdkdQVGWgSmTrlaOFSmNrGfkfvI1MC/X3P332JkKy1/kPZ
	 joOh1lTbiQZSZoqyqwoHdyo+wD0WzQ6Zu/bxDG84V2WcowrajTRAeJX9Uyqv4HhJG9
	 eK63kbTdTV6Zv6pubQ3TcXBmF3w1LjKjYpKLTZbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438758AbfJXKZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 06:25:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438730AbfJXKZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 06:25:08 -0400
Subject: Re: [GIT PULL] MFD fixes for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571912708;
        bh=UzI+IAzWutYkDbplIZTphZOhw2eynkxwPzee5D50VEk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xUZ7+HhYJ966KiQQ3zG3Dg8hpzbLxxxCF+fZrkX8kN/AUM3LMExL4jdI30KTUN2W9
         UwcUKSUi5A1Fzci85gotfv2q0K+B1oftBqZ+GP46L7+FC8P7kGhAbgTdxHs+Hmv/qX
         EnJFRqcTcHUDIJmziJVzNfVRy+SOOfwYid2pXAo0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191024075637.GH15843@dell>
References: <20191024075637.GH15843@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191024075637.GH15843@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-fixes-5.4
X-PR-Tracked-Commit-Id: 603d9299da32955d49995738541f750f2ae74839
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f116b96685a046a89c25d4a6ba2da489145c8888
Message-Id: <157191270841.16083.10644990590971486163.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Oct 2019 10:25:08 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 24 Oct 2019 08:56:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-fixes-5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f116b96685a046a89c25d4a6ba2da489145c8888

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
