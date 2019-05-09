Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5BCC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5B52173C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557419128;
	bh=9l24qoZpm/lMj/JHy0wFhM4SVl/U6n5X5kDMMREc2oc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mtF0mrGa8rMcKKYXnpGwUk+Da5YUH0s33SsZEnrUBPAtBnq0RBgTkMC89gZ4moGHd
	 eRoIDSE1NIIj/7X5GwiaNIV8EQqLlyZqtvNLMiX10aAc3UUlWwXELJVQv6Oav/tp1Z
	 0lWQrOoe7prXFn8YUHlObDNtZNMV1G6g5Pdwy7kk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfEIQZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 12:25:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbfEIQZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 12:25:16 -0400
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557419116;
        bh=9l24qoZpm/lMj/JHy0wFhM4SVl/U6n5X5kDMMREc2oc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JnBU9+g8BOMgXWtNf/a/0Qf058g2uCoVRfMsBF+Rv7xv4gE30bzIcgtfFRU5+9MvD
         y+WFMa6PC531DB4PK2vwCFPYCX4ZessmhsCmsKwZWhPd5XZiHY9Nw5Rjzdc9wu/y8h
         wDB68CXqM8vzYJ/wDlhsii59GwJjA0Y3sWstxK6w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190509133711.GA16703@ziepe.ca>
References: <20190509133711.GA16703@ziepe.ca>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190509133711.GA16703@ziepe.ca>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: b79656ed44c6865e17bcd93472ec39488bcc4984
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dce45af5c2e9e85f22578f2f8065f225f5d11764
Message-Id: <155741911625.30533.6017431247232404075.pr-tracker-bot@kernel.org>
Date:   Thu, 09 May 2019 16:25:16 +0000
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 9 May 2019 13:37:23 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dce45af5c2e9e85f22578f2f8065f225f5d11764

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
