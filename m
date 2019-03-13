Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130EFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F2C2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552495820;
	bh=CrD6Oq478unkohUCBUgUcBxHTip48qVCbzPPX76Jv7s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=LodV4xjdl8E+eVhTwNzq9Qn9C5G5+EOZhe7GV4PTD59EePeW7rYi38v7cT1PLqAyb
	 hWNDl5oYYzhpJx1mm20aWk1xbU1FhBqtgwVgWBrRhWMJfZvnU1lJZ1iOfDhlGRdeDO
	 RQ0quZ7eX6OnRpShUy1yotk8JMfYo4t33SAaZbM8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfCMQuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 12:50:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbfCMQuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 12:50:16 -0400
Subject: Re: [GIT PULL] UBI/UBIFS updates for 5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552495816;
        bh=CrD6Oq478unkohUCBUgUcBxHTip48qVCbzPPX76Jv7s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BfoJkbJoFNZJ3sD/KsgqdiE43DkINdaK8SrerDzN5Gq38q+PyK+QzM8703j19KzV1
         bEbYvpFRsfBaexwv4cPXFvs3k6cgd5+S21vDxQ3M14f6kBAY5SAEk9yhWqfDPY0hLs
         jXv0/7PC7YWOKYYgiG7wCNFicQDp7SxqBCoZEqdo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <6283638.XALati16HY@blindfold>
References: <6283638.XALati16HY@blindfold>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <6283638.XALati16HY@blindfold>
X-PR-Tracked-Remote: git://git.infradead.org/linux-ubifs.git
 tags/upstream-5.1-rc1
X-PR-Tracked-Commit-Id: 5578e48e5c0bf4684e68ae08caa2293bfb3f5307
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a840b56ba385059742c2b7f4fd665ec9afb8931e
Message-Id: <155249581630.9487.4809053847391506188.pr-tracker-bot@kernel.org>
Date:   Wed, 13 Mar 2019 16:50:16 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds@linux-foundation.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 12 Mar 2019 16:13:53 +0100:

> git://git.infradead.org/linux-ubifs.git tags/upstream-5.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a840b56ba385059742c2b7f4fd665ec9afb8931e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
