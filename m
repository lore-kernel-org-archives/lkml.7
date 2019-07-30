Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14466C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD1C206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564472950;
	bh=p0ptAuSfNPLNxxRo3FL5oil0Da165+w0H6OX+7p20eI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vLSQjgyAwdmyv3Ehz3CHyG9olSc9I+T/gNsq/34Yq91ScqAdS8kZ/AVXUVLprCuQR
	 Ec/sYSaBx5imgBt2r2Ge+y+LNDEEzd3lxrADbM27GOmJdHwJAZi6uPTg1UDv82KA5Z
	 ww3FGsPjOZ/YhLabpgh9mxj6YsjRNjN6BoTnzowA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730652AbfG3HtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 03:49:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729016AbfG3HtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 03:49:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EABE206E0;
        Tue, 30 Jul 2019 07:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564472948;
        bh=p0ptAuSfNPLNxxRo3FL5oil0Da165+w0H6OX+7p20eI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pkXNIUxOhXVNdls+aru0kxYawa45ajNFvYyxGMSMuObzWG6YjMepQTk4jWs+JE7BL
         cdyWZrtibVn9K6uzCYyCMBVAPy/fDgUQNMoLhtkGN/KPTw9N+be1Cm/JjXr1RTzKeG
         k0aGZ4pume7y1N0+g61kuTpM0WTukgwf2wpYo0QQ=
Date:   Tue, 30 Jul 2019 09:49:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com, Larry.Finger@lwfinger.net
Subject: Re: [PATCH] staging: rtl8723bs: os_dep: Remove function
 _rtw_regdomain_select
Message-ID: <20190730074905.GA25897@kroah.com>
References: <20190725173349.GA9894@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725173349.GA9894@hari-Inspiron-1545>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 11:03:49PM +0530, Hariprasad Kelam wrote:
> This function simply returns &rtw_regdom_rd . So replace this function
> with actual code
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/staging/rtl8723bs/os_dep/wifi_regd.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)

You have sent 11 patches for this driver in the past few days, and I
have no idea what order to apply them in.

Please resend them all as a patch series, properly numbered so that I
have a chance to apply them in the correct order.

thanks,

greg k-h
