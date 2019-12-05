Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9C7C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC6A24672
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575581428;
	bh=53gsHQqClcL7Aoql6lXSgoCQDVGew2OQgpP6KIPSa0A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=gw6SHdh2fMzsvV7F6BM4FGBisDWVucxCB1OaYKOdf2lgz2nrx03BfvpZZwXp547P0
	 ReY6fuQpqA2QPyHk/R0PGC8rkLoF/1D/UXgz40g+9utq5ULklPpQEHqf+wx7ZzXuEA
	 eQGTxKuDzVoGQSEZ7f9Y9PcJ2mL/E182/VVdvOq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbfLEVa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 16:30:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:55526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727236AbfLEVa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 16:30:26 -0500
Subject: Re: [GIT PULL] Ceph updates for 5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575581426;
        bh=53gsHQqClcL7Aoql6lXSgoCQDVGew2OQgpP6KIPSa0A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=eSpNdX9kP0dDK8YXRUf7OuUQUmrgmsqgGcxcWfnSP7GQV0hTUxW/kqhzUFQLD6Yuj
         myeFOXznzNzTNXzVSxWyVOCkUF95tmKlug84XDKGT1PAvhhs42OPSFgFlCGIg+fGEO
         YNA44a7dPeq0y/T4gXL/lIvomYeivgx21auy7ZW0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191204200307.21047-1-idryomov@gmail.com>
References: <20191204200307.21047-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191204200307.21047-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git
 tags/ceph-for-5.5-rc1
X-PR-Tracked-Commit-Id: 82995cc6c5ae4bf4d72edef381a085e52d5b5905
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a231582359ec27e121bf4bb0ab3df8355f919d1d
Message-Id: <157558142612.8243.11548479580688352353.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Dec 2019 21:30:26 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed,  4 Dec 2019 21:03:07 +0100:

> https://github.com/ceph/ceph-client.git tags/ceph-for-5.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a231582359ec27e121bf4bb0ab3df8355f919d1d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
