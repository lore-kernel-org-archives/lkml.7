Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CF3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC45120828
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="KJu7T09D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbfCZH4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 03:56:50 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48632 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730377AbfCZH4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 03:56:50 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0DA631EC09B1;
        Tue, 26 Mar 2019 08:56:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553587009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mJ8dR8Rj2Lm/4xUAuT7rGzb0r6dIei9lVzT84mXYsAE=;
        b=KJu7T09D3kjX1GxIrfH0Et1IRttA3IZK71lyBmZMWp5borlhPp93oBvlo1H47ZZInXseOg
        vJPK1u2IJEP2wp4uecOxSo40EID4F/lmRNUweZ8fMQqB8FKNycmdm+Xi14tm6UAMdeX705
        HuL0kv8AeR3t+85NNY/06ANkG/VKZag=
Date:   Tue, 26 Mar 2019 08:56:51 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "rafal@milecki.pl" <rafal@milecki.pl>,
        "clemej@gmail.com" <clemej@gmail.com>
Subject: Re: [PATCH v4 1/2] x86/MCE: Add function to allow filtering of MCA
 errors
Message-ID: <20190326075651.GB1867@zn.tnic>
References: <20190325163410.171021-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190325163410.171021-1-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 04:34:22PM +0000, Ghannam, Yazen wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Some systems may report spurious MCA errors. In general, spurious MCA
> errors may be disabled by clearing a particular bit in MCA_CTL. However,
> clearing a bit in MCA_CTL may not be recommended for some errors, so the
> only option is to ignore them.
> 
> An MCA error is printed and handled after it has been added to the MCE
> event pool. So an MCA error can be ignored by not adding it to the pool.
> 
> Define a default function that does not filter any errors.
> 
> Check if an MCA error should be filtered out when adding it to the MCE
> event pool.
> 
> Cc: <stable@vger.kernel.org> # 5.0.x

The old version of the patches had 4.14.x here as a kernel version. Why
change?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
