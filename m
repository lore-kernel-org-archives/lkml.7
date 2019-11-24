Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9872C432C3
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 17:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94792207FC
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 17:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="yhAvdlqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfKXRCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 12:02:11 -0500
Received: from mx.kolabnow.com ([95.128.36.42]:9106 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbfKXRCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 12:02:10 -0500
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id C8DE8403FB;
        Sun, 24 Nov 2019 18:02:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1574614925; x=1576429326; bh=ZzJk2PlCg3Y0Fn9+pSO5WGY4G7ppzTRN5vG
        8DpLnZkQ=; b=yhAvdlqGGq72qq5Xl+PXJIbJcUwBqWXx2+LIvwOohEnP1H1uz98
        X3S+KRV07PmipAnrarWpWVAuxNCUQXEVhUcCto24tswQpF0HI9oczp8DC59zx56s
        9qwBi4S/9eFqdfGaYDZMksvncG8OkRisTZ9N1ViuK/AeZxwzcn5gzJyidzAJI2EW
        ZHwmenXZb9hRBhNgBBnF8zNeF+M3yCAVzDVbSM2IjMJulL9xi53njpRNEhropCQA
        Et5FXTE4MOIBAG26x6flXKsZYpIxrbHqovJ7l/GY3DVfbkNWI6CeTAubcSqzg9bl
        5opNByj75x1XXZEhKfzHBVZsqWYFWEY1io4xcGqLNTkPHExmri3Rly3uDxG4nfti
        SDjphTOd4egxuJinl4COxsWNNG5cZFOKnXOLVgTLgXZjtynKGNvbagSNiYtPGcx1
        SKAbjx3q7va/L99FpM+arOkurnsVDOoPcbOQsC4vQO1ODvwwiwbC9EaEHIxMXkbQ
        OrD16B4D9+NOKDc1n73gTbfuM2315ptmxzXcX//JCIyBD0UlxxJIZiMbtzsXIWGs
        ygCY4AkcFMguECcvabA8/G90c9IP7yFKCFVtI+jDb/5z1sYvFCTJFW/e1S0vlTJ+
        HKCVkDkUdktwnbg9GiysO/KwrCTs0NRNoRIUfQf0F333vQRwoq9Z70vc=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id z4IsJ0Xn-Vfy; Sun, 24 Nov 2019 18:02:05 +0100 (CET)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id E740440387;
        Sun, 24 Nov 2019 18:02:04 +0100 (CET)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 754183F0B;
        Sun, 24 Nov 2019 18:02:04 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc: fix reference to core-api/namespaces.rst
Date:   Sun, 24 Nov 2019 18:02:02 +0100
Message-ID: <2008227.4siv4ILC15@harkonnen>
In-Reply-To: <20191122103437.59fda273@lwn.net>
References: <20191122115337.1541-1-federico.vaga@vaga.pv.it> <20191122103437.59fda273@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, November 22, 2019 6:34:37 PM CET Jonathan Corbet wrote:
> On Fri, 22 Nov 2019 12:53:37 +0100
> 
> Federico Vaga <federico.vaga@vaga.pv.it> wrote:
> > This patch:
> > 
> > commit fcfacb9f8374 ("doc: move namespaces.rst from kbuild/ to core-api/")
> > 
> > forgot to update the document kernel-hacking/hacking.rst.
> > 
> > In addition to the fix the path now is a cross-reference to the document.
> > 
> > Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
> > ---
> > 
> >  Documentation/core-api/symbol-namespaces.rst | 2 ++
> >  Documentation/kernel-hacking/hacking.rst     | 4 ++--
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/core-api/symbol-namespaces.rst
> > b/Documentation/core-api/symbol-namespaces.rst index
> > 982ed7b568ac..6791f8a5d726 100644
> > --- a/Documentation/core-api/symbol-namespaces.rst
> > +++ b/Documentation/core-api/symbol-namespaces.rst
> > @@ -1,3 +1,5 @@
> > +.. _core-api-namespace:
> > +
> 
> So I've been wondering for a bit why we don't use section headers as
> targets more often rather than adding all these tags.  Perhaps it's because
> we never enabled that extension? What do you think of this as an
> alternative fix? (Probably before committing this I would split into two,
> since enabling the extension merits its own patch).

I take this occasion to express my opinion, even if it is not a strong 
opinion, I am fine with your solution.

A tag should be always unique (a duplicated tag is an error), so a reference 
to it can't (shouldn't) be wrong. A section header could be repeated when it 
is, let's say, too generic (e.g. "Introduction" is a legitimate section in any 
document). Then we can have both:
- a document title is, in general, unique so it is not a problem to use it as 
targets
- a document sub-section could collide with others so it is preferable an 
unique tag.

> 
> Thanks,
> 
> jon
> 
> From b5ca7304e1a7f67717acff2a7bf50f56d387afdd Mon Sep 17 00:00:00 2001
> From: Jonathan Corbet <corbet@lwn.net>
> Date: Fri, 22 Nov 2019 10:30:30 -0700
> Subject: [PATCH] docs: fix reference to core-api/namespaces.rst
> 
> Fix a couple of dangling links to core-api/namespaces.rst by turning them
> into proper references.  Enable the autosection extension (available since
> Sphinx 1.4) to make this work.
> 
> Co-developed-by: Federico Vaga <federico.vaga@vaga.pv.it>
> Fixes: fcfacb9f8374 ("doc: move namespaces.rst from kbuild/ to core-api/")
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/conf.py                    | 2 +-
>  Documentation/kernel-hacking/hacking.rst | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index 3c7bdf4cd31f..fa2bfcd6df1d 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -38,7 +38,7 @@ needs_sphinx = '1.3'
>  # ones.
>  extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include', 'cdomain',
>                'kfigure', 'sphinx.ext.ifconfig', 'automarkup',
> -              'maintainers_include']
> +              'maintainers_include', 'sphinx.ext.autosectionlabel' ]
> 
>  # The name of the math extension changed on Sphinx 1.4
>  if (major == 1 and minor > 3) or (major > 1):
> diff --git a/Documentation/kernel-hacking/hacking.rst
> b/Documentation/kernel-hacking/hacking.rst index a3ddb213a5e1..d707a0a61cc9
> 100644
> --- a/Documentation/kernel-hacking/hacking.rst
> +++ b/Documentation/kernel-hacking/hacking.rst
> @@ -601,7 +601,7 @@ Defined in ``include/linux/export.h``
> 
>  This is the variant of `EXPORT_SYMBOL()` that allows specifying a symbol
>  namespace. Symbol Namespaces are documented in
> -``Documentation/kbuild/namespaces.rst``.
> +:ref:`Documentation/core-api/symbol-namespaces.rst <Symbol Namespaces>`
> 
>  :c:func:`EXPORT_SYMBOL_NS_GPL()`
> 
>  --------------------------------
> @@ -610,7 +610,7 @@ Defined in ``include/linux/export.h``
> 
>  This is the variant of `EXPORT_SYMBOL_GPL()` that allows specifying a
> symbol namespace. Symbol Namespaces are documented in
> -``Documentation/kbuild/namespaces.rst``.
> +:ref:`Documentation/core-api/symbol-namespaces.rst <Symbol Namespaces>`
> 
>  Routines and Conventions
>  ========================




