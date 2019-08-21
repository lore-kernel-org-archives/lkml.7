Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED582C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 20:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C3D2339E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 20:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566419703;
	bh=f2vThZms9ade6ULNLIYBpJ1ksg1haTxzagrJMrBGACw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=sy6UGuOAsWZCQ5Alw2cj232IwWnV69nPRXVekUR9egv5WcBGrMy9opUhGS/FqyUkh
	 UjowxOnI656zcNZalFrE+qRIpZzZuavfDdiZXcjlR7gbV5mnPL7W+Ph+nItDCfccbR
	 2uwpD7UEBmQR9EZ5qde/Af9deluRsLSc/oyIHNmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbfHUUfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 16:35:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:42000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729962AbfHUUfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 16:35:02 -0400
Subject: Re: [GIT PULL] nfsd bugfixes for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566419701;
        bh=f2vThZms9ade6ULNLIYBpJ1ksg1haTxzagrJMrBGACw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xzqbnHsQmRYPjwrXdzw8uHtUga6MTUW3/HUBEdHV1bnXCDztSzkoeggrlMokqCatx
         Wvw0w05qZ48fO3AGUfKx+O9i+4ymfG5aQqyuCSt5Z7FqY/TJxGIblUFi3cJl2nufOc
         Y3EusHHUuDq6kbiuYJ89D/z+XzHK8ghScKBvsRMk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190821150646.GC22104@fieldses.org>
References: <20190821150646.GC22104@fieldses.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190821150646.GC22104@fieldses.org>
X-PR-Tracked-Remote: git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.3-1
X-PR-Tracked-Commit-Id: 78e70e780b289ff59ec33a9f9c1fcecaf17a46e1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2babd34df2294a72df02dc4a3745df3408147eba
Message-Id: <156641970165.4116.17330431153924630328.pr-tracker-bot@kernel.org>
Date:   Wed, 21 Aug 2019 20:35:01 +0000
To:     bfields@fieldses.org (J. Bruce Fields)
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 21 Aug 2019 11:06:46 -0400:

> git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.3-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2babd34df2294a72df02dc4a3745df3408147eba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
