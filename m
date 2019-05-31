Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDDFC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 03:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659A426260
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 03:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559271614;
	bh=g6c9X+Ca81eqt7cEcqsS9icVqt6e0RWJqE3HvColbx0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=qt7FMov808no8mpqkHQDu3kF4OEgqlRlnfn+qyq9/9oMCpHZe5dgn4mQoTZ8xjOOk
	 Cusn/Clj/pP9Ly8P3c019AKro853uJ8DxVCmeun1G6nM50VvaXZh3EEo65ZgD0/uab
	 +NNmO1Oov+ese+luxnnJ/8qGBL1vxZ8l2y6Rq1+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfEaDAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 23:00:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbfEaDAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 23:00:13 -0400
Subject: Re: [GIT PULL] clk fixes for v5.2-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559271612;
        bh=g6c9X+Ca81eqt7cEcqsS9icVqt6e0RWJqE3HvColbx0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XxuX6z9e5BV6303Z9mZ5cayqt796SuIBPznThy+KtpkJ6b8c/EwsxbKYNAtPTSSnR
         XEiMBRjSnp5mQ/aXnZ14W7cHzzQykLssK3/+zhtjdiYaDnZCO3GSBtj4BYX3i4F7Et
         k58qyJ+jJ2kNc73Zr0pYVv1h8tUaNloaZsTg0/Q0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190529222916.57086-1-sboyd@kernel.org>
References: <20190529222916.57086-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190529222916.57086-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
 tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: 1cc54078d104f5b4d7e9f8d55362efa5a8daffdb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 20f944965601c59e68865d4ee12225fbabb5652b
Message-Id: <155927161275.12059.9392571568533875376.pr-tracker-bot@kernel.org>
Date:   Fri, 31 May 2019 03:00:12 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 29 May 2019 15:29:16 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/20f944965601c59e68865d4ee12225fbabb5652b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
