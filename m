Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5411C49ED8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AEC520863
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rNLUxgoR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732761AbfIJOVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 10:21:34 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:43426 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730779AbfIJOVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 10:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iLTLwbdz4fgVz4ZXeuOVU1SlVl+j3xkBZocxNZDBcz8=; b=rNLUxgoRwkYilxwmy0gL+9fYi
        gBdTra/HYESg9mU8DdjhNegllCIVZtuXQ4jY9+4ozk7JTObWiEyzW/CgaRtkCvLRbTpWSfH0+Qb7P
        kENsgNBqee0NyC044xLLv1Nscb0jcPBRgK1/RQgnF5ABGc0geigOkzWTyfSoGsDaph2eiupGeS20K
        KM/OalB7YYcTLP8rP8ol3NPOgoprRl2Y76eKjszt+7FhrxyO/YuV+LF3Yy0/Z6xwR27JHf7IFP4YW
        OP2AXMUHHRI4LYUfm+GUOOvz7NoXbGDVBpbtkykhv3uld/GLr317sZMUUeNQTLRDlB8Vc8ROYFSmF
        MSTm2ZJQQ==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:37848)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1i7h1O-0000aW-MC; Tue, 10 Sep 2019 15:21:30 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1i7h1M-000334-I5; Tue, 10 Sep 2019 15:21:28 +0100
Date:   Tue, 10 Sep 2019 15:21:28 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <mike.rapoport@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>, Chester Lin <clin@suse.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the arm tree
Message-ID: <20190910142128.GR13294@shell.armlinux.org.uk>
References: <20190911001459.6ccc76ee@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911001459.6ccc76ee@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is correctly signed off, but Mike didn't send the patch correctly.
It missed a From: line for the proper author, so the patch was committed
as if Mike had authored it, which he didn't.

On Wed, Sep 11, 2019 at 12:14:59AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   2505b9ba9c37 ("ARM: 8904/1: skip nomap memblocks while finding the lowmem/highmem boundary")
> 
> is missing a Signed-off-by from its author.
> 
> -- 
> Cheers,
> Stephen Rothwell



-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
