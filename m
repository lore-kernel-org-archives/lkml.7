Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8867EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E102077B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552586122;
	bh=lJypYVn+5ND6/v1CmR4jtdgPkzzYecR9cIRMbluNk1g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=fgHcyau4reriWL6m5yt7ayNHyXHhACVcc9j6xMb6cf+uzEvavB2pvO4yMnWW7Y89+
	 Dr/bk2GDBimgcsl1P+vkHtevt+rshJ4H+UaPvq8ruy051LXm+87oDA9bEMAaY3tGkW
	 tgMNckv5Kpsa3gpQf6WNenhuyhUDjTS3VKMu6SMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbfCNRzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 13:55:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728132AbfCNRzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 13:55:18 -0400
Subject: Re: [PULL REQUEST] dmaengine updates for v5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552586117;
        bh=lJypYVn+5ND6/v1CmR4jtdgPkzzYecR9cIRMbluNk1g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bQrQx6GSU7asPndQ+YP8wG7uz/toRYHr+UqL7aDWCH1rswBgwH6jCgar5M/1mq15s
         t19XuqANz7AAbDZcRo+RoqAWTT9S95XkIt2nTokg75oqTNQ0oHG1HBiikqQH0e4Aza
         3QS2cZtWu23x5PJ91Mh3U8BUs4iwsPJ4PgbA/Cpo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190313193437.GD18228@vkoul-mobl>
References: <20190313193437.GD18228@vkoul-mobl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190313193437.GD18228@vkoul-mobl>
X-PR-Tracked-Remote: git://git.infradead.org/users/vkoul/slave-dma.git
 tags/dmaengine-5.1-rc1
X-PR-Tracked-Commit-Id: feb59d77a46d5df93864471ca926b6701479091b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 31ef489a026ef2c07383ef336dc9b6601c7b9b93
Message-Id: <155258611741.11723.13118903847403662744.pr-tracker-bot@kernel.org>
Date:   Thu, 14 Mar 2019 17:55:17 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dma <dmaengine@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 14 Mar 2019 01:04:37 +0530:

> git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-5.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/31ef489a026ef2c07383ef336dc9b6601c7b9b93

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
