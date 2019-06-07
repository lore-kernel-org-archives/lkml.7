Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD51C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 12:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34EE9208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 12:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbfFGMZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 08:25:43 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:41541 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728597AbfFGMZn (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Fri, 7 Jun 2019 08:25:43 -0400
Received: from [10.160.4.48] (charybdis.suse.de [149.44.162.66])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Fri, 07 Jun 2019 14:25:41 +0200
Subject: Re: [PATCH trivial] [SCSI] aic7xxx: Spelling
 s/configuraion/configuration/
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190607112736.14004-1-geert+renesas@glider.be>
From:   Hannes Reinecke <hare@suse.com>
Message-ID: <032a117c-3698-a803-a340-6df720d61795@suse.com>
Date:   Fri, 7 Jun 2019 14:25:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190607112736.14004-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/19 1:27 PM, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/scsi/aic7xxx/aic7xxx.reg | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/aic7xxx/aic7xxx.reg b/drivers/scsi/aic7xxx/aic7xxx.reg
> index ba0b411d03e2e1fa..00fde2243e486cbd 100644
> --- a/drivers/scsi/aic7xxx/aic7xxx.reg
> +++ b/drivers/scsi/aic7xxx/aic7xxx.reg
> @@ -1666,7 +1666,7 @@ scratch_ram {
>  	size		6
>  	/*
>  	 * These are reserved registers in the card's scratch ram on the 2742.
> -	 * The EISA configuraiton chip is mapped here.  On Rev E. of the
> +	 * The EISA configuration chip is mapped here.  On Rev E. of the
>  	 * aic7770, the sequencer can use this area for scratch, but the
>  	 * host cannot directly access these registers.  On later chips, this
>  	 * area can be read and written by both the host and the sequencer.
> 
Indeed trivial.

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
