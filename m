Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E211AC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D0B2183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FtjjKXI7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="C8yzkkKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388972AbfDRMn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:43:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36550 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfDRMn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:43:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8DF8E617A3; Thu, 18 Apr 2019 12:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555591434;
        bh=n4bmuBYSKa/SbOKNkNvYNIF60Lhb0c8waP1a7hUy2vw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FtjjKXI7fEWNRY4D1MjJ3QcnaaJG1Fzi6SBWq5bF8IjeKBSIhVOUaadpxvjAcL2uj
         9HY/kLH9ALck0TfpZJdY8S0fFTCwfLjcBJ1GPXdTICZ8FZftusqU4eM70gXGUzzACY
         XwsVXU1KbwpvFiAcXe7Zm+npinyXUO1pleYNw8E8=
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 580F360721;
        Thu, 18 Apr 2019 12:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555591431;
        bh=n4bmuBYSKa/SbOKNkNvYNIF60Lhb0c8waP1a7hUy2vw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=C8yzkkKrjRUNfxgst4I/G5M3Nf+3m6ZuhbmdJZPhzWNzsaIkGL7RBD782gVklvVeg
         dV6AVOhppe+ApOOHqMySx8y425jzvdSYHCObg7C13vk02idbAIIYvvKf69GpB3opIA
         wts4MD4J8Lfsa7UKFeCwwEDBfz7BNVGbq38D7za0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 580F360721
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] staging: rtl8723bs: hal: fix spelling mistake "singal" ->
 "signal"
To:     Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190418122041.12896-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <b2cca452-fc4c-00c6-966b-2cdbf25fa2d5@codeaurora.org>
Date:   Thu, 18 Apr 2019 18:13:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418122041.12896-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/18/2019 5:50 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There are multiple spelling mistakes in variable names, fix these.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>


Well, this one a bit sensitive to touch.
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/staging/rtl8723bs/hal/hal_com.c      | 18 +++++++++---------
>   drivers/staging/rtl8723bs/include/rtw_recv.h |  4 ++--
>   2 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
> index f1c91483ca07..e5f1153527b9 100644
> --- a/drivers/staging/rtl8723bs/hal/hal_com.c
> +++ b/drivers/staging/rtl8723bs/hal/hal_com.c
> @@ -1618,14 +1618,14 @@ void rtw_get_raw_rssi_info(void *sel, struct adapter *padapter)
>   	isCCKrate = psample_pkt_rssi->data_rate <= DESC_RATE11M;
>   
>   	if (isCCKrate)
> -		psample_pkt_rssi->mimo_singal_strength[0] = psample_pkt_rssi->pwdball;
> +		psample_pkt_rssi->mimo_signal_strength[0] = psample_pkt_rssi->pwdball;
>   
>   	for (rf_path = 0; rf_path < pHalData->NumTotalRFPath; rf_path++) {
>   		DBG_871X_SEL_NL(
>   			sel,
> -			"RF_PATH_%d =>singal_strength:%d(%%), singal_quality:%d(%%)\n",
> -			rf_path, psample_pkt_rssi->mimo_singal_strength[rf_path],
> -			psample_pkt_rssi->mimo_singal_quality[rf_path]
> +			"RF_PATH_%d =>signal_strength:%d(%%), signal_quality:%d(%%)\n",
> +			rf_path, psample_pkt_rssi->mimo_signal_strength[rf_path],
> +			psample_pkt_rssi->mimo_signal_quality[rf_path]
>   		);
>   
>   		if (!isCCKrate) {
> @@ -1651,11 +1651,11 @@ void rtw_dump_raw_rssi_info(struct adapter *padapter)
>   	isCCKrate = psample_pkt_rssi->data_rate <= DESC_RATE11M;
>   
>   	if (isCCKrate)
> -		psample_pkt_rssi->mimo_singal_strength[0] = psample_pkt_rssi->pwdball;
> +		psample_pkt_rssi->mimo_signal_strength[0] = psample_pkt_rssi->pwdball;
>   
>   	for (rf_path = 0; rf_path < pHalData->NumTotalRFPath; rf_path++) {
> -		DBG_871X("RF_PATH_%d =>singal_strength:%d(%%), singal_quality:%d(%%)"
> -			, rf_path, psample_pkt_rssi->mimo_singal_strength[rf_path], psample_pkt_rssi->mimo_singal_quality[rf_path]);
> +		DBG_871X("RF_PATH_%d =>signal_strength:%d(%%), signal_quality:%d(%%)"
> +			, rf_path, psample_pkt_rssi->mimo_signal_strength[rf_path], psample_pkt_rssi->mimo_signal_quality[rf_path]);
>   
>   		if (!isCCKrate) {
>   			printk(", rx_ofdm_pwr:%d(dBm), rx_ofdm_snr:%d(dB)\n",
> @@ -1682,8 +1682,8 @@ void rtw_store_phy_info(struct adapter *padapter, union recv_frame *prframe)
>   	psample_pkt_rssi->pwr_all = pPhyInfo->recv_signal_power;
>   
>   	for (rf_path = 0; rf_path < pHalData->NumTotalRFPath; rf_path++) {
> -		psample_pkt_rssi->mimo_singal_strength[rf_path] = pPhyInfo->rx_mimo_signal_strength[rf_path];
> -		psample_pkt_rssi->mimo_singal_quality[rf_path] = pPhyInfo->rx_mimo_signal_quality[rf_path];
> +		psample_pkt_rssi->mimo_signal_strength[rf_path] = pPhyInfo->rx_mimo_signal_strength[rf_path];
> +		psample_pkt_rssi->mimo_signal_quality[rf_path] = pPhyInfo->rx_mimo_signal_quality[rf_path];
>   		if (!isCCKrate) {
>   			psample_pkt_rssi->ofdm_pwr[rf_path] = pPhyInfo->RxPwr[rf_path];
>   			psample_pkt_rssi->ofdm_snr[rf_path] = pPhyInfo->RxSNR[rf_path];
> diff --git a/drivers/staging/rtl8723bs/include/rtw_recv.h b/drivers/staging/rtl8723bs/include/rtw_recv.h
> index 7d54cf211315..5de946e66302 100644
> --- a/drivers/staging/rtl8723bs/include/rtw_recv.h
> +++ b/drivers/staging/rtl8723bs/include/rtw_recv.h
> @@ -120,8 +120,8 @@ struct rx_raw_rssi
>   	u8 pwdball;
>   	s8 pwr_all;
>   
> -	u8 mimo_singal_strength[4];/*  in 0~100 index */
> -	u8 mimo_singal_quality[4];
> +	u8 mimo_signal_strength[4];/*  in 0~100 index */
> +	u8 mimo_signal_quality[4];
>   
>   	s8 ofdm_pwr[4];
>   	u8 ofdm_snr[4];
