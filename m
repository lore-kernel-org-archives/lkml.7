Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA19C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B0ED20854
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555366507;
	bh=i6JCg23Ty+c93/BB1/DpydvE2ukrXP6QKdJeH7YLBhM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=FK9YSmPLWbIU7ZceRCq0ZJ9kezJWFVpHLK7vHg+iB4Of6E2H0WiRurgCxNHTa/XuJ
	 i2B2kWtTMygWrZqt/gXlyHdQYSAD0oNy4odNd49ArDNo/iK/FNXskqFneoQ1Gdr5Xo
	 M1Yi4s7Pk06WNY0TBfrCVdrbCKI1vhTXZwJFFOdU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbfDOWPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 18:15:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727214AbfDOWPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 18:15:05 -0400
Subject: Re: [GIT PULL] Fileystem-DAX fix for v5.1-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555366505;
        bh=i6JCg23Ty+c93/BB1/DpydvE2ukrXP6QKdJeH7YLBhM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=S+WDVvnnze28WHXg9PPWyPfaQMHCVqEAyuYzRCTtp6Ai9VK8dglgh4jQSYNNuxyKH
         4uNgd+EzZ4Lb3SKmbrPvdQn7OuUTGzuRd7sPTQl3SmcpeycrgOfvR2nLW7g16e81tQ
         jU2MME/MI+yYvIHpXeveedj+HuHacHgttjYqv+ns=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4g97hof42jNAx__GpZ9ATPLv4J2AFo56nRzH-whCj7vgg@mail.gmail.com>
References: <CAPcyv4g97hof42jNAx__GpZ9ATPLv4J2AFo56nRzH-whCj7vgg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4g97hof42jNAx__GpZ9ATPLv4J2AFo56nRzH-whCj7vgg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
 tags/fsdax-fix-5.1-rc6
X-PR-Tracked-Commit-Id: 11cf9d863dcb583345723b0ed72173348761e9c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5512320c9f6f2acd7972c05400473c2338325339
Message-Id: <155536650499.9216.14416230494985731086.pr-tracker-bot@kernel.org>
Date:   Mon, 15 Apr 2019 22:15:04 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 15 Apr 2019 12:34:33 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/fsdax-fix-5.1-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5512320c9f6f2acd7972c05400473c2338325339

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
