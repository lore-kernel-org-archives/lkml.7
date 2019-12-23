Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD935C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 08:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA2C20709
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 08:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="v6XM4lBK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfLWIyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 03:54:11 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:56460 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfLWIyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 03:54:11 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBN8rvNJ069194;
        Mon, 23 Dec 2019 02:53:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577091237;
        bh=lg1Djuoe6ahXyyc1XjirhC5Cey95aVxgpU1ZuAQBxNk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=v6XM4lBKI9XbJI8Ml7N+1oD0gDvrM/RztLXjhzoNMkkmeENIWvy+3FRWeJvcOmx8o
         KMTUPoIabntTawNC60cxMlG7zZtNbCIoq5gDCbzo4j+h9+HX0Mo55ZkOIYXMjWTFsy
         nfufdhOxRHZf5Ie3xsxTkomH25JdbVUWUKJ/hHIg=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBN8rvd6087337
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Dec 2019 02:53:57 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 23
 Dec 2019 02:53:56 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 23 Dec 2019 02:53:57 -0600
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBN8rsZT045002;
        Mon, 23 Dec 2019 02:53:55 -0600
Subject: Re: [PATCH] usb: cdns3: gadget: Remove unneeded variable ret
To:     Xu Wang <vulab@iscas.ac.cn>, <gregkh@linuxfoundation.org>
CC:     <pawell@cadence.com>, <balbi@kernel.org>, <peter.chen@nxp.com>,
        <colin.king@canonical.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1576826378-4387-1-git-send-email-vulab@iscas.ac.cn>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <890bc22f-9f03-f4c3-9fdc-7afe4c7321ff@ti.com>
Date:   Mon, 23 Dec 2019 10:53:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1576826378-4387-1-git-send-email-vulab@iscas.ac.cn>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/12/2019 09:19, Xu Wang wrote:
> Remove unneeded variable ret used to store return value,just return 0.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>

Acked-by: Roger Quadros <rogerq@ti.com>

> ---
>   drivers/usb/cdns3/gadget.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
> index 4c1e755..73b75a3 100644
> --- a/drivers/usb/cdns3/gadget.c
> +++ b/drivers/usb/cdns3/gadget.c
> @@ -2389,7 +2389,6 @@ static int cdns3_gadget_udc_stop(struct usb_gadget *gadget)
>   	struct cdns3_endpoint *priv_ep;
>   	u32 bEndpointAddress;
>   	struct usb_ep *ep;
> -	int ret = 0;
>   	int val;
>   
>   	priv_dev->gadget_driver = NULL;
> @@ -2413,7 +2412,7 @@ static int cdns3_gadget_udc_stop(struct usb_gadget *gadget)
>   	writel(0, &priv_dev->regs->usb_ien);
>   	writel(USB_CONF_DEVDS, &priv_dev->regs->usb_conf);
>   
> -	return ret;
> +	return 0;
>   }
>   
>   static const struct usb_gadget_ops cdns3_gadget_ops = {
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
