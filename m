Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49693C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 02:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195D12189D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 02:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568772904;
	bh=KOeaZnHk60Ok30bIWubl2BcYdu5uR5JKYioFhYbhzeM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=qpzLkGz8YaCB7K0CDVjq1YqZTi5z3wEygW0pG+Oq6FUi3iONOG0A2B6p+RpPCAW9M
	 DOSjKdD1/UY7sCb0uuPtdmBcWlI6EUDv+je6gZb7EDlQ6MFqgQsq/kXgdEYSeBr68P
	 x8bwF62UhR4gmTpPvEvzyCBdzvUq0xtXGeUJgkJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfIRCPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 22:15:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727774AbfIRCPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 22:15:02 -0400
Subject: Re: [GIT PULL for v5.4-rc1] media updates
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568772902;
        bh=KOeaZnHk60Ok30bIWubl2BcYdu5uR5JKYioFhYbhzeM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Ygb1dAV7A+J0gBDj+L5b0ANla7A+4XNsM4m2mrrz4wjrJyBw3dz/bEv3oOiroOGcE
         6R+PTANKN7tIsB98mhz5HJZ5KTc7vVmtZlhAiBGFztxnMIKuyOg7JCP/kjaAtq8X8A
         tn2RRDeTyNj85VdivP7+W/guRUjrgiYJKtjB2NJg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190916092515.66549c3b@coco.lan>
References: <20190916092515.66549c3b@coco.lan>
X-PR-Tracked-List-Id: <linux-media.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190916092515.66549c3b@coco.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
 media/v5.4-1
X-PR-Tracked-Commit-Id: 6f51fdfd8229d5358c2d6e272cf73478866e8ddc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e7345f92c27af003f219ad026d0e629a50b41e5c
Message-Id: <156877290227.2898.11068539201149651331.pr-tracker-bot@kernel.org>
Date:   Wed, 18 Sep 2019 02:15:02 +0000
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 09:25:15 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media media/v5.4-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e7345f92c27af003f219ad026d0e629a50b41e5c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
