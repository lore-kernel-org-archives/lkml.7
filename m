Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E039C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625A620725
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="dFQ0qLp8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfLPK36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 05:29:58 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:52467 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbfLPK36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:29:58 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 018D122FE5;
        Mon, 16 Dec 2019 11:29:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1576492195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t4kAjv7YRRzabrvv/6fAB8ptr1Y7vtGS1qtFHYNcntg=;
        b=dFQ0qLp8tLxtrzaf8lnp3rj7WZ0UbGT8K1ogwps/IdyDRNOfTy9wV2f6wyfjoxFxxBO/c7
        F3xUHOZSXl4Dh67exbCyhfjlR7Ge9LFFIZ3rD58nk6ZvgmLXRbpm9zCtwvaBhEJUNFMkFB
        cFG3ygRFOlPb+gBH5n7LRcCh0BstI9w=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 16 Dec 2019 11:29:52 +0100
From:   Michael Walle <michael@walle.cc>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: Re: [PATCH 1/2] dt-bindings: mtd: spi-nor: document new flag
In-Reply-To: <556fe468-0080-ad05-8228-5ff8f1b3dac6@ti.com>
References: <20191214191943.3679-1-michael@walle.cc>
 <556fe468-0080-ad05-8228-5ff8f1b3dac6@ti.com>
Message-ID: <af3692dba69e85fa8136ab3d170bef39@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.8
X-Spamd-Bar: +
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 018D122FE5
X-Spamd-Result: default: False [1.40 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[9];
         NEURAL_HAM(-0.00)[-0.678];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2019-12-16 09:54, schrieb Vignesh Raghavendra:
> Hi,
> 
> On 15/12/19 12:49 am, Michael Walle wrote:
>> Document the new flag "no-unlock".
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>> Does the property need a prefix? I couldn't find any hint. If so, what
>> should it be? "m25p," or "spi-nor," ?
>> 
>>  Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt | 6 ++++++
>>  1 file changed, 6 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt 
>> b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
>> index f03be904d3c2..2d305c893ed7 100644
>> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
>> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
>> @@ -78,6 +78,12 @@ Optional properties:
>>  		   cannot reboot properly if the flash is left in the "wrong"
>>  		   state. This boolean flag can be used on such systems, to
>>  		   denote the absence of a reliable reset mechanism.
>> +- no-unlock : By default, linux unlocks the whole flash because there
>> +		   are legacy flash devices which are locked by default
>> +		   after reset. Set this flag if you don't want linux to
>> +		   unlock the whole flash automatically. In this case you
>> +		   can control the non-volatile bits by the
>> +		   flash_lock/flash_unlock tools.
>> 
> 
> Current SPI NOR framework unconditionally unlocks entire flash which
> I agree is not the best thing to do, but I don't think we need
> new DT property here. MTD cmdline partitions and DT partitions already
> provide a way to specify that a partition should remain locked[1][2]

I know that the MTD layer has the same kind of unlocking. But that
unlocking is done on a per mtd partition basis. Eg. consider something
like the following

  mtd1 bootloader  (locked)
  mtd2 firmware    (locked)
  mtd3 kernel
  mtd4 environment

Further assume, that the end of mtd2 aligns with one of the possible
locking areas which are supported by the flash chip. Eg. the first 
quarter.

The mtd layer would do two (or four, if "lock" property is set) unlock()
calls, one for mtd1 and one for mtd2.

My point here is, that the mtd partitions doesn't always map to the
locking regions of the SPI flash (at least if the are not merged 
together).

> SPI NOR framework should instead set MTD_POWERUP_LOCK flags in 
> mtd->flags
> for flash devices that power up with lock bits set. And MTD core will
> take care of unlocking flash regions while taking into account 
> partition
> flags defined by user as part of MTD partitions defined in DT or
> via cmdline args.
> 
> So that change should to be set MTD_POWERUP_LOCK for
> in SPI NOR core. Can you check below[3] (untested) diff helps?
> This should prevent unlocking partitions that are to remain locked
> as specified in DT/cmdline

As this change may help my use-case, unlocking is skipped because the
partitions are marked as read only; I fear that the old behaviour will
change. See above.

Mhh. thinking more about it, doesn't the calls also wear out the
non-volatile bits in the NOR flash?

In any case, I'll try your suggestion.

-michael

> 
> [1] Documentation/devicetree/bindings/mtd/partition.txt
> [2] drivers/mtd/parsers/cmdlinepart.c (see "lk" parameter)
> 
> [3]
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c 
> b/drivers/mtd/spi-nor/spi-nor.c
> index 1082b6bb1393..6adb950849f6 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -4914,23 +4914,6 @@ static int spi_nor_quad_enable(struct spi_nor 
> *nor)
>  	return nor->params.quad_enable(nor);
>  }
> 
> -/**
> - * spi_nor_unlock_all() - Unlocks the entire flash memory array.
> - * @nor:	pointer to a 'struct spi_nor'.
> - *
> - * Some SPI NOR flashes are write protected by default after a 
> power-on reset
> - * cycle, in order to avoid inadvertent writes during power-up. 
> Backward
> - * compatibility imposes to unlock the entire flash memory array at 
> power-up
> - * by default.
> - */
> -static int spi_nor_unlock_all(struct spi_nor *nor)
> -{
> -	if (nor->flags & SNOR_F_HAS_LOCK)
> -		return spi_nor_unlock(&nor->mtd, 0, nor->params.size);
> -
> -	return 0;
> -}
> -
>  static int spi_nor_init(struct spi_nor *nor)
>  {
>  	int err;
> @@ -4941,11 +4924,11 @@ static int spi_nor_init(struct spi_nor *nor)
>  		return err;
>  	}
> 
> -	err = spi_nor_unlock_all(nor);
> -	if (err) {
> -		dev_dbg(nor->dev, "Failed to unlock the entire flash memory 
> array\n");
> -		return err;
> -	}
> +	/*
> +	 * Flashes may power up locked. Set this flag so that MTD core
> +	 * takes care of unlocking partitions as required.
> +	 */
> +	nor->mtd.flags |= MTD_POWERUP_LOCK;
> 
>  	if (nor->addr_width == 4 && !(nor->flags & SNOR_F_4B_OPCODES)) {
>  		/*
