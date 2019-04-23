Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30129C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F135921773
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556048813;
	bh=r9IzEWyW5Le0N3r0EJSg8kliDkNg4GWgud83MRVIXIs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=DcUy0SyP8spkj0JkXeYtQhYavLH6nSH9npbHn2ibwpSqY+NbC98JAGvFRvLPMJMnE
	 xYAY4gZmGejoM+Ppa0svkbIceGweow7xz3plnyWLX6ZCjTj8Drj+9B5zkXdR7EVoF0
	 GwV+pZVpPjd1TDGHfoTz5xo4Y1WDoyuhMG77t+ac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfDWTqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 15:46:52 -0400
Received: from casper.infradead.org ([85.118.1.10]:58734 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfDWTqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 15:46:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bXCtVxVs212+Wn50ho2GN+2s0un3+U1RAoWJPEzBmmk=; b=dkSf5AuA4o7pIqttxEX10oHRAh
        HZo2qbBi+11rjNzG0pclb8FWqA/QaNUrJX48mQx0SlFdX4erPLle3hGmvrccZlb3OGUOf4ennjsG9
        YYXadd/V0l2gUAIMJuLkmiGAN1r1SVUcIXnMs/VVphryTAOS6gMZKrLJBOm9rGc3APgMAvrt9dVp8
        /uAll6mOPBAsauo1ZVSzZMczxZmwayNH3hYYa0V+g9Z7ZvvAg0ynAP5we09ise/ygl3PdrM7ysJiU
        DBD7qwJ7E66ut5QLYcg5eop1BxmRUbsJ7p3j5yvyP4PMyGJScGM9CfmhM1pWvzkcD7/3n7T2hshFM
        NUw65O3w==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJ1NP-0000Zj-JG; Tue, 23 Apr 2019 19:46:47 +0000
Date:   Tue, 23 Apr 2019 16:46:40 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Farhan Ali <alifm@linux.ibm.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH v2 31/79] docs: s390: convert docs to ReST and rename to
 *.rst
Message-ID: <20190423164640.0ed01c20@coco.lan>
In-Reply-To: <3b40a683-a77e-0219-b5bc-2ead38e627af@linux.ibm.com>
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
        <fb86b676b3b426732f1f11378868a9bd3b580b46.1555938376.git.mchehab+samsung@kernel.org>
        <3b40a683-a77e-0219-b5bc-2ead38e627af@linux.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 23 Apr 2019 12:12:41 -0400
Farhan Ali <alifm@linux.ibm.com> escreveu:

> On 04/22/2019 09:27 AM, Mauro Carvalho Chehab wrote:
> > Convert all text files with s390 documentation to ReST format.
> > 
> > Tried to preserve as much as possible the original document
> > format. Still, some of the files required some work in order
> > for it to be visible on both plain text and after converted
> > to html.
> > 
> > The conversion is actually:
> >    - add blank lines and identation in order to identify paragraphs;
> >    - fix tables markups;
> >    - add some lists markups;
> >    - mark literal blocks;
> >    - adjust title markups.
> > 
> > At its new index.rst, let's add a :orphan: while this is not linked to
> > the main index.rst file, in order to avoid build warnings.
> > 
> > Signed-off-by: Mauro Carvalho Chehab<mchehab+samsung@kernel.org>
> > ---  
> 
> Hi Mauro,
> 
> How would the s390 rst files be accessed from a top level index.rst 
> file? Is there a view of the changes? I looked at a link you posted [1] 
> as a reply in another thread, but I couldn't find the s390 docs there.
> 
> [1] https://www.infradead.org/~mchehab/rst_conversion/

With just the patch I added on this series, you'll find the s390
index.html, and one file for each .rst at Documentation/output/s390/.

In order to have it linked to the main index, you need to add
s390/index to Documentation/index.rst, but, if you just want to
see the results, you can just call:

	$ firefox file://`pwd`/Documentation/output/s390/index.html

I have a patch already that adds s390 to the main index, together with
other arch conversions:

	https://git.linuxtv.org/mchehab/experimental.git/commit/?h=convert_rst_renames&id=d28c466a495488e5e57c7893123011342eea40b2

However, as subsystem maintainers may take a while to apply some of those
patches, and there's a patchset converting x86 arch too, I opted to do
such additions on a separate patch, in order to reduce merge conflicts.

Thanks,
Mauro
