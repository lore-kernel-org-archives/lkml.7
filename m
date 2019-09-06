Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0D5C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 19:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23DF12186A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 19:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oeQci1hB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393289AbfIFT3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 15:29:31 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:60430 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbfIFT3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 15:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=VKuOCqb0qokrqyrI79Z2Qe4eyujHBZLejEMxpAlk8kY=; b=oeQci1hBJlwILpkSPpSFnE/4W1
        /E2bxMrjj4JU/oGw3rkg6DXroxyrGNdCNvhXuAWsDVvZ3j4pQ8wNHkh//Q93D8KAECrrWqcl+94aa
        YcKfZfCueFCWXEmbtldg4OqboanUAcvzrmlHb7H1ORjcn28P2n2bPLb+BElpFmJ/CWbE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1i6Jv5-0000mP-9Q; Fri, 06 Sep 2019 21:29:19 +0200
Date:   Fri, 6 Sep 2019 21:29:19 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vitaly Gaiduk <vitaly.gaiduk@cloudbear.ru>
Cc:     davem@davemloft.net, robh+dt@kernel.org, f.fainelli@gmail.com,
        Mark Rutland <mark.rutland@arm.com>,
        Trent Piepho <tpiepho@impinj.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] net: phy: dp83867: Add documentation for SGMII mode
 type
Message-ID: <20190906192919.GA2339@lunn.ch>
References: <1567700761-14195-1-git-send-email-vitaly.gaiduk@cloudbear.ru>
 <1567700761-14195-2-git-send-email-vitaly.gaiduk@cloudbear.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567700761-14195-2-git-send-email-vitaly.gaiduk@cloudbear.ru>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 07:26:00PM +0300, Vitaly Gaiduk wrote:
> Add documentation of ti,sgmii-type which can be used to select
> SGMII mode type (4 or 6-wire).

Hi Vitaly

Is 4 vs 6-wire a generic SGMII property? Or is it proprietary to TI?

I did a quick search and i could not find any other PHYs supporting
it.

	Andrew
