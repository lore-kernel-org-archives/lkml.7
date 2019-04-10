Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA23C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9482084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554926108;
	bh=FnDEx1oPchHBzJO+KDmtLym4sm0rgICkjRM8ELA9Xq4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=T5FHNJRU2jU2xGBtImr8RGmOSbXNKZcEgHk/OELv8SpqQRewzCj7A2Gj1D3BADejL
	 aKabvluG/0zeR1ZJp195Q41rfJk2e/3DZCFrkwaWtAjfPKfboQVoG3sxKiWPq9aQuf
	 HuVJdo7BX2BMjW59+Atf6vZi3CpVnLB5KB/ZU+Zc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfDJTzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726093AbfDJTzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 15:55:06 -0400
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554926105;
        bh=FnDEx1oPchHBzJO+KDmtLym4sm0rgICkjRM8ELA9Xq4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=npaoCbaUprVTc1Wx02gs1tvgNdhG+PfBUzAHwKdO3Sd1rxDn1A7dCJzLHn6AZJvdq
         /NltCbtP+K5uMCd8+FB5TiqPewm8BPKGzEUe8OYCVEgdnkjXPA7S8mRjGdjYj13YbL
         mn9dSovOOwYFR6P0bATHXmdHZlMlHTieAOEctxYQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190410184618.GA6370@ziepe.ca>
References: <20190410184618.GA6370@ziepe.ca>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190410184618.GA6370@ziepe.ca>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: d737b25b1ae0540ba13cbd45ebb9b58a1d6d7f0d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 582549e3fbe137eb6ce9be591aca25c2222a36b4
Message-Id: <155492610581.27061.14785510429244969910.pr-tracker-bot@kernel.org>
Date:   Wed, 10 Apr 2019 19:55:05 +0000
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 10 Apr 2019 18:46:23 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/582549e3fbe137eb6ce9be591aca25c2222a36b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
