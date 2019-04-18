Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E33AC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0334A2083D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Og1Tiho4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Og1Tiho4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388774AbfDRKkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 06:40:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39930 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388304AbfDRKkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 06:40:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CCAC760712; Thu, 18 Apr 2019 10:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555584038;
        bh=4aBD+wcpDZwJGZmbeEovfofZRs/BenSo0ofvu0MDGlo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Og1Tiho4huRzbc92432MwzdmkwC3gCM0oBcZmLWKFwX44UmV6QuRoYYiC9zUp9lIF
         t7VvFwLH6nFfeGgGOTmD1F8vBApA24fFZkpNMF8p++q+gZM+DeukpBx/c+Zs1sEm/l
         n5tbekUu+ogtqNWG8+QRhQJOAKAABLCocgUBFq18=
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3513060274;
        Thu, 18 Apr 2019 10:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555584038;
        bh=4aBD+wcpDZwJGZmbeEovfofZRs/BenSo0ofvu0MDGlo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Og1Tiho4huRzbc92432MwzdmkwC3gCM0oBcZmLWKFwX44UmV6QuRoYYiC9zUp9lIF
         t7VvFwLH6nFfeGgGOTmD1F8vBApA24fFZkpNMF8p++q+gZM+DeukpBx/c+Zs1sEm/l
         n5tbekUu+ogtqNWG8+QRhQJOAKAABLCocgUBFq18=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3513060274
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] net: ipv6: addrlabel: fix spelling mistake "requewst" ->
 "request"
To:     Colin King <colin.king@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190418103918.10729-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <2b20f045-a386-723b-9a8f-265cc96d0916@codeaurora.org>
Date:   Thu, 18 Apr 2019 16:10:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418103918.10729-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/18/2019 4:09 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a NL_SET_ERR_MSG_MOD error message,
> fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   net/ipv6/addrlabel.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv6/addrlabel.c b/net/ipv6/addrlabel.c
> index d43d076c98f5..1766325423b5 100644
> --- a/net/ipv6/addrlabel.c
> +++ b/net/ipv6/addrlabel.c
> @@ -476,7 +476,7 @@ static int ip6addrlbl_valid_dump_req(const struct nlmsghdr *nlh,
>   	}
>   
>   	if (nlmsg_attrlen(nlh, sizeof(*ifal))) {
> -		NL_SET_ERR_MSG_MOD(extack, "Invalid data after header for address label dump requewst");
> +		NL_SET_ERR_MSG_MOD(extack, "Invalid data after header for address label dump request");
>   		return -EINVAL;
>   	}
>   
