Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FE8C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 13:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22442166E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 13:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560952599;
	bh=CrgsIQOlnZ6WGQUTaZ94BputxQ7/aGD8YS1CVN4baqo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=pHC5vi5tgxwBor0NswfhthRbBJsNBocKEHF02TIUR/iiYsNbm76j5LjIMG4Li3saY
	 KGcjlfCrHyvH6ioymRSukD0cR+cLDqnkgmdqg31zaDw8oAw0SQUToB+N7sSpBJz8aV
	 8KPyNfmQ/d/IHo3aXgNCej6QwLZvzqwXVSIgWe/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfFSN4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 09:56:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47314 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFSN4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 09:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vs3lq9W8ecN8AOibEdB+lMHYvJb+tdRA2lymEIS3aZY=; b=qv5azAkUbWT/qFwdLJJ7OVUiR
        KTot7UkL3UrUVK8a4Wwr7UwiPLCW4rAIf6l2RTgs8ru578UpYp9BaRkDsPGLeyshBJaie55vvKQ6B
        7Ap7+MglsrD9N1sDuT7n/9Al1nxDo76qDeiLvdJKdPxcpO3MBE3jOEr66ljzYJwzZ+QxFVLOiUWIZ
        qNwFwTPvw+Q2ophHAY8SH4TOj90jMyddUJBgEJDoBvIlPisCEYToZ47OO4JxM8k6YgmxKJttk3aho
        e/K1ChlXz+8hMq2HpwWf+1a01w0tXcjo59q5t9uXXMqsoh3hlHa5RS4HUxZkrf+UIG6uxe1kr+h0B
        +BNm5kRKg==;
Received: from 177.133.86.196.dynamic.adsl.gvt.net.br ([177.133.86.196] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdb4n-00028r-8f; Wed, 19 Jun 2019 13:56:37 +0000
Date:   Wed, 19 Jun 2019 10:56:33 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Stefan Achatz <erazor_de@users.sourceforge.net>
Subject: Re: [PATCH 04/14] ABI: better identificate tables
Message-ID: <20190619105633.7f7315a5@coco.lan>
In-Reply-To: <20190619125135.GG25248@localhost>
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
        <6bc45c0d5d464d25d4d16eceac48a2f407166944.1560477540.git.mchehab+samsung@kernel.org>
        <20190619125135.GG25248@localhost>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

Em Wed, 19 Jun 2019 14:51:35 +0200
Johan Hovold <johan@kernel.org> escreveu:

> On Thu, Jun 13, 2019 at 11:04:10PM -0300, Mauro Carvalho Chehab wrote:
> > From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> > 
> > When parsing via script, it is important to know if the script
> > should consider a description as a literal block that should
> > be displayed as-is, or if the description can be considered
> > as a normal text.
> > 
> > Change descriptions to ensure that the preceding line of a table
> > ends with a colon. That makes easy to identify the need of a
> > literal block.  
> 
> In the cover letter you say that the first four patches of this series,
> including this one, "fix some ABI descriptions that are violating the
> syntax described at Documentation/ABI/README". This seems a bit harsh,
> given that it's you that is now *introducing* a new syntax requirement
> to assist your script.

Yeah, what's there at the cover letter doesn't apply to this specific
patch. The thing is that I wrote this series a lot of time ago (2016/17).

I revived those per a request at KS ML, as we still need to expose the
ABI content on some book that will be used by userspace people.

So, I just rebased it on the top of curent Kernel, add a cover letter
with the things I remembered and re-sent.

In the specific case of this patch, the ":" there actually makes sense
for someone that it is reading it as a text file, and it is an easy
hack to make it parse better.

> Specifically, this new requirement isn't documented anywhere AFAICT, so
> how will anyone adding new ABI descriptions learn about it?

Yeah, either that or provide an alternative to "Description" tag, to be
used with more complex ABI descriptions.

One of the things that occurred to me, back on 2017, is that we should
have a way to to specify that an specific ABI description would have
a rich format. Something like:

What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/pyra/roccatpyra<minor>/actual_cpi
Date:		August 2010
Contact:	Stefan Achatz <erazor_de@users.sourceforge.net>
RST-Description:
		It is possible to switch the cpi setting of the mouse with the
		press of a button.
		When read, this file returns the raw number of the actual cpi
		setting reported by the mouse. This number has to be further
		processed to receive the real dpi value:

		===== =====
		VALUE DPI
		===== =====
		1     400
		2     800
		4     1600
		===== =====

With that, the script will know that the description contents will be using
the ReST markup, and parse it accordingly. Right now, what it does, instead,
is to place the description on a code-block, e. g. it will produce this
output for the description:

::

		It is possible to switch the cpi setting of the mouse with the
		press of a button.
		When read, this file returns the raw number of the actual cpi
		setting reported by the mouse. This number has to be further
		processed to receive the real dpi value:

		VALUE DPI
		1     400
		2     800
		4     1600


Greg, 

what do you think?

Thanks,
Mauro
