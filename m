Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6D2C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 04:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0BC2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 04:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mWIrPMjN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfHSEj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 00:39:57 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36470 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfHSEj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 00:39:57 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7J4dJ36095386;
        Sun, 18 Aug 2019 23:39:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1566189559;
        bh=SBM143+uKwC8gIRpIrvI0uZ39YPdVq+NjfiPpDmemoo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=mWIrPMjNpyIs7BqM2nUDCV/ei9nWDDqt8QKvxJ+iaeM9/iE34NmkGfPAnRCXtTRHW
         9ivB8nziFGW3asvd7KDnmcRabF98N2WdpXJTcGargtxrDEoCyFK6SYUca2LMC5878i
         w+SKd9PWojDPRnqOshmsGo2kX8iqvZoLNBmlvvhw=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7J4dJ5W065905
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 18 Aug 2019 23:39:19 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Sun, 18
 Aug 2019 23:39:19 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Sun, 18 Aug 2019 23:39:18 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7J4dEZr069725;
        Sun, 18 Aug 2019 23:39:15 -0500
Subject: Re: [PATCH] docs: mtd: Update spi nor reference driver
To:     John Garry <john.garry@huawei.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        wanghuiqiang <wanghuiqiang@huawei.com>
References: <1565107583-68506-1-git-send-email-john.garry@huawei.com>
 <6c4bb892-6cf5-af46-3ace-b333fd47ef14@huawei.com>
 <9b074db7-b95d-a081-2fba-7b2b82997332@kontron.de>
 <ab2d3c29-982f-cb13-e2a2-e6d8da8f1438@huawei.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <b2a475eb-58e6-e7c7-7b8f-b1be04cf27c0@ti.com>
Date:   Mon, 19 Aug 2019 10:09:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ab2d3c29-982f-cb13-e2a2-e6d8da8f1438@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16/08/19 3:50 PM, John Garry wrote:
> On 06/08/2019 17:40, Schrempf Frieder wrote:
[...]
> 
> Hi,
> 
> Could someone kindly advise on the following:
> 
> I am looking at ACPI support only for an mtd spi nor driver we're
> targeting for mainline support.
> 

If its a new driver, please add it under drivers/spi implementing SPI
MEM framework.
There are few drivers under drivers/spi that can be used as example.
(Search for "spi_mem_ops")

> So for the host, I could use a proprietary HID in the DSDT for matching
> in the kernel driver.
> 
> About the child spi flash devices, is the recommendation to just use
> PRP0001 HID and "jedec,spi-nor" compatible?
>

I am not quite familiar with ACPI systems, but child flash device should
use "jedec,spi-nor" as compatible.

Regards
Vignesh

> thanks,
> John
> 
> 
>>
>> @Maintainers:
>> Maybe the docs under Documentation/driver-api/mtd should be officially
>> maintained by the MTD subsystem (and added to MAINTAINERS). And if there
>> will be some driver API docs for SPI MEM it should probably live in
>> Documentation/driver-api/spi instead of Documentation/driver-api/mtd, as
>> spi-mem.c itself is in drivers/spi.
>>
>> Regards,
>> Frieder
>>
>>>
>>> Thanks,
>>> John
>>>
>>>> @@ -59,7 +59,7 @@ Part III - How can drivers use the framework?
>>>>
>>>>  The main API is spi_nor_scan(). Before you call the hook, a driver
>>>> should
>>>>  initialize the necessary fields for spi_nor{}. Please see
>>>> -drivers/mtd/spi-nor/spi-nor.c for detail. Please also refer to
>>>> fsl-quadspi.c
>>>> +drivers/mtd/spi-nor/spi-nor.c for detail. Please also refer to
>>>> spi-fsl-qspi.c
>>>>  when you want to write a new driver for a SPI NOR controller.
>>>>  Another API is spi_nor_restore(), this is used to restore the status
>>>> of SPI
>>>>  flash chip such as addressing mode. Call it whenever detach the
>>>> driver from
>>>>
>>>
>>>
>>>
>>> ______________________________________________________
>>> Linux MTD discussion mailing list
>>> http://lists.infradead.org/mailman/listinfo/linux-mtd/
> 
> 

-- 
Regards
Vignesh
