Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D60AC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE45F20842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551807605;
	bh=+4ZwYjMVTqmrFOckp1xNv/2KBKJxTrbRJSchuLW7PYE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=HVWBJbJtP0aezv6c42qBvO6ZjxIv3O+mt1DraM2k+j8GR20bh1ajUgLE7JMKDeNxy
	 e+KgTCOiw6IlUdULUFpCvTi1MEgcHCQtUrc4g5LAJH82xXKqyq7Q+ThMwpAgRYENMK
	 fxq9kSUQlXwkSBemHlQG/hcUzt01yy/RN8Jj2GzQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfCERkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 12:40:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:41180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbfCERkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 12:40:03 -0500
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551807602;
        bh=+4ZwYjMVTqmrFOckp1xNv/2KBKJxTrbRJSchuLW7PYE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wJ4fQcsefIJeiWdruhJOlUMLdTKsHDwUSBkcKRIt9pq3VgfMI6vesIcy8q7Bgk6db
         TF6CN3uOdj4kZDjhoq+9S7Z5JOXVBWH6QwwJ2noG2BU385VJTR44+ChygevRIh/es3
         YzgRyjXdHnDIW/jn1REZBzwutR12yKLj5VdK5+Pc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190304.152627.899317145967428120.davem@davemloft.net>
References: <20190304.152627.899317145967428120.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190304.152627.899317145967428120.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next
 refs/heads/master
X-PR-Tracked-Commit-Id: 18a4d8bf250a33c015955f0dec27259780ef6448
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6456300356433873309a1cae6aa05e77d6b59153
Message-Id: <155180760284.1948.10539925222059815431.pr-tracker-bot@kernel.org>
Date:   Tue, 05 Mar 2019 17:40:02 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 04 Mar 2019 15:26:27 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6456300356433873309a1cae6aa05e77d6b59153

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
