Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17101C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E95612087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfECG7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 02:59:20 -0400
Received: from ozlabs.org ([203.11.71.1]:36331 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727165AbfECG7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:59:16 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44wNKF4yxqz9sB8; Fri,  3 May 2019 16:59:13 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 32eeb5614d3bf166e84fe69bb5f3a51a48cac7a1
X-Patchwork-Hint: ignore
In-Reply-To: <20190329154456.27152-1-yuehaibing@huawei.com>
To:     Yue Haibing <yuehaibing@huawei.com>, <fbarrat@linux.ibm.com>,
        <andrew.donnellan@au1.ibm.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     YueHaibing <yuehaibing@huawei.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ocxl: remove set but not used variables 'tid' and 'lpid'
Message-Id: <44wNKF4yxqz9sB8@ozlabs.org>
Date:   Fri,  3 May 2019 16:59:13 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-03-29 at 15:44:56 UTC, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/misc/ocxl/link.c: In function 'xsl_fault_handler':
> drivers/misc/ocxl/link.c:187:17: warning: variable 'tid' set but not used [-Wunused-but-set-variable]
> drivers/misc/ocxl/link.c:187:6: warning: variable 'lpid' set but not used [-Wunused-but-set-variable]
> 
> They are never used and can be removed.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/32eeb5614d3bf166e84fe69bb5f3a51a

cheers
