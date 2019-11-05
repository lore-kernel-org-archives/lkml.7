Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC47AC010D8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02E021D71
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WA1yTRgO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388207AbfKEMVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 07:21:34 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:51756 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730766AbfKEMVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:21:32 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA5CLGUl012639;
        Tue, 5 Nov 2019 06:21:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572956476;
        bh=kGJ7EX4Q5G3Jejse7d/w7FiPRClTmk5MfWU59Z5UCPg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=WA1yTRgOI11n4BAC8UmAiIGOP1j1oUrNzvI1rewXPs6JD8kWlNoo/txz9Ny0HDDgG
         1/t8E3576LjcdOa5Fl3zS94lB+eCtBIaHX0sYbYGQLuorLtnoJj62ZL2OaRd9m6trd
         6DZS1mwvM/V905g5yisawDDBs1ROI7UfvVXp+tHI=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xA5CLGRg000748
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Nov 2019 06:21:16 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 5 Nov
 2019 06:21:01 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 5 Nov 2019 06:21:01 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA5CLDuq119819;
        Tue, 5 Nov 2019 06:21:14 -0600
Subject: Re: [PATCH v4 08/20] mtd: spi-nor: Describe all the Reg Ops
To:     <Tudor.Ambarus@microchip.com>, <boris.brezillon@collabora.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20191102112316.20715-1-tudor.ambarus@microchip.com>
 <20191102112316.20715-9-tudor.ambarus@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <2db8722f-d4ea-b230-8729-f02cc95e23b2@ti.com>
Date:   Tue, 5 Nov 2019 17:51:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191102112316.20715-9-tudor.ambarus@microchip.com>
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
> Document all the Register Operations.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

Regards
Vignesh

> ---
>  drivers/mtd/spi-nor/spi-nor.c | 138 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 127 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 857675a4e329..99a9a6aba41d 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -388,9 +388,11 @@ static ssize_t spi_nor_write_data(struct spi_nor *nor, loff_t to, size_t len,
>  	return nor->controller_ops->write(nor, to, len, buf);
>  }
>  
> -/*
> - * Set write enable latch with Write Enable command.
> - * Returns negative if error occurred.
> +/**
> + * spi_nor_write_enable() - Set write enable latch with Write Enable command.
> + * @nor:	pointer to 'struct spi_nor'.
> + *
> + * Return: 0 on success, -errno otherwise.
>   */
>  static int spi_nor_write_enable(struct spi_nor *nor)
>  {
> @@ -415,8 +417,11 @@ static int spi_nor_write_enable(struct spi_nor *nor)
>  	return ret;
>  }
>  
> -/*
> - * Send write disable instruction to the chip.
> +/**
> + * spi_nor_write_disable() - Send Write Disable instruction to the chip.
> + * @nor:	pointer to 'struct spi_nor'.
> + *
> + * Return: 0 on success, -errno otherwise.
>   */
>  static int spi_nor_write_disable(struct spi_nor *nor)
>  {
> @@ -534,6 +539,14 @@ static int spi_nor_read_cr(struct spi_nor *nor, u8 *cr)
>  	return ret;
>  }
>  
> +/**
> + * macronix_set_4byte() - Set 4-byte address mode for Macronix flashes.
> + * @nor:	pointer to 'struct spi_nor'.
> + * @enable:	true to enter the 4-byte address mode, false to exit the 4-byte
> + *		address mode.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
>  static int macronix_set_4byte(struct spi_nor *nor, bool enable)
>  {
>  	int ret;
> @@ -562,6 +575,14 @@ static int macronix_set_4byte(struct spi_nor *nor, bool enable)
>  	return ret;
>  }
>  
> +/**
> + * st_micron_set_4byte() - Set 4-byte address mode for ST and Micron flashes.
> + * @nor:	pointer to 'struct spi_nor'.
> + * @enable:	true to enter the 4-byte address mode, false to exit the 4-byte
> + *		address mode.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
>  static int st_micron_set_4byte(struct spi_nor *nor, bool enable)
>  {
>  	int ret;
> @@ -577,6 +598,14 @@ static int st_micron_set_4byte(struct spi_nor *nor, bool enable)
>  	return spi_nor_write_disable(nor);
>  }
>  
> +/**
> + * spansion_set_4byte() - Set 4-byte address mode for Spansion flashes.
> + * @nor:	pointer to 'struct spi_nor'.
> + * @enable:	true to enter the 4-byte address mode, false to exit the 4-byte
> + *		address mode.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
>  static int spansion_set_4byte(struct spi_nor *nor, bool enable)
>  {
>  	int ret;
> @@ -602,6 +631,13 @@ static int spansion_set_4byte(struct spi_nor *nor, bool enable)
>  	return ret;
>  }
>  
> +/**
> + * spi_nor_write_ear() - Write Extended Address Register.
> + * @nor:	pointer to 'struct spi_nor'.
> + * @ear:	value to write to the Extended Address Register.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
>  static int spi_nor_write_ear(struct spi_nor *nor, u8 ear)
>  {
>  	int ret;
> @@ -627,6 +663,14 @@ static int spi_nor_write_ear(struct spi_nor *nor, u8 ear)
>  	return ret;
>  }
>  
> +/**
> + * winbond_set_4byte() - Set 4-byte address mode for Winbond flashes.
> + * @nor:	pointer to 'struct spi_nor'.
> + * @enable:	true to enter the 4-byte address mode, false to exit the 4-byte
> + *		address mode.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
>  static int winbond_set_4byte(struct spi_nor *nor, bool enable)
>  {
>  	int ret;
> @@ -651,6 +695,14 @@ static int winbond_set_4byte(struct spi_nor *nor, bool enable)
>  	return spi_nor_write_disable(nor);
>  }
>  
> +/**
> + * spi_nor_xread_sr() - Read the Status Register on S3AN flashes.
> + * @nor:	pointer to 'struct spi_nor'.
> + * @sr:		pointer to a DMA-able buffer where the value of the
> + *              Status Register will be written.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
>  static int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr)
>  {
>  	int ret;
> @@ -674,6 +726,13 @@ static int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr)
>  	return ret;
>  }
>  
> +/**
> + * s3an_sr_ready() - Query the Status Register of the S3AN flash to see if the
> + * flash is ready for new commands.
> + * @nor:	pointer to 'struct spi_nor'.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
>  static int s3an_sr_ready(struct spi_nor *nor)
>  {
>  	int ret;
> @@ -685,6 +744,10 @@ static int s3an_sr_ready(struct spi_nor *nor)
>  	return !!(nor->bouncebuf[0] & XSR_RDY);
>  }
>  
> +/**
> + * spi_nor_clear_sr() - Clear the Status Register.
> + * @nor:	pointer to 'struct spi_nor'.
> + */
>  static void spi_nor_clear_sr(struct spi_nor *nor)
>  {
>  	int ret;
> @@ -706,6 +769,13 @@ static void spi_nor_clear_sr(struct spi_nor *nor)
>  		dev_dbg(nor->dev, "error %d clearing SR\n", ret);
>  }
>  
> +/**
> + * spi_nor_sr_ready() - Query the Status Register to see if the flash is ready
> + * for new commands.
> + * @nor:	pointer to 'struct spi_nor'.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
>  static int spi_nor_sr_ready(struct spi_nor *nor)
>  {
>  	int ret = spi_nor_read_sr(nor, nor->bouncebuf);
> @@ -727,6 +797,10 @@ static int spi_nor_sr_ready(struct spi_nor *nor)
>  	return !(nor->bouncebuf[0] & SR_WIP);
>  }
>  
> +/**
> + * spi_nor_clear_fsr() - Clear the Flag Status Register.
> + * @nor:	pointer to 'struct spi_nor'.
> + */
>  static void spi_nor_clear_fsr(struct spi_nor *nor)
>  {
>  	int ret;
> @@ -748,6 +822,13 @@ static void spi_nor_clear_fsr(struct spi_nor *nor)
>  		dev_dbg(nor->dev, "error %d clearing FSR\n", ret);
>  }
>  
> +/**
> + * spi_nor_fsr_ready() - Query the Flag Status Register to see if the flash is
> + * ready for new commands.
> + * @nor:	pointer to 'struct spi_nor'.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
>  static int spi_nor_fsr_ready(struct spi_nor *nor)
>  {
>  	int ret = spi_nor_read_fsr(nor, nor->bouncebuf);
> @@ -772,6 +853,12 @@ static int spi_nor_fsr_ready(struct spi_nor *nor)
>  	return nor->bouncebuf[0] & FSR_READY;
>  }
>  
> +/**
> + * spi_nor_ready() - Query the flash to see if it is ready for new commands.
> + * @nor:	pointer to 'struct spi_nor'.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
>  static int spi_nor_ready(struct spi_nor *nor)
>  {
>  	int sr, fsr;
> @@ -788,9 +875,13 @@ static int spi_nor_ready(struct spi_nor *nor)
>  	return sr && fsr;
>  }
>  
> -/*
> - * Service routine to read status register until ready, or timeout occurs.
> - * Returns non-zero if error.
> +/**
> + * spi_nor_wait_till_ready_with_timeout() - Service routine to read the
> + * Status Register until ready, or timeout occurs.
> + * @nor:		pointer to "struct spi_nor".
> + * @timeout_jiffies:	jiffies to wait until timeout.
> + *
> + * Return: 0 on success, -errno otherwise.
>   */
>  static int spi_nor_wait_till_ready_with_timeout(struct spi_nor *nor,
>  						unsigned long timeout_jiffies)
> @@ -818,6 +909,13 @@ static int spi_nor_wait_till_ready_with_timeout(struct spi_nor *nor,
>  	return -ETIMEDOUT;
>  }
>  
> +/**
> + * spi_nor_wait_till_ready() - Wait for a predefined amount of time for the
> + * flash to be ready, or timeout occurs.
> + * @nor:	pointer to "struct spi_nor".
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
>  static int spi_nor_wait_till_ready(struct spi_nor *nor)
>  {
>  	return spi_nor_wait_till_ready_with_timeout(nor,
> @@ -880,6 +978,14 @@ static int spi_nor_write_sr_and_check(struct spi_nor *nor, u8 status_new,
>  	return ((nor->bouncebuf[0] & mask) != (status_new & mask)) ? -EIO : 0;
>  }
>  
> +/**
> + * spi_nor_write_sr2() - Write the Status Register 2 using the
> + * SPINOR_OP_WRSR2 (3eh) command.
> + * @nor:	pointer to 'struct spi_nor'.
> + * @sr2:	pointer to DMA-able buffer to write to the Status Register 2.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
>  static int spi_nor_write_sr2(struct spi_nor *nor, const u8 *sr2)
>  {
>  	int ret;
> @@ -909,6 +1015,15 @@ static int spi_nor_write_sr2(struct spi_nor *nor, const u8 *sr2)
>  	return spi_nor_wait_till_ready(nor);
>  }
>  
> +/**
> + * spi_nor_read_sr2() - Read the Status Register 2 using the
> + * SPINOR_OP_RDSR2 (3fh) command.
> + * @nor:	pointer to 'struct spi_nor'.
> + * @sr2:	pointer to DMA-able buffer where the value of the
> + *		Status Register 2 will be written.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
>  static int spi_nor_read_sr2(struct spi_nor *nor, u8 *sr2)
>  {
>  	int ret;
> @@ -932,10 +1047,11 @@ static int spi_nor_read_sr2(struct spi_nor *nor, u8 *sr2)
>  	return ret;
>  }
>  
> -/*
> - * Erase the whole flash memory
> +/**
> + * spi_nor_erase_chip() - Erase the entire flash memory.
> + * @nor:	pointer to 'struct spi_nor'.
>   *
> - * Returns 0 if successful, non-zero otherwise.
> + * Return: 0 on success, -errno otherwise.
>   */
>  static int spi_nor_erase_chip(struct spi_nor *nor)
>  {
> 

-- 
Regards
Vignesh
