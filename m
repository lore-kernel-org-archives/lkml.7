Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3F8C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 17:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7265217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 17:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567443910;
	bh=AdMIfNYhZ7FeNxnvjp5wfjRX4hSJblsYFsHY0wpJryg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=2EvBmXkLwOJrr+IYho/uGldAeKYnZrC1Y2BCLtQevzdnBkg6GPrFCBPyEErfiFiS+
	 W/LTH/KuSZoi4FZNaiezFMgQN94gXQXj3EslNIyZNtM3DzChEjVBVmomMXT8aOXX1b
	 4lGmcmbpvXZibSMelo95VkxglN7dBNa6jGeDaUa8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfIBRFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 13:05:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfIBRFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 13:05:08 -0400
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567443907;
        bh=AdMIfNYhZ7FeNxnvjp5wfjRX4hSJblsYFsHY0wpJryg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZBBoAG9+V3CgBUNfKdd0Jm5bo+OCxsyri5S7HTHLqK36QklTnXxR+fgyvAfc8Uihq
         lPhJE2Y1Qfx6/qifWvy36ksiUTcRUmZg0S02uP9y89w82t9KIbLSKW70GHlK6VY6Aq
         NkS4t7Cxh1FiSvxyPUe/nH2tO8rX+sNX0PhzSJS0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190901.134525.286041997131171719.davem@davemloft.net>
References: <20190901.134525.286041997131171719.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190901.134525.286041997131171719.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
 refs/heads/master
X-PR-Tracked-Commit-Id: e1e54ec7fb55501c33b117c111cb0a045b8eded2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 345464fb760d1b772e891538b498e111c588b692
Message-Id: <156744390714.11156.14736006635251477689.pr-tracker-bot@kernel.org>
Date:   Mon, 02 Sep 2019 17:05:07 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 01 Sep 2019 13:45:25 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/345464fb760d1b772e891538b498e111c588b692

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
