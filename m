Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6B1C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF30C20656
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558342544;
	bh=Oee/c2MDV3HNg8hnxn5HjjMAZd7qfmNnxGQ5OCvwopI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0KBsdFnnFKcFldbmkPIA1KMSNWKWz+xkvvikkcaU7e+P3YfGathfwaG6/PIKSZN7w
	 J6X7cAZ5H7cALMtrvG/Uk/z629lMWIerQ2m0rJ6ZwsGfDMjWmSw52SxNFrFexr6m6N
	 sC80VAh6RIqz8xiF/nP0y6JEgHFRiYTfd5sf1JvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731693AbfETIzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:55:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730823AbfETIzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:55:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 482B2204FD;
        Mon, 20 May 2019 08:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558342541;
        bh=Oee/c2MDV3HNg8hnxn5HjjMAZd7qfmNnxGQ5OCvwopI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O5F6SFVQ3q7yTeuTaEgQdA4PTRRLzNIx/A0ruDGhMl2xgHlouZPiVEYr9s/bj2pBJ
         K8LpDTVsB6Y8VQsty+TM43JBqHxZYQJIy5eyIXTY6uVmKUMhT/hjqM1sD0U1KPZFIQ
         HVpTsw4KwlXfaRSlvs9gfk4l9jDIM7BxzKH0pRrg=
Date:   Mon, 20 May 2019 10:55:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Emanuel Bennici <benniciemanuel78@gmail.com>,
        Vatsala Narang <vatsalanarang@gmail.com>,
        Nishka Dasgupta <nishka.dasgupta@yahoo.com>,
        Young Xiao <YangX92@hotmail.com>,
        Aymen Qader <qader.aymen@gmail.com>,
        Henriette Hofmeier <passt@h-hofmeier.de>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: core: rtw_mlme_ext: fix warning
 Unneeded variable: "ret"
Message-ID: <20190520085539.GD19183@kroah.com>
References: <20190519171227.GA8089@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190519171227.GA8089@hari-Inspiron-1545>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 19, 2019 at 10:42:27PM +0530, Hariprasad Kelam wrote:
> This patch fixes below warnings reported by coccicheck
> 
> drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:1888:14-17: Unneeded
> variable: "ret". Return "_FAIL" on line 1920
> drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:466:5-8: Unneeded
> variable: "res". Return "_SUCCESS" on line 494
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> index d110d45..6a2eb66 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> @@ -463,7 +463,6 @@ static u8 init_channel_set(struct adapter *padapter, u8 ChannelPlan, RT_CHANNEL_
>  
>  int	init_mlme_ext_priv(struct adapter *padapter)
>  {
> -	int	res = _SUCCESS;
>  	struct registry_priv *pregistrypriv = &padapter->registrypriv;
>  	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
>  	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
> @@ -491,7 +490,7 @@ int	init_mlme_ext_priv(struct adapter *padapter)
>  	pmlmeext->fixed_chan = 0xFF;
>  #endif
>  
> -	return res;
> +	return _SUCCESS;

If it can never fail, it should not be returning a value :(

