Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869EBC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4DD2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="SMeTv9p4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfDZQQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:16:43 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52824 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbfDZQQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 12:16:43 -0400
Received: from zn.tnic (p200300EC2F0E4E009523F59E52E4EA88.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:4e00:9523:f59e:52e4:ea88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3E2011EC05A6;
        Fri, 26 Apr 2019 18:16:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1556295401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+eiT18Rlztua2QRRPsWhxmkEjPY4mAruq/2ZoQQBbo8=;
        b=SMeTv9p4ocusHBDUDfRSDVDRqx8DR2gxPVciCq8g/xTzFq97lPlqVQkKFCn0lK0mF5VIFr
        QaSle7lsjEmc4rBJQ1SSklQCaBkyuqxK1uhzKk6LsGTVUEzeQf5HD+2fo/XFPP5gx5vIs7
        xg5jhxH5vMDnXWA8AkCI5qfjvlU38wc=
Date:   Fri, 26 Apr 2019 18:16:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, tglx@linutronix.de,
        mingo@redhat.com, x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab+samsung@kernel.org
Subject: Re: [PATCH 01/27] Documentation: add Linux x86 docs to Sphinx TOC
 tree
Message-ID: <20190426161640.GH4608@zn.tnic>
References: <20190426153150.21228-1-changbin.du@gmail.com>
 <20190426153150.21228-2-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190426153150.21228-2-changbin.du@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 11:31:24PM +0800, Changbin Du wrote:
> Add a index.rst for x86 support. More docs will be added later.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/index.rst     | 1 +
>  Documentation/x86/index.rst | 9 +++++++++
>  2 files changed, 10 insertions(+)
>  create mode 100644 Documentation/x86/index.rst
> 
> diff --git a/Documentation/index.rst b/Documentation/index.rst
> index 80a421cb935e..d65dd4934a1a 100644
> --- a/Documentation/index.rst
> +++ b/Documentation/index.rst
> @@ -101,6 +101,7 @@ implementation.
>  .. toctree::
>     :maxdepth: 2
>  
> +   x86/index
>     sh/index
>  
>  Filesystem Documentation
> diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
> new file mode 100644
> index 000000000000..7612d3142b2a
> --- /dev/null
> +++ b/Documentation/x86/index.rst
> @@ -0,0 +1,9 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=================
> +Linux x86 Support

x86-specific Documentation

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
