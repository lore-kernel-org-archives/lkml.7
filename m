Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FB3C04AAB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 04:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BCBD20850
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 04:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557291324;
	bh=FhwotkGj/oJnoKlGvzcHOerw5n4pdnf+7aZuQU7d7yw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=AMpg2Hkc7btB09su54+Hindneob+HnWSOwWLgZL6dhUxErs/AsSGKmLbt6nWu5RQ2
	 cwktSXeincT3BJzx2Cy9qk07svglChrqFMdVJ46votqodnp2uSpneUhs9TB5vpzFTc
	 /VEwv3FtEqTNgMZDWeAbbyTHBRTfux4bA/lz6VGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfEHEzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 00:55:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726838AbfEHEzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 00:55:19 -0400
Subject: Re: [GIT PULL] random changes for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557291318;
        bh=FhwotkGj/oJnoKlGvzcHOerw5n4pdnf+7aZuQU7d7yw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RhmxHzK9glxQVtKras8n4w+k8aD1fIILAb5+/9VaybMphz1dhGBh5fU/EYtv3xL6W
         HdxUxEzNgxrE6pryydu5cPAlaNMTHCDPPAFXzXI1/uAkczZnU0Izd2wwyMV/YhWIYZ
         wAoyhaqvImtyzCdyIl16Cr0zsClEJXtB25eCXEsA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190507233208.GA28817@mit.edu>
References: <20190507233208.GA28817@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190507233208.GA28817@mit.edu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tytso/random.git
 tags/random_for_linus
X-PR-Tracked-Commit-Id: b7d5dc21072cda7124d13eae2aefb7343ef94197
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd5001e21a991b731d659857cd07acc7a13e6789
Message-Id: <155729131875.10324.4695080099688266378.pr-tracker-bot@kernel.org>
Date:   Wed, 08 May 2019 04:55:18 +0000
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 7 May 2019 19:32:08 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/random.git tags/random_for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd5001e21a991b731d659857cd07acc7a13e6789

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
