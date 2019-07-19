Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6574CC76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 19:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363902186A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 19:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563565553;
	bh=1iSGpk13zptImPrJJJlVpmhRGjco+xGgKV6bdnkSHlU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=xQCXTMKTbVHiRvrjRJALnonV+dTr+ilxyrD+b7yoA2+SbRhWsZWgPwaBZsi9O73yB
	 g2JqplXnlcUHqZ/JIJZZxWaMWI4FWm7DtlogfqXJ4QMcYT86C9WWpvtW/2ih2S2n8v
	 2CSfaJtWJ1XhgfTUgjvPGFnhiwWnxNjqFi4geqXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387819AbfGSTpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 15:45:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:34482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387496AbfGSTpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 15:45:22 -0400
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563565521;
        bh=1iSGpk13zptImPrJJJlVpmhRGjco+xGgKV6bdnkSHlU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uxjiXvHflXdYR3X8PfNfXa3B2teew78nvnbafai0I/BpyCF9H1AvOFISGUdTWTr5Y
         N6vwymalO0No/CtmWSv0PDM6n5X7I2WtWjenUyCbpapaSFs/vrXXIW6P+Ehhs8HPRl
         YXLBISoqD+lr5PjSY6+Mj7gASzOfOVc2aSWg8SKI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190718.204420.2101649864834371997.davem@davemloft.net>
References: <20190718.204420.2101649864834371997.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190718.204420.2101649864834371997.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git refs/heads/master
X-PR-Tracked-Commit-Id: 8d650cdedaabb33e85e9b7c517c0c71fcecc1de9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5f4fc6d440d77a2cf74fe4ea56955674ac7e35e7
Message-Id: <156356552145.25668.4602248740881268954.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Jul 2019 19:45:21 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 18 Jul 2019 20:44:20 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5f4fc6d440d77a2cf74fe4ea56955674ac7e35e7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
