Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AE0C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 20:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19A720663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 20:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561406710;
	bh=crDJL2eG55umJ+7XRLK2sVX2vZcj3pgpiKG3X3PLV4E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=F+RxIYbZdUdke/zsboJGdyFT54NMkgywyTlKyH3xQBuZ5ZPl1F6iRFw68Nxem+bl9
	 MFCN2iUk4nng6n01MbKMswG3IfyYvT134Fmy+BhRtCrBLd7VgzOEkpIJCjYV4RdxMj
	 pP+eFcvXDWpVroJBfYKZiQNcCBGTs8KGqMNb3OEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731419AbfFXUFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 16:05:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727419AbfFXUFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 16:05:05 -0400
Subject: Re: [GIT PULL v2] MFD fixes for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561406704;
        bh=crDJL2eG55umJ+7XRLK2sVX2vZcj3pgpiKG3X3PLV4E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TkxJGGNhi0/5nAIwSs69uMiN3/smwCgs2RUSrbh7UuKQeXyYT2X4QIhBgwfJDIT8W
         +lTcB+YUPM46mWHFhcW+P7F/Ylj9dTLPVxudOQKn2ax+ISlJrYNRvuZXUAXIBhnYdu
         Ly0mHxHM4NyjVq2idj6mpJx1jgFFRFgujScc0yp4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190624143411.GI4699@dell>
References: <20190617100054.GE16364@dell> <20190624143411.GI4699@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190624143411.GI4699@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-fixes-5.2-1
X-PR-Tracked-Commit-Id: 63b2de12b7eeacfb2edbe005f5c3cff17a2a02e2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c88e40e07cd967dcdf37321a63ab6e8b0d881100
Message-Id: <156140670468.9276.9194444706869699762.pr-tracker-bot@kernel.org>
Date:   Mon, 24 Jun 2019 20:05:04 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Jun 2019 15:34:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-fixes-5.2-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c88e40e07cd967dcdf37321a63ab6e8b0d881100

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
