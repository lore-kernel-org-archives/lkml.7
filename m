Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA9EC4CECA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 23:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C85206CD
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 23:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568503508;
	bh=s3gxD6eyCdEu/4FefKYxY4pJxCsuwM+EFRkTJ2NlSVc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=gDpKisEYeQK0AiUtgQYL2WOYnjdnP+Y/eI4yX2lGuNjhEDnVv1il+dVaQlJ605XH9
	 lwvKpsyQMeWwXa5FoLgNYp/3ny577vtP6rBxvn7HiJ3+399mED8VlT3vEaYG+OPVZ1
	 MFNcdA6HoSq1QfIvUSDZbPzpKb5nRG+qztjHOBUc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731639AbfINXZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 19:25:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbfINXZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 19:25:06 -0400
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568503505;
        bh=s3gxD6eyCdEu/4FefKYxY4pJxCsuwM+EFRkTJ2NlSVc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DCcCHD8utHRDQRW1ol6O7Ma00QJYaRKAQLa7AEiHT3k3dl8gUw/MxJKfUwalSroyT
         gmigScpfNNPSAywGpfDIik3xLCrdlrJvLYZHRbE3Tr+xLhgPr2BKKR3Aws+wejHUpl
         7IwV8C+FvqTl5Khpmsu9CQ+o2oeC2cGxAOKvYA/4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190913.215540.530478705339568215.davem@davemloft.net>
References: <20190913.215540.530478705339568215.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190913.215540.530478705339568215.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
 refs/heads/master
X-PR-Tracked-Commit-Id: 4d7ffcf3bf1be98d876c570cab8fc31d9fa92725
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 36024fcf8d28999f270908e75675d43b099ff7b3
Message-Id: <156850350588.2116.2502546621500272501.pr-tracker-bot@kernel.org>
Date:   Sat, 14 Sep 2019 23:25:05 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Sep 2019 21:55:40 +0100 (WEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/36024fcf8d28999f270908e75675d43b099ff7b3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
