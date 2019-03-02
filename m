Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791BBC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 17:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 464B020836
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 17:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551546610;
	bh=4ffuoL8fV6goIURTMHtTB8EvzZ7cgICPDhwosVNvXpc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=rXlk9PhN8vYwn4He6s9J8bFXGuU1YKJsIxFHOB/AyOBNPVJ3W87sz31JYQ2zAfvMz
	 6reEiOReFitDZLFt3z8I2/Q40NGjx3T4ctx/35ankezide/mCHo34LtCP+kMs6fQP4
	 V7zCl2RPlefhraicgjpXnsFzEnuntVyQJTZ5mWZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfCBRKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 12:10:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:45592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbfCBRKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 12:10:04 -0500
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551546603;
        bh=4ffuoL8fV6goIURTMHtTB8EvzZ7cgICPDhwosVNvXpc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Y9uTh3g2x0JevtW9e2JytLTYi31tbhBAXkKN5PTr7n0Z2dYKLDnY438WBQ+qNK3YJ
         SNwbQPtcw7QzBswzbaBgBHHnVv1X0gnr3vKyaSMufaAibWNB1zXEdv/ayerZNCW6wW
         hdzr5nlTRsu1t9EKyfJUFqaQTbnKA0pbHBO9tH/8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190302.010823.290132881497291675.davem@davemloft.net>
References: <20190302.010823.290132881497291675.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190302.010823.290132881497291675.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git refs/heads/master
X-PR-Tracked-Commit-Id: 07f12b26e21ab359261bf75cfcb424fdc7daeb6d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c93d9218ea561d6a91b23449cfd637ddec91dc23
Message-Id: <155154660354.7313.18074993959185844627.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Mar 2019 17:10:03 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 02 Mar 2019 01:08:23 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c93d9218ea561d6a91b23449cfd637ddec91dc23

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
