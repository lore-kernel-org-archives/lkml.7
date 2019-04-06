Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98923C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 08:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63BEE21855
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 08:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HLwaGYpj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WXOImq0x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfDFIT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 04:19:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54056 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfDFIT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 04:19:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 311DB609EF; Sat,  6 Apr 2019 08:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554538796;
        bh=eLhcVhGedeKmracodupXv+xR1UNXc4RY3TdGgcMWW3k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HLwaGYpjtdlcWVjayzZBx5qovug0zN4BCApJ5Y2/QlMFww+k29+ISqJQvbYrOo469
         NaY8l2NMmEYQUuFaZEMWiEYUKwhDY4EI+YXi+6s3bT+IQyeNiT32suK4mxW2s2OZ9i
         EA6/eVFlwhHM3XH4jyi0GRwWwV6jfAc/oNSKUM3Q=
Received: from [10.79.167.84] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 306596083E;
        Sat,  6 Apr 2019 08:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554538795;
        bh=eLhcVhGedeKmracodupXv+xR1UNXc4RY3TdGgcMWW3k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WXOImq0xmBXPoEqKGD3VlgePfzI3ZdvkaRS9a5SFrATgUfr0kWxu/5zV9Jwbgi41y
         Aobm/TQqKArOuVYMsGXAo7wgSGoIrPAHq6SlzwrelSGKElUDBo850LTQfx7vaV8YBy
         7ZpGRCqBejdCb6/4vJEpMc4gQraRLvbkOzkjIQE8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 306596083E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH -next] staging: rtlwifi: rtl8822be: Remove set but not
 used variable 'curtxbw_40mhz'
To:     YueHaibing <yuehaibing@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nishka Dasgupta <nishka.dasgupta@yahoo.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20190406031118.59321-1-yuehaibing@huawei.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <44fa9b63-699f-0203-2447-c8217cfbb803@codeaurora.org>
Date:   Sat, 6 Apr 2019 13:49:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190406031118.59321-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/6/2019 8:41 AM, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/staging/rtlwifi/rtl8822be/hw.c: In function 'rtl8822be_update_hal_rate_mask':
> drivers/staging/rtlwifi/rtl8822be/hw.c:2144:5: warning:
>   variable 'curtxbw_40mhz' set but not used [-Wunused-but-set-variable]
>
> It's never used and can be removed.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/staging/rtlwifi/rtl8822be/hw.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/staging/rtlwifi/rtl8822be/hw.c b/drivers/staging/rtlwifi/rtl8822be/hw.c
> index dac22c21f821..1de4e903a4de 100644
> --- a/drivers/staging/rtlwifi/rtl8822be/hw.c
> +++ b/drivers/staging/rtlwifi/rtl8822be/hw.c
> @@ -2141,8 +2141,6 @@ static void rtl8822be_update_hal_rate_mask(struct ieee80211_hw *hw,
>   	u32 ratr_bitmap, ratr_bitmap_msb = 0;
>   	u8 ratr_index;
>   	enum wireless_mode wirelessmode = 0;
> -	u8 curtxbw_40mhz =
> -		(sta->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40) ? 1 : 0;
>   	bool b_shortgi = false;
>   	u8 rate_mask[7];
>   	u8 macid = 0;
> @@ -2153,11 +2151,8 @@ static void rtl8822be_update_hal_rate_mask(struct ieee80211_hw *hw,
>   
>   	RT_TRACE(rtlpriv, COMP_RATR, DBG_LOUD, "wireless mode = 0x%x\n",
>   		 wirelessmode);
> -	if (mac->opmode == NL80211_IFTYPE_STATION ||
> -	    mac->opmode == NL80211_IFTYPE_MESH_POINT) {
> -		curtxbw_40mhz = mac->bw_40;
> -	} else if (mac->opmode == NL80211_IFTYPE_AP ||
> -		   mac->opmode == NL80211_IFTYPE_ADHOC)
> +	if (mac->opmode == NL80211_IFTYPE_AP ||
> +	    mac->opmode == NL80211_IFTYPE_ADHOC)
>   		macid = sta->aid + 1;
>   	if (wirelessmode == WIRELESS_MODE_N_5G ||
>   	    wirelessmode == WIRELESS_MODE_AC_5G ||
>
>
>
>
>
