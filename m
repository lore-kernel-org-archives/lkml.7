Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AC0C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 04:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094FC263A7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 04:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559275203;
	bh=gBqtohv8L5L/MGwJDoTN7iyjbOaZAWETAIXm6f0JhZI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=iLTLN6rDeZDCRUcP6F+dNR/QZ/ROQQmCUK4WGWc1Coav/z3S66u0sd1kli2SJ1PAa
	 mvgoHSbYY5bXXXauXD9jHH4WINlPrQ3+QOXpdt1LWtewSiS9xsZz0r452EGcNucZSY
	 Odi8KSG79PtuU4gfUVnRBFi8V9At7D/1KiIb2WaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfEaEAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 00:00:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbfEaEAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 00:00:01 -0400
Subject: Re: [GIT PULL] configfs fix for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559275201;
        bh=gBqtohv8L5L/MGwJDoTN7iyjbOaZAWETAIXm6f0JhZI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mGKBVC0PG0cJU5yfcQibR0ekMs0iqo7mn2UX2A90tTubunIodTlA2czx6rN1ukG8l
         aQa2Rmmprbb5djVMN/1uMyV047ZBnZsZrTtvqSM3LBIW4VuFgN8Hkyee9Ooz8YnUhn
         IK8GrG0LaIJ8SHeHFfuUx3ApytsOFfa/mLLe155A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190530085321.GA24647@infradead.org>
References: <20190530085321.GA24647@infradead.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190530085321.GA24647@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/configfs.git
 tags/configfs-for-5.2-2
X-PR-Tracked-Commit-Id: f6122ed2a4f9c9c1c073ddf6308d1b2ac10e0781
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8cb7104d03dddeb2f28e590b2d1fab7bf0eef284
Message-Id: <155927520131.31954.10692279844335458558.pr-tracker-bot@kernel.org>
Date:   Fri, 31 May 2019 04:00:01 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Joel Becker <jlbec@evilplan.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 30 May 2019 10:53:21 +0200:

> git://git.infradead.org/users/hch/configfs.git tags/configfs-for-5.2-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8cb7104d03dddeb2f28e590b2d1fab7bf0eef284

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
