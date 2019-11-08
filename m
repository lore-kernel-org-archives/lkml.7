Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEBEFC6196
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11A421848
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573249807;
	bh=wB44KTNLx4zivLpP5jo3n08ALKXJKuThlbJQVcom1cY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=BCuvHl7p68HfjZO96JCStUn6DG2WFmoVhka89UOizHP8SzqzRgC3QnXB/gMpoBlMO
	 O3Knp4xSNJlUmrha2mOaWhFGvhDtFmuBkbiGUbijJ6igmjwOE5UYw2F2w/Q+A17x0r
	 f1Z6FFkavoFpIV9WISOfsw3Sn3M66m9niJSLnZ3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbfKHVuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 16:50:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:38920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbfKHVuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:50:05 -0500
Subject: Re: [GIT PULL] Ceph fixes for 5.4-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573249805;
        bh=wB44KTNLx4zivLpP5jo3n08ALKXJKuThlbJQVcom1cY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rbvH3ylTTfDKN1altPwkWGqGRZnRKnu6S++B+fTmlpXV2hm70vVcXBYI4D+6ryLan
         BNucHxaz0GYTRzjwINhZn544D4xRDJt/ZlOVxKA2y4BqBkk2Gokc8atRkXfYWffYuE
         6iw2z0Yk+PrhZAW/7MfjA66NYVsFPFA2Z5U7tgBk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191108155853.23314-1-idryomov@gmail.com>
References: <20191108155853.23314-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191108155853.23314-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git
 tags/ceph-for-5.4-rc7
X-PR-Tracked-Commit-Id: ff29fde84d1fc82f233c7da0daa3574a3942bec7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0689acfad34e4f60a25e354af2835e1569da81ba
Message-Id: <157324980496.30145.3297312279339956877.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Nov 2019 21:50:04 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  8 Nov 2019 16:58:53 +0100:

> https://github.com/ceph/ceph-client.git tags/ceph-for-5.4-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0689acfad34e4f60a25e354af2835e1569da81ba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
