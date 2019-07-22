Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8B2C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 06:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE43D21921
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 06:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfGVG6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 02:58:16 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:45575 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfGVG6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 02:58:16 -0400
Received: from [192.168.1.110] ([77.2.59.209]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MidPj-1iJXhV0B5r-00fkTH; Mon, 22 Jul 2019 08:58:10 +0200
Subject: Re: [PATCH] ia64: tioca: fix spelling mistake in macros
 CA_APERATURE_{BASE|SIZE}
To:     Colin King <colin.king@canonical.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190721205921.9960-1-colin.king@canonical.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <c62e488f-38b9-304d-f9d6-5502c25b84b7@metux.net>
Date:   Mon, 22 Jul 2019 08:58:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190721205921.9960-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:6Cz69RqLT0dFKL3GeeZxgqGnJtSxgvnVxPk/WTbGqZGWTx0LFw7
 7ARXE6t+4WwyoWIEOjArQFZ6VBHRI+3FUKlcyrFWOItioRv1fIBzOZ52bRh87zpinFjcFyN
 seWLNr2nip6A0e32Jz/DMtyaiC/O4hmxe27SqU4P8BPzp7O3owiN+cNrgLn/NDtKgoRifkW
 hSiZ/Aqad5quh4Ld1jtwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fDfb8F7oJqw=:EZzhv07YxlCmIWvOHTo6TU
 O4FG/vR3+G9+REBTbncXrfVqyot4wAza6ebqLqCoFdUKacVom5Em7fISK+erX+u5cRqsobQNj
 TAAvEOXfpgb7SYhlxBGxWj7DkT4vQOjVlOmaiHqHCWryp73Wa7mGevGf8CsKn8XP8VfN9PoQ7
 HhVr1iDmkPn6zWQPZ9f2hv/xv5wU95vTTS/s8TafLKx3HVGXhJ+lR1GvaJ6z8b4Jrnvhr1Fhl
 x8vRdL6pYBIxtty1/iwKirvg2ZkoevNefVgVKl+IlGDzl49jmKUphDPBjR67LRTYJvRrODmTF
 9RA/TW2MOgNg+RV9xUkXyAnU73lNSOhY1/AkaY8LIItCxcpnWjsCf0NN2cyy9AVIVt8spfrRB
 ZhlRMg0ZjbRpxlSJ6HFn1lgZWu0awf/kXbe0bTeDRyB4Cr7XliSnj7gzioZK6j5FTygQSL3nx
 FBvcd++hg8gNk+5VTwYwuPx8Dqy7vc29DJrMLAftxvcAy9bCDE7/PAso7V7LzDUP+AaZxddQK
 frxEg9HYkaVgHKC9UZWJOPzn1u98s/QdjX/LDrm5FabBVx2DEprcgB1MAU+3bD0wv8pJRtLZC
 EyMaX4PqMe3Tex3u8TS3Zueete4YC1olcuHIeCCW55jVxV/RjTbTalbZa7L819HreuYj14bEn
 GMyzfqCk+WkYUpZwB0a5nHRe/5EkREZILBfIYjgkviYIbW3bvyHBkrO0yZCQcBzk7nLkj8Hmt
 8FNqPRuCncME+1GY5vezEpsayMeLmHgodlI3Az6BgCa3/S5syDWrPIJSP10=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.07.19 22:59, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The two macros CA_APERATURE_BASE and CA_APERATURE_SIZE contain
> a spelling mistake, APERATURE should be APERTURE, so fix these.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   arch/ia64/include/asm/sn/tioca.h  |  4 ++--
>   arch/ia64/sn/pci/tioca_provider.c | 14 +++++++-------
>   2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/ia64/include/asm/sn/tioca.h b/arch/ia64/include/asm/sn/tioca.h
> index 666222d7f0f6..4529fb11c86c 100644
> --- a/arch/ia64/include/asm/sn/tioca.h
> +++ b/arch/ia64/include/asm/sn/tioca.h
> @@ -590,7 +590,7 @@ struct tioca {
>   #define CA_AGP_DIRECT_BASE	0x40000000UL	/* 2GB */
>   #define CA_AGP_DIRECT_SIZE	0x40000000UL
>   
> -#define CA_APERATURE_BASE	(CA_AGP_MAPPED_BASE)
> -#define CA_APERATURE_SIZE	(CA_AGP_MAPPED_SIZE+CA_PCI32_MAPPED_SIZE)
> +#define CA_APERTURE_BASE	(CA_AGP_MAPPED_BASE)
> +#define CA_APERTURE_SIZE	(CA_AGP_MAPPED_SIZE+CA_PCI32_MAPPED_SIZE)
>   
>   #endif  /* _ASM_IA64_SN_TIO_TIOCA_H */
> diff --git a/arch/ia64/sn/pci/tioca_provider.c b/arch/ia64/sn/pci/tioca_provider.c
> index a70b11fd57d6..07832f5e8718 100644
> --- a/arch/ia64/sn/pci/tioca_provider.c
> +++ b/arch/ia64/sn/pci/tioca_provider.c
> @@ -55,7 +55,7 @@ tioca_gart_init(struct tioca_kernel *tioca_kern)
>   	 * Validate aperature size
>   	 */
>   
> -	switch (CA_APERATURE_SIZE >> 20) {
> +	switch (CA_APERTURE_SIZE >> 20) {
>   	case 4:
>   		ap_reg |= (0x3ff << CA_GART_AP_SIZE_SHFT);	/* 4MB */
>   		break;
> @@ -90,8 +90,8 @@ tioca_gart_init(struct tioca_kernel *tioca_kern)
>   		ap_reg |= (0x000 << CA_GART_AP_SIZE_SHFT);	/* 4 GB */
>   		break;
>   	default:
> -		printk(KERN_ERR "%s:  Invalid CA_APERATURE_SIZE "
> -		       "0x%lx\n", __func__, (ulong) CA_APERATURE_SIZE);
> +		printk(KERN_ERR "%s:  Invalid CA_APERTURE_SIZE "
> +		       "0x%lx\n", __func__, (ulong) CA_APERTURE_SIZE);
>   		return -1;
>   	}
>   
> @@ -106,8 +106,8 @@ tioca_gart_init(struct tioca_kernel *tioca_kern)
>   		tioca_kern->ca_ap_pagesize = 4096;
>   	}
>   
> -	tioca_kern->ca_ap_size = CA_APERATURE_SIZE;
> -	tioca_kern->ca_ap_bus_base = CA_APERATURE_BASE;
> +	tioca_kern->ca_ap_size = CA_APERTURE_SIZE;
> +	tioca_kern->ca_ap_bus_base = CA_APERTURE_BASE;
>   	tioca_kern->ca_gart_entries =
>   	    tioca_kern->ca_ap_size / tioca_kern->ca_ap_pagesize;
>   
> @@ -141,7 +141,7 @@ tioca_gart_init(struct tioca_kernel *tioca_kern)
>   	 * Compute PCI/AGP convenience fields
>   	 */
>   
> -	offset = CA_PCI32_MAPPED_BASE - CA_APERATURE_BASE;
> +	offset = CA_PCI32_MAPPED_BASE - CA_APERTURE_BASE;
>   	tioca_kern->ca_pciap_base = CA_PCI32_MAPPED_BASE;
>   	tioca_kern->ca_pciap_size = CA_PCI32_MAPPED_SIZE;
>   	tioca_kern->ca_pcigart_start = offset / tioca_kern->ca_ap_pagesize;
> @@ -159,7 +159,7 @@ tioca_gart_init(struct tioca_kernel *tioca_kern)
>   		return -1;
>   	}
>   
> -	offset = CA_AGP_MAPPED_BASE - CA_APERATURE_BASE;
> +	offset = CA_AGP_MAPPED_BASE - CA_APERTURE_BASE;
>   	tioca_kern->ca_gfxap_base = CA_AGP_MAPPED_BASE;
>   	tioca_kern->ca_gfxap_size = CA_AGP_MAPPED_SIZE;
>   	tioca_kern->ca_gfxgart_start = offset / tioca_kern->ca_ap_pagesize;
> 
Reviewed-By: Enrico Weigelt <info@metux.net>

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
