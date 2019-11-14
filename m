Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5323AC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3958B206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfKNJIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 04:08:36 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:59679 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727319AbfKNJIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:08:31 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47DFyM4sN5z9sSg; Thu, 14 Nov 2019 20:08:27 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 565f9bc05e2dad6c7fdfc7c2e641be580aa599cd
In-Reply-To: <20191107164757.15140-1-msuchanek@suse.de>
To:     Michal Suchanek <msuchanek@suse.de>, linuxppc-dev@lists.ozlabs.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Michal Suchanek <msuchanek@suse.de>,
        Hari Bathini <hbathini@linux.ibm.com>
Subject: Re: [PATCH v3] powerpc/fadump: when fadump is supported register the fadump sysfs files.
Message-Id: <47DFyM4sN5z9sSg@ozlabs.org>
Date:   Thu, 14 Nov 2019 20:08:27 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-11-07 at 16:47:57 UTC, Michal Suchanek wrote:
> Currently it is not possible to distinguish the case when fadump is
> supported by firmware and disabled in kernel and completely unsupported
> using the kernel sysfs interface. User can investigate the devicetree
> but it is more reasonable to provide sysfs files in case we get some
> fadumpv2 in the future.
> 
> With this patch sysfs files are available whenever fadump is supported
> by firmware.
> 
> There is duplicate message about lack of support by firmware in
> fadump_reserve_mem and setup_fadump. Remove the duplicate message in
> setup_fadump.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/565f9bc05e2dad6c7fdfc7c2e641be580aa599cd

cheers
