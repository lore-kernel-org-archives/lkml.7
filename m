Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08EBC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD19A20851
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551453489;
	bh=+BURdT9d+ofdxlxma7IgRLcmsDuU57y7DiZZfIv4jhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R3qMPxKxQBI7spIK257ki2epMhn7rL9Nn2/WYqHqBE//0lnrH9kcD1oJE/sxuhrjh
	 LgEgav60mkIU/dFNoBlNalRIyiD+uzuLJssmlsX91Dqy+I3zvD3DmNr63UTRmtEd3m
	 Npy0OVcwkKN99AY19/BSTdCOB5dPUW47g6bkilB0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387990AbfCAPSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 10:18:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:43448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbfCAPSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 10:18:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A53182084F;
        Fri,  1 Mar 2019 15:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551453487;
        bh=+BURdT9d+ofdxlxma7IgRLcmsDuU57y7DiZZfIv4jhg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZqE/kHCtEXkEcw1nGT6MQdLNNw9jOJTl4SdsY/Ltf49aQdnxe/ACBbG+cJ9FUgHNb
         aQ5lyHQTQ995ea9MXr3JfOGU0fmLkx8WvAJSOnFDcOrcZ3OjBx2QbDeoH9ieTm1REo
         pM9y4tpsEQXyNi41JGei3Rbkw5hvm+GsO3wvtLNY=
Date:   Fri, 1 Mar 2019 16:18:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oryan Perlmutter <oryan.perl1997@gmail.com>
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        devel@driverdev.osuosl.org, trivial@kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Coding style fixes on vme_user.c trivial
Message-ID: <20190301151804.GA31958@kroah.com>
References: <20190301142726.23969-1-oryan.perl1997@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301142726.23969-1-oryan.perl1997@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 04:27:25PM +0200, Oryan Perlmutter wrote:
> drivers/staging/devices: Coding style fixes found at file vme_user.c.


Your subject line, and this changelog text, need a lot of work.  Please
look at the other patches that have been accepted for this driver as
examples of how to do this properly.

> 
> Signed-off-by: Oryan Perlmutter <oryan.perl1997@gmail.com>
> ---
>  drivers/staging/vme/devices/vme_user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vme/devices/vme_user.c b/drivers/staging/vme/devices/vme_user.c
> index 6a33aaa1a49f..4c7db4f5f15e 100644
> --- a/drivers/staging/vme/devices/vme_user.c
> +++ b/drivers/staging/vme/devices/vme_user.c
> @@ -506,7 +506,7 @@ static int vme_user_match(struct vme_dev *vdev)
>  	int cur_slot = vme_slot_num(vdev);
>  
>  	for (i = 0; i < bus_num; i++)
> -		if ((cur_bus == bus[i]) && (cur_slot == vdev->num))
> +		if (cur_bus == bus[i] && cur_slot == vdev->num)

Personally, I like the original code here, it's more explicit as to what
is going on.

thanks,

greg k-h
