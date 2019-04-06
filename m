Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB1FC10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 09:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D0E21855
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 09:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="AuXBTMLW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfDFJv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 05:51:28 -0400
Received: from smtp113.ord1c.emailsrvr.com ([108.166.43.113]:34925 "EHLO
        smtp113.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726036AbfDFJv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 05:51:28 -0400
Received: from smtp23.relay.ord1c.emailsrvr.com (localhost [127.0.0.1])
        by smtp23.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 41FAF401CE;
        Sat,  6 Apr 2019 05:51:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1554544287;
        bh=Qt4iiqKXHOn0XucQXVX+MNagqpQ8P6SfoyEixNo1K4c=;
        h=Subject:To:From:Date:From;
        b=AuXBTMLWTfbo1SBNgwlvnVCybMBAwnzCe4NU1HEmjbgb17Ata1ZR1kVwoYYBAzRS3
         A3DSQrIi2dSVxJuXXE2xH0IGNURwmcWU6ecbe9Pa6VGSPaodug8brBVVhwTKBjhqD3
         6fOh1uSSNipu9Vv8TUACGTPLORK5vgmp98uWOT0Y=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp23.relay.ord1c.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 669AB401CC;
        Sat,  6 Apr 2019 05:51:26 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from [192.168.1.10] (redmecca.plus.com [80.229.15.156])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Sat, 06 Apr 2019 05:51:27 -0400
Subject: Re: [PATCH V2] staging: comedi: dt2811: Fix spelling mistake
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        hsweeten@visionengravers.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20190406082319.GA4231@hari-Inspiron-1545>
From:   Ian Abbott <abbotti@mev.co.uk>
Message-ID: <8b6155c1-ac2e-6db7-8070-5cba5620b879@mev.co.uk>
Date:   Sat, 6 Apr 2019 10:51:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190406082319.GA4231@hari-Inspiron-1545>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2019 09:23, Hariprasad Kelam wrote:
> changes interupts --> interrupts to fix warning reported by checkpatch
> tool
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
> Changes in v2:
>    - Make the Subject more clear by including changed file path.
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

Looks good. Thanks!

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
