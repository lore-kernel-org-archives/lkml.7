Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6768DC31E50
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AD122080A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560779525;
	bh=ADiItmR8aECipOdSDlRTkDMbta0fCjTD4rPDREe/EgM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=FVD6lZoYv717AflPqGWs7wZfOGJ0SJcgEqmhWw+2jc4YRNaoZtwY0awYS2+IRMAKy
	 eDPGvFJVXuuRJQwm8Za1ylY9ReSZEp5G70iI7RW6ap6TQxzmZ3cOr41Zv6HkUSG7d/
	 MGIhCKN4gxHVIE9ypju4+/YfXCYExalYK0fHEQ/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfFQNwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 09:52:03 -0400
Received: from casper.infradead.org ([85.118.1.10]:50732 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfFQNwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rqoIj6ukwJM6l56EUxxnRITr+tibvaPKGHXeg6stNSw=; b=qfKX0T9vD3Jr2Jtfa1cJHW1EdS
        jxjCFwsVgdI0mcoZG1NtKye1fbR6u76zbwjRB3lbVSwAaC5US5sdheGAvCCvYO7D/iOA2PeTGV1n9
        dYtZtKcJAaQT1fAaLiNONQflP5GZ+6HlIGKvncFnGApIQc3M2l06bQZuLjvmu19Im60Un2pvMJmWD
        HksolIGmjABbfAiPYma6XBr/Xy1hGa00Swn2hb/DDSVJ+ejmzfQRsU5HRCw+LnoNqs4c/O2iavTDk
        cDulxLWgxwY7N9GoMzR1PMFp4K8qIX14bsMfEwTFfZCKu4jylrg6lNIVHtGzfs7HwMWWh6JvvAT0R
        /qE3lOmw==;
Received: from 179.186.105.91.dynamic.adsl.gvt.net.br ([179.186.105.91] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hcs3E-0002ed-FW; Mon, 17 Jun 2019 13:52:01 +0000
Date:   Mon, 17 Jun 2019 10:51:54 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 12/14] doc-rst: add ABI documentation to the admin-guide
 book
Message-ID: <20190617105154.3874fd89@coco.lan>
In-Reply-To: <874l4ov16m.fsf@intel.com>
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
        <9da2a7f6ff57d9d53dcbb964eb310f7956522870.1560477540.git.mchehab+samsung@kernel.org>
        <87o930uvur.fsf@intel.com>
        <20190614140603.GB7234@kroah.com>
        <20190614122755.1c7b4898@coco.lan>
        <874l4ov16m.fsf@intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 17 Jun 2019 15:36:17 +0300
Jani Nikula <jani.nikula@linux.intel.com> escreveu:

> On Fri, 14 Jun 2019, Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> > Em Fri, 14 Jun 2019 16:06:03 +0200
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:
> >  
> >> On Fri, Jun 14, 2019 at 04:42:20PM +0300, Jani Nikula wrote:  
> >> > 2) Have the python extension read the ABI files directly, without an
> >> >    extra pipeline.    
> >> 
> >> He who writes the script, get's to dictate the language of the script :)  
> 
> The point is, it's an extension to a python based tool, written in perl,
> using pipes for communication, and losing any advantages of integrating
> with the tool it's extending.
> 
> I doubt you'd want to see system() to be used to subsequently extend the
> perl tool.
> 
> I think it's just sad to see the documentation system slowly drift
> further away from the ideals we had, and towards the old ways we worked
> so hard to fix.

Actually, it is a perl script that can be used standalone (just like
get_maintainers.pl and kernel-doc) with have some features including
producing a ReST output. We could easily get rid of the python extension,
if we add this to the Makefile (adjusted to work with O= option):

	./scripts/get_api.pl rest > Documentation/output/admin-guide/abi.rst

> 
> > No idea about how much time it would take if written in python,
> > but this perl script is really fast:
> >
> > 	$ time ./scripts/get_abi.pl search voltage_max >/dev/null
> > 	real	0m0,139s
> > 	user	0m0,132s
> > 	sys	0m0,006s
> >
> > That's the time it takes here (SSD disks) to read all files under
> > Documentation/ABI, parse them and seek for a string.
> >
> > That's about half of the time a python script takes to just import the
> > the sphinx modules and print its version, running at the same machine:
> >
> > 	$ time sphinx-build --version >/dev/null
> >
> > 	real	0m0,224s
> > 	user	0m0,199s
> > 	sys	0m0,024s  
> 
> Please at least use fair and sensible comparisons. If you want to make
> the extension usable standalone on the command-line, bypassing Sphinx,
> you can do that. No need to factor in Sphinx to your comparisons.

Yeah, I guess it should be possible to do that. How a python script
can identify if it was called by Sphinx, or if it was called directly?

Thanks,
Mauro
