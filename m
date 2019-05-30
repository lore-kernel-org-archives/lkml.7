Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63603C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 01:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2345024400
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 01:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559181195;
	bh=mWKXQ5LIK5DotFlc/72XP8bFO3SQYfZRI+EeWn4Hg60=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=uC/5vGJxF0B+hp1X+gi/NBCscgAU9MfIsmtgDTCYwQTXNoeNvNIFw4YHweXVd3Kg9
	 7rdCVULS0glb3xuc9OAFpD3LjKkkGgFw41fZvaZGXCr8od6+oifj0ah2MNowDWrI0C
	 BIxkQYcSa1D6J0z5gfsODr+3F3KbZo38NStvExlU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfE3BxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 21:53:14 -0400
Received: from casper.infradead.org ([85.118.1.10]:44700 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfE3BxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 21:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fCwm8alnbwX/xB7Ci+E1tlPcE/UJ0YinibQMNsn2oSg=; b=ChtggQYj5MM4I6juXBtPd++rCK
        47zXILgRY3zNl9Lm3pXFKS7GrhYSV3bLmN2+og291ofYdP/gltHagZLC/xksZteOwkgRhiJyl33+d
        9+3vXhZSi7rckEZCFRvn6cj5INFtLA3f9Uz+kkkzJT8KG0zM6/EZE3wQfOO5s3e2mjh4t6VgUH4OX
        ZFfwkbxKcjQ8fTCibEYF0MCUJZADsCSQVeKIur7oCVHA4c6BI5HjwCIYGf4cl28W5FXaK/2TVLpB/
        k8jpGUfnko3+78q/U9g1C0K63cq6fJVYX37CVlyr8NcQrEgxbkZi+D5nULJjf/UqJQa6Q1t/JW7js
        AclIn1MA==;
Received: from 177.132.232.81.dynamic.adsl.gvt.net.br ([177.132.232.81] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWAFi-000846-4c; Thu, 30 May 2019 01:53:10 +0000
Date:   Wed, 29 May 2019 22:53:05 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] docs: by default, build docs a lot faster with
 Sphinx >= 1.7
Message-ID: <20190529225305.213d8c36@coco.lan>
In-Reply-To: <20190529174716.4f0e21ad@lwn.net>
References: <cover.1558955082.git.mchehab+samsung@kernel.org>
        <baf19095789f2b2ed0c7a940703037a00cd77850.1558955082.git.mchehab+samsung@kernel.org>
        <20190529170202.65c7f9ca@lwn.net>
        <20190529202005.04dcd4a0@coco.lan>
        <20190529174716.4f0e21ad@lwn.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 29 May 2019 17:47:16 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Wed, 29 May 2019 20:20:05 -0300
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> 
> > > So this totally fails to work for me with any version of sphinx, and I'm
> > > not enough of a Perl person to figure it out.  Sometimes I'll see the
> > > sphinx-build output, i.e.:
> > > 
> > >     sphinx-build 1.8.4
> > > 
> > > and sometimes (like with 2.0) I don't, but I never get -jauto regardless.    
> > 
> > Hmm... with 2.0.0 --version prints the version.
> > 
> > 	$ sphinx-build --version
> > 	sphinx-build 2.0.0  
> 
> Yup.  The point is that I see the sphinx-build output *in the docs-build
> output", not when I run it standalone (where it does the expected thing).

Weird... could some versions of Sphinx be redirecting the output of
--version to stderr instead of stdout?

If so, something like:

	perl -e 'open IN,"sphinx-build --version 2>&1 |"; while (<IN>) { if (m/([\d\.]+)/) { print "-jauto\n" if ($1 >= "1.7") } ;} close IN'

would make it print "-jauto" with those other versions you're trying.
 
> 
> > > Not sure what's going on here?    
> > 
> > Do you have SPHINXOPTS already set on your environment? If so, Makefile
> > will not override the existing environment.  
> 
> Yeah, I had it set to -j1 because I want to wait as long as possible for my
> docs builds :)
> 
> No, I didn't have it set separately, made a point of that.
> 
> > Here, if I call it by hand (replacing $$1 by $1), it does the right
> > thing. For example:
> > 
> > 1.8.4:
> > 
> > 	$ sphinx-build --version
> > 	sphinx-build 1.8.4
> > 	$ perl -e 'open IN,"sphinx-build --version |"; while (<IN>) { if (m/([\d\.]+)/) { print "-jauto\n" if ($1 >= "1.7") } ;} close IN'
> > 	-jauto  
> 
> $ perl -e 'open IN,"sphinx-build --version |"; while (<IN>) { if (m/([\d\.]+)/) { print "-jauto\n" if ($1 >= "1.7") } ;} close IN'
> sphinx-build 1.8.4
> $
> 
> It works properly with 2.0.1 - but only on the command line; I still don't
> get the right behavior in a docs build.
> 
> Most weird.
> 
> This is an Fedora 30 system, FWIW.

Yeah, really weird. Here I'm using Fedora 30 too:

	python3-sphinx_rtd_theme-0.4.3-1.fc30.noarch
	python3-sphinx-1.8.4-1.fc30.noarch

It works with both installed version and pip3 virtualenvs.

I didn't try the python2 versions, though.


> 
> jon



Thanks,
Mauro
