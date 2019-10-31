Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7134DCA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D908208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfJaLQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:16:08 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46924 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfJaLQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:16:07 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 43D6028F256;
        Thu, 31 Oct 2019 11:16:06 +0000 (GMT)
Date:   Thu, 31 Oct 2019 12:16:03 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 18/32] mtd: spi-nor: Constify data to write to the
 Status Register
Message-ID: <20191031121603.295ee60f@collabora.com>
In-Reply-To: <20191029111615.3706-19-tudor.ambarus@microchip.com>
References: <20191029111615.3706-1-tudor.ambarus@microchip.com>
        <20191029111615.3706-19-tudor.ambarus@microchip.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2019 11:17:17 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Constify the data to write to the Status Register.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/mtd/spi-nor/spi-nor.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 5fb4d953b5c7..274786e1988f 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -865,7 +865,7 @@ static int spi_nor_write_sr(struct spi_nor *nor, u8 val)
>   * second byte will be written to the configuration register.
>   * Return negative if error occurred.
>   */
> -static int spi_nor_write_sr_cr(struct spi_nor *nor, u8 *sr_cr)
> +static int spi_nor_write_sr_cr(struct spi_nor *nor, const u8 *sr_cr)
>  {
>  	int ret;
>  
> @@ -912,7 +912,7 @@ static int spi_nor_write_sr_and_check(struct spi_nor *nor, u8 status_new,
>  	return ((nor->bouncebuf[0] & mask) != (status_new & mask)) ? -EIO : 0;
>  }
>  
> -static int spi_nor_write_sr2(struct spi_nor *nor, u8 *sr2)
> +static int spi_nor_write_sr2(struct spi_nor *nor, const u8 *sr2)
>  {
>  	int ret;
>  

