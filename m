Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94C0C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DCB3217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560526085;
	bh=CLk9UZDxZQ9t+jNshSiXyh3TCxTZNI5t9usdPil2NTI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Uw1wW6CT2TehbHFd4sogs/CsyhQj4ZDmkDcCnvBZ2dEeMplGpGjEGYTbFZc7Y/XQ1
	 R0415P8y1TsMfbW8BjUMATl1He8CxVNwIVCrmM5qaL0kOElozsHORtXPb+DsaLsoz6
	 HLISasf10PntjML0mdWRaSYh+d9KgPIQAr0b2dMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfFNP2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 11:28:03 -0400
Received: from casper.infradead.org ([85.118.1.10]:44860 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfFNP2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 11:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zkYfXJDrba3J/ihhf3pDgW4+XmjWJ9BtTd3Y+UzyafE=; b=BS4ZrbvjFPyHk5xTId0ecXBLat
        Eni7lDtC5c80433fhcjoauEll6LtbS9S/fsvWv32ufxW/XTHAPEcfTjASF3wf4Gc1lv6TBtc1ZYsC
        G/xseTJ8Z9UFEWcexun0lnArWMTwuyO3ZJlueKfxsLz0G1iTTU4KbBn3OVFbN+qCpR5hCPA/LGzvv
        xblKmJx45lS/5NxhKoFJIHGB5Q/dov5mWXKaIopI66sCnlkHoR8M39ZKTlsorzUjs9i+7MUVyWrFb
        Lj/Lb26SC48111GgRl0/zFEiTsCzUXyvLUerQHrwifk/U/+d7jEM0JFcQZp46DZop5KvdDI28SemZ
        ib7N4LrQ==;
Received: from 177.133.85.52.dynamic.adsl.gvt.net.br ([177.133.85.52] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbo7T-0007sx-Kb; Fri, 14 Jun 2019 15:28:00 +0000
Date:   Fri, 14 Jun 2019 12:27:55 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 12/14] doc-rst: add ABI documentation to the admin-guide
 book
Message-ID: <20190614122755.1c7b4898@coco.lan>
In-Reply-To: <20190614140603.GB7234@kroah.com>
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
        <9da2a7f6ff57d9d53dcbb964eb310f7956522870.1560477540.git.mchehab+samsung@kernel.org>
        <87o930uvur.fsf@intel.com>
        <20190614140603.GB7234@kroah.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 14 Jun 2019 16:06:03 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:

> On Fri, Jun 14, 2019 at 04:42:20PM +0300, Jani Nikula wrote:
> > On Thu, 13 Jun 2019, Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:  
> > > From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> > >
> > > As we don't want a generic Sphinx extension to execute commands,
> > > change the one proposed to Markus to call the abi_book.pl
> > > script.
> > >
> > > Use a script to parse the Documentation/ABI directory and output
> > > it at the admin-guide.  
> > 
> > We had a legacy kernel-doc perl script so we used that instead of
> > rewriting it in python. Just to keep it bug-for-bug compatible with the
> > past. That was the only reason.
> > 
> > I see absolutely zero reason to add a new perl monstrosity with a python
> > extension to call it. All of this could be better done in python,
> > directly.
> > 
> > Please don't complicate the documentation build. I know you know we all
> > worked hard to take apart the old DocBook Rube Goldberg machine to
> > replace it with Sphinx. Please don't turn the Sphinx build to another
> > complicated mess.
> > 
> > My strong preferences are, in this order:
> > 
> > 1) Convert the ABI documentation to reStructuredText  
> 
> What would that exactly look like?  What would it require for new
> developers for when they write new entries?  Why not rely on a helper
> script, that allows us to validate things better?

Funny enough, this e-mail arrived here after Greg's reply, and my
reply over his one :-)

-

With regards to the script, my idea is to have it run on a new
"validate" mode, when the Kernel is built with COMPILE_TEST:

	https://git.linuxtv.org/mchehab/experimental.git/log/?h=abi_patches_v4

NB: the last patch is not yet... somehow, the building system is not
passing CONFIG_WARN_ABI_ERRORS to Documentation/Makefile. I'm
debugging it.

Personally, I would prefer to keep it the way it is, with two
additions:

1) I would add a SPDX header at the fist line of each file there;

2) It would make sense to have a new field - or indicator - to let
add ReST markups at the description. 

The advantage of using a parseable ABI file is that it is possible
to parse it, for example, to search for a symbol:

	$ ./scripts/get_abi.pl voltage_max

	/sys/class/power_supply/<supply_name>/voltage_max
	-------------------------------------------------

	Date:			January 2008
	Contact:		linux-pm@vger.kernel.org
	Defined on file:	Documentation/ABI/testing/sysfs-class-power

	Description:

	Reports the maximum VBUS voltage the supply can support.

	Access: Read
	Valid values: Represented in microvolts

	...

> 
> > 2) Have the python extension read the ABI files directly, without an
> >    extra pipeline.  
> 
> He who writes the script, get's to dictate the language of the script :)

No idea about how much time it would take if written in python,
but this perl script is really fast:

	$ time ./scripts/get_abi.pl search voltage_max >/dev/null
	real	0m0,139s
	user	0m0,132s
	sys	0m0,006s

That's the time it takes here (SSD disks) to read all files under
Documentation/ABI, parse them and seek for a string.

That's about half of the time a python script takes to just import the
the sphinx modules and print its version, running at the same machine:

	$ time sphinx-build --version >/dev/null

	real	0m0,224s
	user	0m0,199s
	sys	0m0,024s

> Personally, this looks sane to me, I'm going to apply the ABI fixups to
> my tree at least, and then see how the script works out.  The script can
> always be replaced with a different one in a different language at a
> later point in time of people think it really mattes.

Thanks,
Mauro
