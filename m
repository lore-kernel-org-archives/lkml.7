Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61CCC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 10:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF85D26786
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 10:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="YH+IXwzL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfEaK2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 06:28:09 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:54130 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbfEaK2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 06:28:07 -0400
Received: from g550jk.localnet (80-110-121-20.cgn.dynamic.surfer.at [80.110.121.20])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id A4A83C59F0;
        Fri, 31 May 2019 10:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1559298485; bh=Se4dUZTYep0OSyM0WeJ2pYjOSnGAVavK0huOC+bbDCA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YH+IXwzLuOG3Z6tvsWcUim+3YLlZU9jcxO0xv+Y38t1ecU/TXC1hL1kwFL99yHXga
         hJoaRYID5kqhEUscXaNRwE0waJAd8xM3j0sFWwqz269g02BH6RRe4nenMKPUlGbOEG
         LYC0MdrlJTxZD8G0yw/6iRueY8ftowp/h4ovDw5o=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: allwinner: a64: Add lradc node
Date:   Fri, 31 May 2019 12:27:55 +0200
Message-ID: <6901794.oDhxEVzEqc@g550jk>
In-Reply-To: <20190524092001.ztf3kntaj4uiswnv@flea>
References: <20190518170929.24789-1-luca@z3ntu.xyz> <4343071.IDWclfcoxo@g550jk> <20190524092001.ztf3kntaj4uiswnv@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Freitag, 24. Mai 2019 11:20:01 CEST Maxime Ripard wrote:
> 
> It would be great to drop the -keys from the compatible, and to
> document the bindings
> 
> Looks good otherwise
> 
> Maxime

Hi again,

So I should just document the "allwinner,sun50i-a64-lradc" string in 
Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt ? Don't I also 
have to add the compatible to the driver code then? Just adding the a64 
compatible to a dts wouldn't work without that.

Thanks, Luca



