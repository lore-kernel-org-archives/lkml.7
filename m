Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4003C3276C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 01:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E3021734
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 01:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578014713;
	bh=gPChPPtSRqW9FMY1CkJtHflw4zyyZbnNmaahIM2DQGY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=KoD+0TvqD3T5GMjVBehwDUp6msMhZd3O+htZ+Sc+MQ04rtVzU9b/lpqTUKgCxm2Qt
	 +zzs/hp0PtBw9Ji9kKI2G+9neYUdehzsk8m5UBaIm/SVb7jX+GEgSJsXn7UZb5+/TF
	 5LZvFSUlbo7JF+9QvG8zxXbjG/0Brrv9wT/118J4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgACBZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 20:25:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:46012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgACBZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 20:25:06 -0500
Subject: Re: [GIT PULL] pstore fixes for v5.5-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578014705;
        bh=gPChPPtSRqW9FMY1CkJtHflw4zyyZbnNmaahIM2DQGY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2HObflPFn4qb7dXQurjjnj6jq4dldEpHMoeXoE1/FGyPZpST7ptkI5GRaQ+zOmbY7
         8s8F/zIH6seIOVo9Y4c3A9YOufRdI+2vjQHuzZaMrErmiBJTpQNzztXh1Gc7MKct1m
         WQX3OO3odxnwhIlS5X9zrHBnoWRhIYUwRmnxtIUI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202001021254.2F43E8A@keescook>
References: <202001021254.2F43E8A@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202001021254.2F43E8A@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
 tags/pstore-v5.5-rc5
X-PR-Tracked-Commit-Id: 9e5f1c19800b808a37fb9815a26d382132c26c3d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 278b14eb920322255bf5b831e2bcfc1bf5999036
Message-Id: <157801470547.30243.13698778260520943611.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jan 2020 01:25:05 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Aleksandr Yashkin <a.yashkin@inango-systems.com>,
        Ariel Gilman <a.gilman@inango-systems.com>,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Nikolay Merinov <n.merinov@inango-systems.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 2 Jan 2020 12:55:08 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.5-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/278b14eb920322255bf5b831e2bcfc1bf5999036

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
