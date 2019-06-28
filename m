Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03D6C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7206B2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561683306;
	bh=AeykGisETI19pMTMY7Y0ctoaJTVvUm9DspONR5Tte4Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=bquh80ghyTWlUGcOH1CS0Ae3djqX/VQ1Pq8VKrE5N8Kui5WnWhlxsaxPrtd+Qp93z
	 BoGkcOMiGX37ObIfhsx2CCw6lfXxsknfaquZjKx7B6bCjH20Qog56X57ZHwqqVSikO
	 FjCqJWDw/8Jr94I2Yy5+vP+Q29mx0k/lYjIPugU4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfF1AzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 20:55:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbfF1AzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 20:55:04 -0400
Subject: Re: [GIT PULL] fixes for v5.2-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561683303;
        bh=AeykGisETI19pMTMY7Y0ctoaJTVvUm9DspONR5Tte4Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DwUktA+HC2hC4FnxRIDud/FykKoMb8mMajyc+rQuc5DsE4+ClRVLEyoRu56sxZZz/
         AgacqhE8+3QGyH9FHZLEWfJ7nxfPUU3QzoI7OtHadShdLAlusmb8wpjN4QvHgosSOK
         QA4bjLLvNTnawBcTi4MZt5O5wCXXzWkNqJPKgIoE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190627112430.6590-1-christian@brauner.io>
References: <20190627112430.6590-1-christian@brauner.io>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190627112430.6590-1-christian@brauner.io>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux
 tags/for-linus-20190627
X-PR-Tracked-Commit-Id: 30d158b143b6575261ab610ae7b1b4f7fe3830b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7a702b4e82d8730d6964bfd98b3b024c126e9846
Message-Id: <156168330366.8716.3052438043309398771.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Jun 2019 00:55:03 +0000
To:     Christian Brauner <christian@brauner.io>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        ldv@altlinux.org, viro@zeniv.linux.org.uk, jannh@google.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Jun 2019 13:24:30 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-20190627

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7a702b4e82d8730d6964bfd98b3b024c126e9846

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
