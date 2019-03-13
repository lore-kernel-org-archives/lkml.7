Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398F0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07CD52147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552495823;
	bh=1TPPDHyzdDNVBYvcq6FGAxp+kHEv3lCFVrIm2mONL68=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=peTrwHZScdSS4fnPtASnFdc/cTJ1mr55iDtKejnGmGmZ7FDNb1SEh4ceYp5KbL24t
	 AOEXwG+7XdHzOqn975pK6LnxVgZeEMm+W3ncezhKuFIVy2cwC9J62n1ItrsQowAgdI
	 6o+rh56S5Xi8pdMqrKUTDrbrO9EM2+rimRH14AuA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfCMQuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 12:50:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbfCMQuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 12:50:18 -0400
Subject: Re: [GIT PULL] Filesystem-DAX fixes for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552495817;
        bh=1TPPDHyzdDNVBYvcq6FGAxp+kHEv3lCFVrIm2mONL68=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WzTfYgntuOKVFoFrXpSSdRVM4tgDl/YGMWToxMsO1GNlXPbQ4HJmi35ev4OJJbxyu
         OpvN3T0xHU5AjaOesG3NdylCE3nNugqm+aV0aujU+PXJY0XrXPKfySJJ/wLUR3Ifke
         DV1dpzt1MiV20Mae2aQKW+/KWQobvAFC4eQ19jqk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4g5NH=4wKs7+V3hTw1Qv6peBQbb7xCyjjQn3bhj7J0WTw@mail.gmail.com>
References: <CAPcyv4g5NH=4wKs7+V3hTw1Qv6peBQbb7xCyjjQn3bhj7J0WTw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4g5NH=4wKs7+V3hTw1Qv6peBQbb7xCyjjQn3bhj7J0WTw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
 tags/fsdax-for-5.1
X-PR-Tracked-Commit-Id: e4b3448bc346fedf36db64124a664a959995b085
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3bb0f28d84f3d4e3800ae57d6b1a931b3f88c1f8
Message-Id: <155249581723.9487.16609965772986241330.pr-tracker-bot@kernel.org>
Date:   Wed, 13 Mar 2019 16:50:17 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 12 Mar 2019 16:20:52 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/fsdax-for-5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3bb0f28d84f3d4e3800ae57d6b1a931b3f88c1f8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
