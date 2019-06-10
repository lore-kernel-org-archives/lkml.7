Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15273C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 15:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF10420859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 15:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560181686;
	bh=s/LAKmlHEH3zUNukB0yjQTETxfcFC8gag3lro9BlcFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f/Pgk5BRzrtSPhFSn3FrfV7yMaKSOF3P7vu9pwmcbkwo5LB/Ptj81pPYyo3HFkdTg
	 xgfIZ8Xk8A7g4E9OjgyJWk3mDKNS0f1ZKSnRrkhI3IzOR0z47Vtlwl2ZQJh1yTZNRJ
	 fcotGP1r6LSxyy2CeMkmi16rn4KKNk6Hill9r+Ys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391269AbfFJPsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 11:48:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390335AbfFJPsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 11:48:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39B3420859;
        Mon, 10 Jun 2019 15:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560181684;
        bh=s/LAKmlHEH3zUNukB0yjQTETxfcFC8gag3lro9BlcFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gFGhGAj1S/a5vI1H1ndGakbD6DIjcERFGWfnPUIanOba4OK4VTRZPO+BfgsCCdGOW
         ShymN1csSlnb787DHwuTvUWQIDGn3P2bsmRsPbpzpHLige+gygX/hFNlRXbKaIMG7Z
         mxtXJHYwQ+XRGVmXE862+CMffmHoprAMc9niXEKY=
Date:   Mon, 10 Jun 2019 17:48:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Merwin Trever Ferrao <merwintf@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/16] Staging: wlan-ng: cfg80211: fixed alignment issue
 with open parenthesis line ending with (
Message-ID: <20190610154802.GA29035@kroah.com>
References: <20190610103825.19364-1-merwintf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610103825.19364-1-merwintf@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 04:08:25PM +0530, Merwin Trever Ferrao wrote:
> From: Merwin Trever Ferrao <Merwintf@gmail.com>
> 
> Fixed a coding style issue.
> 
> Signed-off-by: Merwin Trever Ferrao <merwintf@gmail.com>
> ---
>  drivers/staging/wlan-ng/cfg80211.c | 32 ++++++++++++++----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
> index eee1998c4b18..5424e2682911 100644
> --- a/drivers/staging/wlan-ng/cfg80211.c
> +++ b/drivers/staging/wlan-ng/cfg80211.c
> @@ -324,8 +324,7 @@ static int prism2_scan(struct wiphy *wiphy,
>  		(i < request->n_channels) && i < ARRAY_SIZE(prism2_channels);
>  		i++)
>  		msg1.channellist.data.data[i] =
> -			ieee80211_frequency_to_channel(
> -				request->channels[i]->center_freq);
> +			ieee80211_frequency_to_channel(request->channels[i]->center_freq);

And now you violate the other coding style rule of too long lines :(

You can just keep sending patches fixing this back and forth, if you
want a never-ending set of patches to be applied, but we don't really
like that.

So the code is ok as-is.

>  	msg1.channellist.data.len = request->n_channels;
>  
>  	msg1.maxchanneltime.data = 250;
> @@ -359,15 +358,15 @@ static int prism2_scan(struct wiphy *wiphy,
>  		freq = ieee80211_channel_to_frequency(msg2.dschannel.data,
>  						      NL80211_BAND_2GHZ);
>  		bss = cfg80211_inform_bss(wiphy,
> -			ieee80211_get_channel(wiphy, freq),
> -			CFG80211_BSS_FTYPE_UNKNOWN,
> -			(const u8 *)&msg2.bssid.data.data,
> -			msg2.timestamp.data, msg2.capinfo.data,
> -			msg2.beaconperiod.data,
> -			ie_buf,
> -			ie_len,
> -			(msg2.signal.data - 65536) * 100, /* Conversion to signed type */
> -			GFP_KERNEL
> +					  ieee80211_get_channel(wiphy, freq),
> +					  CFG80211_BSS_FTYPE_UNKNOWN,
> +					  (const u8 *)&msg2.bssid.data.data,
> +					  msg2.timestamp.data, msg2.capinfo.data,
> +					  msg2.beaconperiod.data,
> +					  ie_buf,
> +					  ie_len,
> +					  (msg2.signal.data - 65536) * 100, /* Conversion to signed type */
> +					  GFP_KERNEL
>  		);

Why is this final ); way over here?

>  
>  		if (!bss) {
> @@ -475,14 +474,13 @@ static int prism2_connect(struct wiphy *wiphy, struct net_device *dev,
>  			}
>  
>  			result = prism2_domibset_uint32(wlandev,
> -				DIDMIB_DOT11SMT_PRIVACYTABLE_WEPDEFAULTKEYID,
> -				sme->key_idx);
> +							DIDMIB_DOT11SMT_PRIVACYTABLE_WEPDEFAULTKEYID,
> +							sme->key_idx);
>  			if (result)
>  				goto exit;
>  
>  			/* send key to driver */
> -			did = didmib_dot11smt_wepdefaultkeystable_key(
> -					sme->key_idx + 1);
> +			did = didmib_dot11smt_wepdefaultkeystable_key(sme->key_idx + 1);

Too long of a line.

Remember, checkpatch is just a "hint", you still have to use your brain
when looking at the output of it.

thanks,

greg k-h
