Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882F4C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A94E206BF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557249609;
	bh=r655pN5fozXnGz64v9/ltLkTFF7ZA/0LxeNPU/6u6fk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=sBg/gYq4/10QuEO2MnH+76rMaX3iX8erKU78Zu3H4lhmOZRVYzl+JMJ5G6EaHU9fd
	 9wVYrxs0A5BptHu0yELwIpaOnI5GEKiLbIabdgrow8d8ZFRPbESQ7gbMD8cGQ8q9bu
	 u/8gqx2+nNHS7UZa1vZ33Wo/HXe+iCqb8b+l00GE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfEGRUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:20:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfEGRUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:20:07 -0400
Subject: Re: [GIT PULL] HID for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557249606;
        bh=r655pN5fozXnGz64v9/ltLkTFF7ZA/0LxeNPU/6u6fk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=voBI5q1ht2pg2hKa0ycy3H9L5nr5g5U1znZ3UE3OoRr2Fd1fKDNuQEO6Zo2Jy6qLH
         +jnfiJf6mQXFjxbSGV7zygAXyOoDE4Nqg/IlVyLR4l6JEokXHhMGa9sA3uzuxHC1g4
         MGyUOfDbnC0GMxHG6gA1kerzmUwdU/dIgqy445WY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.1905061547380.17054@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1905061547380.17054@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.1905061547380.17054@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: 63b6f0b827d6b40e53bac5abc8150fa117d27bec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b4dd05dee0dbd16afdbba83b698a7110c687be2d
Message-Id: <155724960515.23705.13002310109191380642.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 17:20:05 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 16:03:43 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b4dd05dee0dbd16afdbba83b698a7110c687be2d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
