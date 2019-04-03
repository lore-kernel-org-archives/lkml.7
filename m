Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E63C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9516820882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554265596;
	bh=s1+mjeozG8dJNID92iKzglQZvABgRZXNNUbdrtGrmQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ATh9usPCUxM+IjE4mB4ZVSs16IKqxlxrsMza+hM6m/KKuK0icrk1AIp6fRTn/OhIb
	 JBTc1IS0HEltgD7r1op9DboFabBob6Tmol+J9Jm1CeRdhQca7zIIy5NVaMFWWL31GC
	 3biX/3CKgxRvbLNvb2HIF9BBl7gQq2RzOgVveiek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfDCE0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:26:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:60118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfDCE0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:26:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EC12206B7;
        Wed,  3 Apr 2019 04:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554265594;
        bh=s1+mjeozG8dJNID92iKzglQZvABgRZXNNUbdrtGrmQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N67aWbIPqiLBCHhkHLhznDiBJcoahkPSUhMvBEyktz1rua/5ERuPuB/cccMTKs/QZ
         3s/QMUZcC+Z+soW2WGdvggf61+YLK50ZX/REtwfWF9Z5yju81M+7wPc3wLYNdE5dyK
         yTKJ+zKKLUqwzPc+9ceNQIPf/8X2lgjKR9vc4OBg=
Date:   Wed, 3 Apr 2019 06:26:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andre Dainez <andredainez@gmail.com>
Cc:     lkcamp@lists.libreplanetbr.org, realwakka@gmail.com,
        straube.linux@gmail.com, hle@owl.eu.com, rico.schrage@gmail.com,
        sophie.matter@web.de, Valentin.Vidic@carnet.hr, simon@nikanor.nu,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gdm724x: Add parenthesis to Macro arguments
Message-ID: <20190403042632.GA31130@kroah.com>
References: <1554253445-28635-1-git-send-email-andredainez@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554253445-28635-1-git-send-email-andredainez@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 10:04:05PM -0300, Andre Dainez wrote:
> Fix checkpatch errors:
> 
> CHECK: Macro argument 'len' may be better as '(len)' to avoid precedence issues
> CHECK: Macro argument 'nlh' may be better as '(nlh)' to avoid precedence issues
> 
> Signed-off-by: Andre Dainez <andredainez@gmail.com>
> ---
>  drivers/staging/gdm724x/netlink_k.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/gdm724x/netlink_k.c b/drivers/staging/gdm724x/netlink_k.c
> index 92440c3..36d88f4 100644
> --- a/drivers/staging/gdm724x/netlink_k.c
> +++ b/drivers/staging/gdm724x/netlink_k.c
> @@ -19,8 +19,8 @@ static DEFINE_MUTEX(netlink_mutex);
>  #define ND_NLMSG_SPACE(len)	(NLMSG_SPACE(len) + ND_IFINDEX_LEN)
>  #define ND_NLMSG_DATA(nlh)	((void *)((char *)NLMSG_DATA(nlh) + \
>  						  ND_IFINDEX_LEN))
> -#define ND_NLMSG_S_LEN(len)	(len + ND_IFINDEX_LEN)
> -#define ND_NLMSG_R_LEN(nlh)	(nlh->nlmsg_len - ND_IFINDEX_LEN)
> +#define ND_NLMSG_S_LEN(len)	((len) + ND_IFINDEX_LEN)

This makes sense, but:

> +#define ND_NLMSG_R_LEN(nlh)	((nlh)->nlmsg_len - ND_IFINDEX_LEN)

That does not, correct?
