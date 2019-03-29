Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD952C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F8F12183E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="DpAcgVdj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbfC2KvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:51:11 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43630 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729057AbfC2KvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:51:10 -0400
Received: from zn.tnic (p200300EC2F148A00A084EDD1F3CAD6FC.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:a084:edd1:f3ca:d6fc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5966C1EC082D;
        Fri, 29 Mar 2019 11:51:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553856669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0e85glshDddVnDKYFSqI0DI7WMmCRFw0I8ijzWPUQ3c=;
        b=DpAcgVdj0atephS5XJdlC4mM76vBPG0hwCBzMg7yrdifTmsTbsebQy6FT0Mw6tW1a7J3vP
        qs0+l+wA/78kXzVZPUrVp/x9AoIhMUZiU80rZEoYzzitrSb5p19GhpxspTdWkZlBmYSGuH
        LDL4fdokTlJ3oiOaBBdyPBm7GwPgjTg=
Date:   Fri, 29 Mar 2019 11:51:12 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     thor.thayer@linux.intel.com
Cc:     mchehab@kernel.org, james.morse@arm.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] EDAC, altera: Initialize peripheral FIFOs in probe()
Message-ID: <20190329105112.GD21152@zn.tnic>
References: <1553635771-32693-1-git-send-email-thor.thayer@linux.intel.com>
 <1553635771-32693-2-git-send-email-thor.thayer@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1553635771-32693-2-git-send-email-thor.thayer@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 04:29:31PM -0500, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> The FIFO memory and ECC initialization doesn't need to be
> done as a separate operation early in the startup.
> 
> Improve the Arria10 and Stratix10 peripheral FIFO init
> by initializing memory and enabling ECC as part of the
> device driver initialization.
> 
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
>  drivers/edac/altera_edac.c | 162 +++++++++++++++++++++++++--------------------
>  1 file changed, 91 insertions(+), 71 deletions(-)

Both applied,
thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
