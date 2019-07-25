Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89919C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 09:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB0B22C7B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 09:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564048076;
	bh=MhJw4d4ewEjprJObjjCY8FP2AVv98yCru+fqqnG/PHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FuPSi3Xbu8J+RbO8X5fphcHPo2eyHro0GrgFEIWemA+rZ8wDmx6CjhxFHFcYY8r/v
	 0PRJIWUpMC9Vvj1F8rMMc16sMuoVLPbG0Od6h40DzkEaVsRB2Fh3QMew/tlBeh9HyV
	 fcIyYXgBL7nyxEBHPY8eGp3KpHKhlNyI9opgj30M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbfGYJrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 05:47:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbfGYJry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 05:47:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AB9A2190F;
        Thu, 25 Jul 2019 09:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564048073;
        bh=MhJw4d4ewEjprJObjjCY8FP2AVv98yCru+fqqnG/PHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t6o12Ytv1Exhs1I28zrnl74wKI6nj20dIk4ddtdSkBZj82Q3hbBIzpXiEN2p9hcr8
         4Lf6Kc3PtesJ7+rw9u0xR8M+zkG9aE6KRJv2iGAfKtndAT+rrAHXAc7x5xJaJpDqPO
         taGI+2++x+7/eT/mcJJohNw9CUWwtKkrpgqf4mr8=
Date:   Thu, 25 Jul 2019 11:47:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Changqi Hu <changqi.hu@mediatek.com>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Peter Shih <pihsun@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com,
        Eddie Huang <eddie.huang@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>
Subject: Re: [PATCH v3] serial: 8250-mtk: modify mtk uart power and clock
 management
Message-ID: <20190725094751.GB31845@kroah.com>
References: <1563505182-2408-1-git-send-email-changqi.hu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563505182-2408-1-git-send-email-changqi.hu@mediatek.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 10:59:42AM +0800, Changqi Hu wrote:
> modify mtk uart runtime interface, add uart clock use count.
> merge patch v1 and patch v2 together.
> 
> Signed-off-by: Changqi Hu <changqi.hu@mediatek.com>
> ---
>  drivers/tty/serial/8250/8250_mtk.c | 50 ++++++++++++++++++++++++--------------
>  1 file changed, 32 insertions(+), 18 deletions(-)

Always describe what changed from the previous versions in the area
below the --- line.

Also, your changelog needs a lot more work.  Please read the section
entitled "The canonical patch format" in the kernel file,
Documentation/SubmittingPatches for a description of how to do this.

thanks,

greg k-h's patch email bot

thanks,

greg k-h
