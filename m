Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5BBCA9ED1
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 18:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 591C921783
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 18:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572719711;
	bh=TOyYussdSLJNvufipa1EX90zquHkMbJWvDpA/Jmt63k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=P5PxWZxlXU1ncdmmiJ8p91ymwN08QZg9qhSovBDgTLi6HM5ZTweFDz2SanVeSGxFd
	 7plN6pfFII5LfsBIwpmyegQKNkk3Iivr/UcEMuQIum8ZzP8VQHmZb+RYsJaMeox1Kg
	 8//hlhBEy2w3LV41JLaI3A9ZM7pAHd2sjjcRUc8g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfKBSfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 14:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbfKBSfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 14:35:06 -0400
Subject: Re: [GIT PULL] s390 updates for 5.4-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572719706;
        bh=TOyYussdSLJNvufipa1EX90zquHkMbJWvDpA/Jmt63k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ClzSLg1k6Az7Hfy5Er52q9iyfvKbsinqx4O20wtKnFxq8ah4xy2Eh5MvFnkkpueql
         e0MStL4ByPggMI5ead1TXyefXFYzdOApwjbZVHwsy2S5iOD6T+AtFu4e1ZkaxCGTki
         GXpaC4tm4rv5upb+3GUK5+rTvb7uqwcGmb7/N/9c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01572690220-ext-8522@work.hours>
References: <your-ad-here.call-01572690220-ext-8522@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01572690220-ext-8522@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.4-6
X-PR-Tracked-Commit-Id: 3d7efa4edd07be5c5c3ffa95ba63e97e070e1f3f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 969a5197da89454c41d95e2404e2e9d91ad73ba6
Message-Id: <157271970622.32009.11368122331007905497.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Nov 2019 18:35:06 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 2 Nov 2019 11:23:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.4-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/969a5197da89454c41d95e2404e2e9d91ad73ba6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
