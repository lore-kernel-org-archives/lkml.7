Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDD2CA9ECB
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 23:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33FEF2087E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 23:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tF2YJZEQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfJ3XSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 19:18:04 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:42592 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbfJ3XSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 19:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=DmcyhensQoVojxFW3x93BPAFesaAo/K9s2CPQn70GdE=; b=tF2YJZEQM+GQrvSpgmEYo0PvBR
        fa/ejt2abFO8ciEhqIFvEtSVCF/Jj/GMoKu+eYi+rugq9YcCoucPSIdhrtevWCm8enuAv4tIF0U8t
        AUV/W7kPcA5jK5K0ZK9nMHFo8OGPWIjTT2eyTj/HCLIGjQXWi3V6VcR8Ghrdnu1mBhfI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.92.2)
        (envelope-from <andrew@lunn.ch>)
        id 1iPxE1-0005Xb-2m; Thu, 31 Oct 2019 00:18:01 +0100
Date:   Thu, 31 Oct 2019 00:18:01 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] net: phy: at803x: fix Kconfig description
Message-ID: <20191030231801.GH10555@lunn.ch>
References: <20191030224251.21578-1-michael@walle.cc>
 <20191030224251.21578-2-michael@walle.cc>
 <0a42b1d6-b60d-b8a0-2264-54df155bcb3b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a42b1d6-b60d-b8a0-2264-54df155bcb3b@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 04:16:01PM -0700, Florian Fainelli wrote:
> On 10/30/19 3:42 PM, Michael Walle wrote:
> > The name of the PHY is actually AR803x not AT803x. Additionally, add the
> > name of the vendor and mention the AR8031 support.
> 
> Should not the vendor be QCA these days, or Qualcomm Atheros?

Atheros Qualcomm would work best in terms of not upsetting the sort
order.

	Andrew
