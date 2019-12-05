Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2FBC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 20:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE0B24670
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 20:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575578757;
	bh=DGQ+WTA23wSIuzLCzilA0EK36h3plsb6SH5DX3bjGoA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=aIfdmaS1nfnUS7Y/PuI94NYIbUFaFRsWFtDTBOf/6bxnTBdus4KdGornBRMsjFTes
	 NbyV/dtOet11IB+ITtWQsifHln1srnoozfX6mF0rhNdEe172nFJrj6awmICvdd033g
	 xDL1fkWJVGPuF41m6FrmLqPenuet+GOMT75M7xIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbfLEUp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 15:45:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:43296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729396AbfLEUp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 15:45:26 -0500
Subject: Re: [GIT PULL v2] pwm: Changes for v5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575578726;
        bh=DGQ+WTA23wSIuzLCzilA0EK36h3plsb6SH5DX3bjGoA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EbvxUo0wMJ7o648xjdzHJGa1fyszoxIO3Mh2OQkxsViA1EsmdB84BrszjkNmNg/H6
         6M9xoKtYinOTJbHgXEUc6YZje1U35oCmpmdpkVl7whxz67Apa10nRLKgSVgvWvaxkJ
         cEHzhEge4TyISPF4OiH0cpT6Dk+9I7lgIa912pfM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191205084203.1411690-1-thierry.reding@gmail.com>
References: <20191205061044.1006766-1-thierry.reding@gmail.com>
 <20191205084203.1411690-1-thierry.reding@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191205084203.1411690-1-thierry.reding@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git
 tags/pwm/for-5.5-rc1
X-PR-Tracked-Commit-Id: 9e1b4999a1693d67cc87a887057d8012c28fb12b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d9e48dc2a71a836f17d1febbedb31470f957edb4
Message-Id: <157557872627.26858.5063056354735423757.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Dec 2019 20:45:26 +0000
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  5 Dec 2019 09:42:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d9e48dc2a71a836f17d1febbedb31470f957edb4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
