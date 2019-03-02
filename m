Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F53CC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 14:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CA320836
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 14:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfCBOsA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 09:48:00 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:35589 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfCBOsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 09:48:00 -0500
X-Originating-IP: 77.154.225.176
Received: from xps13 (176.225.154.77.rev.sfr.net [77.154.225.176])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 1A9D2E0008;
        Sat,  2 Mar 2019 14:47:54 +0000 (UTC)
Date:   Sat, 2 Mar 2019 15:47:52 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Kees Cook <keescook@chromium.org>,
        Wan ZongShun <mcuos.com@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] mtd: rawnand: Mark expected switch fall-throughs
Message-ID: <20190302154752.4e05d010@xps13>
In-Reply-To: <91f56f21-48da-1f0a-4018-e080905aca0d@embeddedor.com>
References: <20190208174930.GA12962@embeddedor>
        <1a9e7d7e-6743-4932-a1b6-528ae7e5643a@embeddedor.com>
        <2354894.fi12vfZcmb@blindfold>
        <91f56f21-48da-1f0a-4018-e080905aca0d@embeddedor.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote on Fri, 1 Mar 2019
18:33:13 -0600:

> On 3/1/19 4:39 PM, Richard Weinberger wrote:
> > Am Freitag, 1. März 2019, 22:38:18 CET schrieb Gustavo A. R. Silva:  
> >> Hi all,
> >>
> >> Friendly ping:
> >>
> >> Who can take this, please?  
> > 
> > /me points to Miquel. :)

Yup!

> >   
> 
> Thanks, Richard.
> 
> Hopefully, Miquel will take this for 5.1. :)

No. The timing on your side was right but I was late to send the PR and
I choose not to take this one in a hurry although you addressed only
trivial cases and left aside the ones which were more likely to
introduce bugs. Nevertheless, I plan to queue it for 5.2.


Thanks,
Miquèl
