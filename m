Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CA7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C5A218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553876013;
	bh=5+ek2XNJjdFVsNWvRwzEpu4rOH5046vZu/j6lBPB1hU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ksRlEYyR/HVw3MX4rRC5MZGeUWLYqhDV5LxQTpu4YK06fiFS90X30YKWiuDih4CvY
	 YkmiNrzhN/Tdh7/B7MaevuCdqgWNldYEQFenowjecaamwImtzdP9UQ7EBAJFG3DP/E
	 LKLLidmmyPdwhoT8cvqhjqIgVhQslPHHHDf/3erw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbfC2QNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:13:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:58432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728980AbfC2QNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 12:13:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C8C42070B;
        Fri, 29 Mar 2019 16:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553876011;
        bh=5+ek2XNJjdFVsNWvRwzEpu4rOH5046vZu/j6lBPB1hU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FwLk+DkavixdVeb/vT9YNPOQNRp25UhIUUQ0Lzt1S7fL8BhW1HyYZVBSla9zhcHfj
         k+QiN/ENhUH0rd2tbaerzO9l4yayw1Aj+n43dJTdmuhnYeb1VOsgWS6RRqklogpz6j
         be3956fjCbNUMw19upUNp/4acnxoPh/TAFLFHjP4=
Date:   Fri, 29 Mar 2019 17:13:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Anirudh Rayabharam <anirudh.rayabharam@gmail.com>
Cc:     hadess@hadess.net, hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        dan.carpenter@oracle.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8723bs: core: fix line over 80 characters
 warning
Message-ID: <20190329161328.GA540@kroah.com>
References: <20190326182309.GA33380@auvm>
 <20190327181836.GA37876@auvm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327181836.GA37876@auvm>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 11:49:07PM +0530, Anirudh Rayabharam wrote:
> Checkpatch.pl complains that these lines are over 80 characters. Use the
> "psecuritypriv" pointer for consistency, remove unnecessary parantheses
> and fix the alignment.
> 
> This patch just cleans up a condition, it doesn't affect runtime.
> 
> Signed-off-by: Anirudh Rayabharam <anirudh.rayabharam@gmail.com>
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v2: Made the commit message clearer, removed unnecessary parantheses and fixed
>     the alignment as suggested by Dan Carpenter <dan.carpenter@oracle.com>
> 
>  drivers/staging/rtl8723bs/core/rtw_ap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
> index 18fabf5ff44b..8062b7f36de2 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ap.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
> @@ -2336,8 +2336,8 @@ void rtw_ap_restore_network(struct adapter *padapter)
>  			Update_RA_Entry(padapter, psta);
>  			/* pairwise key */
>  			/* per sta pairwise key and settings */
> -			if ((padapter->securitypriv.dot11PrivacyAlgrthm == _TKIP_) ||
> -				(padapter->securitypriv.dot11PrivacyAlgrthm == _AES_)) {
> +			if (psecuritypriv->dot11PrivacyAlgrthm == _TKIP_ ||
> +			    psecuritypriv->dot11PrivacyAlgrthm == _AES_) {
>  				rtw_setstakey_cmd(padapter, psta, true, false);
>  			}
>  		}

Patch does not apply to my staging-next branch :(

Please rebase and resend.

thanks,

greg k-h
