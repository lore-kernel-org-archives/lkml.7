Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD8DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1255B21852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505150AbfJRPpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:45:09 -0400
Received: from ms.lwn.net ([45.79.88.28]:36694 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409029AbfJRPpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:45:07 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 850AE378;
        Fri, 18 Oct 2019 15:45:06 +0000 (UTC)
Date:   Fri, 18 Oct 2019 09:45:05 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: driver-api: pti_intel_mid: Enable syntax
 highlighting for C code block
Message-ID: <20191018094505.58a5efd4@lwn.net>
In-Reply-To: <20191004170124.13543-1-j.neuschaefer@gmx.net>
References: <20191004170124.13543-1-j.neuschaefer@gmx.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 Oct 2019 19:01:19 +0200
Jonathan Neuschäfer <j.neuschaefer@gmx.net> wrote:

> This makes the code snippet more readable.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  Documentation/driver-api/pti_intel_mid.rst | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/pti_intel_mid.rst b/Documentation/driver-api/pti_intel_mid.rst
> index 20f1cff42d5f..bacc2a4ee89f 100644
> --- a/Documentation/driver-api/pti_intel_mid.rst
> +++ b/Documentation/driver-api/pti_intel_mid.rst
> @@ -49,7 +49,9 @@ but is not just blindly executing as 'root'. Keep in mind
>  the use of ioctl(,TIOCSETD,) is not specific to the n_tracerouter
>  and n_tracesink line discpline drivers but is a generic
>  operation for a program to use a line discpline driver
> -on a tty port other than the default n_tty::
> +on a tty port other than the default n_tty:
> +
> +.. code-block:: c
> 
>    /////////// To hook up n_tracerouter and n_tracesink /////////
> 
> --
> 2.20.1

I had to ponder on this a bit...the addition of that sort of markup tends
to clutter the plain-text reading experience, and I'm personally not
hugely attached to syntax highlighting.  But others feel differently, I
guess, so I applied it.  I'm not sure I want to see a flood of this kind
of change coming in, though.

Thanks,

jon
