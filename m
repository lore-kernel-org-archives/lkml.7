Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45124C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C6D20718
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfKNJIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 04:08:06 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:57841 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727056AbfKNJIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:08:00 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47DFxp4XN4z9sSK; Thu, 14 Nov 2019 20:07:58 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: d273fa919c39223a1edd968e82ea88501b63d21a
In-Reply-To: <20191023134838.21280-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <mahesh@linux.vnet.ibm.com>,
        <ganeshgr@linux.ibm.com>, <yuehaibing@huawei.com>,
        <gregkh@linuxfoundation.org>, <npiggin@gmail.com>,
        <tglx@linutronix.de>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND][PATCH] powerpc/pseries: Use correct event modifier in rtas_parse_epow_errlog()
Message-Id: <47DFxp4XN4z9sSK@ozlabs.org>
Date:   Thu, 14 Nov 2019 20:07:58 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-23 at 13:48:38 UTC, YueHaibing wrote:
> rtas_parse_epow_errlog() should pass 'modifier' to
> handle_system_shutdown, because event modifier only use
> bottom 4 bits.
> 
> Reviewed-by: Tyrel Datwyler <tyreld@linux.ibm.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d273fa919c39223a1edd968e82ea88501b63d21a

cheers
