Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3D8C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 09:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86093214AF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 09:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559986938;
	bh=YR0J/+BCIzUjmKr2HSs1ka18vCvS5I9iXlFVh2UCmcw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=sXlhdLmLX6HPP+Ox90btfHvH8GySwiZr47gM4r02YOm4o6VdGxTjibC6gkUZ7AhLO
	 srICvexoI7ZFxS0lDRC6torJQZTBwKkTbMY2mBpc0zIyUSO5WlyWih2RfOkRmKXNCA
	 c1bv8fRtDCVhLjPqgsaJXZIlK2OROVjOT5Fz+ZZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfFHJmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 05:42:18 -0400
Received: from casper.infradead.org ([85.118.1.10]:36002 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfFHJmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 05:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=L6aKzlUkWy+OfHCVOhU+Gs2YnJQVaK61S0nVMkufido=; b=IfhkF06RWiZRh8TccdsDPqJ8E8
        BzHA6r6xGh+PKE0l9y7k3YCJvjia7GMMLlhYj5r4aWc3jsFOzNWjIGNZmlxFXOp8stdj1EguJcWXi
        iCLJcyQY3fd/SVz3TxGnsqBPdFtvqlh96XzKKfmYiiZfRCMqgnrGofIozJhaH7VdaE7aQ2MSoOgxs
        3CwxBVLYqrABCIZevjMMQsOoz3K9UvDHg6eoq9V/QAVHRtRUlts5qbob/aeO4i+HAOnpp1fcF2+KP
        OfLRyxTGkZHu/+XkHZJTifUfsZB75n6c6Cc875smWbCG2n1xSk/La1qa7n+TzXibY6i2N/1tCydeh
        shGb2EAA==;
Received: from [179.181.119.115] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZXra-000178-D8; Sat, 08 Jun 2019 09:42:14 +0000
Date:   Sat, 8 Jun 2019 06:42:08 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v2 12/22] docs: gpio: driver.rst: fix a bad tag
Message-ID: <20190608064208.12e0e145@coco.lan>
In-Reply-To: <CACRpkdayQdrtqO3aygY1uDG0LCX_9rVnSnxP5F_C-KMZURTAYA@mail.gmail.com>
References: <cover.1559656538.git.mchehab+samsung@kernel.org>
        <ee8f4f56658247a0ab0d9e2c16a9afafefe38da0.1559656538.git.mchehab+samsung@kernel.org>
        <CACRpkdayQdrtqO3aygY1uDG0LCX_9rVnSnxP5F_C-KMZURTAYA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Em Sat, 8 Jun 2019 00:08:10 +0200
Linus Walleij <linus.walleij@linaro.org> escreveu:

> On Tue, Jun 4, 2019 at 4:18 PM Mauro Carvalho Chehab
> <mchehab+samsung@kernel.org> wrote:
> 
> > With ReST, [foo]_ means a reference to foo, causing this warning:
> >
> >     Documentation/driver-api/gpio/driver.rst:419: WARNING: Unknown target name: "devm".
> >
> > Fix it by using a literal for the name.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>  
> 
> Looks identical to the v1 I already applied, so keeping
> that one.

Thanks for applying it.

Yeah, it should be identical (and so it should be the v3 I sent yesterday).

v2 and v3 are just rebases on the top of linux-next.

Thanks,
Mauro
