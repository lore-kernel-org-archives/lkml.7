Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75637C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47CD72133D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553019314;
	bh=ZotSeuJi07buIyWYLmnn2kMeKT8rx4yohNG9jflgfuM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=qqrd8d5flhYQkbr6mDgk6PQKbtrYUiAZe6P/3Nb8lwO6bb1EZ1kzH+UTGve3hNqNX
	 TXRX3dr8pyMcqSjaDGdqpJt/9Ou4mR2fFyUQ19o1chLqZOkmhVi//dNtvpzQO9nUIA
	 E6wibvDx31NvqErRIZ0KvCpN8jR/fohJeuzQfXLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfCSSPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 14:15:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727139AbfCSSPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 14:15:12 -0400
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553019311;
        bh=ZotSeuJi07buIyWYLmnn2kMeKT8rx4yohNG9jflgfuM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qzwl0l2bQVVsG1iOzTv/6nfY4UAQYocLf1SF/ISIftEhD41aGPfmIA+0Io7bJ1Je9
         +/zUQZcyr1SuqAO0vYW9OYKDl0ypsNUotAUakHtQCM+VL5dUeIbXdB9FY9X8bpX/PI
         GnGBDk6yxfhPms4oqYRM1ogZBQPvPJsjHSSzyZHM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190318010407.GA26545@ziepe.ca>
References: <20190318010407.GA26545@ziepe.ca>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190318010407.GA26545@ziepe.ca>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: ec4fe4bcc584b55e24e8d1768f5510a62c0fd619
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 01c8d80383d9076ab4fbebc3e60ae9abc70f70d5
Message-Id: <155301931160.12441.12123218680926000771.pr-tracker-bot@kernel.org>
Date:   Tue, 19 Mar 2019 18:15:11 +0000
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 18 Mar 2019 01:04:12 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/01c8d80383d9076ab4fbebc3e60ae9abc70f70d5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
