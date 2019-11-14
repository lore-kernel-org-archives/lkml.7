Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FC9C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2B120718
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfKNJH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 04:07:57 -0500
Received: from ozlabs.org ([203.11.71.1]:50975 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbfKNJHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:07:55 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47DFxj5f70z9sRm; Thu, 14 Nov 2019 20:07:53 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: b811be615cb78c90fca42bbd5b958427d03ba7e0
In-Reply-To: <20191017093204.7511-2-ravi.bangoria@linux.ibm.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        christophe.leroy@c-s.fr, mikey@neuling.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        linux-kernel@vger.kernel.org, npiggin@gmail.com, paulus@samba.org,
        naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 1/7] Powerpc/Watchpoint: Introduce macros for watchpoint length
Message-Id: <47DFxj5f70z9sRm@ozlabs.org>
Date:   Thu, 14 Nov 2019 20:07:53 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-10-17 at 09:31:58 UTC, Ravi Bangoria wrote:
> We are hadrcoding length everywhere in the watchpoint code.
> Introduce macros for the length and use them.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b811be615cb78c90fca42bbd5b958427d03ba7e0

cheers
