Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85836C432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 02:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5952621774
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 02:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575252317;
	bh=K68W3Mv5HgsV4huwvpG4Iem5rQTq5lgJNmFCuMgKMzc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=MmuDCknqCGCg2kCPy6jtO/itHba2/ftwXqMMHhNwffhsMLeNmqNQEc0jnwS6GQQ+P
	 0pTmqVniigzFUUvU1hpYw5+MHWx9cssm7k5RIMzJGSmPBtGag2sCcPH7B/IVzp0A+N
	 EvTU7pS3fHg2hTjcPk/mNRYAlVMzoZ2sGs4s0bHc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfLBCFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 21:05:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:53812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727681AbfLBCFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 21:05:15 -0500
Subject: Re: [GIT PULL] clk changes for the merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575252315;
        bh=K68W3Mv5HgsV4huwvpG4Iem5rQTq5lgJNmFCuMgKMzc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=eP8JPV7TMh6qncxG03oEieVyxxx5nXL/+JMN3SEeEAp+3SEOceCOVBUltZcSSqKh3
         gP/2ZRbnTdTodVF+oZZmmyMUWmQAOOiYssLx6Cgn8fmKgQlaXYykysVeGasU1lpzT/
         MQGTYNB7hlMspvdQe43e85y/nHgkSlCVV9xFKJl0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191127213618.236975-1-sboyd@kernel.org>
References: <20191127213618.236975-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191127213618.236975-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
 tags/clk-for-linus
X-PR-Tracked-Commit-Id: ec16ffe36d80b18a1f98d126a865d5557ab27c30
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ddebe839c6013ab42f376bdeaaaf66bd0c0d68d6
Message-Id: <157525231526.26823.9137353742819638605.pr-tracker-bot@kernel.org>
Date:   Mon, 02 Dec 2019 02:05:15 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 27 Nov 2019 13:36:18 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ddebe839c6013ab42f376bdeaaaf66bd0c0d68d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
