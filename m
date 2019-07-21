Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BAFC76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 09:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CAC5208C0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 09:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563701366;
	bh=XFXz06/TX2cnOE0rdgo0TH18QiPU5z1ph+93rEumalg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GKryjnJ6V+AizLZk6vbFDcYiDR1MLp1Nh+kWRR6YYwKYC9F6avJl4cJeV+BUZKWCS
	 sRRyk0M3dGXecb/O3ls8gEvGwLth9PrK578neSSMUON3srvKlcgVELuhHWXkjkA3IA
	 tF2e1wirBc4i5dZKdvKTmzbSLjt1XvF05RPS/fCo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfGUJ3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 05:29:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfGUJ3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 05:29:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8063320838;
        Sun, 21 Jul 2019 09:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563701364;
        bh=XFXz06/TX2cnOE0rdgo0TH18QiPU5z1ph+93rEumalg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IxxC4BhY5LKAiDf05Jar/SyU9EZw5zBrSdCx9u2JnCZdi5kNav1o/gM4u4GvZY1gk
         s//UloopvRmkNes8HoBgxkw53eCleAq+vpJCzUqfEsZjFIizl5EeTi4JeHQTEEGeiD
         27LTrRAkW47oXZtWisrSeQko+J5tPjXaFwVUsXDM=
Date:   Sun, 21 Jul 2019 11:29:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hennie Muller <hm@bitlabs.co.za>
Cc:     Tim Collier <osdevtc@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging/wlan-ng: Fixing "line over 80 characters"
 warnings.
Message-ID: <20190721092919.GA9188@kroah.com>
References: <20190721091326.7363-1-hm@bitlabs.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190721091326.7363-1-hm@bitlabs.co.za>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2019 at 11:13:26AM +0200, Hennie Muller wrote:
> Reindent multiline function calls to be tab aligned, instead of open brace
> aligned. This fixes multiple "WARNING: line over 80 characters" generated
> by checkpatch.
> 
> Signed-off-by: Hennie Muller <hm@bitlabs.co.za>
> ---
>  drivers/staging/wlan-ng/cfg80211.c    |  55 ++---
>  drivers/staging/wlan-ng/hfa384x_usb.c | 282 +++++++++++++-------------
>  drivers/staging/wlan-ng/p80211conv.c  |  48 +++--
>  drivers/staging/wlan-ng/p80211req.c   |   6 +-
>  drivers/staging/wlan-ng/prism2fw.c    | 101 +++++----
>  drivers/staging/wlan-ng/prism2mgmt.c  | 170 ++++++++--------
>  drivers/staging/wlan-ng/prism2mib.c   |  14 +-
>  drivers/staging/wlan-ng/prism2sta.c   | 282 +++++++++++++-------------
>  drivers/staging/wlan-ng/prism2usb.c   |  13 +-
>  9 files changed, 494 insertions(+), 477 deletions(-)
> 
> diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
> index eee1998c4b18..c69fb83267ef 100644
> --- a/drivers/staging/wlan-ng/cfg80211.c
> +++ b/drivers/staging/wlan-ng/cfg80211.c
> @@ -130,8 +130,8 @@ static int prism2_change_virtual_intf(struct wiphy *wiphy,
>  
>  	/* Set Operation mode to the PORT TYPE RID */
>  	result = prism2_domibset_uint32(wlandev,
> -					DIDMIB_P2_STATIC_CNFPORTTYPE,
> -					data);
> +			DIDMIB_P2_STATIC_CNFPORTTYPE,
> +			data);

This then violates another checkpatch warning, so you can't win :(

Just leave it as-is, it's fine, right?  Coding styles are there to make
things easy to read and understand, and the code is fine like this.

So don't move arguments to the left of the '(' character on the line
above please.

thanks,

greg k-h
