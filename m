Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C57C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6177120652
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555409882;
	bh=A11U6XtF16mtIgkSQnvQoL6KOzQ42fHOAUmaQVsPCQ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FosM6K8BOs+fy/dEoYt2bDLhE3OpixNzqgphWeW3waxyNZk1tMmNBrBWfabRyJedc
	 1DleWCWM6WfGFRBmSERPUxW2Xyygvug2TOiRGBLpszw05B866KbXhJPgUUFm0SNY8g
	 VrKeejPbbz52+m/rPvTTONUw4Cfg8+ryXflYeBIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbfDPKSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:18:01 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38319 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfDPKSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:18:00 -0400
Received: by mail-oi1-f194.google.com with SMTP id a6so16448323oie.5;
        Tue, 16 Apr 2019 03:18:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0TuyvSOa9yABxybjHPN+lmbVTaeXDs+z8tLDKxQyOJo=;
        b=c1WCu5y/ZIWdKORNsJeBsFE9s0N21B9UIsT2bSdXRr+jcnLFzPozQVbzLclnDI+9Ak
         j35iJmCLTjjtL6/7lb8VSFc/YOVZqpkfzcUhZOsW6DZCKYvvG1snkIhiPFpkHza91oBG
         CGQ7TK/sEAhQHPJSsMRiASIEqK1OsI4JsYTWIslbiThc2bQoGRbqeMEKWSqgaNwxsqgd
         E5QNWv8hTWPhnTtoFIZq5EY7LZwnGIoVJdrONJ/RngEhTFWZodozGVT7N+5vsSpyWyLT
         xshjeXXL7a2uPs4MzT94cb3JWwSxLgM0RXluhMDxCe+GMvSTftl8Zd1lC54lM8i4BioE
         gnVw==
X-Gm-Message-State: APjAAAWoLIvDBVRISOB6U0VKv+B7qzAJ8tYfS7evlqeVtmJvXHfHtOSG
        gpoxenwMkzIAV3dpHKYdW3sXQqbUW4w1VQe9+fY=
X-Google-Smtp-Source: APXvYqzDFE+wwUBZuvDJuLyi664UF43IBwogfYvWVIFa0AQREjcnET7HQE6+BT+o2CEPrwFMNGXMn32G3ipyXIR19Oc=
X-Received: by 2002:aca:4c08:: with SMTP id z8mr17331578oia.30.1555409879608;
 Tue, 16 Apr 2019 03:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
 <10802a7ac16958a2786c2fc083fb5cb50eb7ebb9.1555382110.git.mchehab+samsung@kernel.org>
 <CAJZ5v0hZK07zQzmD6J0J5dBUAecpE_31_W5Ade5UpWrsWBeU+Q@mail.gmail.com> <20190416065444.2460d3a3@coco.lan>
In-Reply-To: <20190416065444.2460d3a3@coco.lan>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 16 Apr 2019 12:17:48 +0200
Message-ID: <CAJZ5v0i3-VCxNvp5v2wUOeaCUJcJUXLZzHFNJiFH5FG-Negpdw@mail.gmail.com>
Subject: Re: [PATCH 02/57] docs: acpi: convert text files to ReST
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 11:54 AM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> Em Tue, 16 Apr 2019 10:17:11 +0200
> "Rafael J. Wysocki" <rafael@kernel.org> escreveu:
>
> > On Tue, Apr 16, 2019 at 5:02 AM Mauro Carvalho Chehab
> > <mchehab+samsung@kernel.org> wrote:
> > >
> > > Most of the files are already in good shape, making easier to
> > > convert them to ReST by adding proper title markups and
> > > addressing some identation and markups to properly format the
> > > document.
> >
> > There is concurrent work on this under way, please see
> > https://marc.info/?t=155381845300002&r=2&w=2
> >
> > I'd prefer that one to continue, honestly.
>
> Agreed. I didn't notice the patchset.
>
> Btw, please notice patch 11/57:
>
>         Subject: [PATCH 11/57] docs: extcon: move it to acpi dir and convert it to ReST
>
> IMO, it makes sense to move the extcon driver to ACPI, as it sounds
> to be just another ACPI driver.

But that can be done later, on top of the Changbin Du's changes.

Thanks,
Rafael
