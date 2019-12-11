Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD9DC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 20:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70C42173E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 20:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576097426;
	bh=In2OppxUUmMhw77Nh597V626V7rNMRFuadsOqSA+vXc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=qKjE6e/WgtAwRuTm+O6yTZh/qKK/wC404JbWb/L8H1Vll6kzvWyUO9IXX2WDI0QnS
	 +tKTq4UDmVydmjS8Knnwz9wXaE/dd7X7/a97YlvnJc0n+81ewg46fILKDatuZFQgM6
	 g2gE+3NgsrQjLZ7Z6N8QrF3/ohKwlTvB3x5x/mG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfLKUuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 15:50:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:48874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbfLKUuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 15:50:22 -0500
Subject: Re: [GIT PULL] erofs fixes for 5.5-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576097421;
        bh=In2OppxUUmMhw77Nh597V626V7rNMRFuadsOqSA+vXc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mHrh2Qv1J/uKZr+j6A30SXVsvPImlXoSI1gexIdQDc6E7aZ9jM8YQGTfBSOG59vjs
         mzxlCCZeVSzbhJXQZJRfP6QM4qGmKuu2lse/aMStqDeGqOuO0Sq0ALH1QIPuAaQ+nb
         tfDxENO8aC/bS0roDISpnheby8MbWcqbKrvjrY3I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191211170950.GA16027@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20191211170950.GA16027.ref@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20191211170950.GA16027@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191211170950.GA16027@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
 tags/erofs-for-5.5-rc2-fixes
X-PR-Tracked-Commit-Id: ffafde478309af01b2a495ecaf203125abfb35bd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 687dec9b94599b19e218f89fd034d6449c3ff57c
Message-Id: <157609742192.20554.6170432426388502768.pr-tracker-bot@kernel.org>
Date:   Wed, 11 Dec 2019 20:50:21 +0000
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Michael <fedora.dm0@gmail.com>,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Wang Li <wangli74@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 12 Dec 2019 01:09:58 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.5-rc2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/687dec9b94599b19e218f89fd034d6449c3ff57c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
