Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6402EC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3727521927
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568838607;
	bh=OJJZWPQXP8cUC5NclBwTlGCgX/ZEFrt8IBkCUFLs40U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Z+1ufgVVmIlMQ7cKnX1X7Ei89GvSkLiXAGILBYMX89+U2Azge/SgiIjQW4ts2Us34
	 8WcLQJWrL0qjAfXPoscGDgnY947w+4m6ZxJ7Lpj+hgzB09jYx6ZmIhUpVxHu3M6QO9
	 NxWWydq/pkvuQGnhGephGCzldGqJ0dMuexoHstvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387558AbfIRUaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 16:30:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387456AbfIRUaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 16:30:04 -0400
Subject: Re: [git pull] work.mount - infrastructure
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568838603;
        bh=OJJZWPQXP8cUC5NclBwTlGCgX/ZEFrt8IBkCUFLs40U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zSG9UoDtKHtF6617udGaLz2Ej3jQLKahYUBdts3li4Vtv3s9/nZ2/CcxwwawIz+hZ
         3tspzZoXXGJ50bZPuszCHoLtdP4INyjQSPQTOwWCJVBgGW5FHiipKrNo5scSyOY8wB
         KrthPA4FVH/WfLW4DBjXAoGv31xetGTluGRIEsUk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190917014101.GF1131@ZenIV.linux.org.uk>
References: <20190917014101.GF1131@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190917014101.GF1131@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.mount-base
X-PR-Tracked-Commit-Id: 0f071004109d9c8de7023b9a64fa2ba3fa87cbed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e170eb27715fc9253ae031297d0638a3ef51b5da
Message-Id: <156883860387.13812.17628500676358897597.pr-tracker-bot@kernel.org>
Date:   Wed, 18 Sep 2019 20:30:03 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 17 Sep 2019 02:41:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.mount-base

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e170eb27715fc9253ae031297d0638a3ef51b5da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
