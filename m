Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7C6C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 10:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B432086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 10:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561632752;
	bh=q/D9q6XrPEUkLYgQMJmvvcOU6kMo0DZxmHeNrNmy40U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=WFsmc/XRis99ukUo5orGnSWhXOB/aCgMXKqjA2uE37aNM2rUr+/Z2IqVOfzoi3C9c
	 q+gPXD2woVpVyEVd2pgJqCJglRfaYCgUt/lTWTGXKTZorQkQXR4gUULkGPg7pVbbZv
	 9CcviljjiewTBhimvRZsBD4FXmjAbx800ZzeATRg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfF0Kwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 06:52:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52364 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfF0Kwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 06:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=d7UsfJNZRzKm4RLEJ8xCGaJL1/w5M/N9EXa+/Ti2rqw=; b=NmjLGbk5nMb640HCjyvgUfVbV
        iCw2ISM+wEBIUOcaBh4xELH548wfUKuJgcn9VArHpht9uAdqUebDxRYVOS8rwf0ypjtOYh8KaFVLJ
        HFte2q1YdoOj94TqAdZp+skJybh7DMZcCg44dvlGh1NBo7X2T2TbYDr918M520yKSoi+V8tOwtzYO
        YJCe9iiV1/IPcUJmxG5+mS+1Hrj+AANavnIWkfB/gfXJ2I4MzDb6ZsCVpgdUZOGY9MG78mrrNRP/Q
        OWIfg+hluhABXHmmQCEErDnZaQMbp0g2X8N4H8kADNRpzMTYQXVrA82BJ5DSBX0a3k7HpBuHQ5X/i
        nGrU56wKg==;
Received: from [186.213.242.156] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgS0y-0006mN-V2; Thu, 27 Jun 2019 10:52:29 +0000
Date:   Thu, 27 Jun 2019 07:52:25 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 12/14] doc-rst: add ABI documentation to the admin-guide
 book
Message-ID: <20190627075225.34f8457f@coco.lan>
In-Reply-To: <87blyjqrz7.fsf@intel.com>
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
        <9da2a7f6ff57d9d53dcbb964eb310f7956522870.1560477540.git.mchehab+samsung@kernel.org>
        <87o930uvur.fsf@intel.com>
        <20190614140603.GB7234@kroah.com>
        <20190614122755.1c7b4898@coco.lan>
        <874l4ov16m.fsf@intel.com>
        <20190617105154.3874fd89@coco.lan>
        <87h88nth3v.fsf@intel.com>
        <20190619133739.44f92409@coco.lan>
        <20190621112700.6922d80d@coco.lan>
        <87blyjqrz7.fsf@intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 27 Jun 2019 12:48:12 +0300
Jani Nikula <jani.nikula@linux.intel.com> escreveu:

> On Fri, 21 Jun 2019, Mauro Carvalho Chehab <mchehab+samsung@kernel.org> w=
rote:
> > Em Wed, 19 Jun 2019 13:37:39 -0300
> > Mauro Carvalho Chehab <mchehab+samsung@kernel.org> escreveu:
> > =20
> >> Em Tue, 18 Jun 2019 11:47:32 +0300
> >> Jani Nikula <jani.nikula@linux.intel.com> escreveu:
> >>  =20
> >> > On Mon, 17 Jun 2019, Mauro Carvalho Chehab <mchehab+samsung@kernel.o=
rg> wrote:   =20
> >> > > Yeah, I guess it should be possible to do that. How a python script
> >> > > can identify if it was called by Sphinx, or if it was called direc=
tly?     =20
> >> >=20
> >> > if __name__ =3D=3D '__main__':
> >> > 	# run on the command-line, not imported   =20
> >>=20
> >> Ok, when I have some spare time, I may try to convert one script
> >> to python and see how it behaves.  =20
> >
> > Did a quick test here...=20
> >
> > Probably I'm doing something wrong (as I'm a rookie with Python), but,
> > in order to be able to use the same script as command line and as an Sp=
hinx
> > extension, everything that it is currently there should be "escaped"
> > by an:
> >
> > 	if __name__ !=3D '__main__':
> >
> > As event the class definition:
> >
> >     class KernelCmd(Directive):
> >
> > depends on:
> >
> > 	from docutils.parsers.rst import directives, Directive
> >
> > With is only required when one needs to parse ReST - e. g. only
> > when the script runs as a Sphinx extension.
> >
> > If this is right, as we want a script that can run by command line
> > to parse and search inside ABI files, at the end of the day, it will
> > be a lot easier to maintain if the parser script is different from the
> > Sphinx extension.  =20
>=20
> Split it into two files, one has the nuts and bolts of parsing and has
> the "if __name__ =3D=3D '__main__':" bit to run on the command line, and =
the
> other interfaces with Sphinx and imports the parser.

It seems we have an agreement here: the best is indeed to have two
files, one with the Documentation/ABI parser, and another one with the=20
Sphinx extension...

>=20
> > If so, as the Sphinx extension script will need to call a parsing script
> > anyway, it doesn't matter the language of the script with will be
> > doing the ABI file parsing. =20
>=20
> Calling the parser using an API will be easier to use, maintain and
> extend than using pipes, with all the interleaved sideband information
> to adjust line numbers and whatnot.

... and here is where we have two different views.

=46rom debug PoV, the Documentation/ABI parser script should be able to
print the results by a command line call. This is also a feature
that it is useful for the users: to be able to seek for a symbol
and output its ABI description. So, the "stdout" output will be
there anyway.

The only extra data for the extension side is the file name where
the information came and the line number.

=46rom maintainership PoV, adding the sideband API for file+line is
one line at the parser script (a print) and two lines at the Sphinx
extension (a regex expression and a match line). That's simple to
maintain.

It is also simple to verify both sides independently, as what
you see when running the parser script is what you get at the
extension.

If we add a new ABI between the parser script and the extension
script, this would require to also maintain the ABI, and would
make harder to identify problems on ABI problems.

-

Another advantage of having those independent is that the
language of the parsing script can be different. Not being
python is a big advantage for me, as perl is a lot more
intuitive and easier to write parser scripts for my eyes.

I can write a perl parsing script in a matter of minutes.
It takes me a lot more time to do the same with python, and then
ensure that it will work with two similar but different languages
(python2 and python3) [1].

[1] btw, with that regards, I still don't know how to teach a
    python script that it should "prefer" to run with python3 but would
    fall back to python2. Adding this shebang:
	# /usr/bin/env python
    just do the opposite - at least on Fedora


Thanks,
Mauro
