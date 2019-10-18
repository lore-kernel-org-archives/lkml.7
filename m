Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18876CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE0F222CD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571439011;
	bh=KCSvp0ERsuqTZ6xhTbOYZl5RkXmC8gexcwDy3BL+tdo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=CnH/tjsYf+4ZlRfIcWfWYtM99SJ8izdDxL0NxwOCD+2mQxs/3xtQkaYZl6Dy4W19Z
	 nImLDgsNTlAEL07thWaw0HfwHC9gbBN523g4MRanAMYCbiO2CgEbZauiyjyXGivJpP
	 fi8zDxrDD9eF/3F2jdkSEzEjprlc+69FxSxHU44Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395129AbfJRWuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:50:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:32880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729034AbfJRWuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:50:06 -0400
Subject: Re: [GIT PULL] Ceph fixes for 5.4-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571439005;
        bh=KCSvp0ERsuqTZ6xhTbOYZl5RkXmC8gexcwDy3BL+tdo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0DrlqKWuPxrMgDN34n70NHarJjYo+R5D5TqR9lJr9dKWF/Fp7wakDPzzOEhytLSAy
         StPzFw7Offj4CpoPTd2zRq70gW+csqIuZF5bj9U6hyoEwB2WQkj5/Xo1wtatMBqzy6
         /Hm6mKodjTKVHf2cvzC1wOTjkwwUwhRthBtqaYd0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191018181511.8844-1-idryomov@gmail.com>
References: <20191018181511.8844-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191018181511.8844-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git
 tags/ceph-for-5.4-rc4
X-PR-Tracked-Commit-Id: 25e6be21230d3208d687dad90b6e43419013c351
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6b95cf9b8bb3cb647d9f43109a9c50a234b39781
Message-Id: <157143900578.13317.9811568128379617942.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Oct 2019 22:50:05 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Oct 2019 20:15:11 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-5.4-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6b95cf9b8bb3cb647d9f43109a9c50a234b39781

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
