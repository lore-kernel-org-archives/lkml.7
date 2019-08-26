Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00888C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 14:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F642173E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 14:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732214AbfHZODC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 10:03:02 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47618 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732193AbfHZODC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 10:03:02 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 7233528A9BB;
        Mon, 26 Aug 2019 15:03:00 +0100 (BST)
Date:   Mon, 26 Aug 2019 16:02:57 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>
Subject: Re: [RESEND PATCH v3 14/20] mtd: spi_nor: Add a ->setup() method
Message-ID: <20190826160257.17b46962@collabora.com>
In-Reply-To: <d44218eb-458a-dd59-b79d-7803de2bdc09@kontron.de>
References: <20190826120821.16351-1-tudor.ambarus@microchip.com>
        <20190826120821.16351-15-tudor.ambarus@microchip.com>
        <20190826144002.479494be@collabora.com>
        <d44218eb-458a-dd59-b79d-7803de2bdc09@kontron.de>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Aug 2019 13:38:48 +0000
Schrempf Frieder <frieder.schrempf@kontron.de> wrote:

> On 26.08.19 14:40, Boris Brezillon wrote:
> > On Mon, 26 Aug 2019 12:08:58 +0000
> > <Tudor.Ambarus@microchip.com> wrote:
> >   
> >> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> >>
> >> nor->params.setup() configures the SPI NOR memory. Useful for SPI NOR
> >> flashes that have peculiarities to the SPI NOR standard, e.g.
> >> different opcodes, specific address calculation, page size, etc.
> >> Right now the only user will be the S3AN chips, but other
> >> manufacturers can implement it if needed.
> >>
> >> Move spi_nor_setup() related code in order to avoid a forward
> >> declaration to spi_nor_default_setup().
> >>
> >> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>  
> > 
> > Nitpick: R-bs should normally be placed after your SoB.  
> 
> Just a question unrelated to the patch content:
> 
> I learned to add R-b tags after my SoB when submitting MTD patches, but 
> recently I submitted a patch to the serial subsystem and was told to put 
> my SoB last. Is there an "official" rule for this? And if so where to 
> find it?

Should match the order of addition: if you picked an existing patch that
had already received R-b/A-b tags and applied it to your tree you
should add your SoB at the end. But if you are the author, your SoB
should come first. At least that's the rule I follow :-).
