Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB91C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A96220828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfH0HXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:23:25 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51612 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725825AbfH0HXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:23:25 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 673CA44DC12ACBBBF01D;
        Tue, 27 Aug 2019 15:23:23 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Tue, 27 Aug 2019
 15:23:19 +0800
Subject: Re: [PATCH -next] media: sun6i: Make sun4i_csi_formats static
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
References: <20190827070623.15776-1-yuehaibing@huawei.com>
 <20190827072043.GA7657@paasikivi.fi.intel.com>
CC:     <mripard@kernel.org>, <mchehab@kernel.org>, <wens@csie.org>,
        <maxime.ripard@bootlin.com>, <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <48f90bc2-3c9a-bc37-98b2-e21f76d08afe@huawei.com>
Date:   Tue, 27 Aug 2019 15:23:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190827072043.GA7657@paasikivi.fi.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/8/27 15:20, Sakari Ailus wrote:
> Hi Yue,
> 
> On Tue, Aug 27, 2019 at 03:06:23PM +0800, YueHaibing wrote:
>> Fix sparse warning:
>>
>> drivers/media/platform/sunxi/sun4i-csi/sun4i_v4l2.c:21:31:
>>  warning: symbol 'sun4i_csi_formats' was not declared. Should it be static?
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Thanks for the patch.
> 
> This has been already addressed by another patch:
> 
> <URL:https://patchwork.linuxtv.org/patch/58395/>

OK, thank you!

> 

