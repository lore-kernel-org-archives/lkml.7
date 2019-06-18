Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F973C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2FE220673
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560841224;
	bh=zyoTbA/X8DjK3gQ0rzJxs92dPQZZnv6PtxgiKe9KUbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gXMRBdBaYefZpUVcHEBQ35AZODeO9uw4SjGb4RWYpATVNlDTmR0zKi8NceFYMJfGv
	 zMqP6X96HpdoQEYWb/GqvCSPFG3ymBoAvZ//SJNqr4qD6eb+hC2febPrI0hlx5Gye8
	 3ARhN4n+QdFIYR+QsxgUGRnZHhNbvfQClIDzc2UE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfFRHAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:00:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfFRHAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:00:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEB1B20665;
        Tue, 18 Jun 2019 07:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560841221;
        bh=zyoTbA/X8DjK3gQ0rzJxs92dPQZZnv6PtxgiKe9KUbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UMqfrvGmoZKS6fDsGggwuNfWr0M4aOYHDvAEomPqWZK5kBsXiByGfxwWulvle/eGL
         3LajHF7zPGnjoHdAURTpA3CkD7zeNLMjXhLy8BqsaD6Wc6FjS6D/GvkM5OK9eD003v
         xIr81+VyroIKqPGMUuUJCVv7+hRFJ7xaWonj4rGc=
Date:   Tue, 18 Jun 2019 09:00:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Shobhit Kukreti <shobhitkukreti@gmail.com>
Cc:     Joe Perches <joe@perches.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Bastien Nocera <hadess@hadess.net>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH v3 1/3] staging: rtl8723bs: Resolve checkpatch error
 "that open brace { should be on the previous line" in the rtl8723 driver
Message-ID: <20190618070019.GA20601@kroah.com>
References: <cover.1560701271.git.shobhitkukreti@gmail.com>
 <387734fb053e04eb44a0813ab3531a1f4344fdb2.1560701271.git.shobhitkukreti@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <387734fb053e04eb44a0813ab3531a1f4344fdb2.1560701271.git.shobhitkukreti@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 16, 2019 at 09:19:49AM -0700, Shobhit Kukreti wrote:
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
>  drivers/staging/rtl8723bs/os_dep/mlme_linux.c     | 15 +++--
>  drivers/staging/rtl8723bs/os_dep/recv_linux.c     | 77 ++++++++---------------
>  drivers/staging/rtl8723bs/os_dep/rtw_proc.c       |  6 +-
>  drivers/staging/rtl8723bs/os_dep/sdio_intf.c      | 15 ++---
>  drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c | 24 +++----
>  5 files changed, 49 insertions(+), 88 deletions(-)
> 
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
> @@ -77,8 +76,8 @@ void rtw_reset_securitypriv(struct adapter *adapter)
>  
>  	spin_lock_bh(&adapter->security_key_mutex);
>  
> -	if (adapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X)/* 802.1x */
> -	{
> +	if (adapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) { /* 802.1x */
> +

Why the blank line?

And don't keep the comment on the right side, that's just a pain to work
with.

thanks,

greg k-h
