Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44940C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 19:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A2922087C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 19:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551814504;
	bh=hDqrivzcNNww0PW5T/zFh3ZOFCFfgBrJpUP+f2QnjAM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=W12YHmUXnptvymqTRSomVHYuP72LZ8TSXFwwKnxEw7Lvd1dlDv07DRrhuofMmQFJW
	 D2TSTrbpBssXGi9LaafNVuS1WV9I/o0fURkK4SROf0nVCKGKaVG4W/PaW+B6tGsu9f
	 2hf1iQAkC18C/7Uholz33bbM80UA9Q/VEfAMarVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfCETfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 14:35:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:37126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbfCETfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 14:35:02 -0500
Subject: Re: [GIT PULL] parisc architecture updates for kernel v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551814501;
        bh=hDqrivzcNNww0PW5T/zFh3ZOFCFfgBrJpUP+f2QnjAM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zZsRzTyktoumdbxfCtdkKOuc+ennl6v0QLwihA7Pf/QSf23gn067BcEDY/mmOjIA4
         gskqvM6rfOpgnLGKBdfhoo8VasxKOVQ2I3OjrbtsURyh64A37LZuJ9T1k7fGK+weTo
         cR0RviVVIK7DjsPOf1GqtZfLDUNcPxrDCWXcBXlI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190305080721.GA15719@ls3530.dellerweb.de>
References: <20190305080721.GA15719@ls3530.dellerweb.de>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190305080721.GA15719@ls3530.dellerweb.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
 parisc-5.1-1
X-PR-Tracked-Commit-Id: 6a5280012da50ae985da4acacc865d5e8bf30a48
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8feed3efa8022107bcb3432ac3ec9917e078ae70
Message-Id: <155181450168.15853.16005863591554303383.pr-tracker-bot@kernel.org>
Date:   Tue, 05 Mar 2019 19:35:01 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 5 Mar 2019 09:07:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.1-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8feed3efa8022107bcb3432ac3ec9917e078ae70

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
