Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B805EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D4B20C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3R+pP9ww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389135AbfB1PdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:33:09 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:41848 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387501AbfB1PdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:33:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=LGQa47AsbWpP/5YhYun05kE7ORpuATn4szWRFaYP6WU=; b=3R+pP9ww9AJBbHnq/pg8w0y/99
        CA2dy6GqJwJ8XIyOD7/TxH+ADCXnbQJkeehvh4+m+gPTe4ksCnBrmiBTnASRirLznSkx/O+g12k87
        zh02DEhLJccYypoH4Dv8RcC9iNrDxSt/oudPLzO3e4DfBPt/ND1EUYa0yFdGHTR8bxKc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gzNfx-0003W7-Mv; Thu, 28 Feb 2019 16:32:45 +0100
Date:   Thu, 28 Feb 2019 16:32:45 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: e1000e: add MAC address kernel cmd line parameter
Message-ID: <20190228153245.GA17912@lunn.ch>
References: <1551361135-404-1-git-send-email-f.suligoi@asem.it>
 <1551361951-1595-1-git-send-email-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551361951-1595-1-git-send-email-f.suligoi@asem.it>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 02:52:31PM +0100, Flavio Suligoi wrote:
> Sometimes, in some embedded systems boards (i.e. ARM boards),
> the NVM eeprom is not mounted, to save cost and space.
> 
> In this case it is necessary to bypass the NVM management
> and directly force the MAC address using a kernel command-line
> parameter (macaddr).

Hi Flavio

Why not use device tree, since this is an ARM platform?

    Andrew
