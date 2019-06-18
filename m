Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EE0C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 00:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0C920873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 00:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfFRAZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 20:25:21 -0400
Received: from smtprelay0236.hostedemail.com ([216.40.44.236]:48362 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725829AbfFRAZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 20:25:21 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 29EC41F0A;
        Tue, 18 Jun 2019 00:25:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: clock60_4b5582c271355
X-Filterd-Recvd-Size: 2222
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Tue, 18 Jun 2019 00:25:17 +0000 (UTC)
Message-ID: <547e251d87e307fa4d1e31dfc61b496c152f0905.camel@perches.com>
Subject: Re: [PATCH v5 2/3] mtd: spi-nor: add support to unlock flash device
From:   Joe Perches <joe@perches.com>
To:     Sagar Kadam <sagar.kadam@sifive.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Wesley Terpstra <wesley@sifive.com>
Date:   Mon, 17 Jun 2019 17:25:16 -0700
In-Reply-To: <CAARK3HmFg=v+cMGAykPPpwxDGaSKk5k+Gz4fSHQPQmg-rCjPhQ@mail.gmail.com>
References: <1560336476-31763-1-git-send-email-sagar.kadam@sifive.com>
         <1560336476-31763-3-git-send-email-sagar.kadam@sifive.com>
         <70732c8e-111f-7c46-9e93-11894d944a1d@ti.com>
         <CAARK3HmFg=v+cMGAykPPpwxDGaSKk5k+Gz4fSHQPQmg-rCjPhQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-06-17 at 21:10 +0530, Sagar Kadam wrote:
> On Sun, Jun 16, 2019 at 6:35 PM Vignesh Raghavendra <vigneshr@ti.com> wrote:
[]
> > > +static int issi_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
> > > +{
[]
> > > +     if (ret > 0 && !(ret & mask)) {
> > > +             dev_info(nor->dev,
> > > +                     "ISSI Block Protection Bits cleared SR=0x%x", ret);

Please use '\n' terminations on formats

> > > +             ret = 0;
> > > +     } else {
> > > +             dev_err(nor->dev, "ISSI Block Protection Bits not cleared\n");

like this one

> > > +             ret = -EINVAL;
> > > +     }
> > > +     return ret;
> > > +}
> > > +
> > > +/**
> > >   * spansion_quad_enable() - set QE bit in Configuraiton Register.

s/Configuraiton/Configuration/


