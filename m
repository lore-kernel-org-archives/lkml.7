Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72730C742D2
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 00:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47AC120896
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 00:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562978424;
	bh=YEdvw8KKPDlfcOiH98l1gke1HwRIqid/SZHdOShcLA8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=o1ciOe5NswSGJUSUlf0oOFMs/Byoi5OkYmrs/bcNI76T9AjnCtc0fZkNa8PFSD5e0
	 nv8vYaq5CHdKaceyQBH2aNel+ARg/mHuFqqjaEwuj8+y3UK4vjFNuudpe4J74iiG9g
	 T+eoTjYva44ZBPyOoZPgT7pneNBBLMllq2Oq7+ao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfGMAkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 20:40:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727666AbfGMAkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 20:40:15 -0400
Subject: Re: [GIT PULL] dlm updates for 5.3 (second try)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562978414;
        bh=YEdvw8KKPDlfcOiH98l1gke1HwRIqid/SZHdOShcLA8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Cvd6uhuDmeUMa/GUb0BDXfAH6iGYFvFRqYYJ1o5D8LsR7QHFTF6GjipeXq/yeoAzK
         5tzvoraa0dVwPekVvIGmqH22+//jqowWOt/7FjE/cOrujhTinShKmlptI7s/3W5Mol
         ZwOIOwpHoLPVp8ETHcDrQJs5YEU9/IMc8xLbflsc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190712151844.GA24064@redhat.com>
References: <20190712151844.GA24064@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190712151844.GA24064@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-5.3
X-PR-Tracked-Commit-Id: a48f9721e6db74dfbeb8d4a2cd616b20017f4b78
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 964a4eacef67503a1154f7e0a75f52fbdce52022
Message-Id: <156297841464.30815.16194210122331063303.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Jul 2019 00:40:14 +0000
To:     David Teigland <teigland@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Jul 2019 10:18:44 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/964a4eacef67503a1154f7e0a75f52fbdce52022

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
