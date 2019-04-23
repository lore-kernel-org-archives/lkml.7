Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EEBC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 765D0217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="p+iLsEBA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfDWSlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 14:41:40 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:41783 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfDWSlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 14:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=dAF9nIWmIh1/ooMMKzQTyClpuWxezlNewUUn6k+y/Sg=; b=p+iLsEBA4a+ZFja+VfuyZ79IxF
        hin6CEFHhOv/y4MXlzNjrw1AliDJBKT5UQwTOktpH93aHw06aTAg0ZS/6fLPM9YVlnmxGYKF94Hqw
        zC13ZjJhC4C1Ho5xIuymzaqd1/7lrPfTMHVD97KfIKvXE5IRamwM+O9y0GlX4pbXNUXk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hJ0MJ-0001V0-Vg; Tue, 23 Apr 2019 20:41:35 +0200
Date:   Tue, 23 Apr 2019 20:41:35 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     netdev@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>
Subject: Re: [PATCH net-next 07/19] net: ethernet: ti: cpsw: use
 devm_alloc_etherdev_mqs()
Message-ID: <20190423184135.GF28405@lunn.ch>
References: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
 <1556024950-20752-8-git-send-email-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556024950-20752-8-git-send-email-grygorii.strashko@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 04:08:58PM +0300, Grygorii Strashko wrote:
> Use devm_alloc_etherdev_mqs() and simplify code.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
