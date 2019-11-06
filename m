Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCBEC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 05:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C852084C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 05:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="i+xoTHoc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730900AbfKFF7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 00:59:49 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48428 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfKFF7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 00:59:48 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA65xcY6070610;
        Tue, 5 Nov 2019 23:59:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573019978;
        bh=/RK0uOCbClf9VxVsdthFZWLOyuG/GQTi/0ClInCExY8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=i+xoTHocY4Dl3oq5ERNLhp2Fw+DfK7gwro/M0dDMtSSMriQLKQ71xgfpcQWehA3Ox
         MntAXR3R7tJ66lE/G7NMX4M/jYRy+kdYQA6XxgVYAiv8VulqK3glK2CwiMJqPxc/A9
         94igXccbXOm3Ctv0MG/5MryfsziLt1I20yCUFO2w=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xA65xcYW066822
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Nov 2019 23:59:38 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 5 Nov
 2019 23:59:23 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 5 Nov 2019 23:59:23 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA65xYLe081054;
        Tue, 5 Nov 2019 23:59:35 -0600
Subject: Re: [PATCH v4 18/20] mtd: spi-nor: Rename macronix_quad_enable to
 spi_nor_sr1_bit6_quad_enable
To:     <Tudor.Ambarus@microchip.com>, <boris.brezillon@collabora.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20191102112316.20715-1-tudor.ambarus@microchip.com>
 <20191102112316.20715-19-tudor.ambarus@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <10b14e43-0f06-88fa-20b5-05f99cd93b6f@ti.com>
Date:   Wed, 6 Nov 2019 11:30:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191102112316.20715-19-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/11/19 4:53 PM, Tudor.Ambarus@microchip.com wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Rename method to a generic name: spi_nor_sr1_bit6_quad_enable().
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

Regards
Vignesh

> ---
>  drivers/mtd/spi-nor/spi-nor.c | 19 +++++++++----------
>  include/linux/mtd/spi-nor.h   |  2 +-
>  2 files changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 8bc29cc073a0..85e5a56fb2d7 100644
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
> @@ -2349,7 +2348,7 @@ static void gd25q256_default_init(struct spi_nor *nor)
>  	 * indicate the quad_enable method for this case, we need
>  	 * to set it in the default_init fixup hook.
>  	 */
> -	nor->params.quad_enable = macronix_quad_enable;
> +	nor->params.quad_enable = spi_nor_sr1_bit6_quad_enable;
>  }
>  
>  static struct spi_nor_fixups gd25q256_fixups = {
> @@ -3729,7 +3728,7 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
>  
>  	case BFPT_DWORD15_QER_SR1_BIT6:
>  		nor->flags &= ~SNOR_F_HAS_16BIT_SR;
> -		params->quad_enable = macronix_quad_enable;
> +		params->quad_enable = spi_nor_sr1_bit6_quad_enable;
>  		break;
>  
>  	case BFPT_DWORD15_QER_SR2_BIT7:
> @@ -4627,7 +4626,7 @@ static int spi_nor_setup(struct spi_nor *nor,
>  
>  static void macronix_set_default_init(struct spi_nor *nor)
>  {
> -	nor->params.quad_enable = macronix_quad_enable;
> +	nor->params.quad_enable = spi_nor_sr1_bit6_quad_enable;
>  	nor->params.set_4byte = macronix_set_4byte;
>  }
>  
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index f626e0e52909..6d703df97f13 100644
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

-- 
Regards
Vignesh
