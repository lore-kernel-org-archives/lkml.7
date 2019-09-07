Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AE3C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 00:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1EA521670
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 00:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567814408;
	bh=bO5D7b+G4BacDXfHXQp7mqjyzEa961ZYDoRZ01kCtNE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=oYtNFqd2bfY5b0+kv0OXoVFBGGZAK7f3fcZmeKCfM0+axhRnUi+yPSE74B3A5BUZM
	 8rvev0vt2UtnRPa+HP5TNUz4SgcX6iruX+iIiWwU6htWwpr6cKlON9zpB9WYz3uD81
	 FYk3WnnaBaObT5RUYzpOauWvbIUEA7ALFKUdki6I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405535AbfIGAAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 20:00:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393299AbfIGAAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 20:00:06 -0400
Subject: Re: [GIT PULL] libnvdimm fix for v5.3-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567814406;
        bh=bO5D7b+G4BacDXfHXQp7mqjyzEa961ZYDoRZ01kCtNE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=M08mv9AypFTjYdUaHMxmT+I0/cDZXVcrLFl+Byxf60wP6Zjf5+Ul982M4PBT28OfW
         IAMlOMdA08n0fCyYbIpxvaKplSBkcWPnMYlpgO8ohYBzenUhLiyb/RV7Di2npzo3M0
         H/W8ZkQjyB6Xzdu8Df6F048ljACf9ooTrWoAsGY0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4jDWgZDJTAgghrFX1MQXPJX_6jiqsmx9sQUOL7ZaWtk+w@mail.gmail.com>
References: <CAPcyv4jDWgZDJTAgghrFX1MQXPJX_6jiqsmx9sQUOL7ZaWtk+w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4jDWgZDJTAgghrFX1MQXPJX_6jiqsmx9sQUOL7ZaWtk+w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
 tags/libnvdimm-fix-5.3-rc8
X-PR-Tracked-Commit-Id: 274b924088e93593c76fb122d24bc0ef18d0ddf4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7641033e17efe472c0e2fd6da00f1b75dc6788f3
Message-Id: <156781440637.2933.2647196814273727641.pr-tracker-bot@kernel.org>
Date:   Sat, 07 Sep 2019 00:00:06 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        jmoyer <jmoyer@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 6 Sep 2019 13:00:00 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fix-5.3-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7641033e17efe472c0e2fd6da00f1b75dc6788f3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
