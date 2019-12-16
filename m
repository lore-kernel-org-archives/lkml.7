Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DF6C2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 19:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 601A42082E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 19:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576524914;
	bh=jsrfCHHYKY0vkTXN4nMzpTPCwU/s5OIj35Zy+kQ4Ico=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=lvnhi/CBm/yulfm1l8gZoHdedfrqZoxa1k7aWsQRNi5ASgQqN3MFcuG+Ee6qEL0ND
	 HPKcjs5/KwCyBQXCksvoxlfNI66SxyL5FKMUGjvQc+qGfzJglSgucvs1fByYpmKfwH
	 QvXbNfubvvemE8lI/W0NSKjO2+6jmSLJLxiUTbc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfLPTfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 14:35:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:54304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbfLPTfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 14:35:12 -0500
Subject: Re: [GIT PULL] Kselftest fixes update for Linux 5.5-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576524912;
        bh=jsrfCHHYKY0vkTXN4nMzpTPCwU/s5OIj35Zy+kQ4Ico=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2KyCnZwwc+WtMmRa/1JmTP4v8qIuAVFZRTqwyYjJ+XfkkBK0KQfa4PGFUOyg2d9zE
         njlgT5htLxSoeXfNDAXB/P2UTRoeCC4XdOkkH8t9fcEM1n3LUA/xl6928q8P5e3A8K
         NRZy4ZFZ2wZv1XuYspMhVE1ZmKLlxiMUzTxEkqeE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <57894f9b-3cd0-f42d-cdc2-e3b8cb7255ab@linuxfoundation.org>
References: <57894f9b-3cd0-f42d-cdc2-e3b8cb7255ab@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <57894f9b-3cd0-f42d-cdc2-e3b8cb7255ab@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-5.5-rc2
X-PR-Tracked-Commit-Id: 4eac734486fd431e0756cc5e929f140911a36a53
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6afa873170a612b2b9e392c19c523ed8aae6fbc9
Message-Id: <157652491208.27590.13034529510762184266.pr-tracker-bot@kernel.org>
Date:   Mon, 16 Dec 2019 19:35:12 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     torvalds@linux-foundation.org, skhan@linuxfoundation.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Dec 2019 11:00:51 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-5.5-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6afa873170a612b2b9e392c19c523ed8aae6fbc9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
