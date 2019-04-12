Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13706C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E04D32073F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbfDLQFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:05:00 -0400
Received: from ms.lwn.net ([45.79.88.28]:45308 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbfDLQE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 12:04:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4E35F308;
        Fri, 12 Apr 2019 16:04:55 +0000 (UTC)
Date:   Fri, 12 Apr 2019 10:04:51 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
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
Message-ID: <20190412100451.6fe49de7@lwn.net>
In-Reply-To: <20190411210731.GA29378@roeck-us.net>
References: <cover.1554923967.git.mchehab+samsung@kernel.org>
        <20190411124324.3ed62fad@lwn.net>
        <20190411174357.251904f5@coco.lan>
        <20190411210731.GA29378@roeck-us.net>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2019 14:07:31 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> > While nobody does such split, IMHO, the best would be to keep the
> > information outside Documentation/admin-guide. But hey! You're
> > the Doc maintainer. If you prefer to move, I'm perfectly fine
> > with that.
> >   
> 
> Same here, but please don't move the files which are kernel facing only.

Well, let's step back and think about this.  Who is the audience for
these documents?  That will tell us a lot about where they should really
be.  

What I would prefer to avoid is the status quo where *everything* is in
the top-level directory, and where documents are organized for the
convenience of their maintainers rather than of their readers.  But
sometimes I feel like I'm alone in that desire...:)

Thanks,

jon
