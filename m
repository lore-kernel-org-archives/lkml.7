Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFD6C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 09:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3372A2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 09:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfFEJlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 05:41:35 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:38802 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbfFEJlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 05:41:35 -0400
Received: by mail-lf1-f54.google.com with SMTP id b11so18588523lfa.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 02:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mD5POnGi96vhsSTDzK5VPlMWzvJ6ZNYJN2YLUROjSiE=;
        b=IHjAXcdABIHO90WkXder9o9jW2BXCxXw7vTp6N0s59YZSI5uomdV21knnYs7mPra4B
         tcH1hq9ciVQ3Azd3xiLbiE9RyvQXxQehP2VAzm/BW9NT20dvbZXGaK2+caN9z38MUDOy
         jyf4LMevIVId22w6kDYB03rvhb/Jp0y0DjkRgpeY+DqKJsCn97DFPgdaH7ukr+7DpbPL
         4jiMteQM3S4KbdZsVa3l+lbui8jeOYJb2NdGySiTTo74WEpMI5+mR1j7J5eIM8tR5oJj
         zwBr2FMzZKwHDgO97sVb7m10YAYCMKbPMa6Uw4SjmketsspvX3gC1DrpEou9cftqJPGx
         W9vA==
X-Gm-Message-State: APjAAAVhYbLvfEfx/gIfh8us3Hn5JMofw7LYqDI8vdRP/bS0ibZbxT5q
        qfrbtHYFbFpwGN26IxC+jXvO54qrylix9oElU/ldZg==
X-Google-Smtp-Source: APXvYqzwcglkITd7H0Ft0gMprdTFjTSYUv+hAGVBAfXR4UQk7GiuIytvLKV7ZVoazrmJaPI65LZkXlelTZSIlO32llE=
X-Received: by 2002:ac2:46ef:: with SMTP id q15mr19765640lfo.63.1559727693337;
 Wed, 05 Jun 2019 02:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <1559212177-7072-1-git-send-email-bhsharma@redhat.com>
 <87v9xsnlu9.fsf@concordia.ellerman.id.au> <CACi5LpM9v1YC_6HhA-uKghawzkEu=TTPVkomMmv2i-LGi8X7+g@mail.gmail.com>
 <20190530081358.650930ad@lwn.net> <87ef4eodwf.fsf@concordia.ellerman.id.au>
In-Reply-To: <87ef4eodwf.fsf@concordia.ellerman.id.au>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Wed, 5 Jun 2019 15:11:20 +0530
Message-ID: <CACi5LpMTSu0PuZhLDnQv_bFD42vFnX_LMQvse4ERPfFiquSriw@mail.gmail.com>
Subject: Re: [PATCH] Documentation/stackprotector: powerpc supports stack protector
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Jonathan Corbet <corbet@lwn.net>, linuxppc-dev@lists.ozlabs.org,
        Arnd Bergmann <arnd@arndb.de>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Fri, May 31, 2019 at 8:44 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Jonathan Corbet <corbet@lwn.net> writes:
> > On Thu, 30 May 2019 18:37:46 +0530
> > Bhupesh Sharma <bhsharma@redhat.com> wrote:
> >
> >> > This should probably go via the documentation tree?
> >> >
> >> > Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> >>
> >> Thanks for the review Michael.
> >> I am ok with this going through the documentation tree as well.
> >
> > Works for me too, but I don't seem to find the actual patch anywhere I
> > look.  Can you send me a copy?
>
> You can get it from lore:
>
>   https://lore.kernel.org/linuxppc-dev/1559212177-7072-1-git-send-email-bhsharma@redhat.com/raw
>
> Or patchwork (automatically adds my ack):
>
>   https://patchwork.ozlabs.org/patch/1107706/mbox/
>
> Or Bhupesh can send it to you :)

Please let me know if I should send out the patch again, this time
Cc'ing you and the doc-list.

Thanks,
Bhupesh
