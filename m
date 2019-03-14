Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E5EC10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 591CB21855
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552586117;
	bh=5BpPG4ZM3MOQOs0JU/7j368i3/4hGgtGjCpPreu9aHI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=J3k8NlubfkZKFKzmnywEYmSkRBpvxRMGAt/luTFLLDCnC9WGcwwKvllci6r7PYLjc
	 XD2xrmlDpyRlwpR5TT0ri+AIfFtEz5SF9rCgzAbanr84zdHFj/auUaNcwV0rGysTSV
	 LQXj8dvRh1OBuZDDpyhLS++tneg6Jov3+8L5Q2qY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfCNRzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 13:55:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728109AbfCNRzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 13:55:16 -0400
Subject: Re: [GIT PULL] clk changes for the merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552586115;
        bh=5BpPG4ZM3MOQOs0JU/7j368i3/4hGgtGjCpPreu9aHI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Ut6Hqekv3oDeowsa/c8s+pMQIaAHas17umG7sqH/0zVOXRkkoUQTy4er2L+NsvrlX
         ZlpjfqnD2rrYkYKnNz62Pf92hu1QjLvViEGNeRD6lJyfbrinZhZdhtamh8bzq5Pq5m
         zv9NHK9jxeyA7pQLvK4oIyoboXgN+0tlrcD10cUY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190313182826.71926-1-sboyd@kernel.org>
References: <20190313182826.71926-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190313182826.71926-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
 tags/clk-for-linus
X-PR-Tracked-Commit-Id: 010d5166bbe95523e8584f3caca9f1bbeac9ea6e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dc2535be1fd547fbd56aff091370280007b0a1af
Message-Id: <155258611549.11723.7331117740931663978.pr-tracker-bot@kernel.org>
Date:   Thu, 14 Mar 2019 17:55:15 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 13 Mar 2019 11:28:26 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dc2535be1fd547fbd56aff091370280007b0a1af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
