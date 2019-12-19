Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190BDC2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 05:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5956222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 05:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="N3ZfoC8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfLSFdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 00:33:39 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:36452 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfLSFdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 00:33:38 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBJ5XAMo090485;
        Wed, 18 Dec 2019 23:33:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576733590;
        bh=LOOY6W2Ku2R5ppLjFbe/RkqYjMl9lftew8PFB4joQIs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=N3ZfoC8+zHBNo+unnhOUoM5b//zS1vm0iE6RRaKDoli0tIVjMvE0s3DjrOe+SK6Yb
         ZCa1CRV7PqFore/THw7HRmM2MYNLimmu3N3IA7EEWRymae76Tb2p65xyLOhapJNacj
         XmWwX8VNPVQ227zYdY6HkPqpvWzYpbZLVO21MVvM=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBJ5XAu1122133
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Dec 2019 23:33:10 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 18
 Dec 2019 23:33:10 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 18 Dec 2019 23:33:10 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBJ5X6wR055261;
        Wed, 18 Dec 2019 23:33:07 -0600
Subject: Re: [PATCH 1/2] dt-bindings: mtd: spi-nor: document new flag
To:     Michael Walle <michael@walle.cc>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20191214191943.3679-1-michael@walle.cc>
 <556fe468-0080-ad05-8228-5ff8f1b3dac6@ti.com>
 <af3692dba69e85fa8136ab3d170bef39@walle.cc>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <2dfc30a7-3261-d783-8256-f72458a0141b@ti.com>
Date:   Thu, 19 Dec 2019 11:03:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <af3692dba69e85fa8136ab3d170bef39@walle.cc>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

[...]
>>> +- no-unlock : By default, linux unlocks the whole flash because there
>>> +           are legacy flash devices which are locked by default
>>> +           after reset. Set this flag if you don't want linux to
>>> +           unlock the whole flash automatically. In this case you
>>> +           can control the non-volatile bits by the
>>> +           flash_lock/flash_unlock tools.
>>>
>>
>> Current SPI NOR framework unconditionally unlocks entire flash which
>> I agree is not the best thing to do, but I don't think we need
>> new DT property here. MTD cmdline partitions and DT partitions already
>> provide a way to specify that a partition should remain locked[1][2]
> 
> I know that the MTD layer has the same kind of unlocking. But that
> unlocking is done on a per mtd partition basis. Eg. consider something
> like the following
> 
>  mtd1 bootloader  (locked)
>  mtd2 firmware    (locked)
>  mtd3 kernel
>  mtd4 environment
> 
> Further assume, that the end of mtd2 aligns with one of the possible
> locking areas which are supported by the flash chip. Eg. the first quarter.
> 
> The mtd layer would do two (or four, if "lock" property is set) unlock()
> calls, one for mtd1 and one for mtd2.
> 


> My point here is, that the mtd partitions doesn't always map to the
> locking regions of the SPI flash (at least if the are not merged together).
> 

You are right! This will be an issue if existing partitions are not
aligned to locking regions.

I take my comments back... But I am not sure if a new DT property is the
needed. This does not describe HW and is specific to Linux SPI NOR
stack. How about a module parameter instead?
Module parameter won't provide per flash granularity in controlling
unlocking behavior. But I don't think that matters.

Tudor,

You had a patch doing something similar. Does module param sound good to
you?


-- 
Regards
Vignesh
