Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9DBC2D0D2
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 14:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32352070C
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 14:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576940127;
	bh=MI/JmG2aNZLH/n4zNzRm8HaS1AdrgVr2N65rL/m9UO8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=JI03pLdlcfR5eDiB6ldF8Q77v/Vls3kkiFs6HgZlVOYfpd8qjHDtcPl3a4dUJBwuE
	 0eVg1x+q0P2Qj5ZQLTbOrd38kekMR06pLohO5/xpeFlfj/hp2+skRtF5kjEM5vJm/i
	 egn2MItQga3JrTzT1zFinO2DOBBMRaFrqRshFbx0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfLUOz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 09:55:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:51580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbfLUOzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 09:55:10 -0500
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.5-4 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576940110;
        bh=MI/JmG2aNZLH/n4zNzRm8HaS1AdrgVr2N65rL/m9UO8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dRhbY1jJH0CP7sZg8h2wzi5T8ukY+RVnvEPChsH2sWHaR430ctqXdKlbzMlNXOw5J
         zEDz53EQbjeBEPDrgDQMxD7Wpa7atNFm7M/3QzyTeGzzzWU3l0sbYLRMiv07rGeOZU
         avuJYeHI85dOGasK7J8KlKGurO73naWiJRGtIMiE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87sgldlwb0.fsf@mpe.ellerman.id.au>
References: <87sgldlwb0.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87sgldlwb0.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.5-4
X-PR-Tracked-Commit-Id: 228b607d8ea1b7d4561945058d5692709099d432
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6d04182dd36dc5a4dd2e352c1d0f0241e83bd2a0
Message-Id: <157694011047.20544.8813472995788397797.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Dec 2019 14:55:10 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, ajd@linux.ibm.com,
        christophe.leroy@c-s.fr, david@redhat.com, fbarrat@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        longman@redhat.com, marcus@mc.pp.se, pauld@redhat.com,
        rppt@linux.ibm.com, srikar@linux.vnet.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Dec 2019 23:04:03 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.5-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6d04182dd36dc5a4dd2e352c1d0f0241e83bd2a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
