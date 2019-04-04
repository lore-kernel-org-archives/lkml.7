Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19866C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D82CD20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aB70heMo";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="B4scPH0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfDDH0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:26:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50540 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbfDDH0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:26:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 09A7B611CF; Thu,  4 Apr 2019 07:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554362798;
        bh=cruvqDNvKQYK7r1CTvADytjyadAZMgX23F8Uvvk/Usg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aB70heMo2xzq2NtNBc0RXGe977CRcrJxJ8g6rGThCM9BtP0V9wUCAYoXV8TD3iCTe
         hGw69UK5cEsq1w4IgnPje+R7Br0vVqnZgnTdWNdHr8Qr1XRSJHqYF7TfNN7/idva0G
         rqfBIpkFWCqcq8/A2iYcCG0SXwWiD9N+SFzwpnBY=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 47CF560790;
        Thu,  4 Apr 2019 07:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554362795;
        bh=cruvqDNvKQYK7r1CTvADytjyadAZMgX23F8Uvvk/Usg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=B4scPH0sq+l2+s34TfBbPzYiAvjjcQIEfeubqubjcYHQ/FGMBJsp9bgwl92pGDyr6
         igHkLrM7e1xW5K4FrBnd4mzDyJ6Sm8BKzJ6kBRhtW+sxIVMCHYIORtNulAThhCsBIy
         K0KBA926SW+9SqQVnJHcnd/eVln6jDBbn0I121Ig=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 47CF560790
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH -next] net: pasemi: remove set but not used variable
 'cpyhdr'
To:     Yue Haibing <yuehaibing@huawei.com>, davem@davemloft.net,
        mpe@ellerman.id.au, mcgrof@kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20190403075027.26744-1-yuehaibing@huawei.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <d32d829c-a6fe-9e47-5a00-b73b67fa1b65@codeaurora.org>
Date:   Thu, 4 Apr 2019 12:56:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403075027.26744-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/3/2019 1:20 PM, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/net/ethernet/pasemi/pasemi_mac.c: In function 'pasemi_mac_queue_csdesc':
> drivers/net/ethernet/pasemi/pasemi_mac.c:1358:29: warning: variable 'cpyhdr' set but not used [-Wunused-but-set-variable]
>
> It's never used since commit 8d636d8bc5ff ("pasemi_mac: jumbo
> frame support") and can be removed.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/net/ethernet/pasemi/pasemi_mac.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/pasemi/pasemi_mac.c b/drivers/net/ethernet/pasemi/pasemi_mac.c
> index 55d686e..5ffaee9 100644
> --- a/drivers/net/ethernet/pasemi/pasemi_mac.c
> +++ b/drivers/net/ethernet/pasemi/pasemi_mac.c
> @@ -1355,7 +1355,7 @@ static void pasemi_mac_queue_csdesc(const struct sk_buff *skb,
>   	const int nh_off = skb_network_offset(skb);
>   	const int nh_len = skb_network_header_len(skb);
>   	const int nfrags = skb_shinfo(skb)->nr_frags;
> -	int cs_size, i, fill, hdr, cpyhdr, evt;
> +	int cs_size, i, fill, hdr, evt;
>   	dma_addr_t csdma;
>   
>   	fund = XCT_FUN_ST | XCT_FUN_RR_8BRES |
> @@ -1396,7 +1396,6 @@ static void pasemi_mac_queue_csdesc(const struct sk_buff *skb,
>   		fill++;
>   
>   	/* Copy the result into the TCP packet */
> -	cpyhdr = fill;
>   	CS_DESC(csring, fill++) = XCT_FUN_O | XCT_FUN_FUN(csring->fun) |
>   				  XCT_FUN_LLEN(2) | XCT_FUN_SE;
>   	CS_DESC(csring, fill++) = XCT_PTR_LEN(2) | XCT_PTR_ADDR(cs_dest) | XCT_PTR_T;
