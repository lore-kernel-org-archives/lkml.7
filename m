Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7610C468BD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 11:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8CC520673
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 11:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfFILzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 07:55:18 -0400
Received: from smtprelay0014.hostedemail.com ([216.40.44.14]:45579 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728356AbfFILzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 07:55:18 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 367EE181D3419;
        Sun,  9 Jun 2019 11:55:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tail02_2dc14101a324c
X-Filterd-Recvd-Size: 2654
Received: from XPS-9350 (107-134-184-123.lightspeed.renonv.sbcglobal.net [107.134.184.123])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Sun,  9 Jun 2019 11:55:14 +0000 (UTC)
Message-ID: <ba5ec856bce34eead8ba655b9bd6c54b002c40b5.camel@perches.com>
Subject: Re: [PATCH] media: do not use C++ style comments in uapi headers
From:   Joe Perches <joe@perches.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Julia Lawall <julia.lawall@lip6.fr>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sun, 09 Jun 2019 04:55:09 -0700
In-Reply-To: <CAK7LNARsSFT1ncyRgWi_tga_7KC6ZwZOETXQ2GrO9PfeJgLxyQ@mail.gmail.com>
References: <20190604111334.22182-1-yamada.masahiro@socionext.com>
         <8cf48e20064eabdfe150795365e6ca6f36032e9f.camel@perches.com>
         <CAK8P3a1oDfNF_T+NCoPsXkJAY2x4_uCWSwrDXHi7dDSaMqfnfA@mail.gmail.com>
         <CAK7LNAS0Ph2Z6x0-UPSkJUC31NvPi09BmFrve+YJcXMrop-BGA@mail.gmail.com>
         <20190604134213.GA26263@kroah.com>
         <CAK7LNARyqW3q6_46e-aYjmF8c0jUNDLdyB28zNaBEXqTV+5QSA@mail.gmail.com>
         <CAK8P3a0bz8XYJOsmND2=CT_oTDmGMJGaRo9+QMroEhpekSMEaQ@mail.gmail.com>
         <CAK7LNARU+uT0aUBh5niwEafL8+Ok7=sOZYukptpDH1w7Cii3hQ@mail.gmail.com>
         <20190605051040.GA22760@kroah.com>
         <b70cf8c1f901ea09abbdb22dd28244b18fd1a39d.camel@perches.com>
         <20190605071413.779bd821@coco.lan>
         <a798561d24c486d31063a7994d8630c859df00e9.camel@perches.com>
         <CAK7LNARsSFT1ncyRgWi_tga_7KC6ZwZOETXQ2GrO9PfeJgLxyQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-06-09 at 16:14 +0900, Masahiro Yamada wrote:
> Hi Joe,
> 
> On Thu, Jun 6, 2019 at 2:06 AM Joe Perches <joe@perches.com> wrote:
> > Perhaps a checkpatch change too:
> > 
> > The first block updates unsigned only bitfields
> > The second tests uapi definitions and suggests "__<kernel_types"
> 
> Good.
> 
> In addition,
> 
> "warn if __u8, __u16, __u32, __u64 are used outside of uapi/"
> 
> Lots of kernel-space headers use __u{8,16,32,64} instead of u{8,16,32,64}
> just because developers often miss to understand when to use
> the underscore-prefixed types.

The problem there is that checkpatch can't know if the
__<uapi_type> being used is for an actual uapi use or not.

coccinelle could be much better at that.

