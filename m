Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB1EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01D5217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbfCON4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:56:32 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39864 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727705AbfCON4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:56:32 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 31116DB620054078BE5C;
        Fri, 15 Mar 2019 21:56:26 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Fri, 15 Mar 2019
 21:56:21 +0800
Subject: Re: [PATCH serial v3] sc16is7xx: missing unregister/delete driver on
 error in sc16is7xx_init()
To:     Dan Carpenter <dan.carpenter@oracle.com>
References: <20190311093959.86344-1-maowenan@huawei.com>
 <20190311121918.GD2412@kadam>
CC:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <vz@mleia.com>
From:   maowenan <maowenan@huawei.com>
Message-ID: <566a03ba-aae9-3169-5db3-3417d5eb60f9@huawei.com>
Date:   Fri, 15 Mar 2019 21:56:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190311121918.GD2412@kadam>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping...

On 2019/3/11 20:19, Dan Carpenter wrote:
> On Mon, Mar 11, 2019 at 05:39:59PM +0800, Mao Wenan wrote:
>> Add the missing uart_unregister_driver() and i2c_del_driver() before
>> return from sc16is7xx_init() in the error handling case.
>>
>> Signed-off-by: Mao Wenan <maowenan@huawei.com>
>> Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
> 
> This looks nice.  Thanks!
> 
> Reviewed-by: Dan Carpeter <dan.carpenter@oracle.com>
> 
> regards,
> dan carpenter
> 
> 
> 

