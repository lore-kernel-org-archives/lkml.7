Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C6AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4907F20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="a9gx2fOq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="a9gx2fOq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbfDDLXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 07:23:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42478 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbfDDLXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 07:23:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EF3CC6047C; Thu,  4 Apr 2019 11:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554376992;
        bh=7c8F70fyu4zI+Fnp/OkQADY0t1J80uJykaGCvdwOjIQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=a9gx2fOq3p81UdmmSLE0ENopf5tqJAJ0pfGRvOhC3lmIk1nKrAcToU92sIPEdPxwD
         uqIy6K9i5jc4n/P8B1y+QrTaTltRUCFhL7jHb3YDm3Fxp+kXXQKLYpJM4ecVNDWwwB
         A34HSmUBpbnZlQrel8UQeVBxVE25TOnPmz/td9mE=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AE5E4602F2;
        Thu,  4 Apr 2019 11:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554376992;
        bh=7c8F70fyu4zI+Fnp/OkQADY0t1J80uJykaGCvdwOjIQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=a9gx2fOq3p81UdmmSLE0ENopf5tqJAJ0pfGRvOhC3lmIk1nKrAcToU92sIPEdPxwD
         uqIy6K9i5jc4n/P8B1y+QrTaTltRUCFhL7jHb3YDm3Fxp+kXXQKLYpJM4ecVNDWwwB
         A34HSmUBpbnZlQrel8UQeVBxVE25TOnPmz/td9mE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AE5E4602F2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH][V2] Documentation: bus: ti-sysc: fix spelling mistakes
 "multipe" and "interconnet"
To:     Colin King <colin.king@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Faiz Abbas <faiz_abbas@ti.com>, devicetree@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190404111657.21477-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <46156ce3-7b5d-2545-41f2-5816ae9c1a5a@codeaurora.org>
Date:   Thu, 4 Apr 2019 16:53:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404111657.21477-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/4/2019 4:46 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There is are a couple of spelling mistakes in the Documentation. Fix them.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>
> V2: Add fix to interconnect, thanks to Mukesh Ojha for spotting that
>
> ---
>   Documentation/devicetree/bindings/bus/ti-sysc.txt | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/bus/ti-sysc.txt b/Documentation/devicetree/bindings/bus/ti-sysc.txt
> index 85a23f551f02..cf0e1d6d6f2e 100644
> --- a/Documentation/devicetree/bindings/bus/ti-sysc.txt
> +++ b/Documentation/devicetree/bindings/bus/ti-sysc.txt
> @@ -131,6 +131,6 @@ using offsets from l4_cfg second segment (0x4a000000 + 0x80000 = 0x4a0ab000):
>   		};
>   	};
>   
> -Note that other SoCs, such as am335x can have multipe child devices. On am335x
> +Note that other SoCs, such as am335x can have multiple child devices. On am335x
>   there are two MUSB instances, two USB PHY instances, and a single CPPI41 DMA
> -instance as children of a single interconnet target module.
> +instance as children of a single interconnect target module.
