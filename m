Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA1FC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31EA9204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556023111;
	bh=QVEe+2xZKzvtEZVFYMTywIqdBnYVBfXIfhwKS9ENxQE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=sNwOeW6b0k2zlv/YdfbpnG72Y2j+VADFqyuYiwc6AY4BRS8KQZ4iCe5VOHMIyUUn/
	 E4kHlOwwiWRGQqFIHPzaMrbKVC6R8eIaCBCCYc/fE+EX6DON98LxULCmZXrLOYm0rL
	 uSFtMjeXm9rJsV7gwo3dJHuSH8TQYZk4+W0zFLPw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfDWMia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 08:38:30 -0400
Received: from casper.infradead.org ([85.118.1.10]:46868 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfDWMia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 08:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jzsCu3UclCPI4Y3sy+iQiRukLb1fa86cUHsLshVIRb4=; b=mKLA4xKILZf611KFqFyn7OqbXm
        B9GQhp2gs27WeI0/7IR+3GhOxdIn5lRQ4GpgE/WNkLGnvRxWxe18oqmNJmAHslz4zcoHq09VY2xxC
        jagHDybF9gHj+nlpxZ7pe+AWJOBOKlABvK4IHO9z3g0aNoOn5LDO7jBX1Dg7b55rcnFxe5Tv0WXWK
        Rfrre8oNVVxHlzASzRyIKf/bNJK69TwI/RNdtJfvKcZ4kgB8jNoDjzE82HAzWc6kzDoZWlKgwcvgS
        di4AuAJXhdH2Bj11ce4NhZteBBMxlrwfdi0jQSrxI4ZyScHY2bi4K757eMNcRpFFhyYTZecavyMeL
        6Ma2iczA==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIugt-0001HC-Eq; Tue, 23 Apr 2019 12:38:28 +0000
Date:   Tue, 23 Apr 2019 09:38:22 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH 15/57] docs: gpio: convert it to ReST
Message-ID: <20190423093822.52227129@coco.lan>
In-Reply-To: <CACRpkdYQeEoyE9sAAo2KZjurx9sH4w+bzM-_-_h6U4w7PeX7eg@mail.gmail.com>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
        <0f2d522a80f96391d3f7b51389d08b4afaedb618.1555382110.git.mchehab+samsung@kernel.org>
        <CACRpkdYQeEoyE9sAAo2KZjurx9sH4w+bzM-_-_h6U4w7PeX7eg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 23 Apr 2019 12:52:04 +0200
Linus Walleij <linus.walleij@linaro.org> escreveu:

> On Tue, Apr 16, 2019 at 4:56 AM Mauro Carvalho Chehab
> <mchehab+samsung@kernel.org> wrote:
> 
> > The API described at sysfs.txt is deprecated.
> >
> > Still, as it is still part of the Kernel (and will likely be
> > there for some time, as we don't simply remove APIs). So,
> > it makes sense to keep it there.
> >
> > The conversion of this file is trivial.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>  
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Mauro will you merge this or do you want me to merge it?

Linus,

Just answered on the other e-mail: better to merge via your
tree. Just notice that this version was superseded by

 [PATCH v2 15/79] docs: gpio: convert docs to ReST and rename to *.rst

As it also does the rename to .rst.

Thanks,
Mauro
