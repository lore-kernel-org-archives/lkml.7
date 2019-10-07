Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32372C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 10:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E9421655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 10:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570444158;
	bh=vYCw1L6EsClQX3kWOyy3rJzfrw9jqEvK3iRpnr+usV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LS1cyWht7nWEDcOWgU0x/HdppJ/TucjWu7lcA6VaFAXQ40NAgQMNDzFRv1+EevFu/
	 urggnwIzr7RBJtgWQaxJ2KC7t0VVDU1fANMKSVsk57iTTc0fKpzldpu78ajDjVlegv
	 z4u2vAmRymQRr2jaUl1FRlytlZqt9teOHVnxdKv0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfJGK3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 06:29:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfJGK3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 06:29:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7ED0D2084D;
        Mon,  7 Oct 2019 10:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570444156;
        bh=vYCw1L6EsClQX3kWOyy3rJzfrw9jqEvK3iRpnr+usV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ezrfGqfxHWrZR6uCHtFebNS+0ysEFD5JXQBbZknoBa02FwHkRzFDbcCwcqHb8V3Ba
         v+22i716+OXDgN0W19mYxBLli07I9rf9QT5LVCveLbVAwwzGdHHF1sOwUYduBauq86
         /nKAYK8/JTF0MuaINFK4wme0DoUT5N4uBC5O09zU=
Date:   Mon, 7 Oct 2019 12:29:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        trivial@kernel.org
Subject: Re: [PATCH] staging: rtl8712: align arguments with open parenthesis
Message-ID: <20191007102913.GA369086@kroah.com>
References: <20191006222015.15937-1-gabrielabittencourt00@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191006222015.15937-1-gabrielabittencourt00@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2019 at 07:20:15PM -0300, Gabriela Bittencourt wrote:
> Cleans up checks of: "Alignment should match open parenthesis"
> 
> Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
> ---
>  drivers/staging/rtl8712/osdep_service.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

You sent 2 different patches that do different things, yet have the same
exact subject line :(

Please fix this up and send a patch series, so I know what order in
which to apply your patches.

thanks,

greg k-h
