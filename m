Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3335BC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF574214C6
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oTFysx+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733155AbfHHNc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:32:27 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:44254 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732909AbfHHNcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 09:32:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=GHo/6QReMThwQvyBgODim8yuFC35rBgqhlgJLF2q8Q4=; b=oTFysx+mCgXvRtdsg5J4CTTGW9
        HLBr7jV26zYbqX3l5R1W+PwgvvBWC+pzrJ3PQPhNUQyC24TlfZZebDOLgNBcbMNYiq6arqFiIqBnb
        RIZABxEu3b7a9BLjmVbOsv1luWS1rqlniXD45/u4PrYAH1Ue6Z0VevzULWXe6kCo64n8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hviWX-0002zd-D4; Thu, 08 Aug 2019 15:32:09 +0200
Date:   Thu, 8 Aug 2019 15:32:09 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Tao Ren <taoren@fb.com>
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S . Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        William Kennington <wak@google.com>,
        Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH net-next] net/ncsi: allow to customize BMC MAC Address
 offset
Message-ID: <20190808133209.GB32706@lunn.ch>
References: <20190807002118.164360-1-taoren@fb.com>
 <20190807112518.644a21a2@cakuba.netronome.com>
 <20190807184143.GE26047@lunn.ch>
 <806a76a8-229a-7f24-33c7-2cf2094f3436@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <806a76a8-229a-7f24-33c7-2cf2094f3436@fb.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Let me prepare patch v2 using device tree. I'm not sure if standard
> "mac-address" fits this situation because all we need is an offset
> (integer) and BMC MAC is calculated by adding the offset to NIC's
> MAC address. Anyways, let me work out v2 patch we can discuss more
> then.

Hi Tao

I don't know BMC terminology. By NICs MAC address, you are referring
to the hosts MAC address? The MAC address the big CPU is using for its
interface?  Where does this NIC get its MAC address from? If the BMCs
bootloader has access to it, it can set the mac-address property in
the device tree.

    Andrew
