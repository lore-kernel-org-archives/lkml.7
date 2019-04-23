Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E464C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9D120645
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HWbGRMm4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbfDWN6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:58:31 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:41391 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727656AbfDWN6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=E1zVshIKweUw7ldBCtOfA2TewuVHmWK7D9HujauCzVs=; b=HWbGRMm4TLnCjpEfrWxX3Nx4T5
        FKwAa93Dwx7HFtoASJVj79MLsvb9HZcMH4gRsXBnlv3nuS7V5uLY6J37QdosbMzJHiL+O4WcX2SBu
        s58QMrej6DHocuPetW1eMbMYVUKVBsdtuWgTmCm95uQSr0tZBL1I8wm38psGj6gcAhWc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hIvwH-00072r-7h; Tue, 23 Apr 2019 15:58:25 +0200
Date:   Tue, 23 Apr 2019 15:58:25 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     netdev@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>
Subject: Re: [PATCH net-next 01/19] net: ethernet: ti: convert to SPDX
 license identifiers
Message-ID: <20190423135825.GE3371@lunn.ch>
References: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
 <1556024950-20752-2-git-send-email-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556024950-20752-2-git-send-email-grygorii.strashko@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 04:08:52PM +0300, Grygorii Strashko wrote:
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (C) 2006, 2007 Eugene Konev
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.

Hi Grygorii

Your SPDX says version 2. The text says version 2 or later. You need
to add a + .

     Andrew
