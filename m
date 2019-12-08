Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C08C43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 02:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB8021835
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 02:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575772844;
	bh=yQ2AuTaZYSmCpEgi8Nk+sMFnCrkgsC9GqwHQj6tIDHU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=qD2uMztvINKI0l3rblDB4g0zEZQ9sDOV4NCn5vH0T2X/9MiL4tdfTZUHj1iILUIhW
	 Tdhy0V3tAQLaDcnz65cr44ZXkwU115WtIC9VU9Z+zdmnYKvmDwOZ6KONn1jj8G9yJp
	 bTcr7MOUpm6m2c3GH0tuSVWGOACbcGgDXk96SXn8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfLHCka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 21:40:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:44230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbfLHCk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 21:40:29 -0500
Subject: Re: [GIT PULL] NTB patches for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575772829;
        bh=yQ2AuTaZYSmCpEgi8Nk+sMFnCrkgsC9GqwHQj6tIDHU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KSRThp44urtT6QlXwjHD9GbGFtFLE4DYurMakzrZXv0kgk4m9C+rz42/Dt8f/M1D0
         ZlDVhH5+S47t/h3oJeMZpb6kj+uLrrY0r3Z0DTqsrugcFeKONtbYT7ZqydkAqD4pfb
         hkPY0MLS+DHnK5540QGp89XoKRcdG5O42Vrk0YSo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191207214242.GA22441@graymalkin>
References: <20191207214242.GA22441@graymalkin>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191207214242.GA22441@graymalkin>
X-PR-Tracked-Remote: git://github.com/jonmason/ntb tags/ntb-5.5
X-PR-Tracked-Commit-Id: 9b5b99a89f641555d9d00452afb0a8aea4471eba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9455d25f4e3b3d009fa1b810862e5b06229530e4
Message-Id: <157577282920.16893.17916917958020676481.pr-tracker-bot@kernel.org>
Date:   Sun, 08 Dec 2019 02:40:29 +0000
To:     Jon Mason <jdmason@kudzu.us>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-ntb@googlegroups.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 7 Dec 2019 16:42:42 -0500:

> git://github.com/jonmason/ntb tags/ntb-5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9455d25f4e3b3d009fa1b810862e5b06229530e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
