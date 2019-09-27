Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD1CC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 16:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A0E321850
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 16:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569600339;
	bh=8CSeS9F/4G2eeUxeyd4c7CtL2C8yijITsDDLQsUqk/I=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=uNtgdCuaGMKnkSVHH/VNhvq3fVtFr8NkeA6bdlAS8GHh3QVr2zTdCLuwGk5ZCwmug
	 tCRhXugbc7iPwKkOUUcwu4Tr9LFCSg7+ch9YJjT+34ks0/BYw0CQ5gAfECY0o3SI+A
	 kPNkCPI1dBZYagql9Sspqljsz4dmIx7A7xwf7Imo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfI0QFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 12:05:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727995AbfI0QFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 12:05:38 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53E7C207E0;
        Fri, 27 Sep 2019 16:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569600337;
        bh=8CSeS9F/4G2eeUxeyd4c7CtL2C8yijITsDDLQsUqk/I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=V9GPThNsj0HKMJ7PtZdAYqPlWNQYPpDjMzmA2NFSBNEAtFnbQkPC8Crd7iG9xiXQD
         bIU7y3WUUqT4Qh2z6pLluvZAMRurEmL8gv4F74ojQsLKvHcDp+Q/yGl64DPfNgkq5n
         NVFfM8SYfDeyJj1JsIcrRec69gT5VFU24S2ccV6A=
Subject: Re: [PATCH] usbip: clean up an indentation issue
To:     Colin King <colin.king@canonical.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20190927092000.19373-1-colin.king@canonical.com>
From:   shuah <shuah@kernel.org>
Message-ID: <824cf4f0-572b-9b60-e93c-83c1be0df181@kernel.org>
Date:   Fri, 27 Sep 2019 10:05:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190927092000.19373-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/19 3:20 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a return statement that is indented incorrectly, fix this.

Please include the warn you are fixing in the commit log
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/usb/usbip/stub_tx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/usbip/stub_tx.c b/drivers/usb/usbip/stub_tx.c
> index 36010a82b359..b1c2f6781cb3 100644
> --- a/drivers/usb/usbip/stub_tx.c
> +++ b/drivers/usb/usbip/stub_tx.c
> @@ -291,7 +291,7 @@ static int stub_send_ret_submit(struct stub_device *sdev)
>   				kfree(iov);
>   				usbip_event_add(&sdev->ud,
>   						SDEV_EVENT_ERROR_TCP);
> -			   return -1;
> +				return -1;
>   			}
>   		}
>   
> 
thanks,
-- Shuah
