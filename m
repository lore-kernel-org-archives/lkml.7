Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1BAC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 16:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771592146E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 16:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfF0Q1w convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 12:27:52 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:33557 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfF0Q1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 12:27:51 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 43C36E0010;
        Thu, 27 Jun 2019 16:27:45 +0000 (UTC)
Date:   Thu, 27 Jun 2019 18:27:42 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Naga Sureshkumar Relli <nagasureshkumarrelli@gmail.com>
Cc:     Naga Sureshkumar Relli <nagasure@xilinx.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "martin.lund@keep-it-simple.com" <martin.lund@keep-it-simple.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "nagasuresh12@gmail.com" <nagasuresh12@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>
Subject: Re: [LINUX PATCH v12 3/3] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Message-ID: <20190627182742.6389d772@xps13>
In-Reply-To: <20190619044424.GB28766@xhdnagasure40.xilinx.com>
References: <20181212100931.149b0cac@xps13>
        <MWHPR02MB2623EDA15BE59304795F3034AFA70@MWHPR02MB2623.namprd02.prod.outlook.com>
        <20181212141825.69711c57@xps13>
        <MWHPR02MB26235AE6567A06EF4C6362E6AFBC0@MWHPR02MB2623.namprd02.prod.outlook.com>
        <20181217174114.24196d17@xps13>
        <MWHPR02MB26237B932D7F3CCEE0476FE0AFBD0@MWHPR02MB2623.namprd02.prod.outlook.com>
        <20181219152647.76f77711@xps13>
        <MWHPR02MB262396FFF946A95D7821D61BAFB80@MWHPR02MB2623.namprd02.prod.outlook.com>
        <MWHPR02MB262328DF62906C01DCDF18E5AF960@MWHPR02MB2623.namprd02.prod.outlook.com>
        <20190128102720.70a52da7@xps13>
        <20190619044424.GB28766@xhdnagasure40.xilinx.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naga,

Naga Sureshkumar Relli <nagasureshkumarrelli@gmail.com> wrote on Tue,
18 Jun 2019 22:44:24 -0600:

> On Mon, Jan 28, 2019 at 10:27:39AM +0100, Miquel Raynal wrote:
> Hi Miquel,
> 
> > Hi Naga,
> > 
> > Naga Sureshkumar Relli <nagasure@xilinx.com> wrote on Mon, 28 Jan 2019
> > 06:04:53 +0000:
> >   
> > > Hi Boris & Miquel,
> > > 
> > > Could you please provide your thoughts on this driver to support HW-ECC?
> > > As I said previously, there is no way to detect errors beyond N bit.
> > > I am ok to update the driver based on your inputs.  
> > 
> > We won't support the ECC engine. It simply cannot be used reliably.
> > 
> > I am working on a generic ECC engine object. It's gonna take a few
> > months until it gets merged but after that you could update the
> > controller driver to drop any ECC-related function. Although the ECC  
> 
> Could you please let me know that, when can we expect generic ECC engine
> update in mtd NAND?
> Based on that, i will plan to update the ARASAN NAND driver along with your
> comments mentioned above under this update,
> as you know there is a limiation in ARASAN NAND controller to detect
> ECC errors.
> i am following this series https://patchwork.kernel.org/patch/10838705/

It is gonna take more time than expected. You can stick to the software
engines for now.

Thanks,
Miquèl
