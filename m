Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D72C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC2B2146F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555015455;
	bh=hIR4lRUbvqlC/HBs5JbYz9dkM6hDrcx+BaiwK1FLnjs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=CRiTwpnMco4YbDqwT4ntraFTL0CvbnsklNQkmHFa0XfG4Nldvg7Az75Aydy/femIX
	 FnvcAKGdM4C6f81ztAnYOaf58V1c/4T+FNLkImuwDD560EOxH3RhJEVXSlLvWclSRV
	 qHT/MxDTIOFTP7ugKY11BY11K2uVFsyq5fXDOA0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfDKUoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:44:14 -0400
Received: from casper.infradead.org ([85.118.1.10]:37936 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfDKUoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 16:44:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=e9Z/7e3/hRsGnS2IGdT3ZcpPF2Keute9G8FZSvjPYvw=; b=ml67nDSf8iAwnEALQB1I8vyqA8
        TS0UFAHu4F1JxQDfKqgX4khtCfCdm/PNWWp8FlxfUL99uzN2HQOx+4IDNHFU5FGEv9O7sv8yzZEs3
        do+3nQvj8OqYxn2AwfvufaI2prXL19tSuh1JOugN7O6qRW/E91lUjXRs5ksYawU06OU7ltn2UDkk9
        4drePCv1T5mbCpYRxmqLazFVy6Xrdwfe5A6AaAtdHMTZ93NqEYt29XBKrVkePqBxaNZ5n/E3AiKWp
        hvktN8LDszwkexr2gk7xY5cJcwmDrZckik1bgoUqT807DsY1VHtEE157AYGNBEBi7oBeGlOCFGBsT
        +DZPLIaA==;
Received: from 201.86.162.146.dynamic.adsl.gvt.net.br ([201.86.162.146] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEgYH-0001OQ-If; Thu, 11 Apr 2019 20:44:06 +0000
Date:   Thu, 11 Apr 2019 17:43:57 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Guenter Roeck <linux@roeck-us.net>,
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
Message-ID: <20190411174357.251904f5@coco.lan>
In-Reply-To: <20190411124324.3ed62fad@lwn.net>
References: <cover.1554923967.git.mchehab+samsung@kernel.org>
        <20190411124324.3ed62fad@lwn.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 11 Apr 2019 12:43:24 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Wed, 10 Apr 2019 16:22:37 -0300
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> 
> > This series converts the contents of Documentation/hwmon to ReST
> > format.
> > 
> > PS.: I opted to group the conversion files per groups of maintainer
> > set, as, if I were to generate one patch per file, it would give around
> > 160 patches.
> > 
> > I also added those patches to my development tree at:
> > 	https://git.linuxtv.org/mchehab/experimental.git/log/?h=hwmon
> > 
> > If you want to see the results, they're at:
> > 	https://www.infradead.org/~mchehab/hwmon/  
> 
> This set seems generally good and could probably be applied as-is.  But I
> have to ask...is there a reason to not take the last step and actually
> bring this stuff into the Sphinx doc tree?
> 
> We seem to be mostly documenting sysfs files and such.  I am *guessing*
> that perhaps the set should move to Documentation/admin-guide/hwmon?  Or
> have I misunderstood the intended audience here?

:-)

Yeah, I'd say that 80% of the contents there are user-faced.

Yet, the main issue with this (and other driver subsystems) is that there's
a mix of userspace and Kernelspace stuff. One somewhat simple case is
the abituguru: it has a "datasheet" file:

	abituguru-datasheet

This contains programming information for the corresponding drivers,
while abituguru and abituguru3 contains mostly userspace
stuff (still, it also contains the I2C address, with shouldn't mean
anything for the user).

However, if you take a look at w83781d, you'll see a mix of both
userspace and driver developer info there... it has a chapter called
"Data sheet updates", for example, with is probably meaningless for
anyone but the hwmon driver developers.

That's, btw, a pattern that happens a lot inside device driver
documents on almost all subsystems I checked: driver-specific
documentation is usually not split into user-facing/kernel-facing.

While nobody does such split, IMHO, the best would be to keep the
information outside Documentation/admin-guide. But hey! You're
the Doc maintainer. If you prefer to move, I'm perfectly fine
with that.


Thanks,
Mauro
