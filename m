Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D42BC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9B1205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MyI0M5J6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732494AbfJAM2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 08:28:38 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:55880 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfJAM2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=XNJhDhnm+k1BnwnI1CC9SFDSWX+IJemCfMgg5iRpkPM=; b=MyI0M5J6Gl87yb7+MYC6igRM5W
        svqKuK/FPdwG8Szw+sxcaIkGM1zF210G540yp/qUE9FqYqreDW9JcT6bcfDPuygh7sXWzPHd4/p7t
        pMJWKJUe2Sp0E+9Hxnk22rZdsaYgzR0Wc4HBHgzaNkW5LZ/csG8wkvoqyeG+2lI8qrHg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.92.2)
        (envelope-from <andrew@lunn.ch>)
        id 1iFHGd-0000LL-Cn; Tue, 01 Oct 2019 14:28:35 +0200
Date:   Tue, 1 Oct 2019 14:28:35 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Walter Schweizer <ws.kernel@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Gregory Clement <gregory.clement@bootlin.com>
Subject: Re: [PATCH] ARM: dts: kirkwood: synology: Fix rs5c372 RTC entry
Message-ID: <20191001122835.GB869@lunn.ch>
References: <20190928105344.6788-1-ws.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190928105344.6788-1-ws.kernel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2019 at 12:53:44PM +0200, Walter Schweizer wrote:
> In the rtc-rs5c372.c driver the compatible entry has been renamed
> from rs5c372 to rs5c372a. Most dts files have been adapted.
> This patch completes the change.
> 
> Signed-off-by: Walter Schweizer <ws.kernel@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
