Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99072C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 22:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C5272171F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 22:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565908312;
	bh=JUGSZP1OX5849QbPzVQs+ETR+b8Pn+G4+/yEBBC8o+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x2/9/9K/UfHGKlmR+AOykE+g3ywGIFnI5NAJiUSVuCDJiQzVKzv4xh+3uyvDvRYUt
	 +uORFydG0XIvMXAkFFUst/8mgvlS2jTZF8yWebPTZy6kn/TQXY87oc1xzn63aA9lis
	 ar5Xsh3Jz9SZm8Q/+df0dCwDRAriwSM6EKZrghAU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733300AbfHOWbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 18:31:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:35232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733095AbfHOWbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 18:31:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA09C206C1;
        Thu, 15 Aug 2019 22:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565908309;
        bh=JUGSZP1OX5849QbPzVQs+ETR+b8Pn+G4+/yEBBC8o+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cRfJuEyWeJJuhd9QF7crXoOFqXFb+u+wQN6XqXf1A1x1kjJt2OFpxR0Zn6CilZfuI
         g4GvJ0Im/niVAq3tSBh6zxznh1Yt8PhcLV4iAGXGv08V7S9O/836zf21UbFSB5cfSw
         +uWad/+kXkvUhW72IUR2yLoAfpfPav4JWdYr7JRQ=
Date:   Fri, 16 Aug 2019 00:31:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        security@kernel.org, linux-doc@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Kosina <jkosina@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH] Documentation/admin-guide: Embargoed hardware security
 issues
Message-ID: <20190815223147.GA28275@kroah.com>
References: <20190725130113.GA12932@kroah.com>
 <20190725151302.16a3e0e3@lwn.net>
 <20190815212019.GB12041@kroah.com>
 <e3ae0d66-b9eb-97ba-647a-57f3e2eb4af2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3ae0d66-b9eb-97ba-647a-57f3e2eb4af2@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 03:12:34PM -0700, Randy Dunlap wrote:
> On 8/15/19 2:20 PM, Greg Kroah-Hartman wrote:
> >>> +The hardware security team will provide a per incident specific encrypted
> >> s/per incident specific/incident-specific/
> > Fixed.  And changed /a/ to /an/
> 
> eh?  still should be /a per incident/

The sentence was changed to:
	The hardware security team will provide an incident-specific
	encrypted...

is not "an" correct here?

thanks,

greg k-h
