Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7AFC47E49
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3BFB2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407602AbfJXLEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 07:04:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:36606 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2393393AbfJXLEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 07:04:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 498ECB1A1;
        Thu, 24 Oct 2019 11:04:08 +0000 (UTC)
Subject: Re: [PATCH v2] zswap: allow setting default status, compressor and
 allocator in Kconfig
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>
Cc:     Vitaly Wool <vitalywool@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20191023232209.3016231-1-mail@maciej.szmigiero.name>
From:   Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <eb65a87b-5bfe-345e-dd83-39243db717a9@suse.cz>
Date:   Thu, 24 Oct 2019 13:04:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191023232209.3016231-1-mail@maciej.szmigiero.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/19 1:22 AM, Maciej S. Szmigiero wrote:
> The compressed cache for swap pages (zswap) currently needs from 1 to 3
> extra kernel command line parameters in order to make it work: it has to be
> enabled by adding a "zswap.enabled=1" command line parameter and if one
> wants a different compressor or pool allocator than the default lzo / zbud
> combination then these choices also need to be specified on the kernel
> command line in additional parameters.
> 
> Using a different compressor and allocator for zswap is actually pretty
> common as guides often recommend using the lz4 / z3fold pair instead of
> the default one.
> In such case it is also necessary to remember to enable the appropriate
> compression algorithm and pool allocator in the kernel config manually.
> 
> Let's avoid the need for adding these kernel command line parameters and
> automatically pull in the dependencies for the selected compressor
> algorithm and pool allocator by adding an appropriate default switches to
> Kconfig.
> 
> The default values for these options match what the code was using
> previously as its defaults.
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> ---
> Changes from v1:
> Rename CONFIG_ZSWAP_DEFAULT_COMP_* to CONFIG_ZSWAP_COMPRESSOR_DEFAULT_*
> and CONFIG_ZSWAP_DEFAULT_ZPOOL_* to CONFIG_ZSWAP_ZPOOL_DEFAULT_* while
> dropping the "_NAME" suffix from the final string option in both cases.
> 
>  mm/Kconfig | 103 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  mm/zswap.c |  26 ++++++++------
>  2 files changed, 117 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index a5dae9a7eb51..267316941324 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -525,7 +525,6 @@ config MEM_SOFT_DIRTY
>  config ZSWAP
>  	bool "Compressed cache for swap pages (EXPERIMENTAL)"
>  	depends on FRONTSWAP && CRYPTO=y
> -	select CRYPTO_LZO
>  	select ZPOOL
>  	help
>  	  A lightweight compressed cache for swap pages.  It takes
> @@ -541,6 +540,108 @@ config ZSWAP
>  	  they have not be fully explored on the large set of potential
>  	  configurations and workloads that exist.
>  
> +choice
> +	prompt "Compressed cache for swap pages default compressor"
> +	depends on ZSWAP
> +	default ZSWAP_COMPRESSOR_DEFAULT_LZO
> +	help
> +	  Selects the default compression algorithm for the compressed cache
> +	  for swap pages.
> +	  If in doubt, select 'LZO'.

Could it e.g. suggest which one is the fastest and which most space
efficient?
Also does this cover all compression algorithms? Are we going to add new
options if there are new ones? Wouldn't a string instead of choice be
sufficient here?

> +
> +choice
> +	prompt "Compressed cache for swap pages default allocator"
> +	depends on ZSWAP
> +	default ZSWAP_ZPOOL_DEFAULT_ZBUD
> +	help
> +	  Selects the default allocator for the compressed cache for
> +	  swap pages.
> +	  The default is 'zbud' for compatibility, however please do
> +	  read the description of each of the allocators below before
> +	  making a right choice.

It's somewhat unfortunate that the choice options don't include the
description and one has to go look for it elsewhere.

Also, shouldn't the list include zsmalloc?

> +	  The selection made here can be overridden by using the kernel
> +	  command line 'zswap.zpool=' option.
> +
> +config ZSWAP_ZPOOL_DEFAULT_ZBUD
> +	bool "zbud"
> +	select ZBUD
> +	help
> +	  Use the zbud allocator as the default allocator.
> +
> +config ZSWAP_ZPOOL_DEFAULT_Z3FOLD
> +	bool "z3fold"
> +	select Z3FOLD
> +	help
> +	  Use the z3fold allocator as the default allocator.
> +endchoice
> +
> +config ZSWAP_ZPOOL_DEFAULT
> +       string
> +       default "zbud" if ZSWAP_ZPOOL_DEFAULT_ZBUD
> +       default "z3fold" if ZSWAP_ZPOOL_DEFAULT_Z3FOLD
> +       default ""
> +
> +config ZSWAP_DEFAULT_ON
> +	bool "Enable the compressed cache for swap pages by default"
> +	depends on ZSWAP
> +	help
> +	  If selected, the compressed cache for swap pages will be enabled
> +	  at boot, otherwise it will be disabled.
> +
> +	  The selection made here can be overridden by using the kernel
> +	  command line 'zswap.enabled=' option.
> +
>  config ZPOOL
>  	tristate "Common API for compressed memory storage"
>  	help
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 46a322316e52..71795b6f5b71 100644
> --- a/mm/zswap.c
