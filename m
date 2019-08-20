Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFE2C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31C722DBF
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AB7uQPTC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbfHTMWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 08:22:48 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36050 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbfHTMWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 08:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ao7gt5KDV0ONoTC0rFw7t2x/1w81a5HjQybBH7126vg=; b=AB7uQPTC2CEakdf7eAwGXLP28
        aDwACv/x1leJU6OwOGwBPPu5fR+Guyg2LNJinEJRErZLkrEhInBv2AhqV3+De0MjRLstaoiuE+xAG
        /AB6IiMp8m2a2dQSMNpLar1ddu4ty0b7uKxvEavWsdQCnpD6BSr5iRAjDV8BTs1qFKqyXu5EJSdIV
        KRgtK3GyDmcgK3MEc3wX/VKxpzJKoYsIBrh3j9qZWI9khfjnDpuWAP+TjhBLGP5nyUz7hvOM81BjN
        dPU2TIoWjPYW9Ehuw8lwPi9D6t685ZctxzRwvRtuGZ4vD68puRcDlDAtIVk009j2+J13qd7FpczAt
        DP7y3dNgA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i039o-0007Tw-Cc; Tue, 20 Aug 2019 12:22:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1F0B1307603;
        Tue, 20 Aug 2019 14:22:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5DF9B20A999E3; Tue, 20 Aug 2019 14:22:33 +0200 (CEST)
Date:   Tue, 20 Aug 2019 14:22:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        tony.luck@intel.com, x86@kernel.org, andriy.shevchenko@intel.com,
        alan@linux.intel.com, ricardo.neri-calderon@linux.intel.com,
        rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
        qi-ming.wu@intel.com, cheol.yong.kim@intel.com,
        rahul.tanwar@intel.com
Subject: Re: [PATCH v2 2/3] x86/cpu: Add new Intel Atom CPU model name
Message-ID: <20190820122233.GN2332@hirez.programming.kicks-ass.net>
References: <cover.1565940653.git.rahul.tanwar@linux.intel.com>
 <83345984845d24b6ce97a32bef21cd0bbdffc86d.1565940653.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83345984845d24b6ce97a32bef21cd0bbdffc86d.1565940653.git.rahul.tanwar@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 04:18:58PM +0800, Rahul Tanwar wrote:
> Add a new variant of Intel Atom Airmont CPU model.
> 
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---
>  arch/x86/include/asm/intel-family.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
> index 0278aa66ef62..cbbb8250370f 100644
> --- a/arch/x86/include/asm/intel-family.h
> +++ b/arch/x86/include/asm/intel-family.h
> @@ -73,6 +73,7 @@
>  
>  #define INTEL_FAM6_ATOM_AIRMONT		0x4C /* Cherry Trail, Braswell */
>  #define INTEL_FAM6_ATOM_AIRMONT_MID	0x5A /* Moorefield */
> +#define INTEL_FAM6_ATOM_AIRMONT_NP	0x75 /* Lightning Mountain */

What's _NP ?
