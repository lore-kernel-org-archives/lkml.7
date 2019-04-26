Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC540C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 22:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928EB2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 22:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BxV5aV7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfDZWKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 18:10:32 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:46274 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbfDZWKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 18:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Qt6uc9Lt1JGEPDXMy17QN7pYp1FaE8gQkEYbKzm2498=; b=BxV5aV7bVRunnjxfoLwvEN7yzK
        Ja9C1CnPdMQygj9lIhw4iAZDiKmujofp/zd91TtedcCXOlwb8Y4QSKDC/FO9aF++i9zTdLPMbn/0A
        AY/F/AAqdTxtFuQ8MV5NtpOXFf1Z358ttlHCGr4plNaMHiEghOvAFsr8xp0muk8rBhrY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hK937-0006Ek-05; Sat, 27 Apr 2019 00:10:29 +0200
Date:   Sat, 27 Apr 2019 00:10:28 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     netdev@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>
Subject: Re: [PATCH net-next v2 05/20] net: ethernet: ti: cpsw: use local var
 dev in probe
Message-ID: <20190426221028.GE23059@lunn.ch>
References: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
 <1556298762-8632-6-git-send-email-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556298762-8632-6-git-send-email-grygorii.strashko@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 08:12:27PM +0300, Grygorii Strashko wrote:
> Use local variable struct device *dev in probe to simplify code.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
> changes in v2:
>  - fixed dev variable alignment

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
