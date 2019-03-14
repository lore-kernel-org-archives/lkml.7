Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C50C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 964F420693
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfCNLoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:44:02 -0400
Received: from ozlabs.org ([203.11.71.1]:50695 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726724AbfCNLoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 07:44:02 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44Kn0v6w4Hz9s55; Thu, 14 Mar 2019 22:43:59 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: de3c83c2fd2b87cf68214eda76dfa66989d78cb6
X-Patchwork-Hint: ignore
In-Reply-To: <20190312201823.29371-1-malat@debian.org>
To:     Mathieu Malaterre <malat@debian.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/64s: Include <asm/nmi.h> header file to fix a warning
Message-Id: <44Kn0v6w4Hz9s55@ozlabs.org>
Date:   Thu, 14 Mar 2019 22:43:59 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-12 at 20:18:23 UTC, Mathieu Malaterre wrote:
> Make sure to include <asm/nmi.h> to provide the following prototype:
> hv_nmi_check_nonrecoverable.
> 
> Remove the following warning treated as error (W=1):
> 
>   arch/powerpc/kernel/traps.c:393:6: error: no previous prototype for 'hv_nmi_check_nonrecoverable' [-Werror=missing-prototypes]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/de3c83c2fd2b87cf68214eda76dfa669

cheers
