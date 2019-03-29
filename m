Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90200C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A36E206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QXb1LBZw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mm5D6fIh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbfC2OHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:07:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42816 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbfC2OHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:07:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BFF9A61570; Fri, 29 Mar 2019 14:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553868451;
        bh=lr8gVn+JEAPnNvkty/sTPLFZxa/laEWN12wveQ3lIyY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QXb1LBZwDWsYxNu2d89xloowNCdullJNaeGndjTTN+qGN+fAkq6cPsFtay21k8wJd
         iSEh6Sh5W8wXsXkIoF+QfJbg/bO1SZS5mn/l8TiYUMMHGnQTR5kQ1ei6ow2s9AxpHV
         5MHoyZc+9MXduXZDo4X1OGHOtgfJicmDC0NcQs3w=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D78B860DB4;
        Fri, 29 Mar 2019 14:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553868450;
        bh=lr8gVn+JEAPnNvkty/sTPLFZxa/laEWN12wveQ3lIyY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mm5D6fIhCDYeQLprGZNxpR6jA3B7dsOY3jvdCQMRh4zyArnMKefcfPA6dWF5HadtS
         2zx9ZVv3f4FEtZOoEz6rDGp8oWUgylhEIosGi2BWeABra+UMN/ut9WyxW5MyTxHzKY
         BIl1yNao1cEeG/5IJqddJPOoI7NlpUJnP0nlfuDg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D78B860DB4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v2 1/2] MAINTAINERS: fix bad pattern in ARM/NUVOTON NPCM
To:     Tomer Maimon <tmaimon77@gmail.com>, joe@perches.com,
        avifishman70@gmail.com, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, brendanhiggins@google.com,
        tali.perry1@gmail.com, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
References: <20190328235752.334462-1-tmaimon77@gmail.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <367707d3-9f3f-e15b-1db3-eedb2e23981d@codeaurora.org>
Date:   Fri, 29 Mar 2019 19:37:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190328235752.334462-1-tmaimon77@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/29/2019 5:27 AM, Tomer Maimon wrote:
> In the process of upstreaming architecture support for ARM/NUVOTON NPCM
> include/dt-bindings/clock/nuvoton,npcm7xx-clks.h was renamed
> include/dt-bindings/clock/nuvoton,npcm7xx-clock.h without updating
> MAINTAINERS. This updates the MAINTAINERS pattern to match the new name
> of this file.
>
> Fixes: 6a498e06ba22 ("MAINTAINERS: Add entry for the Nuvoton NPCM architecture")
> Reported-by: Joe Perches <joe@perches.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3e5a5d263f29..8b305d2f2a8a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1900,7 +1900,7 @@ L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
>   S:	Supported
>   F:	arch/arm/mach-npcm/
>   F:	arch/arm/boot/dts/nuvoton-npcm*
> -F:	include/dt-bindings/clock/nuvoton,npcm7xx-clks.h
> +F:	include/dt-bindings/clock/nuvoton,npcm7xx-clock.h
>   F:	drivers/*/*npcm*
>   F:	Documentation/devicetree/bindings/*/*npcm*
>   F:	Documentation/devicetree/bindings/*/*/*npcm*
