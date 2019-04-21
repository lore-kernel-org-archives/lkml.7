Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E10C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 14:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8B12086A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 14:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbfDUOTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 10:19:02 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57851 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbfDUOTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 10:19:00 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44nBf972Stz9sBZ; Mon, 22 Apr 2019 00:18:57 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 308be6c7817c850b55c3b6ff4bf53c2427e274bc
X-Patchwork-Hint: ignore
In-Reply-To: <20190326204720.18882-1-malat@debian.org>
To:     Mathieu Malaterre <malat@debian.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v2,1/2] powerpc: Make some functions static
Message-Id: <44nBf972Stz9sBZ@ozlabs.org>
Date:   Mon, 22 Apr 2019 00:18:57 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-26 at 20:47:18 UTC, Mathieu Malaterre wrote:
> In commit cb9e4d10c448 ("[POWERPC] Add support for 750CL Holly board")
> new functions were added. Since most of these functions can be made static,
> make it so.
> 
> Both holly_power_off and holly_halt functions were not changed since they
> are unused, making them static would have triggered the following warning
> (treated as error):
> 
>   arch/powerpc/platforms/embedded6xx/holly.c:244:13: error: 'holly_halt' defined but not used [-Werror=unused-function]
> 
> Silence the following warnings triggered using W=1:
> 
>   arch/powerpc/platforms/embedded6xx/holly.c:47:5: error: no previous prototype for 'holly_exclude_device' [-Werror=missing-prototypes]
>   arch/powerpc/platforms/embedded6xx/holly.c:190:6: error: no previous prototype for 'holly_show_cpuinfo' [-Werror=missing-prototypes]
>   arch/powerpc/platforms/embedded6xx/holly.c:196:17: error: no previous prototype for 'holly_restart' [-Werror=missing-prototypes]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/308be6c7817c850b55c3b6ff4bf53c24

cheers
