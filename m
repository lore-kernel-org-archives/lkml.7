Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CF1C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A509220679
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bmdDEV7Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfKHQDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:03:30 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58750 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfKHQDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:03:30 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA8G33u3080555;
        Fri, 8 Nov 2019 10:03:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573228983;
        bh=u4gsuJ0OJ+HEZB/Xhok1JnEaGMFtpAhmu8kN1Pe4jhQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bmdDEV7QGrYbIWe6/nh9q/ja1owTdoHJxXzEVlbSkuYgmDFmbaVhamIFANOp8qDT8
         T/fI164BsQgkBiCwMcJtZDCirX2eLxICjdz4faL9IO9J6j99B9cKcGCysn1KH6o5NN
         AHDi9V1yQ9K1B3LXiVFgoOyHpFEJWF8nT55JU6Qo=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xA8G32QB032789
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Nov 2019 10:03:02 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 8 Nov
 2019 10:02:46 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 8 Nov 2019 10:02:46 -0600
Received: from [10.250.132.49] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA8G2xhr034183;
        Fri, 8 Nov 2019 10:03:00 -0600
Subject: Re: [PATCH v5 6/6] mtd: spi-nor: Rename Quad Enable methods
To:     <Tudor.Ambarus@microchip.com>, <boris.brezillon@collabora.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20191107084135.22122-1-tudor.ambarus@microchip.com>
 <20191107084135.22122-7-tudor.ambarus@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <d71a58fb-90a5-3ebb-1ce8-046be7f0be1f@ti.com>
Date:   Fri, 8 Nov 2019 21:32:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191107084135.22122-7-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07-Nov-19 2:12 PM, Tudor.Ambarus@microchip.com wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Rename macronix_quad_enable() to a generic name:
> spi_nor_sr1_bit6_quad_enable().
> 
> Prepend "spi_nor_" to "sr2_bit7_quad_enable". All SPI NOR generic
> methods should be prepended by "spi_nor_".
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

Regards
Vignesh

> ---
>  drivers/mtd/spi-nor/spi-nor.c | 25 ++++++++++++-------------
>  include/linux/mtd/spi-nor.h   |  2 +-
>  2 files changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 16fb3c7d0daf..824649eecd59 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -2078,16 +2078,15 @@ static int spi_nor_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t len)
>  }
>  
>  /**
> - * macronix_quad_enable() - set QE bit in Status Register.
> + * spi_nor_sr1_bit6_quad_enable() - Set the Quad Enable BIT(6) in the Status
> + * Register 1.
>   * @nor:	pointer to a 'struct spi_nor'
>   *
> - * Set the Quad Enable (QE) bit in the Status Register.
> - *
> - * bit 6 of the Status Register is the QE bit for Macronix like QSPI memories.
> + * Bit 6 of the Status Register 1 is the QE bit for Macronix like QSPI memories.
>   *
>   * Return: 0 on success, -errno otherwise.
>   */
> -static int macronix_quad_enable(struct spi_nor *nor)
> +static int spi_nor_sr1_bit6_quad_enable(struct spi_nor *nor)
>  {
>  	int ret;
>  
> @@ -2095,10 +2094,10 @@ static int macronix_quad_enable(struct spi_nor *nor)
>  	if (ret)
>  		return ret;
>  
> -	if (nor->bouncebuf[0] & SR_QUAD_EN_MX)
> +	if (nor->bouncebuf[0] & SR1_QUAD_EN_BIT6)
>  		return 0;
>  
> -	nor->bouncebuf[0] |= SR_QUAD_EN_MX;
> +	nor->bouncebuf[0] |= SR1_QUAD_EN_BIT6;
>  
>  	return spi_nor_write_sr1_and_check(nor, nor->bouncebuf[0]);
>  }
> @@ -2130,7 +2129,7 @@ static int spi_nor_sr2_bit1_quad_enable(struct spi_nor *nor)
>  }
>  
>  /**
> - * sr2_bit7_quad_enable() - set QE bit in Status Register 2.
> + * spi_nor_sr2_bit7_quad_enable() - set QE bit in Status Register 2.
>   * @nor:	pointer to a 'struct spi_nor'
>   *
>   * Set the Quad Enable (QE) bit in the Status Register 2.
> @@ -2141,7 +2140,7 @@ static int spi_nor_sr2_bit1_quad_enable(struct spi_nor *nor)
>   *
>   * Return: 0 on success, -errno otherwise.
>   */
> -static int sr2_bit7_quad_enable(struct spi_nor *nor)
> +static int spi_nor_sr2_bit7_quad_enable(struct spi_nor *nor)
>  {
>  	u8 *sr2 = nor->bouncebuf;
>  	int ret;
> @@ -2281,7 +2280,7 @@ static void gd25q256_default_init(struct spi_nor *nor)
>  	 * indicate the quad_enable method for this case, we need
>  	 * to set it in the default_init fixup hook.
>  	 */
> -	nor->params.quad_enable = macronix_quad_enable;
> +	nor->params.quad_enable = spi_nor_sr1_bit6_quad_enable;
>  }
>  
>  static struct spi_nor_fixups gd25q256_fixups = {
> @@ -3661,12 +3660,12 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
>  
>  	case BFPT_DWORD15_QER_SR1_BIT6:
>  		nor->flags &= ~SNOR_F_HAS_16BIT_SR;
> -		params->quad_enable = macronix_quad_enable;
> +		params->quad_enable = spi_nor_sr1_bit6_quad_enable;
>  		break;
>  
>  	case BFPT_DWORD15_QER_SR2_BIT7:
>  		nor->flags &= ~SNOR_F_HAS_16BIT_SR;
> -		params->quad_enable = sr2_bit7_quad_enable;
> +		params->quad_enable = spi_nor_sr2_bit7_quad_enable;
>  		break;
>  
>  	case BFPT_DWORD15_QER_SR2_BIT1:
> @@ -4569,7 +4568,7 @@ static void intel_set_default_init(struct spi_nor *nor)
>  
>  static void macronix_set_default_init(struct spi_nor *nor)
>  {
> -	nor->params.quad_enable = macronix_quad_enable;
> +	nor->params.quad_enable = spi_nor_sr1_bit6_quad_enable;
>  	nor->params.set_4byte = macronix_set_4byte;
>  }
>  
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index 364309845de0..9eae35c60bce 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -133,7 +133,7 @@
>  #define SR_E_ERR		BIT(5)
>  #define SR_P_ERR		BIT(6)
>  
> -#define SR_QUAD_EN_MX		BIT(6)	/* Macronix Quad I/O */
> +#define SR1_QUAD_EN_BIT6	BIT(6)
>  
>  /* Enhanced Volatile Configuration Register bits */
>  #define EVCR_QUAD_EN_MICRON	BIT(7)	/* Micron Quad I/O */
> 
