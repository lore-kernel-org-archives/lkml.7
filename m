Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C7CC282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69AA120869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555706161;
	bh=zPpIXKtl3W5IQ6Br+9FnoZbCi+Gq5FDSi3hVapgtmzk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=2bTrcNpBm6ayXm+IObwhWbhnUu0eNhCgOv+rxBwa/NDwGl1U+mo93evaRKvUOpXNN
	 CmxEod6HVEu2jZ3yM/r77cR1AFQpl92dRi5SdYts3XdeO8q5xwVGm4UANYwkiE9RjH
	 6BclfnRIpnifDUJnF8YY62vqmV/VTZJpMSGbf7kM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfDSUgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:36:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59524 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfDSUf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 16:35:59 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AEBE3283B;
        Fri, 19 Apr 2019 20:35:58 +0000 (UTC)
Date:   Fri, 19 Apr 2019 13:35:56 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: Re: [PATCH] docs: core-api: fix broken references for div64.c and
 gcd.c
Message-Id: <20190419133556.80a049d3fbc71f0f2d594702@linux-foundation.org>
In-Reply-To: <20190419125548.2cca263d@lwn.net>
References: <734f49bae5d4052b3c25691dfefad59bea2e5843.1555580999.git.mchehab+samsung@kernel.org>
        <20190419125548.2cca263d@lwn.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Apr 2019 12:55:48 -0600 Jonathan Corbet <corbet@lwn.net> wrote:

> > -.. kernel-doc:: lib/div64.c
> > +.. kernel-doc:: lib/math/div64.c
> >     :functions: div_s64_rem div64_u64_rem div64_u64 div64_s64
> >  
> > -.. kernel-doc:: lib/gcd.c
> > +.. kernel-doc:: lib/math/gcd.c
> >     :export:
> 
> This, of course, creates a build error in docs-next...hopefully that
> situation won't last more than a couple of weeks or so.

I'll fold this into the base patch
lib-move-mathematic-helpers-to-separate-folder.patch so there won't be
such a situation.

> Applied, thanks.

Please unapply ;)
