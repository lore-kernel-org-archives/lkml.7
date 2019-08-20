Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F60DC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D355D206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XTnkpAA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbfHTP3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:29:33 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:45378 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730292AbfHTP3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=K7KPnT4B2RzmdYoyeN79Pgg8w00ak1V/OyvQUugvq7o=; b=XTnkpAA6r15dLiAWOYoOCTyj89
        5nZBXZ8C/7Ve5YmeDns4N5XguLkbXUgI9v6e5JbhetZ4MgP2jwnROHMr7B37n96kYqe37YfHzuOpS
        wksGpCV6BQalKGpBfFPyI/6/T5D1veciopCzLnueFsOTrGb7QOnPM88EE7h+1nze7AGQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1i064f-0006Ig-0N; Tue, 20 Aug 2019 17:29:29 +0200
Date:   Tue, 20 Aug 2019 17:29:28 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        Chris Healy <cphealy@gmail.com>
Subject: Re: [PATCH] ARM: dts: vf610-zii-cfu1: Slow I2C0 down to 100kHz
Message-ID: <20190820152928.GK29991@lunn.ch>
References: <20190820030804.8892-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820030804.8892-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 08:08:04PM -0700, Andrey Smirnov wrote:
> Fiber-optic module attached to the bus is only rated to work at
> 100kHz, so drop the bus frequncy to accomodate that.

Hi Andrey

Did you review all the other ZII platforms? I could imaging the same
problem happening else where.

Thanks
	Andrew
