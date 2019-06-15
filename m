Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5E5C31E50
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 18:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40BF2184D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 18:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560624841;
	bh=PcNtMWJn1JC5fgNG7jD7XI0Lo4/bd+UCSCuIEWqVjbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wTUcvxKU58bGQD99RbPVjsPw7P8MmEp7kuSvZYS8H1tv//UeOw10JEAlTx0kY0kX4
	 iw2RGmvaMsujh02kEKByfaJZk5fG/Q76NMD9eUsqKV+vVyNW+J7OW4YsigdMzYZZBD
	 IU/NkhH6MFrR7bcJnoft96kksUV91LR5mPHeaG/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfFOSx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 14:53:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:41456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfFOSx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 14:53:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 142E821841;
        Sat, 15 Jun 2019 18:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560624838;
        bh=PcNtMWJn1JC5fgNG7jD7XI0Lo4/bd+UCSCuIEWqVjbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kLaCWFUewcyRCIJaZeKgiA89Ir7na/WTr5gYF7cCS9SsWNUtwBlW3j4vqUBWUcqOX
         iDAQGdG2/INYUg2aQCa7BeIYmBgrVzgL5z27LZdpNdtZQDTsNNx0ugjJBi7n5ivXzP
         dwBQqv9NKcqKQdLuNpKpz8ER6TxXvcPBYXw7wD34=
Date:   Sat, 15 Jun 2019 20:53:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Shobhit Kukreti <shobhitkukreti@gmail.com>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Resolve checkpatch error "that open
 brace { should be on the previous line" in the rtl8723bs driver
Message-ID: <20190615185355.GC10201@kroah.com>
References: <20190614021206.GA895@t-1000>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614021206.GA895@t-1000>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 07:12:10PM -0700, Shobhit Kukreti wrote:
> Cleaned up the code from the following files to get rid of
> check patch error "that open brace { should be on the previous line"
> 
> drivers/staging/rtl8723bs/os_dep/mlme_linux.c
> drivers/staging/rtl8723bs/os_dep/recv_linux.c
> drivers/staging/rtl8723bs/os_dep/rtw_proc.c
> drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
> 
> Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>
> ---
>  drivers/staging/rtl8723bs/os_dep/mlme_linux.c     | 14 ++---
>  drivers/staging/rtl8723bs/os_dep/recv_linux.c     | 76 ++++++++---------------
>  drivers/staging/rtl8723bs/os_dep/rtw_proc.c       |  6 +-
>  drivers/staging/rtl8723bs/os_dep/sdio_intf.c      | 15 ++---
>  drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c | 24 +++----
>  5 files changed, 47 insertions(+), 88 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
> index aa2499f..6799ed4 100644
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
> @@ -77,8 +76,8 @@ void rtw_reset_securitypriv(struct adapter *adapter)
>  
>  	spin_lock_bh(&adapter->security_key_mutex);
>  
> -	if (adapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X)/* 802.1x */
> -	{
> +	if (adapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) { /* 802.1x */
> +
>  		/*  Added by Albert 2009/02/18 */
>  		/*  We have to backup the PMK information for WiFi PMK Caching test item. */
>  		/*  */
> @@ -106,8 +105,8 @@ void rtw_reset_securitypriv(struct adapter *adapter)
>  		adapter->securitypriv.ndisencryptstatus = Ndis802_11WEPDisabled;
>  
>  	}
> -	else /* reset values in securitypriv */
> -	{
> +	else { /* reset values in securitypriv */
> +	

Trailing whitespace?

The comment should be on a new line, not on the same line.

thanks,

greg k-h
