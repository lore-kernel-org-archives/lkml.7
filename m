Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F29BC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 07:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5A02086D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 07:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="f6HisGZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfHEH1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 03:27:01 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52950 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfHEH07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 03:26:59 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x757QbJG095128;
        Mon, 5 Aug 2019 02:26:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1564989997;
        bh=uidjpdewfqTdZ5riSTkbMqc93TtOR+1gb9Qd4hk0vgY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=f6HisGZKsNmeoV1HocrEiJg35w2RV+ih3ZCkUAYKnJLkInX7z0GFEwTLuQZj/VKJh
         m6+kcdxNAQo4Lt8l2t8wS2bMJXD3MtOGldsI0Q3twcOI0pjlSLIYQvrxQpoGodEa5c
         akcogifgJHDe+QQvRWmNiw0BXiie9jcYkGWBEH9Q=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x757QbPZ069705
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Aug 2019 02:26:37 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 5 Aug
 2019 02:26:37 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 5 Aug 2019 02:26:37 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x757QYBJ027450;
        Mon, 5 Aug 2019 02:26:35 -0500
Subject: Re: [PATCH] mtd: hyperbus: Kconfig: Fix HBMC_AM654 dependencies
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Mao Wenan <maowenan@huawei.com>
References: <20190719082912.10316-1-vigneshr@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <ee11628f-46b7-bfd8-4b32-b87bc133f6d2@ti.com>
Date:   Mon, 5 Aug 2019 12:57:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190719082912.10316-1-vigneshr@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/07/19 1:59 PM, Vignesh Raghavendra wrote:
> On x86_64, when CONFIG_OF is not disabled:
> 
> WARNING: unmet direct dependencies detected for MUX_MMIO
>   Depends on [n]: MULTIPLEXER [=y] && (OF [=n] || COMPILE_TEST [=n])
>   Selected by [y]:
>   - HBMC_AM654 [=y] && MTD [=y] && MTD_HYPERBUS [=y]
> 
> due to
> config HBMC_AM654
> 	tristate "HyperBus controller driver for AM65x SoC"
> 	select MULTIPLEXER
> 	select MUX_MMIO
> 
> Fix this by making HBMC_AM654 imply MUX_MMIO instead of select so
> that dependencies are taken care of. MUX_MMIO is optional for
> functioning of driver.
> 
> Fixes: b07079f1642c ("mtd: hyperbus: Add driver for TI's HyperBus memory controller")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>> ---

Applied to mtd/fixes.

>  drivers/mtd/hyperbus/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/hyperbus/Kconfig b/drivers/mtd/hyperbus/Kconfig
> index cff6bbd226f5..1c691df8eff7 100644
> --- a/drivers/mtd/hyperbus/Kconfig
> +++ b/drivers/mtd/hyperbus/Kconfig
> @@ -15,7 +15,7 @@ if MTD_HYPERBUS
>  config HBMC_AM654
>  	tristate "HyperBus controller driver for AM65x SoC"
>  	select MULTIPLEXER
> -	select MUX_MMIO
> +	imply MUX_MMIO
>  	help
>  	 This is the driver for HyperBus controller on TI's AM65x and
>  	 other SoCs
> 

-- 
Regards
Vignesh
