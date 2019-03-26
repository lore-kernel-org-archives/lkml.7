Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297E0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFDC72070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="LWQQT7i0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731735AbfCZPzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:55:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37972 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbfCZPzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:55:05 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B8EDD1EC0104;
        Tue, 26 Mar 2019 16:55:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553615703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zQrlEXTzsStp/M2+x3lbkt/Eudpr10KgHvIcVXjQ7Jg=;
        b=LWQQT7i0W3laWRq0NmPczIUC2+OSlvmbWKgoHgQvx9lleurXSSM5g6L/2rCJfTnXHDQ9BG
        PJpeI80aUcxylGtyRrHh617wA5feC1OnCZFXpnpRe38kLzFx0QbB8VqzTLzEmbDDEJlDWP
        lc6iV3GIkmqAnIYuTG/59G6GJMPK5h8=
Date:   Tue, 26 Mar 2019 16:55:11 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC/amd64: Use maximum channel count for the EDAC
 channel layer size
Message-ID: <20190326155511.GM1867@zn.tnic>
References: <20190325203319.7603-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190325203319.7603-1-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 08:33:30PM +0000, Ghannam, Yazen wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> The AMD64 EDAC module current hardcodes the EDAC channel layer size
> (count) to two. Future AMD systems may have more channels than this.
> 
> Set the EDAC channel layer size equal to the maximum number of channels
> possible for the system. On Family 17h and later, this is set in the
> num_umcs variable. Older systems will continue to use two as the
> default.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/edac/amd64_edac.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Ok, whole pile here:

https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=edac-for-5.2-amd64

Please run it to check all is still good.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
