Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F42CC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 721E4204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558342633;
	bh=sqBRBNYx88jBR4CAFDwy0bVCEpQ/bWh2PM+rtQzV+Uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nxE4T+P3jmYiBZr0Tb8iBlMVeqxCXK7nNWjpYN4SVZZu+dbOHRGRKN6LLZKRhp8TQ
	 +UmRK73Ry6yAtuBsUjIH8r/jQ2Dn/2ewMy5sHfDvzMMoINbMghDtZZ9XyRE3DrP6qD
	 FqgFzVLhJiL7/ltYZBVz3981tC0QhmxUmalNp7r0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731706AbfETI5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:57:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:58256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfETI5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:57:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9A56204FD;
        Mon, 20 May 2019 08:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558342631;
        bh=sqBRBNYx88jBR4CAFDwy0bVCEpQ/bWh2PM+rtQzV+Uo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kBghcluu904iLZDgDasB1qWGsD1n65j6ly4K7EwC5tyFIyy9xsPyVKKMgaRPTbANg
         u0OP6z70K/Dh/64Rdj4KSaIr3Rno1yrKWcaa3CjB8tG0sXsz74M0usmQVngvW68VRb
         ghI/2JiwB78f+zmRVRji3Fnpx619EVvlYF81WW0A=
Date:   Mon, 20 May 2019 10:57:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v2] staging: rtl8723bs: hal: odm_HWConfig: odm_HWConfig:
 Unneeded variable: "result". Return "HAL_STATUS_SUCCESS"
Message-ID: <20190520085709.GE19183@kroah.com>
References: <20190519172723.GA9329@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190519172723.GA9329@hari-Inspiron-1545>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 19, 2019 at 10:57:24PM +0530, Hariprasad Kelam wrote:
> This patch fixes below warnings reported by coccicheck
> 
> drivers/staging/rtl8723bs/hal/odm_HWConfig.c:501:4-10: Unneeded
> variable: "result". Return "HAL_STATUS_SUCCESS" on line 526
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> -----
> Changes in v2:
>   - fixed typo in commit message
> ---
> 
> ---
>  drivers/staging/rtl8723bs/hal/odm_HWConfig.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/odm_HWConfig.c b/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
> index d802a1f..4711c65 100644
> --- a/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
> +++ b/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
> @@ -498,8 +498,6 @@ HAL_STATUS ODM_ConfigBBWithHeaderFile(
>  
>  HAL_STATUS ODM_ConfigMACWithHeaderFile(PDM_ODM_T pDM_Odm)
>  {
> -	u8 result = HAL_STATUS_SUCCESS;
> -
>  	ODM_RT_TRACE(
>  		pDM_Odm,
>  		ODM_COMP_INIT,
> @@ -523,5 +521,5 @@ HAL_STATUS ODM_ConfigMACWithHeaderFile(PDM_ODM_T pDM_Odm)
>  
>  	READ_AND_CONFIG(8723B, _MAC_REG);
>  
> -	return result;
> +	return HAL_STATUS_SUCCESS;
>  }

This whole function should really be reduced to just one line (the trace
stuff is not needed), and as this can not fail, it should not be
returning a value.

And if it can be one line, then why is it a function at all?  It's only
called in one place.

thanks,

greg k-h
