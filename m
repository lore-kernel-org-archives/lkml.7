Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B355C3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 02:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C17214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 02:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FShJKSPW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FShJKSPW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394661AbfITCEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 22:04:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36192 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390810AbfITCEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 22:04:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EC7876122D; Fri, 20 Sep 2019 02:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568945071;
        bh=7VRyQrCrEIg2B5dbxsKJsZB0FNxfrVA48YSIi9y+2Os=;
        h=Date:From:To:Cc:Subject:From;
        b=FShJKSPW0XfZJeo5I3gGmXH9lqzOX8YyBeciOR4R2NCet5ripR+7Sx4zbJCQQtCh+
         /kkkS3txf3eqf755Owz4k33d56jKQurmFiGl2quw4cE0qWW5GZS/xsbFYNo5TSVoBe
         2JHJeQYUp1ruSspcgibSieRUr/RUtEwxsICKUwnM=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rkuo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ECF5460850;
        Fri, 20 Sep 2019 02:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568945071;
        bh=7VRyQrCrEIg2B5dbxsKJsZB0FNxfrVA48YSIi9y+2Os=;
        h=Date:From:To:Cc:Subject:From;
        b=FShJKSPW0XfZJeo5I3gGmXH9lqzOX8YyBeciOR4R2NCet5ripR+7Sx4zbJCQQtCh+
         /kkkS3txf3eqf755Owz4k33d56jKQurmFiGl2quw4cE0qWW5GZS/xsbFYNo5TSVoBe
         2JHJeQYUp1ruSspcgibSieRUr/RUtEwxsICKUwnM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ECF5460850
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rkuo@codeaurora.org
Date:   Thu, 19 Sep 2019 21:04:27 -0500
From:   Richard Kuo <rkuo@codeaurora.org>
To:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-hexagon@vger.kernel.org
Cc:     bcain@codeaurora.org
Subject: [GIT PULL] Hexagon arch maintainer change
Message-ID: <20190920020427.GA7719@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the following changes.  I am leaving QuIC, and Brian Cain will be
taking over maintainership of the Hexagon port.


Thanks,
Richard Kuo


The following changes since commit 4d856f72c10ecb060868ed10ff1b1453943fc6c8:

  Linux 5.3 (2019-09-15 14:19:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rkuo/linux-hexagon-kernel.git for-linus

for you to fetch changes up to 18dd1793a340f8216e22c9295c0c7b95cdae1783:

  Hexagon: change maintainer to Brian Cain (2019-09-19 14:58:15 -0500)

----------------------------------------------------------------
Brian Cain (1):
      Hexagon: change maintainer to Brian Cain

 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)


-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
