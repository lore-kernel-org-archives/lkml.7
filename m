Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB70C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 23:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57AD218AE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 23:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568763621;
	bh=Ne0yRbdT8PpLUK/TPK3mDvpPWz3ogAq3s+79svNELtw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=c+xpi2x2lKIydh8lgpGPuA/IL7yaWF9aFpspE2wmCOdK55JEM+x/HRvWxP5d3K98Q
	 GASRmpJDXnpoWNc4i9RKvFubrqM2KtwKywFQM46GPsHf3uXJMGyhAy5mtngqWNoX+j
	 dUAvY+4SZUnpsn/buM9CHWD+JycWWp7VSd3Xtocc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfIQXkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 19:40:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbfIQXkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 19:40:19 -0400
Subject: Re: [GIT PULL] Documentation for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568763618;
        bh=Ne0yRbdT8PpLUK/TPK3mDvpPWz3ogAq3s+79svNELtw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EIXEkLp3nWp3SiqWA/lWfqmIrd4Cqu+No4b+UnwNL7VlfXMRZJ8HyR9DIV6EbNTfw
         2rFzxQLGu2H92adjC1mUvcO7E7RFAGQ3SAZyYnybQ3g/xfMKpPK20pnUuCo/YfPrzt
         k+0YAglrMXEEIS3Pju36k8h9Xs/CImbX8v+/yrew=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190916001918.7c9b69f7@lwn.net>
References: <20190916001918.7c9b69f7@lwn.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190916001918.7c9b69f7@lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-5.4
X-PR-Tracked-Commit-Id: fe013f8bc160d79c6e33bb66d9bb0cd24949274c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7c672abc120a55f678e5571ae2ee93f06ca4d7f9
Message-Id: <156876361890.26432.9962895084250559819.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Sep 2019 23:40:18 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 00:19:18 -0600:

> git://git.lwn.net/linux.git tags/docs-5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7c672abc120a55f678e5571ae2ee93f06ca4d7f9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
