Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E57EC32759
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 07:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58446206C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 07:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="W9esGaau"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730685AbfHOH5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 03:57:38 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60386 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730382AbfHOH5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 03:57:38 -0400
Received: from zn.tnic (p200300EC2F0B5200DD69E9E370CF27BC.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:5200:dd69:e9e3:70cf:27bc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1897E1EC067D;
        Thu, 15 Aug 2019 09:57:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565855857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uw3MuAP15iFyITo377LGBMxCUt0Up0dvOinOJIGTV2A=;
        b=W9esGaaupYIdGPouuR90QaBfSgBnDfREQw6TDL6x045YHxclYzfsbxIC+SdU+VaY58/TW2
        04vwvyTA+P/AtaS/obMo/1thFLCIcjCo02SBanEVuEP/v7rrBmZS8Lo9cReSMxVQ8nlUQR
        PzuY9GuVwWpP0i0Azq1Nelq1iqEjWMg=
Date:   Thu, 15 Aug 2019 09:58:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS, x86/CPU: Tony Luck will maintain
 asm/intel-family.h
Message-ID: <20190815075822.GC15313@zn.tnic>
References: <20190814234030.30817-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190814234030.30817-1-tony.luck@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 04:40:30PM -0700, Tony Luck wrote:
> There are a few different subsystems in the kernel that depend on
> model specific behaviour (perf, EDAC, power, ...). Easier for just
> one person to have the task to get new model numbers included instead
> of having these groups trip over each other to do it.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)

Applied, thanks.

As a first order of business, pls sum up the naming scheme convention
you guys are going to adhere to so that it is clear to everybody:

https://lkml.kernel.org/r/91eefbe4-e32b-d762-be4d-672ff915db47@intel.com

in a patch form. :)

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
