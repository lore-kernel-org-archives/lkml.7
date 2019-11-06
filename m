Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BFCC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 05:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 117A82084C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 05:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="l/he5zoL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbfKFFpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 00:45:24 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51246 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfKFFpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 00:45:23 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA65j4Bx125992;
        Tue, 5 Nov 2019 23:45:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573019104;
        bh=kcsJtvuh/ZeYHZ1N0JL53sjXg9t96k4SlPrBCY1RDFs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=l/he5zoLUijOOSORmhEb1GICJ1ah3Vn/JDhbB4eEZAKuK32RWg3K4LPwYhxYagm8F
         N9pQ0d7BEwqHwJ+sZocNT0PEAMVHE9QxfmBBlGKO+sIORegv1rGZiNy1wPMGxZqhtd
         CHhC3WsqTeKpcYSjJPYOOWXgBMG8j6ZKChhCDOP0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA65j4Z7030988;
        Tue, 5 Nov 2019 23:45:04 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 5 Nov
 2019 23:44:49 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 5 Nov 2019 23:44:49 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA65j1PK071193;
        Tue, 5 Nov 2019 23:45:02 -0600
Subject: Re: [PATCH v4 16/20] mtd: spi-nor: Rename CR_QUAD_EN_SPAN to
 SR2_QUAD_EN_BIT1
To:     <Tudor.Ambarus@microchip.com>, <boris.brezillon@collabora.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20191102112316.20715-1-tudor.ambarus@microchip.com>
 <20191102112316.20715-17-tudor.ambarus@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <56381a82-0bf9-a018-90c6-64405c2d23c1@ti.com>
Date:   Wed, 6 Nov 2019 11:15:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191102112316.20715-17-tudor.ambarus@microchip.com>
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
> JEDEC Basic Flash Parameter Table, 15th DWORD, bits 22:20,
> refers to this bit as "bit 1 of the status register 2".
> Rename the macro accordingly.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

Regards
Vignesh

> ---
>  drivers/mtd/spi-nor/spi-nor.c | 10 +++++-----
>  include/linux/mtd/spi-nor.h   |  4 +---
>  2 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 8f11c00e8ae5..e367a4862ec1 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -1026,7 +1026,7 @@ static int spi_nor_write_16bit_sr_and_check(struct spi_nor *nor, u8 sr1)
>  		 * Write Status (01h) command is available just for the cases
>  		 * in which the QE bit is described in SR2 at BIT(1).
>  		 */
> -		sr_cr[1] = CR_QUAD_EN_SPAN;
> +		sr_cr[1] = SR2_QUAD_EN_BIT1;
>  	} else {
>  		sr_cr[1] = 0;
>  	}
> @@ -2074,7 +2074,7 @@ static int spansion_no_read_cr_quad_enable(struct spi_nor *nor)
>  	if (ret)
>  		return ret;
>  
> -	sr_cr[1] = CR_QUAD_EN_SPAN;
> +	sr_cr[1] = SR2_QUAD_EN_BIT1;
>  
>  	ret = spi_nor_write_sr(nor, sr_cr, 2);
>  	if (ret)
> @@ -2118,10 +2118,10 @@ static int spansion_read_cr_quad_enable(struct spi_nor *nor)
>  	if (ret)
>  		return ret;
>  
> -	if (sr_cr[1] & CR_QUAD_EN_SPAN)
> +	if (sr_cr[1] & SR2_QUAD_EN_BIT1)
>  		return 0;
>  
> -	sr_cr[1] |= CR_QUAD_EN_SPAN;
> +	sr_cr[1] |= SR2_QUAD_EN_BIT1;
>  
>  	/* Keep the current value of the Status Register. */
>  	ret = spi_nor_read_sr(nor, sr_cr);
> @@ -2256,7 +2256,7 @@ static int spi_nor_spansion_clear_sr_bp(struct spi_nor *nor)
>  	 * When the configuration register Quad Enable bit is one, only the
>  	 * Write Status (01h) command with two data bytes may be used.
>  	 */
> -	if (sr_cr[1] & CR_QUAD_EN_SPAN) {
> +	if (sr_cr[1] & SR2_QUAD_EN_BIT1) {
>  		ret = spi_nor_read_sr(nor, sr_cr);
>  		if (ret)
>  			return ret;
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index d6ec55cc6d97..f626e0e52909 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -144,10 +144,8 @@
>  #define FSR_P_ERR		BIT(4)	/* Program operation status */
>  #define FSR_PT_ERR		BIT(1)	/* Protection error bit */
>  
> -/* Configuration Register bits. */
> -#define CR_QUAD_EN_SPAN		BIT(1)	/* Spansion Quad I/O */
> -
>  /* Status Register 2 bits. */
> +#define SR2_QUAD_EN_BIT1	BIT(1)
>  #define SR2_QUAD_EN_BIT7	BIT(7)
>  
>  /* Supported SPI protocols */
> 

-- 
Regards
Vignesh
