Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AFBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF6A218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553896218;
	bh=6J41Ytu5BUDCNXj7XWd3RnEfKAX8V0eqe+K7sAtBzt4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=NjgLq2F+A/awe1wsa8kJW/POuSMV3jRoc3xLICYswX2aM25Ny9i7UVoYvRQR9kKX8
	 1pGuTObaTo9dnGKXMOKu/M14TwHXTj58HRdeAZwcPIhdsSSVGWi4jLSVTRmvYlpM0p
	 oDd9zlpsyg6+KLFrdDZzaUs2p3JyoXHxATKvFyis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbfC2VuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 17:50:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730330AbfC2VuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 17:50:12 -0400
Subject: Re: [GIT PULL] Ceph fixes for 5.1-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553896212;
        bh=6J41Ytu5BUDCNXj7XWd3RnEfKAX8V0eqe+K7sAtBzt4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kozXfAmY2LKXI9JWd9Sqk9wG8yJ09BhMvG9KR9hi6G9vZO0Jpu9yamFoOrRdRKAYo
         qfGS16hULzp5T+YdrOO8c3NgJmhJeG7vFGa6RNyTVL4B8eAeXVgiSX1uPMm10jGyGh
         Q2DamUi4/wcQl2PVP59uOXBz1RSxvQGvv9N8lNDI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190329163213.17081-1-idryomov@gmail.com>
References: <20190329163213.17081-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190329163213.17081-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git
 tags/ceph-for-5.1-rc3
X-PR-Tracked-Commit-Id: daf5cc27eed99afdea8d96e71b89ba41f5406ef6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7376e39ad96583545faefa2e7798bcb6a2a212a7
Message-Id: <155389621216.28625.13207181306263631140.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Mar 2019 21:50:12 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Mar 2019 17:32:13 +0100:

> https://github.com/ceph/ceph-client.git tags/ceph-for-5.1-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7376e39ad96583545faefa2e7798bcb6a2a212a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
