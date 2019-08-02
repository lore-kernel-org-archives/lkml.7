Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF1BC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B002087C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564762211;
	bh=UvT0o3ZBxyf3aVJPZyAhNoNbsQfK7wrSubXZIRnYedo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=U4rpOkAKhDf88Kp0G13s78S0YdXErLftGTut4L28EiTLJ3j8BW2jaNFJMVqt0UW1X
	 zmypgkb/WMVRT0TIapSG5gRt/jGg8V/h/iYYPOhwFx8pIPtJfKVOnw4uU2YL2+chq8
	 7U5cUoXdpV4jSfX3lZHYsGoWu8SccDRwOxrJvKlA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389937AbfHBQKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 12:10:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389867AbfHBQKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 12:10:10 -0400
Subject: Re: [GIT PULL] Fix gfs2 cluster coherency bug
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564762209;
        bh=UvT0o3ZBxyf3aVJPZyAhNoNbsQfK7wrSubXZIRnYedo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=T96o7tXXs5u9mwDddoFrAY8HYPPz9BJ+A2pzSEC5oH4DioweNDTMF2LfM1sOnAHyt
         QmEF9Nf0hRU1dkfNHLt48pWG98Xs2zzgogxPfYb7GNQMp/beNN/ZLlajHk65dx69rE
         jqdPHzO0XIkHOnJ+IiYlc06qkOrQEzkI1TrSD90E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190801195259.27274-1-agruenba@redhat.com>
References: <20190801195259.27274-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190801195259.27274-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
 tags/gfs2-v5.3-rc2.fixes
X-PR-Tracked-Commit-Id: 706cb5492c8c459199fa0ab3b5fd2ba54ee53b0c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 97b00aff2c45069bb8ea88acac664a17d63f77f9
Message-Id: <156476220923.32155.6136557482022472343.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Aug 2019 16:10:09 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  1 Aug 2019 21:52:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.3-rc2.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/97b00aff2c45069bb8ea88acac664a17d63f77f9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
