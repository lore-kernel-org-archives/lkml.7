Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC18C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 16:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA86206CD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 16:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732161AbfIFQUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 12:20:40 -0400
Received: from smtprelay0113.hostedemail.com ([216.40.44.113]:47720 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727391AbfIFQUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 12:20:39 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 10FFD18026B11;
        Fri,  6 Sep 2019 16:20:38 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: jump19_79b02ed939a5d
X-Filterd-Recvd-Size: 2482
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Fri,  6 Sep 2019 16:20:36 +0000 (UTC)
Message-ID: <38bf64245d173d0de4452cac1c6cf028ad0490d8.camel@perches.com>
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
Date:   Fri, 06 Sep 2019 09:20:35 -0700
In-Reply-To: <20190906114552.524d0d50@coco.lan>
References: <20190905055614.7958918b@coco.lan>
         <88e638eb959095ab6657d295f9f8c27169569bf2.1567675272.git.mchehab+samsung@kernel.org>
         <20190905092703.GA30899@kroah.com> <20190905090701.37dcf75e@coco.lan>
         <b32c2e46b91e7bcda2a9bd140673f06d71b2487a.camel@perches.com>
         <20190906083457.7e7934ec@coco.lan>
         <a610efdd3bf488d407dc1130fa8ed090019ccffd.camel@perches.com>
         <20190906114552.524d0d50@coco.lan>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-09-06 at 11:45 -0300, Mauro Carvalho Chehab wrote:
> Em Fri, 06 Sep 2019 05:20:30 -0700
> Joe Perches <joe@perches.com> escreveu:
> 
> > On Fri, 2019-09-06 at 08:34 -0300, Mauro Carvalho Chehab wrote:
> > > I did some changes on it, plus one change at the pedantic mode of
> > > scripts/spdxcheck.py, and placed the corresponding patches at:
> > > 
> > > 	https://git.linuxtv.org/mchehab/experimental.git/log/?h=spdx_pedantic  
> > 
> > Overall seems very nice, thanks.
> > 
> > Couple nits.
> > 
> > Some of the scripts and py files move the author
> > block into a description or add unnecessary blank
> > comments.  These may use some manual fixups.
> 
> True. I noticed that too. I suspect that fixing this automatically would 
> make the script too complex.
> 
> Anyway, the point is: who will apply it? Linus? Each maintainer?

I have been advocating for a treewide scripted mechanism for awhile.
https://lore.kernel.org/lkml/4398924f28a58fca296d101dae11e7accce80656.camel@perches.com/



