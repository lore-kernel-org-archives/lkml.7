Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B539EC43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 00:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 778C720857
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 00:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551573915;
	bh=BUho7jWug+FjU62l4NIjsvsNQneng2jPb5tU2/zWmxM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=xTZVRDCuUrCfEdNO48WdWvW1w32JT+Fn1UugnFN2qnCWBE94u26RynbWIljos2uMd
	 G7NCRuzjr4xlPIpvuekyU2ySd+iJU9tFNGPgK79KlOTeifNjE2+PAh4guImDZ9uYHl
	 INuj5R3ctPRT6mQV7dNb6kLcLiVHurcZgYjNxREs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfCCApE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 19:45:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:41862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726786AbfCCApD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 19:45:03 -0500
Subject: Re: [GIT PULL] ARM: SoC fixes for v5.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551573903;
        bh=BUho7jWug+FjU62l4NIjsvsNQneng2jPb5tU2/zWmxM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yTcQl12ovv5t9jEPbTGzRfSA93ZTSyfhhewFGTnuB+zFAbYPOKeS1cgWtwH61Myj8
         SzQZ/WlRXi3uF9Sd64LMZjKU4QPd1CYEf0ilROT4hjzVRLMPytGb7oUMTgPbbE1nVP
         Zz0U8QJUYRLUWcfoAQ42pCtFcIvsxh4ZY/PqalDs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a32CEOeUe+WT_p23FoY3V7vkCyMvBfvGmvSC--cuHxkdA@mail.gmail.com>
References: <CAK8P3a32CEOeUe+WT_p23FoY3V7vkCyMvBfvGmvSC--cuHxkdA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a32CEOeUe+WT_p23FoY3V7vkCyMvBfvGmvSC--cuHxkdA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes
X-PR-Tracked-Commit-Id: 6089e65618dca3fc0e7ccd7a6315de62ebf893a4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c027c7cf1577bc2333449447c6e48c93126a56b0
Message-Id: <155157390321.9987.770647267879867371.pr-tracker-bot@kernel.org>
Date:   Sun, 03 Mar 2019 00:45:03 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <arm@kernel.org>, soc@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 2 Mar 2019 23:28:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c027c7cf1577bc2333449447c6e48c93126a56b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
