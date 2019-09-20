Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970BFC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 23:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693D3206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 23:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569020432;
	bh=zMRR4T7A7gCoeONvPDtUNTpxmIuYHH/9EVmvQZmZIbU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=V54roSQVxXTn6P8+oqQyR8q9Y3koEw7hprxQliugWlyOqyJrmaMr0kSKRWvAQZW8O
	 K9eo54N5kodLIiVIhH4AZwMOH9sfSW6kyzoSUyM1Oe+pF20g0v9YFVQBRhlFoO0GS2
	 PDcN4sdJf3mD+k4TU76IHdzaUpCLjhZfh0pNBnIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406965AbfITXAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 19:00:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404690AbfITXA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 19:00:28 -0400
Subject: Re: [GIT PULL] clk changes for the merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569020428;
        bh=zMRR4T7A7gCoeONvPDtUNTpxmIuYHH/9EVmvQZmZIbU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=arGTReYPfyVN/rsaJb1AcAW3Lp2cy43GnbLB4Ntu1OinfWSljOaJrwdsfhh2dUwru
         3tJsBYSMGeeT8xbtLKXtNr+HJs4faDHK9FvfR/ibaltN16Cw6hfyyYGuBzXOYBouUW
         SXWJBr0+DbAODz8AbxBdXBysaR7JyvR+5DeH2M4Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190920214042.261378-1-sboyd@kernel.org>
References: <20190920214042.261378-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190920214042.261378-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
 tags/clk-for-linus
X-PR-Tracked-Commit-Id: ebd47c8434064687ab6641e837144e0a3ea3872d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a703d279c57e1bfe2b6536c3a17c1c498b416d24
Message-Id: <156902042837.31413.4918553714894313165.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Sep 2019 23:00:28 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Sep 2019 14:40:42 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a703d279c57e1bfe2b6536c3a17c1c498b416d24

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
