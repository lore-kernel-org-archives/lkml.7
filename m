Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E44FC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 22:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525B22071C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 22:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574462706;
	bh=d8oXppx+2YbgA8Cf5mAhkifdEjS+4TUDqLDsK0lT574=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=fnySiEICRrGQiDSugoQi9D+vIKC/HVIi7XokZ+G2fKia9qkh5WLtehi1+DowsQsmJ
	 IaDZbzN99X3ORtuJZa5XUuS1SgzpwyroyRS1f6bP3G4VL3rV/iAhaKxtCQcW9VQnB2
	 aD/qhC+fZdTpZ3kiyzO8lQCgY0xpTnWkcTSmrlKw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfKVWpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 17:45:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:50434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbfKVWpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 17:45:05 -0500
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574462704;
        bh=d8oXppx+2YbgA8Cf5mAhkifdEjS+4TUDqLDsK0lT574=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1wzvzz4lR+zlu3lEAiGWnzAIZF6WTEZipsM+D0f1oMSBsm6zXIDPTvV95sz/P3FY6
         +PxmKlhfAwND8HOuaL5behgADLMVAy5UxKDMaGFoEvseXNtj73+UlplNHqyHwprfwx
         KKkuhdhuouw2C78M5g9+WPl/CWrt8IvNJRDCM6lE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191122.101751.1677491851513930094.davem@davemloft.net>
References: <20191122.101751.1677491851513930094.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191122.101751.1677491851513930094.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
 refs/heads/master
X-PR-Tracked-Commit-Id: 5b1d9c17a3e0c16e1c9adf9c8a89f2735cb6dff8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 34c36f4564b8a3339db3ce832a5aaf1871185685
Message-Id: <157446270451.8590.2299555023167506203.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Nov 2019 22:45:04 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Nov 2019 10:17:51 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/34c36f4564b8a3339db3ce832a5aaf1871185685

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
