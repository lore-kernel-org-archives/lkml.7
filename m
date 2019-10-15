Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AC4C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFEE2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571159109;
	bh=pxUwNPGigamTymvVuZ+SrGQ+bIMYIt+shIcP+UO78ao=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=KLT8+lHhqDNs/2uWKthWJ0KZJEtkkx+fKWl7utWfl8/UflrQO4S8EmoeiC2ufyiZV
	 A0vS/2DvJZpkx7ZdsW9zerQQ7forewWKWHUMOYqxfxv0Dzt8uQ29uKnV9cjZGKLDoM
	 6PW0blyBuezzsw+UeXt76qbm4xMhHkfw7VfhJsiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbfJORFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 13:05:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:40622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbfJORFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 13:05:07 -0400
Subject: Re: [GIT PULL] dmi fix for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571159107;
        bh=pxUwNPGigamTymvVuZ+SrGQ+bIMYIt+shIcP+UO78ao=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fsPtKs68SdxBZG/KYnpvfVW5bh3QCZykh8b1fPzrx/Gf+qbFFzknK8PjoDSylGsWn
         hPutFodLFakoQc0J7pdwW1YnnRa2j+7GpIeTJNt4bmz42XH6mjBhUn00u+NbPnUlvS
         +8iOlK05nLHXRgJl5+g7eU4et3I0zzHMIGLI3Y0k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191015101534.278375b9@endymion>
References: <20191015101534.278375b9@endymion>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191015101534.278375b9@endymion>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git
 dmi-for-linus
X-PR-Tracked-Commit-Id: 81dde26de9c08bb04c4962a15608778aaffb3cf9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 37b238da15a87a0be1cdda09e4aa8a5bc2b4d759
Message-Id: <157115910711.6841.17095554620947522714.pr-tracker-bot@kernel.org>
Date:   Tue, 15 Oct 2019 17:05:07 +0000
To:     Jean Delvare <jdelvare@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 15 Oct 2019 10:15:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git dmi-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/37b238da15a87a0be1cdda09e4aa8a5bc2b4d759

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
