Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D92C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 21:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FECD2075B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 21:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfCAViW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 16:38:22 -0500
Received: from gateway36.websitewelcome.com ([192.185.193.119]:18903 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725996AbfCAViW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 16:38:22 -0500
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 8D2AA400CA06B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2019 14:53:30 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id zprIg5gQV4FKpzprIgN64M; Fri, 01 Mar 2019 15:38:20 -0600
X-Authority-Reason: nr=8
Received: from [189.250.88.58] (port=33126 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gzprI-00246B-20; Fri, 01 Mar 2019 15:38:20 -0600
Subject: Re: [PATCH v3] mtd: rawnand: Mark expected switch fall-throughs
To:     Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Wan ZongShun <mcuos.com@gmail.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Kees Cook <keescook@chromium.org>
References: <20190208174930.GA12962@embeddedor>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 VtSixD1uOgytAP7RWS474w==
Message-ID: <1a9e7d7e-6743-4932-a1b6-528ae7e5643a@embeddedor.com>
Date:   Fri, 1 Mar 2019 15:38:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190208174930.GA12962@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.88.58
X-Source-L: No
X-Exim-ID: 1gzprI-00246B-20
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.88.58]:33126
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 20
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Friendly ping:

Who can take this, please?

Thanks
--
Gustavo

On 2/8/19 11:49 AM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warning:
> 
> drivers/mtd/nand/raw/diskonchip.c: In function ‘doc_probe’:
> ./include/linux/printk.h:303:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/mtd/nand/raw/diskonchip.c:1479:4: note: in expansion of macro ‘pr_err’
>     pr_err("DiskOnChip Millennium Plus 32MB is not supported, ignoring.\n");
>     ^~~~~~
> drivers/mtd/nand/raw/diskonchip.c:1480:3: note: here
>    default:
>    ^~~~~~~
> drivers/mtd/nand/raw/nandsim.c: In function ‘ns_init_module’:
> drivers/mtd/nand/raw/nandsim.c:2254:22: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     chip->bbt_options |= NAND_BBT_NO_OOB;
> drivers/mtd/nand/raw/nandsim.c:2255:2: note: here
>   case 1:
>   ^~~~
> drivers/mtd/nand/raw/nuc900_nand.c: In function ‘nuc900_nand_command_lp’:
> ./arch/x86/include/asm/io.h:91:22: warning: this statement may fall through [-Wimplicit-fallthrough=]
>  #define __raw_writel __writel
> drivers/mtd/nand/raw/nuc900_nand.c:52:2: note: in expansion of macro ‘__raw_writel’
>   __raw_writel((val), (dev)->reg + REG_SMCMD)
>   ^~~~~~~~~~~~
> drivers/mtd/nand/raw/nuc900_nand.c:196:3: note: in expansion of macro ‘write_cmd_reg’
>    write_cmd_reg(nand, NAND_CMD_READSTART);
>    ^~~~~~~~~~~~~
> drivers/mtd/nand/raw/nuc900_nand.c:197:2: note: here
>   default:
>   ^~~~~~~
> drivers/mtd/nand/raw/omap_elm.c: In function ‘elm_context_restore’:
> drivers/mtd/nand/raw/omap_elm.c:512:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     elm_write_reg(info, ELM_SYNDROME_FRAGMENT_4 + offset,
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       regs->elm_syndrome_fragment_4[i]);
>       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/mtd/nand/raw/omap_elm.c:514:3: note: here
>    case BCH8_ECC:
>    ^~~~
> drivers/mtd/nand/raw/omap_elm.c:517:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     elm_write_reg(info, ELM_SYNDROME_FRAGMENT_2 + offset,
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       regs->elm_syndrome_fragment_2[i]);
>       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/mtd/nand/raw/omap_elm.c:519:3: note: here
>    case BCH4_ECC:
>    ^~~~
> drivers/mtd/nand/raw/omap_elm.c: In function ‘elm_context_save’:
> drivers/mtd/nand/raw/omap_elm.c:466:37: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     regs->elm_syndrome_fragment_4[i] = elm_read_reg(info,
>     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
>       ELM_SYNDROME_FRAGMENT_4 + offset);
>       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/mtd/nand/raw/omap_elm.c:468:3: note: here
>    case BCH8_ECC:
>    ^~~~
> drivers/mtd/nand/raw/omap_elm.c:471:37: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     regs->elm_syndrome_fragment_2[i] = elm_read_reg(info,
>     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
>       ELM_SYNDROME_FRAGMENT_2 + offset);
>       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/mtd/nand/raw/omap_elm.c:473:3: note: here
>    case BCH4_ECC:
>    ^~~~
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enabling
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> Changes in v3:
>  - Leave out of this patch the following files:
> 	drivers/mtd/nand/onenand/onenand_base.c
> 	drivers/mtd/nand/raw/nand_base.c
> 	drivers/mtd/nand/raw/nand_legacy.c
> 	
>    The first one needs to be reworked, and the last
>    two have already been addressed.
> 
> Changes in v2:
>  - Add extra /* fall through */ comment in nandsim.c file.
> 
>  drivers/mtd/nand/raw/diskonchip.c  | 1 +
>  drivers/mtd/nand/raw/nandsim.c     | 6 ++++--
>  drivers/mtd/nand/raw/nuc900_nand.c | 3 ++-
>  drivers/mtd/nand/raw/omap_elm.c    | 4 ++++
>  4 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/diskonchip.c b/drivers/mtd/nand/raw/diskonchip.c
> index 53f57e0f007e..ead54c90f2d1 100644
> --- a/drivers/mtd/nand/raw/diskonchip.c
> +++ b/drivers/mtd/nand/raw/diskonchip.c
> @@ -1477,6 +1477,7 @@ static int __init doc_probe(unsigned long physadr)
>  			break;
>  		case DOC_ChipID_DocMilPlus32:
>  			pr_err("DiskOnChip Millennium Plus 32MB is not supported, ignoring.\n");
> +			/* fall through */
>  		default:
>  			ret = -ENODEV;
>  			goto notfound;
> diff --git a/drivers/mtd/nand/raw/nandsim.c b/drivers/mtd/nand/raw/nandsim.c
> index 933d1a629c51..edf5fd3d5f07 100644
> --- a/drivers/mtd/nand/raw/nandsim.c
> +++ b/drivers/mtd/nand/raw/nandsim.c
> @@ -2251,9 +2251,11 @@ static int __init ns_init_module(void)
>  
>  	switch (bbt) {
>  	case 2:
> -		 chip->bbt_options |= NAND_BBT_NO_OOB;
> +		chip->bbt_options |= NAND_BBT_NO_OOB;
> +		/* fall through */
>  	case 1:
> -		 chip->bbt_options |= NAND_BBT_USE_FLASH;
> +		chip->bbt_options |= NAND_BBT_USE_FLASH;
> +		/* fall through */
>  	case 0:
>  		break;
>  	default:
> diff --git a/drivers/mtd/nand/raw/nuc900_nand.c b/drivers/mtd/nand/raw/nuc900_nand.c
> index 38b1994e7ed3..56fa84029482 100644
> --- a/drivers/mtd/nand/raw/nuc900_nand.c
> +++ b/drivers/mtd/nand/raw/nuc900_nand.c
> @@ -192,8 +192,9 @@ static void nuc900_nand_command_lp(struct nand_chip *chip,
>  		return;
>  
>  	case NAND_CMD_READ0:
> -
>  		write_cmd_reg(nand, NAND_CMD_READSTART);
> +		/* fall through */
> +
>  	default:
>  
>  		if (!chip->legacy.dev_ready) {
> diff --git a/drivers/mtd/nand/raw/omap_elm.c b/drivers/mtd/nand/raw/omap_elm.c
> index a3f32f939cc1..94c6401ef32f 100644
> --- a/drivers/mtd/nand/raw/omap_elm.c
> +++ b/drivers/mtd/nand/raw/omap_elm.c
> @@ -465,11 +465,13 @@ static int elm_context_save(struct elm_info *info)
>  					ELM_SYNDROME_FRAGMENT_5 + offset);
>  			regs->elm_syndrome_fragment_4[i] = elm_read_reg(info,
>  					ELM_SYNDROME_FRAGMENT_4 + offset);
> +			/* fall through */
>  		case BCH8_ECC:
>  			regs->elm_syndrome_fragment_3[i] = elm_read_reg(info,
>  					ELM_SYNDROME_FRAGMENT_3 + offset);
>  			regs->elm_syndrome_fragment_2[i] = elm_read_reg(info,
>  					ELM_SYNDROME_FRAGMENT_2 + offset);
> +			/* fall through */
>  		case BCH4_ECC:
>  			regs->elm_syndrome_fragment_1[i] = elm_read_reg(info,
>  					ELM_SYNDROME_FRAGMENT_1 + offset);
> @@ -511,11 +513,13 @@ static int elm_context_restore(struct elm_info *info)
>  					regs->elm_syndrome_fragment_5[i]);
>  			elm_write_reg(info, ELM_SYNDROME_FRAGMENT_4 + offset,
>  					regs->elm_syndrome_fragment_4[i]);
> +			/* fall through */
>  		case BCH8_ECC:
>  			elm_write_reg(info, ELM_SYNDROME_FRAGMENT_3 + offset,
>  					regs->elm_syndrome_fragment_3[i]);
>  			elm_write_reg(info, ELM_SYNDROME_FRAGMENT_2 + offset,
>  					regs->elm_syndrome_fragment_2[i]);
> +			/* fall through */
>  		case BCH4_ECC:
>  			elm_write_reg(info, ELM_SYNDROME_FRAGMENT_1 + offset,
>  					regs->elm_syndrome_fragment_1[i]);
> 
