Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AB2C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 20:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10435206B6
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 20:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfCBUhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 15:37:50 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:45666 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfCBUhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 15:37:50 -0500
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 10B638D8C;
        Sat,  2 Mar 2019 21:37:48 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id td6EgetcrO5U; Sat,  2 Mar 2019 21:37:46 +0100 (CET)
Received: from function (unknown [198.134.98.50])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 16D078DDF;
        Sat,  2 Mar 2019 21:37:45 +0100 (CET)
Received: from samy by function with local (Exim 4.92-RC6)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1h0AWR-000310-1V; Sat, 02 Mar 2019 20:42:11 +0100
Date:   Sat, 2 Mar 2019 11:42:11 -0800
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Colin King <colin.king@canonical.com>
Cc:     William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: speakup: i18n: fix spelling mistake
 "phoneticly" -> "phonetically"
Message-ID: <20190302194211.4aj6r3dr4hahbnqi@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Colin King <colin.king@canonical.com>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181128161232.14907-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128161232.14907-1-colin.king@canonical.com>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Colin King, le mer. 28 nov. 2018 16:12:32 +0000, a ecrit:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in array speakup_default_msgs at index
> MSG_FUNCNAME_SPELL_WORD_PHONETICALLY, fix this.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

We never got any feedback from the speakup mailing list, I guess fixing
the typo is fine.

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

> ---
>  drivers/staging/speakup/i18n.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/speakup/i18n.c b/drivers/staging/speakup/i18n.c
> index cea8707653f5..ee240d36f947 100644
> --- a/drivers/staging/speakup/i18n.c
> +++ b/drivers/staging/speakup/i18n.c
> @@ -336,7 +336,7 @@ static char *speakup_default_msgs[MSG_LAST_INDEX] = {
>  	[MSG_FUNCNAME_SPELL_DELAY_DEC] = "spell delay decrement",
>  	[MSG_FUNCNAME_SPELL_DELAY_INC] = "spell delay increment",
>  	[MSG_FUNCNAME_SPELL_WORD] = "spell word",
> -	[MSG_FUNCNAME_SPELL_WORD_PHONETICALLY] = "spell word phoneticly",
> +	[MSG_FUNCNAME_SPELL_WORD_PHONETICALLY] = "spell word phonetically",
>  	[MSG_FUNCNAME_TONE_DEC] = "tone decrement",
>  	[MSG_FUNCNAME_TONE_INC] = "tone increment",
>  	[MSG_FUNCNAME_VOICE_DEC] = "voice decrement",
> -- 
> 2.19.1
> 

