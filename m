Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB9DC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E02BE20693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555411308;
	bh=IuY4d0lkgNblotnaP0I5pzfCljqH4BpN4+D0BApEy/M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=OdPZkJQWfiY8I27RukRufJnRi+RjsHeYKmqwXZb3fNPu94XwQN7GMgT8Ute82OX5j
	 dv7mVAKVmKtGT5Xkrei0RoNJyhf+K72ndXLtMztOK53WV1NMse4+EUIws/qM283zch
	 bNUs7cdSJPfeVSeBlNMT9KijqGoqB5M+6ymxvlts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbfDPKlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:41:46 -0400
Received: from casper.infradead.org ([85.118.1.10]:54034 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbfDPKlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:41:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0foI7flnWJDWw/jzN+HRvW/YERYAG7KVKnFbMG17tn8=; b=pitrbNy97kTVSL0mpk/TgZHJjg
        e3G+H2f08a56Y4UXjbytSBTUCtIy5nj9z/CUJz+8WQPSf3TqvyBZ0nn057W+ThcBzt+0Bup3xervX
        RdF4RfDMAGNKfs/86muCUTDv5dT+wp+Sd27LT4abddNIt7yGIU2tOiAnaKxSi7V4ppgx/ZPUFdaFs
        Grdsi08BZOgFBqt4XPCZSCV7/+l2F+FvmIWfU8TlIf2a4ppQeYQXUS/JCCUmW7AuFs9Qt56zHEcjn
        6ryy/GT2Ps+bFZyTKhs7YWUf+uho13RnmC0IUV0EOgjXNVk0ZruqfTG3NLTldZ/tw5iTRNXXdNAe4
        mQg1PlqA==;
Received: from 177.205.118.176.dynamic.adsl.gvt.net.br ([177.205.118.176] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGLX4-00061n-HS; Tue, 16 Apr 2019 10:41:42 +0000
Date:   Tue, 16 Apr 2019 07:41:37 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 25/57] docs: power: convert docs to ReST
Message-ID: <20190416074137.53873332@coco.lan>
In-Reply-To: <1616669.eeiCRjss8h@kreacher>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
        <cfab8842b681a84518b327980b08aee95d159605.1555382110.git.mchehab+samsung@kernel.org>
        <1616669.eeiCRjss8h@kreacher>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 16 Apr 2019 10:59:23 +0200
"Rafael J. Wysocki" <rjw@rjwysocki.net> escreveu:

> On Tuesday, April 16, 2019 4:55:50 AM CEST Mauro Carvalho Chehab wrote:
> > Convert the PM documents to ReST, in order to allow them to
> > build with Sphinx.  
> 
> And what exactly is the motivation for doing that?

Providing a little of context, I tried to submit a patchset that would
just place existing documents on a sort of "staging" way, without
actually reformatting:

	https://lkml.org/lkml/2019/4/10/244

Jon had some concerns about such approach.

So, I split into one patch per subsystem. Then, I looked on each, and
opted to do the conversion, as, on several cases, the conversion
seemed to be easy enough.

My selfish motivation is that I was returning from vacations and wanted to
review some stuff at the Kernel docs, but, discovered that, despite we
started migrating the documentation on May, 2016, still the vast
majority of documents that weren't converted.

For me, the main motivation for the conversion are:

1) Documents will be grouped into books and chapters,
   with makes easier to study them;
2) The Sphinx javascript is very convenient for seeking a
   document and a keyword within the body of the document;
3) Using a browser to read documentation allows to better
   scale the document to the screen I'm using.

That's said, sometimes I just prefer to convert the document
to a PDF and read it on my tablet. PDF tools also provide 
similar features.

In other words, for my own consumption, I prefer reading 
documents using document tools, instead of reading in plain
text.

> There are plans for some of these files to be converted already, some of them need to be merged or split and it just is not worth it to convert some others.

Feel free to use this patch as an starting point. If you prefer,
I can split into smaller sets, but my main goal here is just
to help to speedup the conversion.

Thanks,
Mauro
