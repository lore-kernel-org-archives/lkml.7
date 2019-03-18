Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2826DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 06:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71B12083D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 06:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552892332;
	bh=/0c7lbGlF+F93K/FUhGL6QGQI6Sa+nwBr4hgn8vxsBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XJKMCfDGBloLH7pLMSrML1Xf/zi03hRWgk0RlOEHxmn/L3cFoSUyYD+yvurRLEIB4
	 UhJd7FEd00BY+CoiXVqrXGlLU/6lED70t9GFAKlcNsBCd45U4042hxwZ8fO7QGxSuM
	 LvyF4xeTJQVp8lPHLHuK7eZx2kcCFq+vRV5Agqiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfCRG6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 02:58:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:44166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbfCRG6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 02:58:49 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD4062077B;
        Mon, 18 Mar 2019 06:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552892329;
        bh=/0c7lbGlF+F93K/FUhGL6QGQI6Sa+nwBr4hgn8vxsBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OBZ84gQQyD9p8scaaaGdXxrtEH8bQWxOBdR5b8HyPVLqeSnYOG/7IoAv4ASwag9DU
         VDgExRWXu2cQRv8mTkisCj7d9IQ0HnffNRMnVF7PnYSscrW8bE3vf0ukgig89g0Yt8
         nF5eL4hgae1JDzoZUOfRkjvhm95jD0Q1FtgDiAVc=
Date:   Mon, 18 Mar 2019 07:58:46 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Maxim Zhukov <mussitantesmortem@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging, mt7621-eth: fix api for linkmode bitmap
Message-ID: <20190318065846.GA15948@kroah.com>
References: <20190309095400.26930-1-mussitantesmortem@gmail.com>
 <20190309095400.26930-2-mussitantesmortem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190309095400.26930-2-mussitantesmortem@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 09, 2019 at 12:53:59PM +0300, Maxim Zhukov wrote:
> Start using new api for linkmode bitmap
> 
> Fixed build after 3c1bcc8614db ("net: ethernet: Convert phydev advertize and supported from u32 to link mode")
> 
> Signed-off-by: Maxim Zhukov <mussitantesmortem@gmail.com>
> ---
>  drivers/staging/mt7621-eth/mdio.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

This driver is now dropped from the tree, so no need to fix any build
issues :)

thanks,

greg k-h
