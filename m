Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6858CC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 10:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41DDC218AF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 10:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfIQKx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 06:53:28 -0400
Received: from smtp2.goneo.de ([85.220.129.33]:42898 "EHLO smtp2.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725270AbfIQKx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 06:53:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp2.goneo.de (Postfix) with ESMTP id 55BD823F721;
        Tue, 17 Sep 2019 12:53:25 +0200 (CEST)
X-Virus-Scanned: by goneo
Received: from smtp2.goneo.de ([127.0.0.1])
        by localhost (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7XkpoVnsJAju; Tue, 17 Sep 2019 12:53:24 +0200 (CEST)
Received: from lem-wkst-02.lemonage (hq.lemonage.de [87.138.178.34])
        by smtp2.goneo.de (Postfix) with ESMTPSA id 4FCDF23F609;
        Tue, 17 Sep 2019 12:53:24 +0200 (CEST)
Date:   Tue, 17 Sep 2019 12:53:19 +0200
From:   Lars Poeschel <poeschel@lemonage.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v7 2/7] nfc: pn532_uart: Add NXP PN532 to devicetree docs
Message-ID: <20190917105319.GA18936@lem-wkst-02.lemonage>
References: <20190910093256.1920-1-poeschel@lemonage.de>
 <20190913203221.GA19194@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913203221.GA19194@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 03:32:21PM -0500, Rob Herring wrote:
> On Tue, Sep 10, 2019 at 11:32:53AM +0200, Lars Poeschel wrote:
> > Add a simple binding doc for the pn532.
> > 
> > Cc: Johan Hovold <johan@kernel.org>
> > Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
> > ---
> > Changes in v6:
> > - Rebased the patch series on v5.3-rc5
> > - Picked up Rob's Reviewed-By
> 
> And dropped in v7?

I am very sorry, I somehow lost it. :(
I will re-pick up it in v8.

> > Changes in v4:
> > - Add documentation about reg property in case of i2c
> > 
> > Changes in v3:
> > - seperate binding doc instead of entry in trivial-devices.txt
> > 
> >  .../devicetree/bindings/nfc/pn532.txt         | 33 +++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/nfc/pn532.txt
