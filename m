Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C80DC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9F321726
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388992AbfHVNJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 09:09:19 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47091 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388972AbfHVNJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:09:15 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 46DlGw6ltlz9sPg; Thu, 22 Aug 2019 23:09:12 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: b5bda6263cad9a927e1a4edb7493d542da0c1410
In-Reply-To: <20190820081352.8641-2-santosh@fossix.org>
To:     Santosh Sivaraj <santosh@fossix.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Chandan Rajendra <chandan@linux.ibm.com>,
        stable@vger.kernel.org, Reza Arbab <arbab@linux.ibm.com>
Subject: Re: [PATCH v11 1/7] powerpc/mce: Schedule work from irq_work
Message-Id: <46DlGw6ltlz9sPg@ozlabs.org>
Date:   Thu, 22 Aug 2019 23:09:12 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-20 at 08:13:46 UTC, Santosh Sivaraj wrote:
> schedule_work() cannot be called from MCE exception context as MCE can
> interrupt even in interrupt disabled context.
> 
> fixes: 733e4a4c ("powerpc/mce: hookup memory_failure for UE errors")
> Reviewed-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> Acked-by: Balbir Singh <bsingharora@gmail.com>
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
> Cc: stable@vger.kernel.org # v4.15+

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b5bda6263cad9a927e1a4edb7493d542da0c1410

cheers
