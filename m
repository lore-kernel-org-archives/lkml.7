Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A5CC31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B7521880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560959659;
	bh=ARTOLHRHR1hFlR81jKHz4t0apOrt0IvLivvVcQ5cca8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=hXXly8EqZFbfuitVujki6wm9fSB29aavI2zGCiJzX4ALQS56x3e3KnL2YmttijBoA
	 cXfAkboPgGCO4ke6fz6n/OT6xE0ibb4ndRi9hr8pFSPQGhvSZSp1/amx1CmfaAsiap
	 KiuKSlPtPwKFBviWVEPnQS+6iwnYqVTbMed64E3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbfFSPyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:54:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34426 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729659AbfFSPyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AdWAClAsfgdFDOJ8SthOKZD1SKi8T6yPStutUze/gU0=; b=Wvx1FUNrzE5YYXD5o9Dr+bO15
        j1jeHYKfNRQGrDYwaCKhV/IdcRcjftWo+6hZ9RsS1kDngLy+TbYtXv1fko94u+vEKt1BBzU2sdhjg
        CydrwMLlm7xIXkbJOGt2uQuYKBIGFuzPeNeEXPom6V32KWbdN0OU18OrYqnsexrt6KiKsqsBok1yy
        TuOWNGqGLnekOhD/iibLN0pQ/Ugf5N9OnwV+gMWzGT++sgnCVsLyTxO35KjFZlGSh8oakU3SXUij6
        oiSlX5OoOWCm0zB60t1LkC7V8sI6jj3RleF1e66cuyOgNtwJ0de7ZMt9PT/xeTXTPsL+IVmbgU1nE
        98zoAB5yw==;
Received: from 177.133.86.196.dynamic.adsl.gvt.net.br ([177.133.86.196] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdcub-000669-Sg; Wed, 19 Jun 2019 15:54:14 +0000
Date:   Wed, 19 Jun 2019 12:54:10 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     David Howells <dhowells@redhat.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Asmaa Mnebhi <Asmaa@mellanox.com>,
        Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH v1 12/22] docs: driver-api: add .rst files from the main
 dir
Message-ID: <20190619125410.6da59ea6@coco.lan>
In-Reply-To: <20190619085458.08872dbb@lwn.net>
References: <20190619072218.4437f891@coco.lan>
        <cover.1560890771.git.mchehab+samsung@kernel.org>
        <b0d24e805d5368719cc64e8104d64ee9b5b89dd0.1560890772.git.mchehab+samsung@kernel.org>
        <CAKMK7uGM1aZz9yg1kYM8w2gw_cS6Eaynmar-uVurXjK5t6WouQ@mail.gmail.com>
        <11422.1560951550@warthog.procyon.org.uk>
        <20190619111528.3e2665e3@coco.lan>
        <20190619085458.08872dbb@lwn.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 19 Jun 2019 08:54:58 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> [Trimming the CC list from hell made sense, but it might have been better
> to leave me on it...]
> 
> On Wed, 19 Jun 2019 11:15:28 -0300
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> 
> > Em Wed, 19 Jun 2019 14:39:10 +0100
> > David Howells <dhowells@redhat.com> escreveu:
> >   
> > > Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> > >     
> > > > > > -Documentation/nommu-mmap.rst
> > > > > > +Documentation/driver-api/nommu-mmap.rst        
> > > 
> > > Why is this moving to Documentation/driver-api?      
> > 
> > Good point. I tried to do my best with those document renames, but
> > I'm pretty sure some of them ended by going to the wrong place - or
> > at least there are arguments in favor of moving it to different
> > places :-)  
> 
> I think that a lot of this might also be an argument for slowing down just
> a little bit.  I really don't think that blasting through and reformatting
> all of our text documents is the most urgent problem right now and, in
> cases like this, it might create others.
> 
> Organization of the documentation tree is important; it has never really
> gotten any attention so far, and we're trying to make it better.  But
> moving documents will, by its nature, annoy people.  We can generally get
> past that, but I'd really like to avoid moving things twice.  In general,
> I would rather see a single document converted, read critically and
> updated, and carefully integrated with the rest than a hundred of them
> swept into different piles...
> 
> See what I'm getting at?

I see what you mean, and I agree with this principle. That's basically 
why I split the patches into two groups. 

The first group (with comes first) does just the conversion
and renames from txt to rst, adding a :orphan: to the stuff that was
just converted.

On this series, those are patches 1 to 11. I was already expecting
some heat on patch 1.

The next group of patches do the renaming part. Those are the ones that
actually took me a lot more time, as I needed to quickly read several docs
in order to understand what's happening, before proposing a change.

That's also the group of patches were I expect more active comments,
as there are several cases where this is not obvious.

Yet, from what I saw, there are some documents that sounds easy to
move, like Documentation/laptops, with (except if I missed something)
clearly belongs to admin-guide.

Applying the second patch series and patches 2 to 11 from this third
series is, IMHO, a good thing to do.

-

IMO, patches 1 and 12 are important, as, after those patches, the
/Documentation dir becomes a lot cleaner:

	$ ls -F Documentation/
	ABI/              fb/              locking/        s390/
	accounting/       features/        logo.gif        scheduler/
	acpi/             filesystems/     logo.txt        scsi/
	admin-guide/      firmware_class/  m68k/           security/
	arm/              firmware-guide/  maintainer/     sh/
	arm64/            fpga/            Makefile        sound/
	auxdisplay/       gpio/            media/          sparc/
	block/            gpu/             mic/            sphinx/
	bpf/              hid/             mips/           sphinx-static/
	cdrom/            hwmon/           misc-devices/   spi/
	Changes@          i2c/             Module.symvers  SubmittingPatches
	CodingStyle       ia64/            netlabel/       target/
	conf.py           ide/             networking/     timers/
	core-api/         iio/             nios2/          trace/
	cpu-freq/         index.rst        openrisc/       translations/
	crypto/           infiniband/      output/         usb/
	devicetree/       input/           packing.txt     userspace-api/
	dev-tools/        ioctl/           parisc/         virtual/
	DocBook/          IPMB.txt         PCI/            vm/
	doc-guide/        isdn/            pcmcia/         w1/
	docutils.conf     kbuild/          power/          watchdog/
	dontdiff          Kconfig          powerpc/        wimax/
	driver-api/       kernel-hacking/  process/        x86/
	EDID/             leds/            RCU/            xtensa/
	fault-injection/  livepatch/       riscv/

Being easy to identify when someone tries to add a new text file there
without thinking on where it would fit[1], and to reorganize the
directory tree in a way that it will fit our needs.

[1] Btw, there are some two files at linux-next, incrementally
    increasing the Documentation/ mess:

	   IPMB.txt and packing.txt.

   Added on those commits:

	commit 51bd6f291583684f495ea498984dfc22049d7fd2
	Author: Asmaa Mnebhi <Asmaa@mellanox.com>
	Date:   Mon Jun 10 14:57:02 2019 -0400

	    Add support for IPMB driver

	commit 554aae35007e49f533d3d10e788295f7141725bc
	Author: Vladimir Oltean <olteanv@gmail.com>
	Date:   Thu May 2 23:23:29 2019 +0300

	    lib: Add support for generic packing operations

   We'll never finish organizing documents while people don't stop
   adding new files to Documentation/ directory.


Thanks,
Mauro
