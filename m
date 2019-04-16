Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B76EC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA117206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="VHHqaZIy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbfDPKWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:22:52 -0400
Received: from smtp89.ord1c.emailsrvr.com ([108.166.43.89]:39153 "EHLO
        smtp89.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726686AbfDPKWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:22:52 -0400
Received: from smtp28.relay.ord1c.emailsrvr.com (localhost [127.0.0.1])
        by smtp28.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 3C599401AA;
        Tue, 16 Apr 2019 06:22:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1555410171;
        bh=XE36eOwio0qqT02qNb8G8G4AEDiof3c3gM18Ev+F4ek=;
        h=Subject:To:From:Date:From;
        b=VHHqaZIyBXpiqCbSJ0eoCXuvXoSnSkQIJdKmKC01/ghzjcvpe52wjT30K9fI0gXlo
         /lYr2QPPsZlhZTs/hj6k6wLRA1Kr60GqbMwSbwvYkvS9dHk/VFEm3+Z8PwC/dnqeN8
         SOS4mcTiZ5e8VKrJrDPmewCH2GJ2mRHC2yLkfb4A=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp28.relay.ord1c.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 41E944011E;
        Tue, 16 Apr 2019 06:22:50 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from [10.0.0.62] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Tue, 16 Apr 2019 06:22:51 -0400
Subject: Re: [PATCH] staging: comedi: adv_pci1710: fix spelling mistake:
 "droput" -> "dropout"
To:     Colin King <colin.king@canonical.com>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190415174945.32712-1-colin.king@canonical.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <dbe5e3b9-0653-53ec-1371-88c29aed7b8d@mev.co.uk>
Date:   Tue, 16 Apr 2019 11:22:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415174945.32712-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/2019 18:49, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a dev_error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Looks good, thanks!

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

> ---
>   drivers/staging/comedi/drivers/adv_pci1710.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/comedi/drivers/adv_pci1710.c b/drivers/staging/comedi/drivers/adv_pci1710.c
> index 6a93b04f1fdf..dbff0f7e7cf5 100644
> --- a/drivers/staging/comedi/drivers/adv_pci1710.c
> +++ b/drivers/staging/comedi/drivers/adv_pci1710.c
> @@ -317,7 +317,7 @@ static int pci1710_ai_read_sample(struct comedi_device *dev,
>   		chan = sample >> 12;
>   		if (chan != devpriv->act_chanlist[cur_chan]) {
>   			dev_err(dev->class_dev,
> -				"A/D data droput: received from channel %d, expected %d\n",
> +				"A/D data dropout: received from channel %d, expected %d\n",
>   				chan, devpriv->act_chanlist[cur_chan]);
>   			return -ENODATA;
>   		}
> 


-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
