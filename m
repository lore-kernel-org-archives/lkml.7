Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9A1C31E40
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 00:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0343217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 00:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565137812;
	bh=1L7jH45DxzfNoMd3XdH9LcuQVFlnxperKjR9QMTRNcA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=2iEmI7ERtb3up8OTXFy6UYSkF4AJyl8IhR1N5mhDmzxRuvd5JZq6rmq/QaFtT5goD
	 CUVhpJFGzSHfemllb0jTp/f1KNCSv2jueL77dn5hOsF/Oqw+/tlWwKtH34t1ceH6nq
	 SVd4mMRJRcOcrPwrWKJqPsaR4jG7wTM3IzmpqHu0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfHGAaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 20:30:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728144AbfHGAaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 20:30:10 -0400
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565137809;
        bh=1L7jH45DxzfNoMd3XdH9LcuQVFlnxperKjR9QMTRNcA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=W8dhFYfso6loQV7SqcOJJrvSKF5QcXAal4FB/isgT21vKX438PGBYfG1kEwUqwEUk
         cZ3fuIxhrXRyV5L8JfhLMc9aLuLp296RFx9qm3sLiiGG6e0QRMM7YAjgIqgCUFXWRp
         GZFlL2qQ3gijY5juyH2s1q6q2DMxpY21QZQFzLH8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190806.163557.192717542972894245.davem@davemloft.net>
References: <20190806.163557.192717542972894245.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190806.163557.192717542972894245.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
 refs/heads/master
X-PR-Tracked-Commit-Id: feac1d680233a48603213d52230f92222462a1c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 33920f1ec5bf47c5c0a1d2113989bdd9dfb3fae9
Message-Id: <156513780964.19141.4150616808616856653.pr-tracker-bot@kernel.org>
Date:   Wed, 07 Aug 2019 00:30:09 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 06 Aug 2019 16:35:57 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/33920f1ec5bf47c5c0a1d2113989bdd9dfb3fae9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
