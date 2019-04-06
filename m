Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C5DC10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 08:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF6B2173C
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 08:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="D4iglZjA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hRDeuI2I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfDFI1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 04:27:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56180 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfDFI1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 04:27:44 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 94F12609F3; Sat,  6 Apr 2019 08:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554539263;
        bh=GgrpZJfu9S102z1Kmxc+6GRMlu4aQuWZwymrsxzsJXw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=D4iglZjAeT3hJcy4WTsEyCQiMvNm6mZq7N72iCP0ffGIj69MEW2Pktb82wTnHuhcv
         THsKhXWWxz6dXEtBcLh2PjOaT6kuZR7+m3aFBNy5+28G99bqXQTvlWmZgDbas0+66c
         MHqQEecZY/IkT1Yg31RfvSR77QMXmQcuIE9j5em8=
Received: from [10.79.167.84] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F3C846083E;
        Sat,  6 Apr 2019 08:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554539262;
        bh=GgrpZJfu9S102z1Kmxc+6GRMlu4aQuWZwymrsxzsJXw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hRDeuI2IHFQaPI+Ldl+zCVzxUDJIry+rer+uOJi0RcqtOn7vfya66FoTpmyex+7/X
         c4q81ecY6DF9n7qfPMX74Gtwl+klQN2+zGKKXAWYbFiz/T/hmxqxzwtlb2069yc5pm
         WCDfeYWlZgQUJU8/1BrpSc6aC4rGS5UoGLsHJAYY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F3C846083E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH -next] staging: rtlwifi: base: Remove set but not used
 variables
To:     YueHaibing <yuehaibing@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>,
        Sohil Ladhani <supertakumi86@gmail.com>,
        Cristian Sicilia <sicilia.cristian@gmail.com>,
        Luke Triantafyllidis <ltriant@cpan.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Luca Coelho <luciano.coelho@intel.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20190406031225.60088-1-yuehaibing@huawei.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <3180555a-a87a-0e39-3343-154a256bd530@codeaurora.org>
Date:   Sat, 6 Apr 2019 13:57:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190406031225.60088-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/6/2019 8:42 AM, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/staging/rtlwifi/base.c: In function 'rtl_tx_agg_stop':
> drivers/staging/rtlwifi/base.c:1733:23: warning:
>   variable 'tid_data' set but not used [-Wunused-but-set-variable]
>
> drivers/staging/rtlwifi/base.c: In function 'rtl_check_beacon_key':
> drivers/staging/rtlwifi/base.c:2474:5: warning:
>   variable 'ds_param_len' set but not used [-Wunused-but-set-variable]
>
> drivers/staging/rtlwifi/base.c:2472:5: warning:
>   variable 'ht_oper_len' set but not used [-Wunused-but-set-variable]
>
> drivers/staging/rtlwifi/base.c:2470:5: warning:
>   variable 'ht_cap_len' set but not used [-Wunused-but-set-variable]
>
> They are never used and can be removed.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/staging/rtlwifi/base.c | 18 ++++--------------
>   1 file changed, 4 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/staging/rtlwifi/base.c b/drivers/staging/rtlwifi/base.c
> index b8358ebbf912..b8b89e4c54d4 100644
> --- a/drivers/staging/rtlwifi/base.c
> +++ b/drivers/staging/rtlwifi/base.c
> @@ -1730,7 +1730,6 @@ int rtl_tx_agg_stop(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>   		    struct ieee80211_sta *sta, u16 tid)
>   {
>   	struct rtl_priv *rtlpriv = rtl_priv(hw);
> -	struct rtl_tid_data *tid_data;
>   	struct rtl_sta_info *sta_entry = NULL;
>   
>   	if (!sta)
> @@ -1743,7 +1742,6 @@ int rtl_tx_agg_stop(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>   		return -EINVAL;
>   
>   	sta_entry = (struct rtl_sta_info *)sta->drv_priv;
> -	tid_data = &sta_entry->tids[tid];
>   	sta_entry->tids[tid].agg.agg_state = RTL_AGG_STOP;
>   
>   	ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
> @@ -2467,11 +2465,8 @@ bool rtl_check_beacon_key(struct ieee80211_hw *hw, void *data, unsigned int len)
>   	struct rtl_beacon_keys bcn_key = {};
>   	struct rtl_beacon_keys *cur_bcn_key;
>   	u8 *ht_cap;
> -	u8 ht_cap_len;
>   	u8 *ht_oper;
> -	u8 ht_oper_len;
>   	u8 *ds_param;
> -	u8 ds_param_len;
>   
>   	if (mac->opmode != NL80211_IFTYPE_STATION)
>   		return false;
> @@ -2502,18 +2497,15 @@ bool rtl_check_beacon_key(struct ieee80211_hw *hw, void *data, unsigned int len)
>   	/***** Parsing DS Param IE ******/
>   	ds_param = rtl_find_ie(data, len - FCS_LEN, WLAN_EID_DS_PARAMS);
>   
> -	if (ds_param && !(ds_param[1] < sizeof(*ds_param))) {
> -		ds_param_len = ds_param[1];
> +	if (ds_param && !(ds_param[1] < sizeof(*ds_param)))
>   		bcn_key.bcn_channel = ds_param[2];
> -	} else {
> +	else
>   		ds_param = NULL;
> -	}
>   
>   	/***** Parsing HT Cap. IE ******/
>   	ht_cap = rtl_find_ie(data, len - FCS_LEN, WLAN_EID_HT_CAPABILITY);
>   
>   	if (ht_cap && !(ht_cap[1] < sizeof(*ht_cap))) {
> -		ht_cap_len = ht_cap[1];
>   		ht_cap_ie = (struct ieee80211_ht_cap *)&ht_cap[2];
>   		bcn_key.ht_cap_info = ht_cap_ie->cap_info;
>   	} else  {
> @@ -2523,12 +2515,10 @@ bool rtl_check_beacon_key(struct ieee80211_hw *hw, void *data, unsigned int len)
>   	/***** Parsing HT Info. IE ******/
>   	ht_oper = rtl_find_ie(data, len - FCS_LEN, WLAN_EID_HT_OPERATION);
>   
> -	if (ht_oper && !(ht_oper[1] < sizeof(*ht_oper))) {
> -		ht_oper_len = ht_oper[1];
> +	if (ht_oper && !(ht_oper[1] < sizeof(*ht_oper)))
>   		ht_oper_ie = (struct ieee80211_ht_operation *)&ht_oper[2];
> -	} else {
> +	else
>   		ht_oper = NULL;
> -	}
>   
>   	/* update bcn_key */
>   
>
>
>
>
>
