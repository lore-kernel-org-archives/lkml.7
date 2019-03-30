Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84A9C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 09:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843B8218E2
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 09:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553938917;
	bh=LkKZk6pDoy1mn0WceG9/G9zcgWPupGUKZwVGsPw1M6s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iPLVHXOspYf/c7p1pauoSDq5+PiaNodHJcbVwaeawcPaD/YpfFJUcbinAkqUT9d4O
	 ZbsE4/65u1SVWWeN/+JLzIau3igIkQqYbeUlQjQqsBR5GNSUijs42ZtZWRbdLq+gsn
	 gDzvdcXnP4RROV+zZHeTkGGqZ9s/7o/A0hXIsKCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbfC3Jl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 05:41:56 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37500 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730352AbfC3Jl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 05:41:56 -0400
Received: by mail-ot1-f66.google.com with SMTP id c16so4373695otn.4;
        Sat, 30 Mar 2019 02:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LkKZk6pDoy1mn0WceG9/G9zcgWPupGUKZwVGsPw1M6s=;
        b=l448sWENozxn8mx6VlTbPY1GrH4X7cXB4BbPwpbH+mDF0YpiCHvoDAYGTvemNWsb+a
         orbm8ekBufcYoXgn5ZQANpFHsAOQU5tLmGlZIuB5fnuIe8+DfCcNTPn8vcFQXotffouH
         45HoxM0hmxPt61XKAT34+m7mgYab+8Mi7D31Mk3KoFJ+AlHaQun4RsL05uuMHEHcHLsx
         9004oYKcFmvVIA50U0tZ3FWVmVXS0190UuEyYV2XL3KVVz7I+SKA/aLFTsG3m0jP0o4l
         +TyuE+ITtilLEu0FDhjRkRVQgdH2+ki7+g2EuQZwnphEGVR+JbSdfUQfL93ZSVQO9zVg
         olgw==
X-Gm-Message-State: APjAAAVVht5GfHRCq9Y7QhQetzq/PYPLcJneQZfrG4dGPUNHQ2yz6rxM
        LxfIPUmZ5z3uZ8Wk6gBWlcVHxkwWAADJ+KnsinI=
X-Google-Smtp-Source: APXvYqxUVZoWkXNoOwzteEdgC/6rx+NiDVELHzdqLL62SCTHd146Mv3b4t/8s2STZI46hj0PS+aj5mqgTXLczkNripY=
X-Received: by 2002:a9d:738c:: with SMTP id j12mr35958556otk.119.1553938915592;
 Sat, 30 Mar 2019 02:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190329001135.15847-1-changbin.du@gmail.com>
In-Reply-To: <20190329001135.15847-1-changbin.du@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 30 Mar 2019 10:41:44 +0100
Message-ID: <CAJZ5v0gKX9E+U_9eKfTr7pWGH=jxMLz_Jr850-6BcbG3xBz5qg@mail.gmail.com>
Subject: Re: [PATCH v2 00/24] Include linux ACPI docs into Sphinx TOC tree
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 1:11 AM Changbin Du <changbin.du@gmail.com> wrote:
>
> Hi Corbet and All,
> The kernel now uses Sphinx to generate intelligent and beautiful documentation
> from reStructuredText files. I converted most of the Linux ACPI docs to rst
> format in this serias.

First, I appreciated the effort, thanks for your work!

> For you to preview, please visit below url:
> http://104.238.181.70:8080/kernel-doc/acpi/index.html

So currently all of this appears under Kernel API documentation, but
the majority of it is not about kernel API.

At least some of it could go under admin-guide IMO.

Thanks,
Rafael
