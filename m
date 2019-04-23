Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360C0C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A6E20652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfDWINB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 04:13:01 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43694 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfDWINB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 04:13:01 -0400
Received: by mail-lj1-f193.google.com with SMTP id f18so12622958lja.10;
        Tue, 23 Apr 2019 01:12:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=66t0PU31NWF0UcK8xhT0ViUIurqvRTTPYdEGVSwzQGo=;
        b=LWpXkxk6+rFGSHVm0QH9RHPw2QdUnNszV+r/USnh7GR4oD48++p/s8+iVwfny76PLA
         rCzRQesII7oS8sVEWA7pXHI10n6vxBMUrBkgRfwlLBYb+bK/iWMECFfNsrEexd1s87AF
         QRPtx43bj7Ns96BD5w/Gykj5gE82K2bDgz7ZslLDT5pzODChZW31cybG++xRN/YeCJ2v
         +MTh4V9j5tivZgRPdWjwZLEqdn2/CTJ+BZ+4uIewdDtvuApZK1nfUftUOYxg6iUy1drz
         qSRsJRS1TwX9a+n9Oj5yJLN6eKxbd/2FC+w4AIPv78HLgG/VLdMeEmXEkBWtGZCd/vC7
         Pdvw==
X-Gm-Message-State: APjAAAUFqvEhQi0fU5m7oHw7qYU7JR2zIkYRAK7CxWNiUPZR4eHbkf91
        5vwMY9IXXvfjIYVTsJo4gFR0NP5NybE8P4dmNV+xAIR6
X-Google-Smtp-Source: APXvYqxYD0KZsETsZF+7+OrSVcgIODfclMxpd83q1zgT49DhNgfTIfMhs7RrkL4bOThaLHypmYmBaau/EcspJ5LO9iU=
X-Received: by 2002:a2e:88c1:: with SMTP id a1mr12147259ljk.78.1556007178949;
 Tue, 23 Apr 2019 01:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190423105131.7f460991@canb.auug.org.au>
In-Reply-To: <20190423105131.7f460991@canb.auug.org.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 23 Apr 2019 10:12:42 +0200
Message-ID: <CAK8P3a1LDL51KW2jJdOacAxNP=Gk9YSdcP2LfX8ZasLOdcibDg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the v4l-dvb-next tree with the
 v4l-dvb tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sean Young <sean@mess.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 2:51 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the v4l-dvb-next tree got a conflict in:
>
>   drivers/media/platform/Kconfig
>
> between commit:
>
>   63604a143fe1 ("media: seco-cec: fix building with RC_CORE=m")
>
> from the v4l-dvb tree and commit:
>
>   81527254e151 ("media: seco: depend on CONFIG_RC_CORE=y when not a module")
>
> from the v4l-dvb-next tree.
>
> I fixed it up (I just used the v4l-dvb tree version) and can carry the
> fix as necessary. This is now fixed as far as linux-next is concerned,
> but any non trivial conflicts should be mentioned to your upstream
> maintainer when your tree is submitted for merging.  You may also want
> to consider cooperating with the maintainer of the conflicting tree to
> minimise any particularly complex conflicts.

Thanks!

Both patches are correct, they just use slightly different syntax, so
the merge is fine as well.

     Arnd
