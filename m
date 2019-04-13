Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D16FC10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 22:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C32820870
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 22:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555192818;
	bh=WjG4qqkjedloJq3kWZnCNdSQTagkG7dbdQQpfd48EjA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=d0jdmXjKZ5AtLMc33zb31eiDjFbeYPlTUSKBUidzxi1cFy7WJqV648326p0floR+l
	 r42R2GjBm60JyNJ2PDjp4+fm7pTEv1xTEKlP5PGJh04tKWXrp3n2AqYzXrQ/AzPaew
	 7kiBTQm7DxyLhwHeuNTDnG/9aU51MBM5ItpqFEn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfDMWAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 18:00:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727197AbfDMWAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 18:00:07 -0400
Subject: Re: [GIT PULL] clk fixes for v5.1-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555192806;
        bh=WjG4qqkjedloJq3kWZnCNdSQTagkG7dbdQQpfd48EjA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OIhWrUTOrcO4snUj7A5kVLiEjLGHc8poVWLhBHvRsrsqq1B5LeHy9jhpC0gR1IEV5
         p/gy21FZL4VwneS+1+ai7aVE8CKJQadUMcT/ablDLMlm/HrA1FJ3uyNmjbaNQkUl+S
         QJd5S2HA1ZfMisdrOtlcUKRzr699X/uE1/9gWs6k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190412232107.26830-1-sboyd@kernel.org>
References: <20190412232107.26830-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190412232107.26830-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
 tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: f89b9e1be7da8bb0aac667a0206a00975cefe6d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 09bad0df3974ef9e682447f48bb7fd55c48513f3
Message-Id: <155519280652.8399.1697359705697560259.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Apr 2019 22:00:06 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Apr 2019 16:21:07 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/09bad0df3974ef9e682447f48bb7fd55c48513f3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
