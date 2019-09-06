Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C763C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 18:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A04D214DE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 18:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395355AbfIFSap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 14:30:45 -0400
Received: from smtprelay0196.hostedemail.com ([216.40.44.196]:50330 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730881AbfIFSao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 14:30:44 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 415B3180A68C2;
        Fri,  6 Sep 2019 18:30:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: range19_5d5ebd3838638
X-Filterd-Recvd-Size: 2460
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Fri,  6 Sep 2019 18:30:41 +0000 (UTC)
Message-ID: <de9f0991025f3f527beff494682df9fc1a47be98.camel@perches.com>
Subject: Re: [PATCH] docs: license-rules.txt: cover SPDX headers on Python
 scripts
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jessica Yu <jeyu@kernel.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Thomas Gleixner <tglx@linutronix.de>, linux-doc@vger.kernel.org
Date:   Fri, 06 Sep 2019 11:30:40 -0700
In-Reply-To: <20190906151702.3e67ccf7@coco.lan>
References: <20190905055614.7958918b@coco.lan>
         <88e638eb959095ab6657d295f9f8c27169569bf2.1567675272.git.mchehab+samsung@kernel.org>
         <20190905092703.GA30899@kroah.com> <20190905090701.37dcf75e@coco.lan>
         <b32c2e46b91e7bcda2a9bd140673f06d71b2487a.camel@perches.com>
         <20190906083457.7e7934ec@coco.lan>
         <9d30210a2d024aae4c36c8995019cdeab29e1e19.camel@perches.com>
         <20190906151702.3e67ccf7@coco.lan>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-09-06 at 15:17 -0300, Mauro Carvalho Chehab wrote:
> Em Fri, 06 Sep 2019 10:33:42 -0700
> Joe Perches <joe@perches.com> escreveu:
> 
> > On Fri, 2019-09-06 at 08:34 -0300, Mauro Carvalho Chehab wrote:
> > > I did some changes on it, plus one change at the pedantic mode of
> > > scripts/spdxcheck.py, and placed the corresponding patches at:
> > > 
> > > 	https://git.linuxtv.org/mchehab/experimental.git/log/?h=spdx_pedantic  
> > 
> > Your script needs a modification of this line:
> 
> It is yours script, I just made a few improvements for it to also catch
> scripts.

Not really, my script worked only on .[ch] files to
avoid making the script more complicated and more
prone to the inevitable unintended defect which I
manage to introduce more often than I should.

btw:

I already submitted a separate patch for the arm/arm64
.dts and .dtsi files.

https://lore.kernel.org/linux-arm-kernel/f85fe45879469ba53d3ae91475b4502546de501e.camel@perches.com/

cheers, Joe

