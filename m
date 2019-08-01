Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC041C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BB0216C8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564667119;
	bh=irKBkTZOXA50lKhibKjnQGmncCQWkMm6qcsvotwYPEY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=d+9NcRn8RUX9eU8oWYhWkHl+ztUtR8Ht4ZP+SCGb/b6en6BRu6g+UAP/a/5so7bPp
	 GNPvPmujGdMsgoh93vlzU+lCwQXQyyk37cu4SJwWzT6fBpkxCwbIVTdqWEIoLPVuVl
	 9crDsd/q7TGBEMi9ni/571r4FQcvdjKSs4IYWoNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbfHANpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 09:45:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:56202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728836AbfHANpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 09:45:16 -0400
Subject: Re: [GIT PULL] MMC fixes for v5.3-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564667115;
        bh=irKBkTZOXA50lKhibKjnQGmncCQWkMm6qcsvotwYPEY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=n5sUIyDfaDsFVZIMWm3S3HMidX1YApcCpcHh1whEKbUpG3goAfsfSkiWFlXBmuIht
         FJeUP6xM3KRKTIsNZfSmy32G4o2pWhnuzG3AKAS1UoY0AY4BvNC2qS81r2ejaFD+f5
         Q051fUj3sw7bF40fFgEipfp1dpccfGh7uquW5gSM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190801104319.25247-1-ulf.hansson@linaro.org>
References: <20190801104319.25247-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190801104319.25247-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.3-rc1
X-PR-Tracked-Commit-Id: 3a6ffb3c8c3274a39dc8f2514526e645c5d21753
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1e78030e5e5b2d8b0cad7136caf9cfab986a6bff
Message-Id: <156466711554.11650.9013736897239318826.pr-tracker-bot@kernel.org>
Date:   Thu, 01 Aug 2019 13:45:15 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  1 Aug 2019 12:43:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1e78030e5e5b2d8b0cad7136caf9cfab986a6bff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
