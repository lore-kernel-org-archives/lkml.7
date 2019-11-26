Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86ED8C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB1F20722
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rw+WNrhI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbfKZOaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 09:30:21 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:56604 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbfKZOaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 09:30:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=9LohR98h7eSnbtOjih5buv5szdpX2GUI8naC1HscHjw=; b=rw+WNrhIljSW4nQOJHevd6Xn92
        AHiqQUiOji33SYte/aZOoBfrw0XK+xwXdtuTm9dEjQLL3tAzzEeNRNH3adS8x4/u/Qf/YhMgCfo8Z
        T6Af7wJxGxwAyauS5SJ0T0SW+Fb9thcbSrNyYDPfIOMnCGjeJSboCJYhTfts5/WMp0kc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.92.2)
        (envelope-from <andrew@lunn.ch>)
        id 1iZbqz-0003UL-Ak; Tue, 26 Nov 2019 15:30:09 +0100
Date:   Tue, 26 Nov 2019 15:30:09 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Milind Parab <mparab@cadence.com>
Cc:     antoine.tenart@bootlin.com, nicolas.ferre@microchip.com,
        davem@davemloft.net, netdev@vger.kernel.org, f.fainelli@gmail.com,
        hkallweit1@gmail.com, linux-kernel@vger.kernel.org,
        dkangude@cadence.com, pthombar@cadence.com
Subject: Re: [PATCH 1/3] net: macb: fix for fixed-link mode
Message-ID: <20191126143009.GO6602@lunn.ch>
References: <1574759354-102696-1-git-send-email-mparab@cadence.com>
 <1574759380-102986-1-git-send-email-mparab@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574759380-102986-1-git-send-email-mparab@cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 09:09:40AM +0000, Milind Parab wrote:
> This patch fix the issue with fixed link mode in macb.

Hi Milind.

What issue is it fixing? Please give a good description here, so we
can understand what/why the patch exists.

    Andrew
