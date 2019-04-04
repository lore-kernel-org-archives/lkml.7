Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310A5C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D42206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="W8F2PSS8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="E1R9CfqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfDDH2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:28:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51746 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfDDH2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:28:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CB48B6044E; Thu,  4 Apr 2019 07:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554362892;
        bh=bbPktcGZo2LUunx7pBeq+goNUYG+dVguY4N1A1nvANQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=W8F2PSS8EOX3nKUWrakW7dWiDVvBtlUjSVPlufzNjClbNteENgaQyzew3LfZJ/twD
         vMtJHisC81H1xCjANihwZhNeOyrww+w8dEf8ZA5uSOeGdmxECE5+pv2Ei2OUikmhxp
         A4kbtXmi8iE4CZ/uS+43eaZnY6srmChznHQsmfxA=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B44246044E;
        Thu,  4 Apr 2019 07:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554362885;
        bh=bbPktcGZo2LUunx7pBeq+goNUYG+dVguY4N1A1nvANQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=E1R9CfqGbf0D3/3UjsWe3FDxs689gwb7JNDoSVErlWm8w8HFTnP7YFFEU5w9VJHI+
         5iyl1Q7otHCmoY4Y2b5AO7cgD/iMV6eMR7gRdBWhVWSLC7vbzEqxx2WcqYVnCTZn5g
         hAHgvjuRdvM0oN4oaVzxRIYz7uxNnmaEqlVnnuYQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B44246044E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH -next] ehea: remove set but not used variables 'epa' and
 'cq_handle_ref'
To:     Yue Haibing <yuehaibing@huawei.com>, davem@davemloft.net,
        dougmill@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20190403075208.30000-1-yuehaibing@huawei.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <1fd03d2c-001b-89d4-eeb1-9666ac8b6d8d@codeaurora.org>
Date:   Thu, 4 Apr 2019 12:58:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403075208.30000-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/3/2019 1:22 PM, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/net/ethernet/ibm/ehea/ehea_qmr.c: In function 'ehea_create_cq':
> drivers/net/ethernet/ibm/ehea/ehea_qmr.c:127:7: warning: variable 'cq_handle_ref' set but not used [-Wunused-but-set-variable]
> drivers/net/ethernet/ibm/ehea/ehea_qmr.c:126:15: warning: variable 'epa' set but not used [-Wunused-but-set-variable]
>
> They are never used since commit
> 7a291083225a ("[PATCH] ehea: IBM eHEA Ethernet Device Driver")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   drivers/net/ethernet/ibm/ehea/ehea_qmr.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/net/ethernet/ibm/ehea/ehea_qmr.c b/drivers/net/ethernet/ibm/ehea/ehea_qmr.c
> index 5e4e371..77ce173 100644
> --- a/drivers/net/ethernet/ibm/ehea/ehea_qmr.c
> +++ b/drivers/net/ethernet/ibm/ehea/ehea_qmr.c
> @@ -123,8 +123,7 @@ struct ehea_cq *ehea_create_cq(struct ehea_adapter *adapter,
>   			       int nr_of_cqe, u64 eq_handle, u32 cq_token)
>   {
>   	struct ehea_cq *cq;
> -	struct h_epa epa;
> -	u64 *cq_handle_ref, hret, rpage;
> +	u64 hret, rpage;
>   	u32 counter;
>   	int ret;
>   	void *vpage;
> @@ -139,8 +138,6 @@ struct ehea_cq *ehea_create_cq(struct ehea_adapter *adapter,
>   
>   	cq->adapter = adapter;
>   
> -	cq_handle_ref = &cq->fw_handle;
> -
>   	hret = ehea_h_alloc_resource_cq(adapter->handle, &cq->attr,
>   					&cq->fw_handle, &cq->epas);
>   	if (hret != H_SUCCESS) {
> @@ -188,7 +185,6 @@ struct ehea_cq *ehea_create_cq(struct ehea_adapter *adapter,
>   	}
>   
>   	hw_qeit_reset(&cq->hw_queue);
> -	epa = cq->epas.kernel;
>   	ehea_reset_cq_ep(cq);
>   	ehea_reset_cq_n1(cq);
>   
