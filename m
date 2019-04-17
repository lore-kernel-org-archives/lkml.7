Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF0CC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B7F32173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555494496;
	bh=Rw/jpgiTbu4tSjV4tc+l886jsb1vRbD9ZqD5bmZV7s0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=oyCjAIhebScjCG5Eq5BPsMOEGF0JsT3ezUkFxvg34hQpJ8eTvtTxTum69G9kHxt/y
	 gLZzFS+Uqk2wXVN/asPMtL2aby0dvJgzKT8gc6CWSyOA/uXeQKB4OYhsJ6JuCvdYR9
	 deoRNFLVbjnv5SmGqTbgdzwChI5gMe0U4qjLOj60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfDQJsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 05:48:15 -0400
Received: from casper.infradead.org ([85.118.1.10]:59848 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731706AbfDQJsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 05:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Qi7jhFlrpS4mCz2yht0D/QYsavV/ww0hplcsoy6Cnzc=; b=X1TrkOmbRgrLY7YEnjpGPKeTd1
        B9f9Os/kQKdT1xaoK7/NEGFfIG3G2vm2B1bS7NOWv2oCyXCRd6PEYN4+Sz1FTwAjAlaPk/QVrXptX
        0DHrtpSMepqnUuFuJcEKIGjzJQzwq/ZFMIalifKmIHOreBOQSdcm7xSLJchDNAXbLSL2cNFsG6n1L
        W4i06p1mF+Drg75jzySA5b8gRdz4ML7U0Emf3HuUwtyPEQmjVk1qUQR+5ZBQ889VIL6AVbFs+VRmJ
        CD44kBbuKoYWud5Gfa0Ra0dYba1Q1pUm17GaRawL7VE0DpaH03W+DR82X9+IxwK32gAUjMJKGCaAs
        Mbi5I5Dw==;
Received: from 177.132.233.55.dynamic.adsl.gvt.net.br ([177.132.233.55] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGhAh-0008Go-SE; Wed, 17 Apr 2019 09:48:04 +0000
Date:   Wed, 17 Apr 2019 06:47:56 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jean Delvare <jdelvare@suse.com>,
        Joel Stanley <joel@jms.id.au>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 00/21] Convert hwmon documentation to ReST
Message-ID: <20190417064745.46385036@coco.lan>
In-Reply-To: <1d8a4410-4a8c-7b7a-141d-d2495cc66749@roeck-us.net>
References: <cover.1554923967.git.mchehab+samsung@kernel.org>
        <20190411124324.3ed62fad@lwn.net>
        <20190411174357.251904f5@coco.lan>
        <20190411210731.GA29378@roeck-us.net>
        <20190412100451.6fe49de7@lwn.net>
        <f900adea-d231-c00d-847c-33e66e79ea30@roeck-us.net>
        <20190416141949.09b48789@lwn.net>
        <20190416203114.GB25517@roeck-us.net>
        <20190416225836.1d5953bc@coco.lan>
        <1d8a4410-4a8c-7b7a-141d-d2495cc66749@roeck-us.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 16 Apr 2019 20:49:31 -0700
Guenter Roeck <linux@roeck-us.net> escreveu:

> On 4/16/19 6:58 PM, Mauro Carvalho Chehab wrote:
> > Em Tue, 16 Apr 2019 13:31:14 -0700
> > Guenter Roeck <linux@roeck-us.net> escreveu:
> >   
> >> On Tue, Apr 16, 2019 at 02:19:49PM -0600, Jonathan Corbet wrote:  
> >>> On Fri, 12 Apr 2019 20:09:16 -0700
> >>> Guenter Roeck <linux@roeck-us.net> wrote:
> >>>      
> >>>> The big real-world question is: Is the series good enough for you to accept,
> >>>> or do you expect some level of user/kernel separation ?  
> >>>
> >>> I guess it can go in; it's forward progress, even if it doesn't make the
> >>> improvements I would like to see.
> >>>
> >>> The real question, I guess, is who should take it.  I've been seeing a
> >>> fair amount of activity on hwmon, so I suspect that the potential for
> >>> conflicts is real.  Perhaps things would go smoother if it went through
> >>> your tree?
> >>>      
> >> We'll see a number of conflicts, yes. In terms of timing, this is probably
> >> the worst release in the last few years to make such a change. I currently
> >> have 9 patches queued in hwmon-next which touch Documentation/hwmon.
> >> Of course the changes made in those are all not ReST compatible, and I have
> >> no idea what to look out for to make it compatible. So this is going to be
> >> fun (in a negative sense) either way.
> >>
> >> I don't really have a recommendation at this point; I think the best I could
> >> do to take the patches which don't generate conflicts and leave the rest
> >> alone. But that would also be bad, since the new index file would not match
> >> reality. No idea, really, what the best or even a useful approach would be.
> >>
> >> Maybe automated changes like this (assuming they are indeed automated)
> >> can be generated and pushed right after a commit window closes. Would
> >> that by any chance be possible ?  
> > 
> > No, those patches are hand-maid, but I can surely rebase it on the top of
> > your tree. Is your tree already merged at linux-next, or should I use some
> > other branch/tree for rebase?
> >   
> 
> linux-next merges hwmon-next. next-20190416 is missing one patch which touches
> Documentation/hwmon, but that should be easy to deal with.

Ok, did a rebase on the top of next-20190417. While re-reading the output
of the html files, I noticed a few minor issues on some tables and fixed.

Thanks,
Mauro
