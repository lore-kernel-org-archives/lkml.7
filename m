Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2E3C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CFAF2071C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="IagYogM3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbfKVOKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 09:10:30 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:15519 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfKVOK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 09:10:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574431824;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=EJSl3iRJcanzg159K/qfpdsrnAGlP/ValPtgHthr2To=;
        b=IagYogM3d820iB2L+gXfiZBOm8r19xQ1Jcx0afMNzzl0DIa++kngCrB87VBp16nOY5
        dWeOhJBA9P1f2SqTO6ETXRDcGypATfWf/t402Dt1+UR+E9GYSkS/c+m3nNJ9LclFwekd
        9Q7H8bHdA0fS39BTMBquAboxvTY95D5DD4cTI828Uf7jUveVwDNDojur8jn510AeUoMe
        z1Gr3xH/sqtyMgS+1aEUYuQeENZxTdAd0XRQY09zL/Vf4ehW0hMjtE33Q94cf+i0BnZr
        422LCMWG6rKVgZsEw6qTzR3OsdwpiuEC6/DPgzGzAuiubRGzxpNWsGW96D9vmH1XFnn+
        XXVw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8fxIc6p"
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 44.29.0 DYNA|AUTH)
        with ESMTPSA id e07688vAMEAN4rh
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 22 Nov 2019 15:10:23 +0100 (CET)
Date:   Fri, 22 Nov 2019 15:10:09 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] dt-bindings: arm: Document compatibles for Ux500
 boards
Message-ID: <20191122140944.GA2872@gerhold.net>
References: <20191120181857.97174-1-stephan@gerhold.net>
 <20191120181857.97174-4-stephan@gerhold.net>
 <CACRpkda-rm=1hz_p2YCqBVgxsM9cmKYJVUg+T91MyBrgmtDP-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkda-rm=1hz_p2YCqBVgxsM9cmKYJVUg+T91MyBrgmtDP-w@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 09:22:19PM +0100, Linus Walleij wrote:
> On Wed, Nov 20, 2019 at 7:20 PM Stephan Gerhold <stephan@gerhold.net> wrote:
> 
> > The device-specific compatible values used by the Ux500 boards
> > were not documented so far. Add a new simple schema to document them.
> >
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> 
> Nice, thanks!
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I expect Rob to merge these patches as they are bindings-only,
> alternatively I can take them in the Ux500 DTS pull request
> for the next kernel cycle.
> 

For this patch it would be easier if you take it through the Ux500 tree,
as I have another patch series that adds a new board to it.

The vendor-prefix patches are independent, so Rob can merge them if that
is easier?

Thanks,
Stephan
