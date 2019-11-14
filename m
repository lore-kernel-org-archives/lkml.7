Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34DFC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F8A620675
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bfs.de header.i=@bfs.de header.b="H6bk6suL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfKNKdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 05:33:33 -0500
Received: from mx01-fr.bfs.de ([193.174.231.67]:64403 "EHLO mx01-fr.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfKNKdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 05:33:32 -0500
Received: from mail-fr.bfs.de (mail-fr.bfs.de [10.177.18.200])
        by mx01-fr.bfs.de (Postfix) with ESMTPS id 6AF3920346;
        Thu, 14 Nov 2019 11:33:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1573727601; h=from:from:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cKhNKGzpQjIXpZ4KphvaUafb/xdZMCyUdnUQ1YJ5Vic=;
        b=H6bk6suLnD4e9AdKorHz8a6XT0fRGyL1Y3ljTQKsJXuK/tiaTNrLxQkDWn6S8KmFHGy24a
        x3MvTHlAWkcZXl7+UQTbSsmE52w9BLHviTfp0rATgm620k90hPmXq5+pEyR/r7fmgrSDLY
        u8+nxRtEJCsriRIBoDBLSyG03lcLNjS8DlFjjR0+2wRYi3nIK0XYnGPCQNcXvnHxoS//mI
        0fMsUO1axJyl1hPp+hmdjyFzKaXAGZ0JJRAgJZmMLAxQB4DYJD4jVCHG2W97dlhpGdonc/
        DWlhGQpXM/YGhawoKNyTqn5BCjCOFHfatns+BiD3mH1p5PDNbsL9DgNJMNtZ2A==
Received: from [134.92.181.33] (unknown [134.92.181.33])
        by mail-fr.bfs.de (Postfix) with ESMTPS id F3BD6BEEBD;
        Thu, 14 Nov 2019 11:33:10 +0100 (CET)
Message-ID: <5DCD2D66.2050206@bfs.de>
Date:   Thu, 14 Nov 2019 11:33:10 +0100
From:   walter harms <wharms@bfs.de>
Reply-To: wharms@bfs.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.16) Gecko/20101125 SUSE/3.0.11 Thunderbird/3.0.11
MIME-Version: 1.0
To:     linux-kernel@vger.kernel.org
CC:     Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192u: fix indentation issue
References: <20191114095430.132120-1-colin.king@canonical.com>
In-Reply-To: <20191114095430.132120-1-colin.king@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: mx01-fr.bfs.de
X-Spamd-Result: default: False [-3.10 / 7.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.00)[wharms@bfs.de];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         RCPT_COUNT_FIVE(0.00)[5];
         DKIM_SIGNED(0.00)[];
         NEURAL_HAM(-0.00)[-0.999,0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         RCVD_TLS_ALL(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 14.11.2019 10:54, schrieb Colin King:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a block of statements that are indented
> too deeply, remove the extraneous tabs.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/staging/rtl8192u/r819xU_cmdpkt.c | 25 ++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192u/r819xU_cmdpkt.c b/drivers/staging/rtl8192u/r819xU_cmdpkt.c
> index e064f43fd8b6..bc98cdaf61ec 100644
> --- a/drivers/staging/rtl8192u/r819xU_cmdpkt.c
> +++ b/drivers/staging/rtl8192u/r819xU_cmdpkt.c
> @@ -169,19 +169,20 @@ static void cmdpkt_beacontimerinterrupt_819xusb(struct net_device *dev)
>  {
>  	struct r8192_priv *priv = ieee80211_priv(dev);
>  	u16 tx_rate;
> -		/* 87B have to S/W beacon for DTM encryption_cmn. */
> -		if (priv->ieee80211->current_network.mode == IEEE_A ||
> -		    priv->ieee80211->current_network.mode == IEEE_N_5G ||
> -		    (priv->ieee80211->current_network.mode == IEEE_N_24G &&
> -		     (!priv->ieee80211->pHTInfo->bCurSuppCCK))) {
> -			tx_rate = 60;
> -			DMESG("send beacon frame  tx rate is 6Mbpm\n");
> -		} else {
> -			tx_rate = 10;
> -			DMESG("send beacon frame  tx rate is 1Mbpm\n");
> -		}
>  
> -		rtl819xusb_beacon_tx(dev, tx_rate); /* HW Beacon */
> +	/* 87B have to S/W beacon for DTM encryption_cmn. */
> +	if (priv->ieee80211->current_network.mode == IEEE_A ||
> +	    priv->ieee80211->current_network.mode == IEEE_N_5G ||
> +	    (priv->ieee80211->current_network.mode == IEEE_N_24G &&
> +	     (!priv->ieee80211->pHTInfo->bCurSuppCCK))) {
> +		tx_rate = 60;
> +		DMESG("send beacon frame  tx rate is 6Mbpm\n");
> +	} else {
> +		tx_rate = 10;
> +		DMESG("send beacon frame  tx rate is 1Mbpm\n");
> +	}
> +
> +	rtl819xusb_beacon_tx(dev, tx_rate); /* HW Beacon */
>  }
>  
>  /*-----------------------------------------------------------------------------

this is hard to read in the first place.
Maybe using switch() here is better to read (untested example below).


	switch(priv->ieee80211->current_network.mode) {

	case IEEE_A:
	case IEEE_N_5G:
	 tx_rate = 60;
         break;
        IEEE_N_24G:
	     if ( !priv->ieee80211->pHTInfo->bCurSuppCCK )
		tx_rate = 60;
             // fall truh

        default:
		tx_rate = 10;

	}	

	if (txrate == 60 )
	     DMESG("send beacon frame  tx rate is 6Mbpm\n");
	else if (txrate == 10 )
	     DMESG("send beacon frame  tx rate is 1Mbpm\n");

JM2C

re,
 wh
