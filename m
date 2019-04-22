Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8154DC282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 17:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5207E2077C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 17:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555954935;
	bh=P1IkHiHYU0nOtqg90rkhIpoA3JTTc50FYvY/gAO6y5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Fx0/lFTL1ZMmwHy/GbHKg7a5TlZpl1cLE2wCxAg1v5lGIvbpYkrmiCIjSGY+q1KlH
	 Tcu2YzWy5mSdEexgtg7lP5xeEvdwuPDv9MSbhoPr7iQoKKC3TW8L6cblKrsDuQLXnR
	 K8G3SeE/H9SsE5s4+1mnBaxjuUDvGNVAKV/1Y46E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbfDVRmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 13:42:14 -0400
Received: from casper.infradead.org ([85.118.1.10]:41938 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfDVRmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 13:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iUFTNL2dQwj8qOgLdg3Js5k1Wjs8hiS0MX8CFwn1UY8=; b=lcVspuoCKXuORscnYt4dtBqJxY
        3uwXDzCtkhU33VdHImONT7bF++ZDOi78gB4jmSaXZgyWq3h5lzDUVrOZnSWlp/L+21M7A0Jqn9Wn6
        Y40HNWqh05EwEJGvZSwbB3pPqukN30tBYooVtD22LeuapfoRETbE3xR20DkvJgVlQPfCc/zTRapa2
        lJFGMvKXbj54YWAf7jwNLLNa+6lsOiZ4oc4MQ1OanKibEUauu5NAoViYuXP+qG66TZhFRSyQSAbID
        nwT1buFwMEWoYU5GMVzMAN6HLsDsrvL05pF8l1V9udDYO/hhUXw0Km3JIc/kaTcRQ1+mSzWNZtcvY
        IkrXYQIg==;
Received: from 179.176.125.229.dynamic.adsl.gvt.net.br ([179.176.125.229] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIcxE-0002LK-T2; Mon, 22 Apr 2019 17:42:09 +0000
Date:   Mon, 22 Apr 2019 14:42:03 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH] docs: hwmon: remove the extension from .rst files
Message-ID: <20190422144203.75431698@coco.lan>
In-Reply-To: <20190422173534.GA1656@roeck-us.net>
References: <20190422173534.GA1656@roeck-us.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 22 Apr 2019 10:35:34 -0700
Guenter Roeck <linux@roeck-us.net> escreveu:

> On Mon, Apr 22, 2019 at 08:14:55AM -0300, Mauro Carvalho Chehab wrote:
> > On almost all places, we're including ReST files without the
> > extension.
> > 
> > Let's remove the extension here	as well, in order to use just
> > one standard.
> > 
> > Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > ---
> >  Documentation/hwmon/index.rst | 322 +++++++++++++++++-----------------
> >  1 file changed, 161 insertions(+), 161 deletions(-)
> > 
> > diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> > index 3fa14fe7b49c..ee090e51653a 100644
> > --- a/Documentation/hwmon/index.rst
> > +++ b/Documentation/hwmon/index.rst
> > @@ -5,11 +5,11 @@ Linux Hardware Monitoring
> >  .. toctree::
> >     :maxdepth: 1
> >    
> ...
> > -   ir38064.rst
> > -   isl68137.rst  
> ...
> > -   lochnagar.rst  
> 
> You never actually sent the patches to convert the above files to .rst.
> It looks like you did convert the files in your tree and added them to
> the index. Since I don't have those patches, this patch does not apply.

I'm pretty sure I sent you last week, as Jani replied on it asking for
the .rst removal.

Anyway it is just one file. I'll just send it again.

Subject: [PATCH] docs: hwmon: convert three docs to ReST format

Regards,
Mauro

> 
> Guenter



Thanks,
Mauro
