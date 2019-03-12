Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4265C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5882177E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552429234;
	bh=gLIqelwBsaGnE6if3DF2fFJcjU+K1RwsOdxS/OE3xNs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Hu7Rfkq8+Fwnjwn1AnMioioIb1G/4r/U8ppCF1cHK/LPWQ2j/xN5r1scoSyYmDt9I
	 RS9b6QBgOUTnSduUmpMMpDFZf+AG52e2BN34LnL4qV6DXKykdOJC/+qT/ADRCbPMVi
	 Wgne1Q50Idh7jyKqkFlM1oJdKuvxnbZeytvnZ+pk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfCLWUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 18:20:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:43240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727365AbfCLWUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 18:20:23 -0400
Subject: Re: [GIT PULL] Ceph updates for 5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552429222;
        bh=gLIqelwBsaGnE6if3DF2fFJcjU+K1RwsOdxS/OE3xNs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iTE+/sTh0RxfPoHvqSE8FIbOE99TzBMlEzmqqy2p6tz2e21lyNDswwfumcsajXHJf
         zT0gF9Lfg9rzwLHEhkpdgRaqIaa9rbfqymhRZuUBniTBcGGNIDgRQJT4lHKsGYTgFA
         ae5xTwGE4fOsBd1MVy7rZD3r4HN3hfpp4jYdx8SU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190312175017.27764-1-idryomov@gmail.com>
References: <20190312175017.27764-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190312175017.27764-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git
 tags/ceph-for-5.1-rc1
X-PR-Tracked-Commit-Id: d11ae8e0a76afc506071831854348f2ea1f3290e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2b0a80b0d0bb0a3db74588279bf851b28c6c4705
Message-Id: <155242922270.11942.12559361231257770995.pr-tracker-bot@kernel.org>
Date:   Tue, 12 Mar 2019 22:20:22 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 12 Mar 2019 18:50:17 +0100:

> https://github.com/ceph/ceph-client.git tags/ceph-for-5.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2b0a80b0d0bb0a3db74588279bf851b28c6c4705

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
