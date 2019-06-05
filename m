Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A01BC282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 10:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18231206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 10:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559729979;
	bh=27P4wHYbg4C21JMRPJFzJ0OtH3AKenPL8TjHhsG9hI4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=LATejj1aD/A1+vrAnpA/OR63By09T4YORuVhHgEM2LkcGKCnINgM7kODRKZZG+qs5
	 UsWVY5Ca0/F/id0KIjV5krOuZIkX+faVKOFSTjYTYKW91+NmdH+z9Nuf0/QKUfYjON
	 uqAJsdAGUb+70/wbpYNXaXSEHbiYaIbWBgnz699w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfFEKTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 06:19:38 -0400
Received: from casper.infradead.org ([85.118.1.10]:43968 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfFEKTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 06:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NdzflC4Gr8040iG9lX4cUUuc9anxbj+Ahlf/+7okbes=; b=EL3kHoOVTXGy+KW2xPo+W+a2QU
        uNEpWKc3YYCfEzzNwBmnkjaUEttxGHoMoogxPxFwnynlct5+azuC6t/BW70DZ5sXuF/1OCSn4XWEb
        H+fNvzbooSlncqfb8H5gUhgfzfobMHIEN7MHMrqBLvkgjz8rlfv9fdxMc2VUkMbX4S7Fr76aviirI
        gWkSgh5CkSqr4iCOv4MHlh7O1+R9CAzUD79Y6PnTNbBiRXvXV/aPN91NHqeOKmKkFAQaM7imMpPWn
        NkxRQug79Ozu4qoIH7VJwtLYq2qqE2qsZIW5jZczyj/RgMGr8OFHd5q9tbG/TXpC4CmDKUMNB/64Z
        AUONcWCg==;
Received: from [179.182.172.34] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYT13-00021g-8L; Wed, 05 Jun 2019 10:19:33 +0000
Date:   Wed, 5 Jun 2019 07:19:28 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        keyrings@vger.kernel.org
Subject: Re: [PATCH v2 15/22] docs: security: core.rst: Fix several warnings
Message-ID: <20190605071928.704558cf@coco.lan>
In-Reply-To: <26617.1559728436@warthog.procyon.org.uk>
References: <21350864823e07cc951e1dc7f0601baa09920ac4.1559656538.git.mchehab+samsung@kernel.org>
        <cover.1559656538.git.mchehab+samsung@kernel.org>
        <26617.1559728436@warthog.procyon.org.uk>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 05 Jun 2019 10:53:56 +0100
David Howells <dhowells@redhat.com> escreveu:

> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> 
> > +  *  ``asym_eds_op`` and ``asym_verify_signature``::
> > +
> > +       int (*asym_eds_op)(struct kernel_pkey_params *params,
> > +			  const void *in, void *out);
> > +       int (*asym_verify_signature)(struct kernel_pkey_params *params,
> > +				    const void *in, const void *in2);  
> 
> That's redundant and shouldn't be necessary.

This should equally fix it:

  * ::

       int (*asym_eds_op)(struct kernel_pkey_params *params,
			  const void *in, void *out);
       int (*asym_verify_signature)(struct kernel_pkey_params *params,
				    const void *in, const void *in2);  

The thing is that we need to teach Sphinx somehow that it should not
try to interpret '*' (with is used there to identify bold/italy blocks)

Using a '::' seems better than escaping all asterisks with a backslash.


Thanks,
Mauro
