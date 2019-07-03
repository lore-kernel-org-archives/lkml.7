Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36489C06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 18:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 146D021881
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 18:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfGCSZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 14:25:51 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45098 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfGCSZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 14:25:50 -0400
Received: by mail-qk1-f193.google.com with SMTP id s22so3554661qkj.12;
        Wed, 03 Jul 2019 11:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hj9Mu/A07WEzdqlLv51CSKCOmnErRsnZV7qZQXqAPU4=;
        b=g/kQq3p647txc2mMTt8f5KdSG4a1NpMtkK4irigH16icij1MmJFrPu2sboNdJl6XSP
         CMuRp7bCBgJe+LM+SE84yjvMjPZB3GVVdV328BWiWwX+cuoGVg0Rr1kc51swRHwpgFuE
         e1ahBWyTilQTVGvEOlxQhNP5Pp9vH2+BuRDpwFwR+kUjp9bxnqhciiL6pux1Ol5/2lfi
         lV+avlAi87pPWGK5MiAXwq7pBjnH8dA+woup+HHZrrQ+jZPP71pchZ1ZG7QYVooNDwqt
         rSWgKQzR9343aRno4lqkVqwekEUWaalPbQC3BTUEK3Z0TVnfqg0Q75OqVatHcMYx+57x
         lvEA==
X-Gm-Message-State: APjAAAV+aDIosMmvSdla46IpeT94VUFhmCe4SeIBmj7176fsYXV/dUhN
        kWahQG3ZszBkMyXkW/eFT39b3qzbn+Rpiju+UabgdYjV
X-Google-Smtp-Source: APXvYqz4bMygWKgzPmMPQ5p4ZuQcJbZZCvEe0RJ2vPSOcOE5DSOmY6oaJcaZ7l0WpnAhLbZjS+hOicTtiyKfXEbB3xc=
X-Received: by 2002:a37:ad12:: with SMTP id f18mr31452492qkm.3.1562178349452;
 Wed, 03 Jul 2019 11:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190703133940.1493249-1-arnd@arndb.de> <7584cf05-e3f9-7027-a08c-87efbfb0f608@synopsys.com>
In-Reply-To: <7584cf05-e3f9-7027-a08c-87efbfb0f608@synopsys.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 3 Jul 2019 20:25:32 +0200
Message-ID: <CAK8P3a2c49gLLU5BKsty7WCD=6gZbJ0PiJvYfe3SMou=SqUi9Q@mail.gmail.com>
Subject: Re: [PATCH] ARC: hide unused function unw_hdr_alloc
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 6:13 PM Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:
> On 7/3/19 6:39 AM, Arnd Bergmann wrote:
> > Fixes: bc79c9a72165 ("ARC: dw2 unwind: Reinstante unwinding out of modules")
> > Link: https://kernelci.org/build/id/5d1cae3f59b514300340c132/logs/
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Thx, do you want me to pick this up via arc tree.

Yes, that would be great.

Thanks,

      Arnd
