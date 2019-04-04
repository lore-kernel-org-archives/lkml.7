Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5194FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C9E2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eINwjcfa";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RCfzv1oh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfDDHgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:36:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:32822 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfDDHgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:36:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3DE6C61A61; Thu,  4 Apr 2019 07:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554363364;
        bh=914xyW+t7L79XYy3oLeZwYav2uaAklk/WQzzkRc90zc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eINwjcfaQYhNEkyI0RKEQCvkyGDyxZFK2NNp4Q7brp5mFY0JrffTZrIOU/MUXeyLV
         DzIajt9pe6WS3/ibOq74YcxH6xXIIc87wVxlY9HQpx+jdMUD1vm5A+5f/ORkdEvG2G
         WrO0tsvQ0gupx+hVFHBvyWcxLCfNBFiB5IfJN84Q=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5F20061A61;
        Thu,  4 Apr 2019 07:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554363362;
        bh=914xyW+t7L79XYy3oLeZwYav2uaAklk/WQzzkRc90zc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RCfzv1ohvzJVX5CGjrYbG7/THigUMoT2RYREDKHs0mZFQZIVbGwmbJX5SDEO31tc0
         WGUEoKmhgmOM3sxK9EWd+L+2StYPkdcTJ7NmMs4WGGhfbRFOa6qKOcftozN+Ix4Ciq
         Ub/sjE4cVxPiM16EASZiRIwZwIcCXXa4VSebosL0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5F20061A61
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH net] trival: net: skbuff: fix comment in skbuff.h
To:     linmiaohe <linmiaohe@huawei.com>,
        David Miller <davem@davemloft.net>, willemb@google.com,
        fw@strlen.de, edumazet@google.com, pabeni@redhat.com,
        pctammela@gmail.com, deepa.kernel@gmail.com, sbrivio@redhat.com,
        mirq-linux@rere.qmqm.pl, linux-kernel@vger.kernel.org
Cc:     Mingfangsen <mingfangsen@huawei.com>
References: <625895cf-f9aa-cb8b-effc-556f6ae70464@huawei.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <5fb72714-5dc8-56da-1b50-a93949f0eb49@codeaurora.org>
Date:   Thu, 4 Apr 2019 13:05:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <625895cf-f9aa-cb8b-effc-556f6ae70464@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/3/2019 2:45 PM, linmiaohe wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
>
> It should be IPv6|UDP instead of IPv4|UDP for NETIF_F_IPV6_CSUM
>
> Signed-off-by: linmiaohe <linmiaohe@huawei.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   include/linux/skbuff.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 69b5538adcea..9683e00a5a79 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -71,7 +71,7 @@
>    *     NETIF_F_IPV6_CSUM - Driver (device) is only able to checksum plain
>    *                       TCP or UDP packets over IPv6. These are specifically
>    *                       unencapsulated packets of the form IPv6|TCP or
> - *                       IPv4|UDP where the Next Header field in the IPv6
> + *                       IPv6|UDP where the Next Header field in the IPv6
>    *                       header is either TCP or UDP. IPv6 extension headers
>    *                       are not supported with this feature. This feature
>    *                       cannot be set in features for a device with
