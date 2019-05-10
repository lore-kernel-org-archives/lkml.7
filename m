Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A8AC04AB1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 00:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4EB72085A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 00:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557447314;
	bh=471Q0FZH+6iM02c97pYQxOSDif0KayU1oC74I23Z6Vk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=T95YF1Rp47Gblfx3HbmEMLWNG6GnFbk/JBf1/tmnjdXsHEMM4yMAg4LjsfxNHnTLC
	 sLLVABLTQ9Qz2R/rgBrO3/lrMawD9pNcJYF6OLDaeuyha05kwD14xLXK3v8Pi3AVgt
	 lNAEmbeVfqObjVety+IyQvRmqph3fwOeYouvthlU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfEJAPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 20:15:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbfEJAPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 20:15:13 -0400
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557447312;
        bh=471Q0FZH+6iM02c97pYQxOSDif0KayU1oC74I23Z6Vk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hiEp5GqfrGILKWWhGHhc4WhQ2Rao+r15fuMNZr9cxZKhbQGfxJUdQvUDOPVZlV0X+
         Ab8t46WUwaFKMWx5NbvRFmeqdyLHMmwN50P1hPqpgv3+TqKKDkanQx5WleAdSSMkO/
         TLpinP+Tf9bwhgo0Xx++HDrptlsHCSw0L+10L2JE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190509.165536.716778200205224094.davem@davemloft.net>
References: <20190509.165536.716778200205224094.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190509.165536.716778200205224094.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
 refs/heads/master
X-PR-Tracked-Commit-Id: 6c9f05441477e29783e8391d06c067e4a3b23d47
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 601e6bcc4ef02bda2831d5ac8133947b5edf597b
Message-Id: <155744731267.2452.12854565532718916139.pr-tracker-bot@kernel.org>
Date:   Fri, 10 May 2019 00:15:12 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 09 May 2019 16:55:36 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/601e6bcc4ef02bda2831d5ac8133947b5edf597b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
