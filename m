Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965F7CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6588121A4A
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571946908;
	bh=LIqpWkAieXkIr5GXmMrlgYOTYrcR4oWkWtuJEgANcpY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=wI/n1DkZjsIgNHgdetDZ8Jnsv+e70vdGdOoDn8wsY7j9HkAHcQBWpYMCq7Aqun+6D
	 G6N5/i+e2wKCYRWhpqudxmD9jPISjFfdLVAElMS5H7yS5kRzPbXAXE+KV0kOUBFvcm
	 vg6jQ/xPbuTl17/V6Mk7gU+qVg0K59pgFv2zoZIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437225AbfJXTzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 15:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408338AbfJXTzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 15:55:06 -0400
Subject: Re: [GIT PULL] gfs2: Fix a memory leak introduced in -rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571946905;
        bh=LIqpWkAieXkIr5GXmMrlgYOTYrcR4oWkWtuJEgANcpY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YxwsTEmiJbxTuKnObNkZFDj5Vb1aGudToc4Q/ur5bu8mMJcJ5nmTBAel03VGk7QQH
         y9NkxlfZn6dtAGPt5gk8tzcb8hKT/B/62h1FodwYZ/ii66FO2f5ky25/vL/5YCuoy5
         wl35Cm1P3d4Htnpq0yhJXk0DhitvNGvm43gDnuXo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191024145120.16939-1-agruenba@redhat.com>
References: <20191024145120.16939-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191024145120.16939-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
 tags/gfs2-v5.4-rc4.fixes
X-PR-Tracked-Commit-Id: 30aecae86e914f526a2ca8d552011960ef6a2615
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 65b15b7f4b37a7e14541a0d8eca144067d23eeb0
Message-Id: <157194690576.28436.9604049539253113022.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Oct 2019 19:55:05 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 24 Oct 2019 16:51:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.4-rc4.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/65b15b7f4b37a7e14541a0d8eca144067d23eeb0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
