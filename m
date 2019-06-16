Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C25CC31E49
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 08:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B52216FD
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 08:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfFPINQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 04:13:16 -0400
Received: from smtprelay0077.hostedemail.com ([216.40.44.77]:45099 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725865AbfFPINQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 04:13:16 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 43DCC181D3368;
        Sun, 16 Jun 2019 08:13:15 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: print89_735c9b2327048
X-Filterd-Recvd-Size: 2424
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Sun, 16 Jun 2019 08:13:12 +0000 (UTC)
Message-ID: <1d668acbce4cc9759cc940f56016dc9437df5441.camel@perches.com>
Subject: Re: [PATCH v2] staging: rtl8723bs: Resolve checkpatch error "that
 open brace { should be on the previous line" in the rtl8723 driver
From:   Joe Perches <joe@perches.com>
To:     Shobhit Kukreti <shobhitkukreti@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Sun, 16 Jun 2019 01:13:11 -0700
In-Reply-To: <1560634159-9015-1-git-send-email-shobhitkukreti@gmail.com>
References: <20190615185355.GC10201@kroah.com>
         <1560634159-9015-1-git-send-email-shobhitkukreti@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-06-15 at 14:29 -0700, Shobhit Kukreti wrote:
> Cleaned up the code from the following files to get rid of
> check patch error "that open brace { should be on the previous line"

It's fine you are modifying brace styles, but:

> diff --git a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
> index aa2499f..4631b68 100644
> --- a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
> +++ b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
> @@ -46,8 +46,7 @@ void rtw_os_indicate_connect(struct adapter *adapter)
>  	struct mlme_priv *pmlmepriv = &(adapter->mlmepriv);
>  
>  	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true) ||
> -		(check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true))
> -	{
> +		(check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true)) {
>  		rtw_cfg80211_ibss_indicate_connect(adapter);
>  	}
>  	else

the else should be on the same line as the close brace

> @@ -106,8 +105,9 @@ void rtw_reset_securitypriv(struct adapter *adapter)
>  		adapter->securitypriv.ndisencryptstatus = Ndis802_11WEPDisabled;
>  
>  	}
> -	else /* reset values in securitypriv */
> -	{
> +	else {
> +		/* reset values in securitypriv */
> +

and here.  etc.  Please change all instances appropriately.


