Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A93C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7402084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="tmh+hfQK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388604AbfCAPQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 10:16:43 -0500
Received: from mail.nic.cz ([217.31.204.67]:43210 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbfCAPQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 10:16:42 -0500
Received: from localhost (unknown [172.20.6.218])
        by mail.nic.cz (Postfix) with ESMTPS id CA1CD63444;
        Fri,  1 Mar 2019 16:16:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1551453400; bh=xQap3CoWR+2YQfTLq2MzDkvKlXLZoNj1sEMenV5XoMg=;
        h=Date:From:To;
        b=tmh+hfQKVCbszTTsJRHOMUQH6cOAAAp+AtOr5q5oFNkb03VH1DYuRFXBcXxtRzO2/
         I8wKx6Z3hw26GbxIb2MDoKbe1dXjC9DgR2bRGlMEsuXKL39HZkI+a1e+ps/le5b/Q3
         sxxoW8bWhKp1yb+IP0U8FeDU8E0HfWSw2ax2A96Y=
Date:   Fri, 1 Mar 2019 16:16:40 +0100
From:   Marek Behun <marek.behun@nic.cz>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Tony Lindgren <tony@atomide.com>, Shawn Guo <shawnguo@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 bus+gpio 5/5] dt-bindings: gpio: Document GPIOs via
 Moxtet bus
Message-ID: <20190301161640.2390c8af@nic.cz>
In-Reply-To: <CACRpkdYpjjpVNUXRgT=XY758FGtDYow2fvwpah37T_GjTvLauQ@mail.gmail.com>
References: <20190301035852.26780-1-marek.behun@nic.cz>
        <20190301035852.26780-6-marek.behun@nic.cz>
        <CACRpkdYpjjpVNUXRgT=XY758FGtDYow2fvwpah37T_GjTvLauQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Mar 2019 15:36:09 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> > +               compatible = "cznic,moxtet-gpio";  
> 
> Is cznic registered in
> Documentation/devicetree/bindings/vendor-prefixes.txt?

Yes, it is registered.
Thank you for the review.
Marek
