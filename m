Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3208C2BD09
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 19:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F6F224F8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 19:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbfLETne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 14:43:34 -0500
Received: from icp-osb-irony-out9.external.iinet.net.au ([203.59.1.226]:52977
        "EHLO icp-osb-irony-out9.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726028AbfLETne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 14:43:34 -0500
X-Greylist: delayed 557 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Dec 2019 14:43:32 EST
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2D5AABIW+ld/zXSMGcNWBwBAQEBAQc?=
 =?us-ascii?q?BAREBBAQBAYF+gwyBMYQrj2YGiyCRRAkBAQEBAQEBAQEjFAEBhECCOTgTAhA?=
 =?us-ascii?q?BAQEEAQEBAQEFAwGFWEyFYScVQSgNAiYCbAgBAYMeAYJSrmB1gTIaiGmBSIE?=
 =?us-ascii?q?OKIFlikx5gQeBOIc8gQSCQ4JeBI0wiUGXWQiCMIcfjjUhgkGHboQsA4tIqn6?=
 =?us-ascii?q?BejMaCCgIgycJR5YShVFijyeCQQEB?=
X-IPAS-Result: =?us-ascii?q?A2D5AABIW+ld/zXSMGcNWBwBAQEBAQcBAREBBAQBAYF+g?=
 =?us-ascii?q?wyBMYQrj2YGiyCRRAkBAQEBAQEBAQEjFAEBhECCOTgTAhABAQEEAQEBAQEFA?=
 =?us-ascii?q?wGFWEyFYScVQSgNAiYCbAgBAYMeAYJSrmB1gTIaiGmBSIEOKIFlikx5gQeBO?=
 =?us-ascii?q?Ic8gQSCQ4JeBI0wiUGXWQiCMIcfjjUhgkGHboQsA4tIqn6BejMaCCgIgycJR?=
 =?us-ascii?q?5YShVFijyeCQQEB?=
X-IronPort-AV: E=Sophos;i="5.69,282,1571673600"; 
   d="scan'208";a="216494522"
Received: from unknown (HELO [10.44.0.192]) ([103.48.210.53])
  by icp-osb-irony-out9.iinet.net.au with ESMTP; 06 Dec 2019 03:34:11 +0800
From:   Greg Ungerer <gerg@linux-m68k.org>
Subject: [git pull] m68knommu changes for v5.5
To:     torvalds@linux-foundation.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <b0a3cf1a-940e-f4e0-7102-acee10248048@linux-m68k.org>
Date:   Fri, 6 Dec 2019 05:34:06 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Can you please pull the m68knommu git tree, for-next branch.

Only a single change, to enable coldfire preemption entry code for all
preemption types.

Regards
Greg


The following changes since commit 31f4f5b495a62c9a8b15b1c3581acd5efeb9af8c:

   Linux 5.4-rc7 (2019-11-10 16:17:15 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git for-next

for you to fetch changes up to 3ad3cbe305b5a23d829d3723b60be59c36713992:

   m68k/coldfire: Use CONFIG_PREEMPTION (2019-11-11 10:54:40 +1000)

----------------------------------------------------------------
Thomas Gleixner (1):
       m68k/coldfire: Use CONFIG_PREEMPTION

  arch/m68k/coldfire/entry.S | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)
