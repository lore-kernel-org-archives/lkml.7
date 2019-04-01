Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0D9C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02FD120830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="B/ZHxKV9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388333AbfDARlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:41:16 -0400
Received: from tomli.me ([153.92.126.73]:32950 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730448AbfDARlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:41:14 -0400
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id dc0b60cf;
        Mon, 1 Apr 2019 17:41:11 +0000 (UTC)
X-HELO: localhost.localdomain
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.localdomain) (2402:f000:1:1501:200:5efe:ddd9:ae88)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Mon, 01 Apr 2019 17:41:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=1490979754; bh=0n49RqqdudOMHy2GstjjVsVG5FuBQTcm0LtdY345n4w=; b=B/ZHxKV9hbIClvlOhzs8EBJVycP7pKCZnxp/IEPcNKyFI8n7PjQtETutcr8DyOxPFQmJAL4qQJiWU+uAd6+NstaXXYkfNPFqD2/6kwjAzjKx99w9DjydmEuVj49vsmSmBP7JpMKXX43alaJSUpcvjHZMq8brE7fd8VGNcZK5TRQd0p1hoyjO6unMjVSsbTtkRhDNflOdafoQhO6VF9zPwQt1GNXwHZzC54/gMdJuG1w6qT25PYQMVfSX+v/EKF3xKpxrVjGrDCuwrdp5lNgU0nzsJGgG8Q76+zllsvAuJSgrnYmJRQPDd+2r2mlEFgQmWecUWd6DPbyMY5bI3Vhamg==
Date:   Tue, 2 Apr 2019 01:41:04 +0800
From:   Tom Li <tomli@tomli.me>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 7/7] MAINTAINERS: sm712fb: list myself as one
 maintainer.
Message-ID: <20190401174103.GF15736@localhost.localdomain>
References: <20190322051759.15007-1-tomli@tomli.me>
 <20190322051759.15007-8-tomli@tomli.me>
 <20190331190801.hxl57om56jskku5s@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190331190801.hxl57om56jskku5s@debian>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 08:08:01PM +0100, Sudip Mukherjee wrote:
> Technically I donot have any problem with this, you seem to know more
> about SM712 than I know. But Teddy Wang is also an existing maintainer
> and I think there should be an ack from him before this is accepted.

Okay, I'll write a personal mail to Teddy. I think it could be a separate
patch to allow more time for communication, but the problem is that, if
the MAINTAINERS and the new changes are not merged at the same time, users
who have problems may unable to see my name and E-mail address for reporting
problems.

I think I can send PATCH v3 early for your review, meanwhile I can write
a personal E-mail to Teddy.

> On Fri, Mar 22, 2019 at 01:17:59PM +0800, Yifeng Li wrote:
> >  SILICON MOTION SM712 FRAME BUFFER DRIVER
> > +M:	Tom Li <tomli@tomli.me>
> 
> Sorry, I am confused. Is your name "Tom Li"? Then why is your
> Signed-off-by: and From: name different?

Sorry for the confusion.

"Tom Li" is my common name. I use this name both in offline and online
activities, and I've used it to contribute various patches to free and
open source projects and mailing list discussions as well. But the
"Signed-off-by" name is the legal name. Linux Kernel's "Developer's
Certificate of Origin" requires the use of legal name in sign-offs.

I think I should write my name as `Yifeng "Tom" Li` in MAINTAINERS to
avoid the confusion.

Thanks for your code review, I've noted your suggestions and I'll
send PATCH v3 soon.

Thanks,
Tom Li
