Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BA2C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 14:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A892137B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 14:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567693048;
	bh=UPePVyXMeG8mDQ7IPquMOAgQoIPRHby+6z55Yt6omMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yxzA77MzVvGlpVHfeXSAYPhmI00BZ0gpRTn08sDs1uvXt1lO0cvMbfYrn6TmxCHs2
	 Dwznhy1X/M4fk1HauwwtmJjMMlEM4fByCufBwJLq+AY9j9QBCWgNhh2BgkVKHNfDH1
	 iA0De3dUVXZ7yHXBWYwkHuDe74ZRj47RM4qVy204=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387612AbfIEOR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 10:17:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbfIEOR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 10:17:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB072206A5;
        Thu,  5 Sep 2019 14:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567693046;
        bh=UPePVyXMeG8mDQ7IPquMOAgQoIPRHby+6z55Yt6omMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AT9B9T8vMdTsYBHToi9SP6SO5oOPzIxzFOwiUWZ/LmJPH5v2t6OwqAIQLvs5SN8VL
         bU/1iPsNAXBVYt1POPhDcOEyEgkBWA0BM45GPwenIGTwBsZv+AVIMuNJS27rPdaicL
         oB18VYDGmNzqUYZZK62jBGv29MrK9ehyXagz9auU=
Date:   Thu, 5 Sep 2019 16:17:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Jessica Yu <jeyu@kernel.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Thomas Gleixner <tglx@linutronix.de>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: license-rules.txt: cover SPDX headers on Python
 scripts
Message-ID: <20190905141723.GB25790@kroah.com>
References: <20190905055614.7958918b@coco.lan>
 <88e638eb959095ab6657d295f9f8c27169569bf2.1567675272.git.mchehab+samsung@kernel.org>
 <20190905065701.4744e66a@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905065701.4744e66a@lwn.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 06:57:01AM -0600, Jonathan Corbet wrote:
> On Thu,  5 Sep 2019 06:23:13 -0300
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> 
> > Python's PEP-263 [1] dictates that an script that needs to default to
> > UTF-8 encoding has to follow this rule:
> > 
> > 	'Python will default to ASCII as standard encoding if no other
> > 	 encoding hints are given.
> > 
> > 	 To define a source code encoding, a magic comment must be placed
> > 	 into the source files either as first or second line in the file'
> 
> So this is only Python 2, right?  Python 3 is UTF8 by default.  Given that
> Python 2 is EOL in January, is this something we should be concerned
> about?  Or should we instead be making sure that all the Python we have
> in-tree works properly with Python 3 and be done with it?

I recommend just using python 3 everywhere and be done with it as there
are already many distros that default to that already.

thanks,

greg k-h
