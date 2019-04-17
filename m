Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C973C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB2620835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ijZUv4zT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Gi7ktCFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732068AbfDQMdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 08:33:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45860 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfDQMdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 08:33:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 81F35602CC; Wed, 17 Apr 2019 12:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555504383;
        bh=P4yN35O+BeiqqWhgLg31H/I83eI5MtmWYgn/j7Y4MIs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ijZUv4zTL7WgfbPLanrmThI8hTJ0zQ/KJx1fIK4ZwtN+vSnir2RQ508LX4z3YDGmj
         IWDkaH4P25mEHhEe1KJaLGuO+IYNWWM33IPZngGXbsXPs0RG5Nt/rF0Ob8ZJZnvRrd
         STHfZNDUXh74cx14NkYLSwiSlWVSLVhWjNgOsiGs=
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 356BF602CC;
        Wed, 17 Apr 2019 12:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555504382;
        bh=P4yN35O+BeiqqWhgLg31H/I83eI5MtmWYgn/j7Y4MIs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Gi7ktCFMsL7VECLXsTsvlcMLjYQ+O29wNF842/eKyIVGN5uRIPl+yt42fy3xwabOv
         PuK9yDYoo4eM5V+X0mSX8smrB7b3mhNTPlNLrgxaUD8t3HxE/H+4V45ZGxZop3DQsR
         8JD2sGKDAB5WLk5p81+XKFjJcEOgsCg3s0Pt3kpk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 356BF602CC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] staging: rtlwifi: fix spelling mistake "notity" ->
 "notify"
To:     Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190417120822.21771-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <f2337966-4842-f362-8bbc-228ab2572936@codeaurora.org>
Date:   Wed, 17 Apr 2019 18:02:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417120822.21771-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/17/2019 5:38 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There are two spelling mistake in RT_TRACE messages. Fix them.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   drivers/staging/rtlwifi/btcoexist/halbtc8822b1ant.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/rtlwifi/btcoexist/halbtc8822b1ant.c b/drivers/staging/rtlwifi/btcoexist/halbtc8822b1ant.c
> index ade271cb4aab..32c797430512 100644
> --- a/drivers/staging/rtlwifi/btcoexist/halbtc8822b1ant.c
> +++ b/drivers/staging/rtlwifi/btcoexist/halbtc8822b1ant.c
> @@ -4730,7 +4730,7 @@ void ex_btc8822b1ant_media_status_notify(struct btc_coexist *btcoexist, u8 type)
>   		if (wifi_under_b_mode) {
>   			RT_TRACE(
>   				rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
> -				"[BTCoex], ********** (media status notity under b mode) **********\n");
> +				"[BTCoex], ********** (media status notify under b mode) **********\n");
>   			btcoexist->btc_write_1byte(btcoexist, 0x6cd,
>   						   0x00); /* CCK Tx */
>   			btcoexist->btc_write_1byte(btcoexist, 0x6cf,
> @@ -4738,7 +4738,7 @@ void ex_btc8822b1ant_media_status_notify(struct btc_coexist *btcoexist, u8 type)
>   		} else {
>   			RT_TRACE(
>   				rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
> -				"[BTCoex], ********** (media status notity not under b mode) **********\n");
> +				"[BTCoex], ********** (media status notify not under b mode) **********\n");
>   			btcoexist->btc_write_1byte(btcoexist, 0x6cd,
>   						   0x00); /* CCK Tx */
>   			btcoexist->btc_write_1byte(btcoexist, 0x6cf,
