Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6698C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 10:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F258214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 10:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="qHzGFNZo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfKKKYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 05:24:50 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:59446 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfKKKYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 05:24:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KkshqQCTszdoi49VntJOylBToP8vc+lvnQmxVqr0Mdk=; b=qHzGFNZowiTaHCrMC2MX4k+Wg
        pEs9U2ks7/S/H0ug9+CYH+PsxYummgRjkI3+NSKKOVBxZOO2bzdBoeG5daFjdBrvl8lXeL+MdwFI3
        8H8gEcAqAp+/mqR5d6RctcvMJLVQ4qGTYY7tbvrT534N4llMtAq7FWiG9ThU1ZY/yt7i2VC+VoDWp
        XajjNXCkGNPEfmarOa6F6E8Fw5y8nJt60JuQUocjWSIpF4IrjfjtonqhMYEAjzyDlY+BzOu2+I8c/
        hEPuMQc5AG7OGZYgFw7tl2A6Pq67wS2DtzWT3YF3cpUsc/oBRKHQrobzIkwMqg5WRK688uZrMwL91
        nh9fdBDaQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38166)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iU6sD-0004wv-Ct; Mon, 11 Nov 2019 10:24:41 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iU6sA-0000Pq-76; Mon, 11 Nov 2019 10:24:38 +0000
Date:   Mon, 11 Nov 2019 10:24:38 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the net-next tree
Message-ID: <20191111102438.GG25745@shell.armlinux.org.uk>
References: <20191111121953.25f34810@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111121953.25f34810@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Stephen, patch coming today.

On Mon, Nov 11, 2019 at 12:19:53PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the net-next tree, today's linux-next build (arm
> multi_v7_defconfig.) produced this warning:
> 
> In file included from net/core/ethtool.c:21:
> include/linux/sfp.h:566:12: warning: 'sfp_bus_add_upstream' defined but not used [-Wunused-function]
>   566 | static int sfp_bus_add_upstream(struct sfp_bus *bus, void *upstream,
>       |            ^~~~~~~~~~~~~~~~~~~~
> 
> Introduced by commit
> 
>   727b3668b730 ("net: sfp: rework upstream interface")
> 
> -- 
> Cheers,
> Stephen Rothwell



-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
