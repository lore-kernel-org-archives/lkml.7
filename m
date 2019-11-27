Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B35C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 18:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6525B20863
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 18:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574880325;
	bh=h0tc59d+kmkpHy21UmhivZLRAzewlsXGrbX34HlG3gg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mgJL6sqWWje6wzoVaPcZxzUsf82kTsljstwXTrcucFauZUUqiabpmT/intIYFPjt5
	 8aJFGHNu9sBfGPMBNj22ipAlz0Q3ia2St5PEIM4KALv+CAan/wCr1sO62cvuEtekdv
	 RqxhQG2Tp/I7d0HldiwbFXwOztrYTUj1lzu3w//A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfK0SpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 13:45:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:57882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727305AbfK0SpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 13:45:17 -0500
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574880316;
        bh=h0tc59d+kmkpHy21UmhivZLRAzewlsXGrbX34HlG3gg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XPmZ0YLKtvdahFs9KMqyhZDgQEFLA/1DnSavWkGNDfUptmTZKwQqsB/FwELp7MtXR
         yyUe3nPhXQTDRBEpJcuVCsZcDf1YbySR0yNisM7yh90KMFJQX7VQa9heGATcBP/AK/
         bB+08xNBXSCDj2equK7JpNdrJNceQz26WYq/aToQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191127002431.GA4861@ziepe.ca>
References: <20191127002431.GA4861@ziepe.ca>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191127002431.GA4861@ziepe.ca>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: f295e4cece5cb4c60715fed539abcd62468f9ef1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d76886972823ce456c0c61cd2284e85668e2131e
Message-Id: <157488031673.21185.14237744447686342993.pr-tracker-bot@kernel.org>
Date:   Wed, 27 Nov 2019 18:45:16 +0000
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 27 Nov 2019 00:24:40 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d76886972823ce456c0c61cd2284e85668e2131e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
