Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB46C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3173D2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="O8NBdrkB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730958AbfCZHdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 03:33:47 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45064 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbfCZHdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 03:33:47 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EEC1D1EC058B;
        Tue, 26 Mar 2019 08:33:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553585626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=yWaw34r3ikZVogWKj8M/1U46mF3JXDYcVy0I2a+rWFc=;
        b=O8NBdrkBC0HDxDl6+mgC1AEi0L4CR7rVaSZqPtbp6rr7zt5qi8OKzXpYqpIb3h3Vf7ccwW
        btuCNFlbcm+5fxtpcvrMsLLsIEREeeS/8unrNPT1Va70q1KH3OCteWa2z9S/tKjgYfyU/g
        UJZnBHk3AR6fNwrMIv7Y2aYfBMLmnCs=
Date:   Tue, 26 Mar 2019 08:33:46 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, Aristeu Rozanski <aris@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH] MAINTAINERS: Add entry for EDAC-I10NM
Message-ID: <20190326073346.GA1867@zn.tnic>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
 <20190325212506.26282-1-joe@perches.com>
 <20190325235627.GA11938@agluck-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190325235627.GA11938@agluck-desk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 04:56:27PM -0700, Luck, Tony wrote:
> We forgot to update the MAINTAINERS file when adding this
> new driver.
> 
> Fixes: d4dc89d069aa ("EDAC, i10nm: Add a driver for Intel 10nm server processors")
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e5f3230d3f14..86c4a5d95cca 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5596,6 +5596,12 @@ L:	linux-edac@vger.kernel.org
>  S:	Maintained
>  F:	drivers/edac/ghes_edac.c
>  
> +EDAC-I10NM
> +M:	Tony Luck <tony.luck@intel.com>
> +L:	linux-edac@vger.kernel.org
> +S:	Maintained
> +F:	drivers/edac/i10nm_base.c
> +
>  EDAC-I3000
>  L:	linux-edac@vger.kernel.org
>  S:	Orphan
> -- 

All 3 applied,
thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
