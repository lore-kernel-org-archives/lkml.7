Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C376C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 23:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62BE1208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 23:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560814512;
	bh=3ihbqGCs7+aS+s5AQNG7ishmcO7blXDpEySSy8BsQSE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ZRlTm9dHEZ/psFnqHgQxfrZN/AWSJecds8Rmba3qEtC6DglrTPMr+TuXbkUG8xXLq
	 KWr+iV+qqlMStg3tCJbyq9pvBs0yBAsRG+6/1hr7ZSZOYLFrvQRxkwiuNED55AF9eE
	 5Bhz7dzDbk6UXiPKNL9juDFrcPO9hZn4oQi+jnoA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbfFQXfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 19:35:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728817AbfFQXfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 19:35:06 -0400
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560814505;
        bh=3ihbqGCs7+aS+s5AQNG7ishmcO7blXDpEySSy8BsQSE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=eCBlVxOsYFQL0ZG1VdwpzmVF0wmM4jKuqD9eJdga0a+jGPSDuibD8RvLTwAKKsLwA
         BH3Xx9VpHT4e7ELzfXXmeNsiNIDAw/7MFOsNvfh8FAgbqca3M36t/hymwpeW0BlAKH
         GqUYWqar3fsuQi7see1AvvYoxqtbtTrZPlBoJblM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190617.111738.2016163932115402710.davem@davemloft.net>
References: <20190617.111738.2016163932115402710.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190617.111738.2016163932115402710.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git refs/heads/master
X-PR-Tracked-Commit-Id: 4fddbf8a99ee5a65bdd31b3ebbf5a84b9395d496
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: da0f382029868806e88c046eb2560fdee7a9457c
Message-Id: <156081450584.13377.14001316439156235841.pr-tracker-bot@kernel.org>
Date:   Mon, 17 Jun 2019 23:35:05 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 17 Jun 2019 11:17:38 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/da0f382029868806e88c046eb2560fdee7a9457c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
