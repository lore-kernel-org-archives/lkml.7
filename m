Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E058C10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05988206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="awDS1WSH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="l4+mRYqx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbfDDIyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:54:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56030 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729606AbfDDIye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:54:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A04E161A49; Thu,  4 Apr 2019 08:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554368073;
        bh=Xh6vq2ddGpiLVEXStfvjyqJcFymW09RvTJq79aBMqGI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=awDS1WSH3L4nIotnc2hWxHpY++GcvJ6pEW9RQF9KkGZzwviAJtyYYiwfvkMOE2+PW
         odKTkXdLEjNkzHsVp9pxyzayOhMMXYu3vv9xYnGQKIWmT14/7uwtD2idjxdc02DUcb
         eAS6/PsnhhbZFzSiqKPJ49v54TtgawXiSKbF/D6c=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 54D8761242;
        Thu,  4 Apr 2019 08:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554368072;
        bh=Xh6vq2ddGpiLVEXStfvjyqJcFymW09RvTJq79aBMqGI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=l4+mRYqxryQWm2yI5kvBKQtNGLFEscpnfSJDefHXz0yo3eVqBTACquVId37+UmNMK
         1KfRsoQbJTef8X7kquC2aT7rp2LTNkSuD/CGnT4JBboeJOwqTtiNWjlCIEPbIjhdEx
         yt8Z7/+8DKhYf/b5jYG6L5cQ+wueKZYW6d0BqEis=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 54D8761242
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] Documentation: bus: ti-sysc: fix spelling mistake
 "multipe" -> "multiple"
To:     Colin King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Faiz Abbas <faiz_abbas@ti.com>, devicetree@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190404081529.15394-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <b9ac4a18-1863-3f4b-b5b8-718ec05d9de2@codeaurora.org>
Date:   Thu, 4 Apr 2019 14:24:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404081529.15394-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/4/2019 1:45 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in the Documentation. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   Documentation/devicetree/bindings/bus/ti-sysc.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/bus/ti-sysc.txt b/Documentation/devicetree/bindings/bus/ti-sysc.txt
> index 85a23f551f02..8eec4c384000 100644
> --- a/Documentation/devicetree/bindings/bus/ti-sysc.txt
> +++ b/Documentation/devicetree/bindings/bus/ti-sysc.txt
> @@ -131,6 +131,6 @@ using offsets from l4_cfg second segment (0x4a000000 + 0x80000 = 0x4a0ab000):
>   		};
>   	};
>   
> -Note that other SoCs, such as am335x can have multipe child devices. On am335x
> +Note that other SoCs, such as am335x can have multiple child devices. On am335x

>   there are two MUSB instances, two USB PHY instances, and a single CPPI41 DMA
>   instance as children of a single interconnet target module.

s/interconnet/interconnect

fix this as well.
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

