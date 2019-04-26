Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A0BC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 22:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE53B206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 22:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PK2gf/D8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfDZWGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 18:06:18 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:46249 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbfDZWGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 18:06:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=C5WQuUlfw5saXnIrFdksMbp9Z1O2sw/i3Qlt7RctDqA=; b=PK2gf/D8SRGUeYKO6lZQ9DSWfC
        9jz1SvW6y/tpVt5DSAvzJ059U5ia5p9djxD6JGvziUskD9CBUVsETa810X0DGhhXhG8SwyeJZyArd
        e1ahc2bGOtmQUn+yqGsRwz58NGcN8R1p4wmyZY1kA2ljIkWq8LyIyhMW9kwwqm0GmFDI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hK8yz-00067l-Pt; Sat, 27 Apr 2019 00:06:13 +0200
Date:   Sat, 27 Apr 2019 00:06:13 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     netdev@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>
Subject: Re: [PATCH net-next v2 02/20] net: ethernet: ti: cpsw: drop
 TI_DAVINCI_CPDMA config option
Message-ID: <20190426220613.GB23059@lunn.ch>
References: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
 <1556298762-8632-3-git-send-email-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556298762-8632-3-git-send-email-grygorii.strashko@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 08:12:24PM +0300, Grygorii Strashko wrote:
> Both drivers CPSW and EMAC can't work without CPDMA, hence simplify build
> of those drivers by always linking davinci_cpdma and drop TI_DAVINCI_CPDMA
> config option.
> Note. the davinci_emac driver module was changed to "ti_davinci_emac" to
> make build work.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
