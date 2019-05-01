Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8031C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 20:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9242020675
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 20:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556743506;
	bh=5pgg8fJghgmAbVKUgViGhwp2W0Iw3pFuUL8623j/+G4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=V3kGvkKiaJOOon5uXSWSPqDFpS68yQ9aGZjb3zNvNRuMDXAz7qoSN2XxF8bUoiiGA
	 m1v1oVGTmdKhKBwTeM9PDgxrF8IuN4flXXrGaLcdg6FbRs+ioUcUaSCMg78UHhnKOJ
	 /5Jz+etuXFK1/JZ7n4jtH3s2QGnmFodvuytQM7iE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfEAUpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 16:45:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfEAUpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 16:45:04 -0400
Subject: Re: [GIT PULL] ARC updates for 5.1 final
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556743504;
        bh=5pgg8fJghgmAbVKUgViGhwp2W0Iw3pFuUL8623j/+G4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RfQZF0j82xXCLTeS+xWKQRBLtxURGEUp7QN9jvZqGwdiDdKrd3SwcaOFg8DxOk6yB
         Q2h7qjOHUuiozCBzJ+NaiyUT9QOiZoP7SNV0abs+CerUGkdJ/vKbyKEefXvgyR4dus
         jdk8dnMYBlUuV4eSS9hFChkrHPmDITTi2q3Dml5A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ab49ac97-deee-e2db-71c7-5544b09aca4f@synopsys.com>
References: <ab49ac97-deee-e2db-71c7-5544b09aca4f@synopsys.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ab49ac97-deee-e2db-71c7-5544b09aca4f@synopsys.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/
 tags/arc-5.1-final
X-PR-Tracked-Commit-Id: 55c0c4c793b538fb438bcc72481b9dc2f79fe5a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 65beea4c3a526320b019ca5c010da41533dafaf5
Message-Id: <155674350397.10978.6664250901055231758.pr-tracker-bot@kernel.org>
Date:   Wed, 01 May 2019 20:45:03 +0000
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 May 2019 09:09:56 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.1-final

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/65beea4c3a526320b019ca5c010da41533dafaf5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
