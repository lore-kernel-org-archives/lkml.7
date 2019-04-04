Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF132C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5AFE206B6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="B+0KuUMs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387699AbfDDJ1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:27:09 -0400
Received: from smtp121.ord1c.emailsrvr.com ([108.166.43.121]:52386 "EHLO
        smtp121.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387447AbfDDJMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:12:47 -0400
Received: from smtp8.relay.ord1c.emailsrvr.com (localhost [127.0.0.1])
        by smtp8.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 70E0FA01C7;
        Thu,  4 Apr 2019 05:12:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1554369166;
        bh=IXYTopmL0PKdXzlk0/Ce0Vlsk0z2nnFS5rJ2rUQzwso=;
        h=Subject:To:From:Date:From;
        b=B+0KuUMsc8g8VMZ9D4w57kG+AAaP3zrZSHhMC0D/A9n2HppqvjFJyNd0kXjtL7wBt
         AmMBUzPRJPRMRNUU3nIqZVnpBtSkj9IeUTY9nXbHqVU1heRtDNiW0GvE5yMLso6Aab
         IbR2tc/qNXrTXYt54RA/QG8R1DSPGsjRfjkp39DE=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp8.relay.ord1c.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 97E1BA00F7;
        Thu,  4 Apr 2019 05:12:45 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from [10.0.0.185] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Thu, 04 Apr 2019 05:12:46 -0400
Subject: Re: [PATCH] staging: comedi: Fix spelling mistake
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20190404012404.GA2098@hari-Inspiron-1545>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <6d2d428f-e370-17d6-e0fc-e66f81a5ce76@mev.co.uk>
Date:   Thu, 4 Apr 2019 10:12:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190404012404.GA2098@hari-Inspiron-1545>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2019 02:24, Hariprasad Kelam wrote:
> changes interupts --> interrupts to fix warning reported by checkpatch
> tool
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>   drivers/staging/comedi/drivers/dt2811.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/comedi/drivers/dt2811.c b/drivers/staging/comedi/drivers/dt2811.c
> index 05207a5..8a1f9ef 100644
> --- a/drivers/staging/comedi/drivers/dt2811.c
> +++ b/drivers/staging/comedi/drivers/dt2811.c
> @@ -52,7 +52,7 @@
>   #define DT2811_ADCSR_ADBUSY		BIT(5)	/* r      1=A/D busy */
>   #define DT2811_ADCSR_CLRERROR		BIT(4)
>   #define DT2811_ADCSR_DMAENB		BIT(3)	/* r/w    1=dma ena */
> -#define DT2811_ADCSR_INTENB		BIT(2)	/* r/w    1=interupts ena */
> +#define DT2811_ADCSR_INTENB		BIT(2)	/* r/w    1=interrupts ena */
>   #define DT2811_ADCSR_ADMODE(x)		(((x) & 0x3) << 0)
>   
>   #define DT2811_ADGCR_REG		0x01	/* r/w  A/D Gain/Channel */
> 

Hi Hariprasad, could you mention dt2811 in the patch subject line like this:

staging: comedi: dt2811: Fix spelling mistake

It helps to narrow down the scope of the patch.

Apart from that, the patch looks fine.  Thanks.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
