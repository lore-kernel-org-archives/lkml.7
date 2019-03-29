Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639F4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298452184C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lQTnqh2C";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="B1QLulfN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbfC2VQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 17:16:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44438 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729771AbfC2VQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 17:16:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 373976086B; Fri, 29 Mar 2019 21:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553894212;
        bh=PeVNvSa/zFZBVE+tnAMI+pinhEjuh5cPupFR6firyiM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lQTnqh2CeICilH5nFgMX36WtR9q2ppN+hMsRWYn1yixzM6s3c8mEs0qxCRJddOpep
         4UdFfxqctWlBPbTYpB4bfjrZL0n60mydN55EtDsUivHO1M79S5mqUGySgEdKWJvXw0
         et90T8AGyBYF9nAx9azLaVwsuRGv3RcmfaRd1a30=
Received: from [10.79.168.116] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 76CDE60D35;
        Fri, 29 Mar 2019 21:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553894210;
        bh=PeVNvSa/zFZBVE+tnAMI+pinhEjuh5cPupFR6firyiM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=B1QLulfN1myscO55CRMUVjwCt5aJIZCvB+sqzeKsuqs6cWpXjhyqOznnX+tZyv5B9
         Mi9SF68SLOIda0kv9l2GP9sInoCHnAru53GCwR5FNVkgEbRJ8EuTW5NYybt/sg2Od+
         8NL0bBRB2Zble7h7SK0bEwQOXK3Iuru3+A6yFaac=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 76CDE60D35
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] staging: rtl8723bs: core: fix line over 80 characters
 warning
To:     Anirudh Rayabharam <anirudh.rayabharam@gmail.com>,
        gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        hadess@hadess.net, hdegoede@redhat.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20190326182309.GA33380@auvm>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <0ffd4bc1-bdc2-7e11-3309-ff6e7d3c206b@codeaurora.org>
Date:   Sat, 30 Mar 2019 02:46:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190326182309.GA33380@auvm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/26/2019 11:55 PM, Anirudh Rayabharam wrote:
> Shorten the expression by re-using the part that was already computed to
> fix the line over 80 characters warning reported by checkpatch.pl.
>
> Signed-off-by: Anirudh Rayabharam <anirudh.rayabharam@gmail.com>
> ---
>   drivers/staging/rtl8723bs/core/rtw_ap.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
> index 18fabf5ff44b..bc0230672457 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ap.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
> @@ -2336,8 +2336,8 @@ void rtw_ap_restore_network(struct adapter *padapter)
>   			Update_RA_Entry(padapter, psta);
>   			/* pairwise key */
>   			/* per sta pairwise key and settings */
> -			if ((padapter->securitypriv.dot11PrivacyAlgrthm == _TKIP_) ||
> -				(padapter->securitypriv.dot11PrivacyAlgrthm == _AES_)) {
> +			if ((psecuritypriv->dot11PrivacyAlgrthm == _TKIP_) ||
> +				(psecuritypriv->dot11PrivacyAlgrthm == _AES_)) {
>   				rtw_setstakey_cmd(padapter, psta, true, false);
>   			}


Get rid of this {}.fix this .

Now patch looks good after Dan comment.
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

>   		}
