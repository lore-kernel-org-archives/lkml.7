Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3427DC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CF4A208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387961AbfHFQf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 12:35:27 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56360 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726877AbfHFQf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 12:35:26 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0D6F1403823FB709DEE3;
        Wed,  7 Aug 2019 00:35:24 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Wed, 7 Aug 2019
 00:35:22 +0800
Subject: Re: [PATCH] docs: mtd: Update spi nor reference driver
To:     <corbet@lwn.net>, <mchehab+samsung@kernel.org>,
        <linux-mtd@lists.infradead.org>
References: <1565107583-68506-1-git-send-email-john.garry@huawei.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <frieder.schrempf@kontron.de>
From:   John Garry <john.garry@huawei.com>
Message-ID: <6c4bb892-6cf5-af46-3ace-b333fd47ef14@huawei.com>
Date:   Tue, 6 Aug 2019 17:35:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1565107583-68506-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2019 17:06, John Garry wrote:
> The reference driver no longer exists since commit 50f1242c6742 ("mtd:
> fsl-quadspi: Remove the driver as it was replaced by spi-fsl-qspi.c").
>
> Update reference to spi-fsl-qspi.c driver.
>
> Signed-off-by: John Garry <john.garry@huawei.com>
>
> diff --git a/Documentation/driver-api/mtd/spi-nor.rst b/Documentation/driver-api/mtd/spi-nor.rst
> index f5333e3bf486..1f0437676762 100644
> --- a/Documentation/driver-api/mtd/spi-nor.rst
> +++ b/Documentation/driver-api/mtd/spi-nor.rst

In fact this document has many references to Freescale QuadSPI - could 
someone kindly review this complete document for up-to-date accuracy?

Thanks,
John

> @@ -59,7 +59,7 @@ Part III - How can drivers use the framework?
>
>  The main API is spi_nor_scan(). Before you call the hook, a driver should
>  initialize the necessary fields for spi_nor{}. Please see
> -drivers/mtd/spi-nor/spi-nor.c for detail. Please also refer to fsl-quadspi.c
> +drivers/mtd/spi-nor/spi-nor.c for detail. Please also refer to spi-fsl-qspi.c
>  when you want to write a new driver for a SPI NOR controller.
>  Another API is spi_nor_restore(), this is used to restore the status of SPI
>  flash chip such as addressing mode. Call it whenever detach the driver from
>


