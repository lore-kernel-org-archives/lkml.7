Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424E6C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11358218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GCTH4fIO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbfDYMTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:19:02 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:43809 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbfDYMTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=HSbgQvEs8ufHCJFyDaygGtbcXzayI98z9Nsepy4UI2Y=; b=GCTH4fIOf2uNVp6cnt5jeuv3Ra
        5QoJKO55D48v5PW4MaTJeWkDEHHQckuVbEoL435QtTxKlz14rq3p8raKlxtkub0tvMXs0YR1KOVMf
        aC47iqqn8VkhN5EGcHspp3jhVkcDRQYndCijf8cns/OlMaczAfCF5JR2ZaOXluvHkIKI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hJdL2-0002AV-OQ; Thu, 25 Apr 2019 14:18:52 +0200
Date:   Thu, 25 Apr 2019 14:18:52 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     netdev@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Jiri Pirko <jiri@resnulli.us>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>,
        Ivan Vecera <ivecera@redhat.com>
Subject: Re: [RFC PATCH v3 net-next 01/11] net: ethernet: ti: cpts: use
 devm_get_clk_from_child
Message-ID: <20190425121852.GA8117@lunn.ch>
References: <1556144667-27997-1-git-send-email-grygorii.strashko@ti.com>
 <1556144667-27997-2-git-send-email-grygorii.strashko@ti.com>
 <20190424224607.GB23779@lunn.ch>
 <3aae7697-3b7f-492b-0600-b6d1382511c3@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aae7697-3b7f-492b-0600-b6d1382511c3@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hi Grygorii
> > 
> > Does this break backwards compatibility for existing DT blobs?
> > Maybe you need to look in both the old and new locations?
> 
> No. It doesn't - default node is cpsw->dev->of_node.

O.K. great. Maybe mention this in the commit message if there is a v2.

     Thanks
        Andrew
