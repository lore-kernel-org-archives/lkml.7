Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9692C2D0D0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 08:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B070D20725
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 08:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="F0P+45XX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfLPIyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 03:54:16 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50762 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfLPIyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 03:54:16 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBG8rqsP083176;
        Mon, 16 Dec 2019 02:53:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576486432;
        bh=6aFcWyhsHHVnr6Cqjh6RFG3uMltbSLRzg3ZmXfAwROo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=F0P+45XXO+oyrT9rlcf9tv/US8pM8xKSRjl88mVxP6m173McAj6Pyhkfi+bIFs8oh
         W3IDPIBKql+P+k+9vXABGrikOVH+ShRd+3NHkLQy0AFryRaIEvVF7KwOjF0qQFXtQU
         TlwhjfDx+D/yzAhFW7NqrutL/8PZPK8Q+YS8YyYA=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBG8rqNW082176
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Dec 2019 02:53:52 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 16
 Dec 2019 02:53:50 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 16 Dec 2019 02:53:50 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBG8rlLb101138;
        Mon, 16 Dec 2019 02:53:48 -0600
Subject: Re: [PATCH 1/2] dt-bindings: mtd: spi-nor: document new flag
To:     Michael Walle <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
References: <20191214191943.3679-1-michael@walle.cc>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <556fe468-0080-ad05-8228-5ff8f1b3dac6@ti.com>
Date:   Mon, 16 Dec 2019 14:24:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191214191943.3679-1-michael@walle.cc>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15/12/19 12:49 am, Michael Walle wrote:
> Document the new flag "no-unlock".
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> Does the property need a prefix? I couldn't find any hint. If so, what
> should it be? "m25p," or "spi-nor," ?
> 
>  Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
> index f03be904d3c2..2d305c893ed7 100644
> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
> @@ -78,6 +78,12 @@ Optional properties:
>  		   cannot reboot properly if the flash is left in the "wrong"
>  		   state. This boolean flag can be used on such systems, to
>  		   denote the absence of a reliable reset mechanism.
> +- no-unlock : By default, linux unlocks the whole flash because there
> +		   are legacy flash devices which are locked by default
> +		   after reset. Set this flag if you don't want linux to
> +		   unlock the whole flash automatically. In this case you
> +		   can control the non-volatile bits by the
> +		   flash_lock/flash_unlock tools.
>  

Current SPI NOR framework unconditionally unlocks entire flash which
I agree is not the best thing to do, but I don't think we need
new DT property here. MTD cmdline partitions and DT partitions already 
provide a way to specify that a partition should remain locked[1][2]

SPI NOR framework should instead set MTD_POWERUP_LOCK flags in mtd->flags
for flash devices that power up with lock bits set. And MTD core will 
take care of unlocking flash regions while taking into account partition
flags defined by user as part of MTD partitions defined in DT or
via cmdline args.

So that change should to be set MTD_POWERUP_LOCK for
in SPI NOR core. Can you check below[3] (untested) diff helps?
This should prevent unlocking partitions that are to remain locked 
as specified in DT/cmdline 

[1] Documentation/devicetree/bindings/mtd/partition.txt
[2] drivers/mtd/parsers/cmdlinepart.c (see "lk" parameter)

[3]

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 1082b6bb1393..6adb950849f6 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -4914,23 +4914,6 @@ static int spi_nor_quad_enable(struct spi_nor *nor)
 	return nor->params.quad_enable(nor);
 }
 
-/**
- * spi_nor_unlock_all() - Unlocks the entire flash memory array.
- * @nor:	pointer to a 'struct spi_nor'.
- *
- * Some SPI NOR flashes are write protected by default after a power-on reset
- * cycle, in order to avoid inadvertent writes during power-up. Backward
- * compatibility imposes to unlock the entire flash memory array at power-up
- * by default.
- */
-static int spi_nor_unlock_all(struct spi_nor *nor)
-{
-	if (nor->flags & SNOR_F_HAS_LOCK)
-		return spi_nor_unlock(&nor->mtd, 0, nor->params.size);
-
-	return 0;
-}
-
 static int spi_nor_init(struct spi_nor *nor)
 {
 	int err;
@@ -4941,11 +4924,11 @@ static int spi_nor_init(struct spi_nor *nor)
 		return err;
 	}
 
-	err = spi_nor_unlock_all(nor);
-	if (err) {
-		dev_dbg(nor->dev, "Failed to unlock the entire flash memory array\n");
-		return err;
-	}
+	/*
+	 * Flashes may power up locked. Set this flag so that MTD core
+	 * takes care of unlocking partitions as required.
+	 */
+	nor->mtd.flags |= MTD_POWERUP_LOCK;
 
 	if (nor->addr_width == 4 && !(nor->flags & SNOR_F_4B_OPCODES)) {
 		/*




-- 
Regards
Vignesh
