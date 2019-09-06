Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68E7C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB63F2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392429AbfIFO6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 10:58:53 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50112 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726019AbfIFO6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 10:58:53 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DF006601A9709E8FC318;
        Fri,  6 Sep 2019 22:58:49 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Fri, 6 Sep 2019
 22:58:45 +0800
Subject: Re: [PATCH] docs: mtd: Update spi nor reference driver
To:     Jonathan Corbet <corbet@lwn.net>
References: <1565107583-68506-1-git-send-email-john.garry@huawei.com>
 <20190906085212.79ec917c@lwn.net>
CC:     <mchehab+samsung@kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <frieder.schrempf@kontron.de>
From:   John Garry <john.garry@huawei.com>
Message-ID: <9110efc4-35e6-ff04-1a6d-d5d9f93927de@huawei.com>
Date:   Fri, 6 Sep 2019 15:58:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190906085212.79ec917c@lwn.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2019 15:52, Jonathan Corbet wrote:
> On Wed, 7 Aug 2019 00:06:23 +0800
> John Garry <john.garry@huawei.com> wrote:
>
>> The reference driver no longer exists since commit 50f1242c6742 ("mtd:
>> fsl-quadspi: Remove the driver as it was replaced by spi-fsl-qspi.c").
>>
>> Update reference to spi-fsl-qspi.c driver.
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>
> So this appears to have languished for a month...applied now, sorry for
> the delay.
>
> Thanks,
>
> jon
>
> .
>

Hi Jon,

I don't think that it was appropriate to apply this patch in the end - 
maybe this could have been communicated better. If you check the 
subsequent discussion in this thread, it seems that completely new 
documentation is required:

"Actually it seems like the whole file is obsolete and needs to be
removed or replaced by proper documentation of the SPI MEM API."

But nothing seems to be happening there...

Thanks,
John



