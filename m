Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D21C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C454F2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jpyYlNaJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbfH0Hu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:50:29 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50160 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbfH0Hu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:50:27 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7R7o8a5125051;
        Tue, 27 Aug 2019 02:50:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1566892208;
        bh=PdzHYCDcfBYTU3QglVDF7SzK04cZ5/w8A1aZKwXzqFM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=jpyYlNaJvqmsDqFlos12acT5nvyofU5C6Dnuu8b2eArfDM8kgdCdTqKWjp55/ECZ3
         TAJ963YD3mHh/0pt71nbVngiSYphc0sWSdKOeINN4viHhZXKW8MhnT2Ye/V/eH599l
         4JGnkCEt3qww2pPgRNrA2CgMulAlQPXlmXff5HNg=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7R7o8IB119262
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Aug 2019 02:50:08 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 27
 Aug 2019 02:50:07 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 27 Aug 2019 02:50:07 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7R7o3Lp087842;
        Tue, 27 Aug 2019 02:50:04 -0500
Subject: Re: [Patch v3] drivers: mtd: spi-nor: Add flash property for
 mt25qu512a and mt35xu02g
To:     Ashish Kumar <Ashish.Kumar@nxp.com>, <tudor.ambarus@microchip.com>,
        <marek.vasut@gmail.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
References: <1565692705-27749-1-git-send-email-Ashish.Kumar@nxp.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <436df042-917b-d148-9226-7a2dd62c65e4@ti.com>
Date:   Tue, 27 Aug 2019 13:20:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565692705-27749-1-git-send-email-Ashish.Kumar@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/08/19 4:08 PM, Ashish Kumar wrote:
> mt25qu512a is rebranded after its spinoff from STM, so it is
> different only in term of operating frequency, initial JEDEC id
> is same as that of n25q512a. In order to avoid any confussion
> with respect to name new entry is added.
> This flash is tested for Single I/O and QUAD I/O mode on LS1046FRWY.
> 
> mt35xu02g is Octal flash supporting Single I/O and QCTAL I/O
> and it has been tested on LS1028ARDB
> 
> Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
> Signed-off-by: Ashish Kumar <ashish.kumar@nxp.com>
> ---
Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

Regards
Vignesh

> v3:
> -Reword commits msg
> -rebase to top of mtd-linux spi-nor/next
> v2:
> Incorporate review comments from Vignesh
> 
>  drivers/mtd/spi-nor/spi-nor.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 03cc788..97d3de8 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -1988,6 +1988,12 @@ static const struct flash_info spi_nor_ids[] = {
>  	{ "n25q128a13",  INFO(0x20ba18, 0, 64 * 1024,  256, SECT_4K | SPI_NOR_QUAD_READ) },
>  	{ "n25q256a",    INFO(0x20ba19, 0, 64 * 1024,  512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  	{ "n25q256ax1",  INFO(0x20bb19, 0, 64 * 1024,  512, SECT_4K | SPI_NOR_QUAD_READ) },
> +
> +	/* Micron */
> +	{ "mt25qu512a", INFO6(0x20bb20, 0x104400, 64 * 1024, 1024, SECT_4K |
> +				USE_FSR | SPI_NOR_DUAL_READ |
> +				SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> +
>  	{ "n25q512a",    INFO(0x20bb20, 0, 64 * 1024, 1024, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ) },
>  	{ "n25q512ax3",  INFO(0x20ba20, 0, 64 * 1024, 1024, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ) },
>  	{ "n25q00",      INFO(0x20ba21, 0, 64 * 1024, 2048, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
> @@ -2003,6 +2009,9 @@ static const struct flash_info spi_nor_ids[] = {
>  			SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ |
>  			SPI_NOR_4B_OPCODES)
>  	},
> +	{ "mt35xu02g",  INFO(0x2c5b1c, 0, 128 * 1024, 2048,
> +			SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ |
> +			SPI_NOR_4B_OPCODES) },
>  
>  	/* PMC */
>  	{ "pm25lv512",   INFO(0,        0, 32 * 1024,    2, SECT_4K_PMC) },
> 

-- 
Regards
Vignesh
