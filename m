Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3A8C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 01:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA0720815
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 01:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552182018;
	bh=Qb56sKpD0CAfhOVnUB0ZZ6FAcPqcAnL6bs//0j1lk5Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=CyRelw3Fai1kCdVCOFI6a8htG5fG5W/3SwoW7uTX+4W+l06qDRv5GiTvWWaVGKi0g
	 pZ7571aXUyMDb2tgP1xdiugfzWsMQf/9R9FOeDNYiczfvSXnCjkXlzYHY5jpkxW7fn
	 24aLxAUHXPEVUmFJFgZIOajm6JhAnP6xpsKhQFTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfCJBkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 20:40:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:33674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726363AbfCJBkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 20:40:15 -0500
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552182014;
        bh=Qb56sKpD0CAfhOVnUB0ZZ6FAcPqcAnL6bs//0j1lk5Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xDx+C/7iVnWEYGjuG8lsxIZP/T9F+byBKeCekLhaxoWnsu5D44R+8Ndo+Nd9NlTfu
         fOaHU7wOxeNagSFXt6gDSBZLQIVwEtEjSvQ3nSrPyIWNMG9w1Ul8SFfK4u61e3n99o
         FABG8SWGbQSvNMSkvrcyWT98VzDKhnut48posq58=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190307013411.GA6010@ziepe.ca>
References: <20190307013411.GA6010@ziepe.ca>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190307013411.GA6010@ziepe.ca>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: fca22e7e595f1799cfbfdfa13e16d48ece0d136c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a50243b1ddcdd766d0d17fbfeeb1a22e62fdc461
Message-Id: <155218201474.32026.5898256217262679744.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Mar 2019 01:40:14 +0000
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 7 Mar 2019 01:34:16 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a50243b1ddcdd766d0d17fbfeeb1a22e62fdc461

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
