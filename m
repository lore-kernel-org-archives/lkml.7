Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3D3C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1136E20881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557933227;
	bh=6IVq7R9+Mw6zBbr68ZoCLS/yB/UFMa1HSoEgnGKNEbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AdBPwslu9q+YECHatSM8RKKtY3pSGH/25dlu2L5RvvdC17C5Dcz8FO04l8TkpdFU+
	 41zqbXw/idTKihEK4gwKF6sIG8t2/Aap2nFCMf8xMGQ+wkOL1x3epkiuZ4Uxv71SyI
	 AO5E392gVjkXaImS6y98oDLsoCID+tAmT620TTIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbfEOPNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 11:13:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:60174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726572AbfEOPNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 11:13:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BD052084E;
        Wed, 15 May 2019 15:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557933224;
        bh=6IVq7R9+Mw6zBbr68ZoCLS/yB/UFMa1HSoEgnGKNEbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v2Ct8xA5rNBGhGlbHtv4wq3dKhf4Ykd9HNKw1sEp2v1lPMC8bmzWYIWIawTy2DPK7
         8oMysglFsDNWpJy6mQFEgcP67PE1ql6noD1ALV7WvYxKXQemXYMchdDEJESquER4Rv
         Y4JJO2oDVjrm1JRi/pZZoL5UsoysCgTTPA9ECi9w=
Date:   Wed, 15 May 2019 17:13:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     parna.naveenkumar@gmail.com
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] char: misc: Move EXPORT_SYMBOL immediately next to
 the functions/varibles
Message-ID: <20190515151342.GC23599@kroah.com>
References: <20190515141731.27908-1-parna.naveenkumar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515141731.27908-1-parna.naveenkumar@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 07:47:31PM +0530, parna.naveenkumar@gmail.com wrote:
> From: Naveen Kumar Parna <parna.naveenkumar@gmail.com>
> 
> According to checkpatch: EXPORT_SYMBOL(foo); should immediately follow its
> function/variable.
> 
> This patch fixes the following checkpatch.pl issues in drivers/char/misc.c:
> WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> 
> Signed-off-by: Naveen Kumar Parna <parna.naveenkumar@gmail.com>
> ---
>  drivers/char/misc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Where are patches 1/3 and 2/3 of this series?

