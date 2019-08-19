Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB92C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D842522CEC
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566257710;
	bh=SQS5aHHw3B5SB7BrUZn9rqctdeYIpVeDZXgkvvB8E2w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=gFrRaiKIALQUt6xwZPni/CrDkVkmEcPgQTRZ8P0g7Ar2wsVkSUVn0U87khyMrdUob
	 547yrMWewjnVIaLC2PgtXnKzG9okOAumSyj7S2V+jJG2gw2Ju9ygEXlrk6LOZLYgGK
	 ijFNX/W2hmui5OGSG61iZf4CLJ4Dy7Fi/JaCiznA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbfHSXfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 19:35:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728690AbfHSXfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:35:09 -0400
Subject: Re: [GIT PULL] clk fixes for v5.3-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566257708;
        bh=SQS5aHHw3B5SB7BrUZn9rqctdeYIpVeDZXgkvvB8E2w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mrD3FyZy4b1lQo57lj5IJsVXWxKCS2C8H5EWYVg5c5rFQozKcnLxQyMJbCudcGzph
         dh6Xu1n6+j+kEELbBlMw1hSpz/vCtHGVNrAmjQCPM/TPEr05FDd9XUe4DIaDeVHblY
         uJI/NF0HYobPwCDevOarmi426u26acP81GENzNH8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190819223635.59566-1-sboyd@kernel.org>
References: <20190819223635.59566-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190819223635.59566-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
 tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: 24876f09a7dfe36a82f53d304d8c1bceb3257a0f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5f97cbe22b7616ead7ae267c29cad73bc1444811
Message-Id: <156625770845.9031.12350958931590253397.pr-tracker-bot@kernel.org>
Date:   Mon, 19 Aug 2019 23:35:08 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 19 Aug 2019 15:36:35 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5f97cbe22b7616ead7ae267c29cad73bc1444811

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
