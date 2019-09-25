Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659C2C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 17:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361A9207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 17:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569433227;
	bh=HbtX/qjOlqpuX+DFduyL/rhLqeFWwbiQLgSnt+HwXIE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Er17h1108r60O9sMlOIsm1zgv/NjkjGBthRfxHi4/rsqKhz5mYqS/wBLOCdTUjDQd
	 qdZjyT4meCEpPeeuik6f6n6xsN020H18POKASJoxWN0Hd0wemhwVdoho2CxBA3tShs
	 nTMBpKJ49D892fPoUVmFGJfSNeF98ayLi5is027w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634236AbfIYRk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 13:40:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:52722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407248AbfIYRk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 13:40:26 -0400
Subject: Re: [GIT PULL] Ceph updates for 5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569433225;
        bh=HbtX/qjOlqpuX+DFduyL/rhLqeFWwbiQLgSnt+HwXIE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vwq7d7g3chhxgw0+CxFaUAw2aajAnvtTIInwY7wcikIJDW6T4pOU3We5PFcX3TkRl
         5cKAlTibMqdBQQ9jOEGb9CMwq+bfuyXD0E40e/T61bgv2rbAQiWPHHK4cIBdX7vG1E
         RMg6qZcv8cwru2K3UkpiaqEDHuXu2iI6TVwwZlCg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190925172021.23334-1-idryomov@gmail.com>
References: <20190925172021.23334-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190925172021.23334-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git
 tags/ceph-for-5.4-rc1
X-PR-Tracked-Commit-Id: 3ee5a7015c8b7cb4de21f7345f8381946f2fce55
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f41def397161053eb0d3ed6861ef65985efbf293
Message-Id: <156943322556.26797.8938418012782948052.pr-tracker-bot@kernel.org>
Date:   Wed, 25 Sep 2019 17:40:25 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 25 Sep 2019 19:20:21 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-5.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f41def397161053eb0d3ed6861ef65985efbf293

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
