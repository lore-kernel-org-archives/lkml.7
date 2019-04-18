Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8180DC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 22:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423BF205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 22:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TVFH39vf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfDRV77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 17:59:59 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45160 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfDRV76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 17:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9jaQe96AMfy8BsHFHwpCay+crw8HVDe9YDeN8yMwU9E=; b=TVFH39vfZ3SdG+TAWrDl1NZdtz
        zc8gJjoM6v/gwKG2pNiA1hK9c5qp6maUd83cdDJalVmyzZafeBimA+NCaf2S704aNLk59UohBPBvR
        lnX6Hh2NcaNOMpttgRsC3cw6ffyW8+jdWMm+f7+L08xjbzqfWVPT417gKOoSQKh89Kui8B79++iym
        Jx+sG6OC7ePtVKBe+ADZVBs7LkSIJinUw0bCFoBrrv+69hUKXdJKAZElb9EfL3GHSODZxlHdoR6K1
        xrChSAYUp0uPMyw1ezkbDvl2CCLR/4jCla9qlj5mKoIsl8sCI4Oz1F+7aBwojPSASjKDa8Sduaplz
        2CPTlslw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hHF4J-0007K8-AJ; Thu, 18 Apr 2019 21:59:43 +0000
Subject: Re: [PATCH] docs: core-api: fix broken references for div64.c and
 gcd.c
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>
References: <734f49bae5d4052b3c25691dfefad59bea2e5843.1555580999.git.mchehab+samsung@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f1ccd7d6-c5c7-f558-18a9-1c2602a2ef84@infradead.org>
Date:   Thu, 18 Apr 2019 14:59:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <734f49bae5d4052b3c25691dfefad59bea2e5843.1555580999.git.mchehab+samsung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/19 2:50 AM, Mauro Carvalho Chehab wrote:
> Those files were moved to lib/math.
> 
> Fixes: 9635bad21596 ("lib: Move mathematic helpers to separate folder")

Is that commid ID in mainline?  I get:
fatal: ambiguous argument '9635bad21596': unknown revision or path not in the working tree.

> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

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
>  
>  UUID/GUID
> 


-- 
~Randy
