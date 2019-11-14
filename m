Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810B2C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB92206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfKNJJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 04:09:36 -0500
Received: from ozlabs.org ([203.11.71.1]:45759 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfKNJHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:07:40 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47DFxP5npwz9sPF; Thu, 14 Nov 2019 20:07:37 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: bc75e5438488edef80d952d1146701f872092750
In-Reply-To: <20190702131733.44100-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <robh@kernel.org>,
        <gregkh@linuxfoundation.org>, <tglx@linutronix.de>,
        <allison@lohutok.net>, <groug@kaod.org>,
        <shilpa.bhat@linux.vnet.ibm.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     YueHaibing <yuehaibing@huawei.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] powerpc/powernv: Make some sysbols static
Message-Id: <47DFxP5npwz9sPF@ozlabs.org>
Date:   Thu, 14 Nov 2019 20:07:37 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-02 at 13:17:33 UTC, YueHaibing wrote:
> Fix sparse warnings:
> 
> arch/powerpc/platforms/powernv/opal-psr.c:20:1:
>  warning: symbol 'psr_mutex' was not declared. Should it be static?
> arch/powerpc/platforms/powernv/opal-psr.c:27:3:
>  warning: symbol 'psr_attrs' was not declared. Should it be static?
> arch/powerpc/platforms/powernv/opal-powercap.c:20:1:
>  warning: symbol 'powercap_mutex' was not declared. Should it be static?
> arch/powerpc/platforms/powernv/opal-sensor-groups.c:20:1:
>  warning: symbol 'sg_mutex' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/bc75e5438488edef80d952d1146701f872092750

cheers
