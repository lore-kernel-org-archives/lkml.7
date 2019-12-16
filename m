Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72969C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44CC320409
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DaCXZPUb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfLPNqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 08:46:02 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:34586 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbfLPNqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 08:46:01 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBGDjkx1004309;
        Mon, 16 Dec 2019 07:45:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576503946;
        bh=hF5fIhi5FXFQOcefCVIFOqhxnmXmtjHzapG1lCwiIoM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=DaCXZPUbFFjoxJCvkIBx5x3SRtz6XKjHviEAOg8k6OCE0iBYfPTepswmfuqau/eDj
         t3pubF92EyaVNIlpjXnBCYLnPd8phKg+QJLJ0Z6r384rS0Krt9RhVCRvDLnxpEqFnW
         GDdoZmmBVkZxWRMuaYoMRIsv13nMzlJlezRgJaXk=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBGDjkw3118351
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Dec 2019 07:45:46 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 16
 Dec 2019 07:45:46 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 16 Dec 2019 07:45:46 -0600
Received: from [10.250.79.55] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBGDjjJi089154;
        Mon, 16 Dec 2019 07:45:46 -0600
Subject: Re: [PATCH v2] dma-heap: Make the symbol 'dma_heap_ioctl_cmds' static
To:     zhong jiang <zhongjiang@huawei.com>, <sumit.semwal@linaro.org>,
        <benjamin.gaignard@linaro.org>
CC:     <labbott@redhat.com>, <Brian.Starkey@arm.com>,
        <john.stultz@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>
References: <c1244a5f-b82a-baee-262a-7241531036ad@ti.com>
 <1576503511-27500-1-git-send-email-zhongjiang@huawei.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <51d74833-5de2-dd2c-f079-321ccc718599@ti.com>
Date:   Mon, 16 Dec 2019 08:45:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1576503511-27500-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/19 8:38 AM, zhong jiang wrote:
> Fix the following sparse warning.
> 
> drivers/dma-buf/dma-heap.c:109:14: warning: symbol 'dma_heap_ioctl_cmds' was not declared. Should it be static?
> 


Acked-by: Andrew F. Davis <afd@ti.com>


> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/dma-buf/dma-heap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> index 4f04d10..da2090e 100644
> --- a/drivers/dma-buf/dma-heap.c
> +++ b/drivers/dma-buf/dma-heap.c
> @@ -106,7 +106,7 @@ static long dma_heap_ioctl_allocate(struct file *file, void *data)
>  	return 0;
>  }
>  
> -unsigned int dma_heap_ioctl_cmds[] = {
> +static unsigned int dma_heap_ioctl_cmds[] = {
>  	DMA_HEAP_IOC_ALLOC,
>  };
>  
> 
