Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B3AC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA1627FE6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559567203;
	bh=u/EU9dtGqWBptP124xbcl8Ga7MudpimrUE9Y+1d6JO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mIcs/kaYrFLTgnlze9njct47mUavEVdzdMc4+DEYnMBZsKWu0PAL9N92taztHbfyf
	 OkAblEvGM2XckSLX9wS/E0F0YgqSRtholicLKyRE9hI9ZAdx2I2IL1+FkIn+TbUSd/
	 qjO/Hb8iQc5rsfc05t9wMr+IUO+QJG4bIGzKVAeg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbfFCNGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:06:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbfFCNGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:06:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BE2627FD9;
        Mon,  3 Jun 2019 13:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559567199;
        bh=u/EU9dtGqWBptP124xbcl8Ga7MudpimrUE9Y+1d6JO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dj9/2BsPf9OJ/Ci9oJOwpWI84f9QDsmruXpzTpeanJEz2z2zpk3RzGvEqyDEkxAx8
         sXZ2JQoyqaJxHFOBStI9YLXGLw974a/3ZV1/k8kRJFCT6g5H31tK222Q+g4Zs/3LKE
         wr/9FDeU60B7MxYw56fTLj+G8kMhn3b7euDVGDOw=
Date:   Mon, 3 Jun 2019 15:06:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian =?iso-8859-1?Q?M=FCller?= <muellerch-privat@web.de>
Cc:     devel@driverdev.osuosl.org, felix.trommer@hotmail.de,
        linux-kernel@i4.cs.fau.de, linux-kernel@vger.kernel.org,
        johnfwhitmore@gmail.com
Subject: Re: [PATCH 2/3] drivers/staging/rtl8192u: Remove comment-out code
Message-ID: <20190603130637.GC30732@kroah.com>
References: <20190603122104.2564-1-muellerch-privat@web.de>
 <20190603122104.2564-3-muellerch-privat@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190603122104.2564-3-muellerch-privat@web.de>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 02:21:03PM +0200, Christian Müller wrote:
> From: Felix Trommer <felix.trommer@hotmail.de>
> 
> Remove the majority of all commented-out code. Commented out code, that
> was adressed by a comment itself is not removed. The code that we left
> in as comments was mostly due to the "pseudo-code"-like nature of the
> code that helped to clarify certain functionalities.
> 
> Signed-off-by: Felix Trommer <felix.trommer@hotmail.de>
> Signed-off-by: Christian Müller <muellerch-privat@web.de>
> ---
>  drivers/staging/rtl8192u/ieee80211/dot11d.h   |  2 +-
>  .../staging/rtl8192u/ieee80211/ieee80211.h    | 35 ++-----
>  .../rtl8192u/ieee80211/ieee80211_crypt_ccmp.c |  1 -
>  .../rtl8192u/ieee80211/ieee80211_crypt_tkip.c |  1 -
>  .../rtl8192u/ieee80211/ieee80211_module.c     |  2 -
>  .../staging/rtl8192u/ieee80211/ieee80211_rx.c | 50 +---------
>  .../rtl8192u/ieee80211/ieee80211_softmac.c    | 93 +++----------------
>  .../rtl8192u/ieee80211/ieee80211_softmac_wx.c | 13 +--
>  .../staging/rtl8192u/ieee80211/ieee80211_tx.c |  3 +-
>  .../staging/rtl8192u/ieee80211/ieee80211_wx.c | 19 +---
>  .../rtl8192u/ieee80211/rtl819x_BAProc.c       |  3 -
>  .../staging/rtl8192u/ieee80211/rtl819x_HT.h   |  2 -
>  .../rtl8192u/ieee80211/rtl819x_HTProc.c       | 54 ++---------
>  .../staging/rtl8192u/ieee80211/rtl819x_Qos.h  |  4 +-
>  .../rtl8192u/ieee80211/rtl819x_TSProc.c       | 11 ---
>  drivers/staging/rtl8192u/r8190_rtl8256.c      |  3 -
>  drivers/staging/rtl8192u/r8192U_core.c        |  5 +-
>  drivers/staging/rtl8192u/r8192U_dm.c          | 60 ------------
>  drivers/staging/rtl8192u/r8192U_wx.c          |  2 -
>  drivers/staging/rtl8192u/r819xU_firmware.c    |  1 -
>  20 files changed, 38 insertions(+), 326 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
> index 8b485fa18089..f27267307b3f 100644
> --- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
> +++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
> @@ -54,4 +54,4 @@ void dot11d_scan_complete(struct ieee80211_device *dev);
>  int is_legal_channel(struct ieee80211_device *dev, u8 channel);
>  int to_legal_channel(struct ieee80211_device *dev, u8 channel);
> 
> -#endif /* #ifndef __INC_DOT11D_H */
> +#endif

This type of comment is there for a good reason :(


> diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
> index 8be8a94a2253..d110e9333799 100644
> --- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
> +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
> @@ -106,17 +106,13 @@ struct cb_desc {
>  	u8 bRTSUseShortGI:1;
>  	u8 bMulticast:1;
>  	u8 bBroadcast:1;
> -	/* u8 reserved2:2; */
>  	u8 drv_agg_enable:1;
>  	u8 reserved2:1;
> 
>  	/* Tx Desc related element(12-19) */
>  	u8 rata_index;
>  	u8 queue_index;
> -	/* u8 reserved3; */
> -	/* u8 reserved4; */
>  	u16 txbuf_size;
> -	/* u8 reserved5; */
>  	u8 RATRIndex;
>  	u8 reserved6;
>  	u8 reserved7;
> @@ -127,9 +123,6 @@ struct cb_desc {
>  	u8 rts_rate;
>  	u8 ampdu_factor;
>  	u8 ampdu_density;
> -	/* u8 reserved9; */
> -	/* u8 reserved10; */
> -	/* u8 reserved11; */
>  	u8 DrvAggrNum;
>  	u16 pkt_size;
>  	u8 reserved12;
> @@ -883,7 +876,8 @@ enum ieee80211_mfie {
>  	MFIE_TYPE_QOS_PARAMETER = 222,
>  };
> 
> -/* Minimal header; can be used for passing 802.11 frames with sufficient
> +/*
> + * Minimal header; can be used for passing 802.11 frames with sufficient
>   * information to determine what type of underlying data type is actually
>   * stored in the data.
>   */

That change is not removing commented out code :(

Please be a lot more careful as to what you are doing in a patch when
you submit it...

> @@ -1144,7 +1138,6 @@ struct ieee80211_tim_parameters {
>  	u8 tim_period;
>  } __packed;
> 
> -//#else
>  struct ieee80211_wmm_ts_info {
>  	u8 ac_dir_tid;
>  	u8 ac_up_psb;
> @@ -1274,7 +1267,6 @@ enum {WMM_all_frame, WMM_two_frame, WMM_four_frame, WMM_six_frame};
>  #define IEEE80211_PS_MBCAST IEEE80211_DTIM_MBCAST
> 
>  /* added by David for QoS 2006/6/30 */
> -//#define WMM_Hang_8187
>  #ifdef WMM_Hang_8187
>  #undef WMM_Hang_8187
>  #endif

Are you sure you should remove this commented out line?

thanks,

greg k-h
