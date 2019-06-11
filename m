Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B69DC43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 03:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2279F20896
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 03:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390953AbfFKDA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 23:00:58 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40698 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390717AbfFKDA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 23:00:57 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 382B46F19029F8968B9E;
        Tue, 11 Jun 2019 11:00:55 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Tue, 11 Jun 2019
 11:00:50 +0800
Subject: Re: [PATCH -next] HID: logitech-dj: fix return value of
 logi_dj_recv_query_hidpp_devices
To:     <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <hdegoede@redhat.com>, <jkosina@suse.cz>,
        <benjamin.tissoires@redhat.com>
References: <20190525140908.2804-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <50800f5e-867d-ded9-235c-b9c2db1c41ef@huawei.com>
Date:   Tue, 11 Jun 2019 11:00:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190525140908.2804-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Friendly ping...

On 2019/5/25 22:09, YueHaibing wrote:
> We should return 'retval' as the correct return value
> instead of always zero.
> 
> Fixes: 74808f9115ce ("HID: logitech-dj: add support for non unifying receivers")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/hid/hid-logitech-dj.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
> index 41baa4dbbfcc..7f8db602eec0 100644
> --- a/drivers/hid/hid-logitech-dj.c
> +++ b/drivers/hid/hid-logitech-dj.c
> @@ -1133,7 +1133,7 @@ static int logi_dj_recv_query_hidpp_devices(struct dj_receiver_dev *djrcv_dev)
>  				    HID_REQ_SET_REPORT);
>  
>  	kfree(hidpp_report);
> -	return 0;
> +	return retval;
>  }
>  
>  static int logi_dj_recv_query_paired_devices(struct dj_receiver_dev *djrcv_dev)
> 

