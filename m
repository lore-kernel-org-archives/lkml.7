Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EFBC06511
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D496F206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfGALYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 07:24:32 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:60107 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbfGALYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 07:24:32 -0400
X-Originating-IP: 86.250.200.211
Received: from bootlin.com (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 434A124000D;
        Mon,  1 Jul 2019 11:24:28 +0000 (UTC)
Date:   Mon, 1 Jul 2019 13:24:39 +0200
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        David Miller <davem@davemloft.net>, brian.brooks@linaro.org,
        linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        nadavh@marvell.com, stefanc@marvell.com,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH] driver core: platform: Allow using a dedicated dma_mask
 for platform_device
Message-ID: <20190701132340.21123dee@bootlin.com>
In-Reply-To: <20190628155946.GA16956@infradead.org>
References: <20190628141550.22938-1-maxime.chevallier@bootlin.com>
 <20190628155946.GA16956@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Fri, 28 Jun 2019 08:59:46 -0700
Christoph Hellwig <hch@infradead.org> wrote:

>I'd much rather bite the bullet and make dev->dma_mask a scalar
>instead of a pointer.  The pointer causes way to much boiler plate code,
>and the semantics are way to subtile.

I agree that this the real solution, it just seemed a bit overwhelming
to me. I'll be happy to help with this though, now that you took a big
first step.

> Below is a POV patch that
>compiles and boots with my usual x86 test config, and at least compiles
>with the arm and pmac32 defconfigs.  It probably breaks just about
>everything else, but should give us an idea what is involve in the
>switch:

I'll test that on my boards too.

Thanks,

Maxime
