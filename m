Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5980C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B52CE2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560762720;
	bh=9P8pW1b9k1oVbqt3EOEL1v25BiBzgnw9YfF+EKJGeoY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZVuTAS/4pWhJ7OWVD7ZAxvzxiUuqzaRDhwD4Tb3UjW85oWglrC9otSmm06mlvMmEK
	 WMOvYPYQGKQbt5sQp7DPlK2N/NzaZhYxD3EC+sEfplP6HKmkQhA5ecZo6E6Jh/KBr+
	 0zOm/f4SfDB42LpBPTczysznk/GKxLttaRPLtUYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbfFQJL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 05:11:59 -0400
Received: from casper.infradead.org ([85.118.1.10]:54208 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfFQJL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 05:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WKDHPuqmk7aGpvs0dQcDhq3t2LeY5Da3Poe4nEoqjOs=; b=BTvmnwI/e5DfYlzQy5najumy0A
        R+0T9W0Onos9CA3zxDpp8p7TbkUpYAXa7a8AIHv9rhltqLLRr3ckaORXF0ZjwMb19HrAmpZcMTEcF
        qsGUyjYro1Z3rfocqhyvNcKgjF8sOEeybxxvn9HR4pSfGjiGjuN+zD1HUEgyZsDzKIuFBRwFifRIK
        QanmVoQx6D4F76RwDF75i6JQ6t1yIDb3T+lKTKycddAD4P5LntUmPn9zYNvqtNvAurSb3DuTJpSvm
        vzh/NPMFsnjtr+32G6icNMfXGqmJFf1Hfy2Re80hnI9G2xhZ5d9hPcE79J+/lzNIhNGU6X61IDEYj
        DcKW/vOw==;
Received: from 179.186.105.91.dynamic.adsl.gvt.net.br ([179.186.105.91] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hcng9-0006tV-Il; Mon, 17 Jun 2019 09:11:54 +0000
Date:   Mon, 17 Jun 2019 06:11:46 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Markus Heiser <markus.heiser@darmarit.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/14] doc-rst: add ABI documentation to the admin-guide
 book
Message-ID: <20190617061146.06975213@coco.lan>
In-Reply-To: <327067f6-2609-41e6-c987-e37620e7154e@darmarit.de>
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
        <9da2a7f6ff57d9d53dcbb964eb310f7956522870.1560477540.git.mchehab+samsung@kernel.org>
        <87o930uvur.fsf@intel.com>
        <2955920a-3d6a-8e41-e8fe-b7db3cefed8b@darmarit.de>
        <20190614081546.64101411@lwn.net>
        <327067f6-2609-41e6-c987-e37620e7154e@darmarit.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, 16 Jun 2019 18:04:01 +0200
Markus Heiser <markus.heiser@darmarit.de> escreveu:

> Am 14.06.19 um 16:15 schrieb Jonathan Corbet:
> > On Fri, 14 Jun 2019 16:10:31 +0200
> > Markus Heiser <markus.heiser@darmarit.de> wrote:
> >   
> >> I agree with Jani. No matter how the decision ends, since I can't help here, I'd
> >> rather not show up in the copyright.  
> > 
> > Is there something specific you are asking us to do here?
> >   
> 
> 
> I have lost the overview, but there was a patch Mauro added a
> kernel_abi.py.  There was my name (Markus Heiser) listed with a
> copyright notation.
> 
> I guess Mauro picked up some old RFC or an other old patch of
> mine from 2016 and made some C&P .. whatever .. ATM I do not have
> time to give any support on parsing ABI and I'am not interested
> in holding copyrights on a C&P of a old source  ;)

Well, the code was basically written by you :-)

It was written to be a script capable of running a generic
script. On that time, my contribution to it was basically
to hardcode it to run "get_abi.pl".

This came from an old branch where the last change was back in 2017. 
It was resurrected due to a discussion at KS ML.

There, the discussion was related to what's left to be converted
to ReST.

While I can't simply remove your copyright, would you be happy
with something like that?


Thanks,
Mauro

diff --git a/Documentation/sphinx/kernel_abi.py b/Documentation/sphinx/kernel_abi.py
index 2d5d582207f7..ef91b1e1ff4b 100644
--- a/Documentation/sphinx/kernel_abi.py
+++ b/Documentation/sphinx/kernel_abi.py
@@ -7,7 +7,8 @@ u"""
     Implementation of the ``kernel-abi`` reST-directive.
 
     :copyright:  Copyright (C) 2016  Markus Heiser
-    :copyright:  Copyright (C) 2016  Mauro Carvalho Chehab
+    :copyright:  Copyright (C) 2016-2019  Mauro Carvalho Chehab
+    :maintained-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
     :license:    GPL Version 2, June 1991 see Linux/COPYING for details.
 
     The ``kernel-abi`` (:py:class:`KernelCmd`) directive calls the


