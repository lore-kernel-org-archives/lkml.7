Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DB2C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE9B20645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfDSSzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:55:51 -0400
Received: from ms.lwn.net ([45.79.88.28]:40250 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbfDSSzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:55:50 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A9B92537;
        Fri, 19 Apr 2019 18:55:49 +0000 (UTC)
Date:   Fri, 19 Apr 2019 12:55:48 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: Re: [PATCH] docs: core-api: fix broken references for div64.c and
 gcd.c
Message-ID: <20190419125548.2cca263d@lwn.net>
In-Reply-To: <734f49bae5d4052b3c25691dfefad59bea2e5843.1555580999.git.mchehab+samsung@kernel.org>
References: <734f49bae5d4052b3c25691dfefad59bea2e5843.1555580999.git.mchehab+samsung@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Apr 2019 06:50:18 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> Those files were moved to lib/math.
> 
> Fixes: 9635bad21596 ("lib: Move mathematic helpers to separate folder")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/core-api/kernel-api.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
> index 71f5d2fe39b7..a29c99d13331 100644
> --- a/Documentation/core-api/kernel-api.rst
> +++ b/Documentation/core-api/kernel-api.rst
> @@ -147,10 +147,10 @@ Division Functions
>  .. kernel-doc:: include/linux/math64.h
>     :internal:
>  
> -.. kernel-doc:: lib/div64.c
> +.. kernel-doc:: lib/math/div64.c
>     :functions: div_s64_rem div64_u64_rem div64_u64 div64_s64
>  
> -.. kernel-doc:: lib/gcd.c
> +.. kernel-doc:: lib/math/gcd.c
>     :export:

This, of course, creates a build error in docs-next...hopefully that
situation won't last more than a couple of weeks or so.  Applied, thanks.

jon
