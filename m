Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00529C5B576
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 21:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD96D20828
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 21:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfF0VWP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 17:22:15 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:33121 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfF0VWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 17:22:15 -0400
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 20E32200006;
        Thu, 27 Jun 2019 21:22:12 +0000 (UTC)
Date:   Thu, 27 Jun 2019 23:22:07 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: linux-next: manual merge of the nand tree with Linus' tree
Message-ID: <20190627232207.6af24e5e@xps13>
In-Reply-To: <20190627165129.3b2c1264@xps13>
References: <20190604105418.58da18b2@canb.auug.org.au>
        <20190627165129.3b2c1264@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Miquel Raynal <miquel.raynal@bootlin.com> wrote on Thu, 27 Jun 2019
16:51:37 +0200:

> Hi Stephen,
> 
> Stephen Rothwell <sfr@canb.auug.org.au> wrote on Tue, 4 Jun 2019
> 10:54:18 +1000:
> 
> > Hi all,
> > 
> > Today's linux-next merge of the nand tree got a conflict in:
> > 
> >   Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt
> > 
> > between commit:
> > 
> >   a5f2246fb913 ("dt: bindings: mtd: replace references to nand.txt with nand-controller.yaml")
> > 
> > from Linus' tree and commit:
> > 
> >   33cc5bd0b87a ("dt-bindings: mtd: brcmnand: Make nand-ecc-strength and nand-ecc-step-size optional")
> > 
> > from the nand tree.
> > 
> > I fixed it up (the latter included the changes from the former, so I
> > just used that) and can carry the fix as necessary. This is now fixed
> > as far as linux-next is concerned, but any non trivial conflicts should
> > be mentioned to your upstream maintainer when your tree is submitted for
> > merging.  You may also want to consider cooperating with the maintainer
> > of the conflicting tree to minimise any particularly complex conflicts.
> >   
> 
> Can you please share the fix? I might want to include it in the final
> PR.
> 

Actually I decided to rebase my branch to avoid all conflicts, no
need for the fix, thanks.

Miquèl
