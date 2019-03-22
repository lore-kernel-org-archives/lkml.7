Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A4BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5791A2175B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553282119;
	bh=ZPXRAXHWwUsCvJBV2wRRIwBVqdaFxaxEHS5EGJnqpsY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=N6NEkEvqCKBtOocISpMdkcjJ9pgB4S4A3zRUmo/EbAYUXSwBlhqIBSUy1tJymw8om
	 j9Iuh3c6Hmn0cjrxb9QgeA0/DzAK8Vze1c3/3Y/IrfSSGEa8vw519nY1wGEEXyC81H
	 0BjWawU6p48LlKG1I0mvdmKmglcDXzkIfOJJ2o/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbfCVTPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 15:15:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbfCVTPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 15:15:11 -0400
Subject: Re: [GIT PULL] Power management fixes for v5.1-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553282111;
        bh=ZPXRAXHWwUsCvJBV2wRRIwBVqdaFxaxEHS5EGJnqpsY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lg8m5IDbFT4wm9vsZ52KDq1hB/mulDTvd0NeJTqjuXgXswwyBUV0Hj37XjTMBYLX5
         0fR/qZMQepP0xNL+e2TNOFlThCYNBTV9CMTCf554NFREGr28zrUOojEAp83StX0ONI
         zrAZQrwc+McGHYCueCn0S0jHzcwULkH9Cce/zzys=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gTJn9fdpM_y2wL=y0vqGeJhvLKzoD_BfNj-yNkmepBnw@mail.gmail.com>
References: <CAJZ5v0gTJn9fdpM_y2wL=y0vqGeJhvLKzoD_BfNj-yNkmepBnw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gTJn9fdpM_y2wL=y0vqGeJhvLKzoD_BfNj-yNkmepBnw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.1-rc2
X-PR-Tracked-Commit-Id: 112a04f653ddf1d4246415e8e0d820002ebe8dca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b44290a022dcffb5ca3b75300e571fad06214bc7
Message-Id: <155328211117.18163.5686802326510454962.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Mar 2019 19:15:11 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Mar 2019 11:25:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.1-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b44290a022dcffb5ca3b75300e571fad06214bc7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
