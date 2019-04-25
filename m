Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C008AC282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E55E217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556181870;
	bh=Bjt9UbhvtnUU4JF1Ugmh32U0petY5Yn4OCBHxmRAjRk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CUwHddU4pXDp0y5ScILJ+TcadZVd412lBnZwcZIL5EP7EgLf3p2SMG62dgtHSaIP7
	 g1uMBKlafry4I7i4DJpE8+vl7xalEnntHNyD3B/wd/ezHLYKSp5fquYbHTeaFW2mmH
	 VH9Uka/wWHFHW661C76+9rus7E9Zy2X/yZ7/5Jao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfDYIo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:44:29 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46191 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfDYIo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:44:27 -0400
Received: by mail-oi1-f194.google.com with SMTP id l12so5603036oie.13;
        Thu, 25 Apr 2019 01:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bjt9UbhvtnUU4JF1Ugmh32U0petY5Yn4OCBHxmRAjRk=;
        b=eXVovOSqqFaD22FpBoWsv41sqZwOu4iycZOlx3Wt2k6FY8krMv0kvZ5ya1bbY8Y6Ve
         g4qZPN3Vm5tkACuIuYxWAJJVb62sDUi7krHBrvKxGuOYkLHN7a63LTF/iZzHa91gx2oW
         zsyf6CTGoRvAl0lqr6WC1uvAgLlTTT77FADv2XtypBbrP790Hw5I9PC++xxrl8owKcgT
         I65JXsIu4HORQYT3znJ8tlh7YlJl5dWxRjftzmdTKQNbR+D7t0YbnMRW6EXOsNNdVO3e
         Iv7HT5R0EJ0I5Hw8tk4DhYwtK1dd/TXT2GaIS4BSwmrkzpH+AsncrkWSnjJIn+v5w3AS
         Ns3g==
X-Gm-Message-State: APjAAAWRTKS3ArbSmb5TdKQ+H8hvB3CC1Q7H23H/EWrSHMhrkpASZ2+V
        KdZV7cPSgLTkibebM6GzrJfrIHuM6rpy96zUX8M=
X-Google-Smtp-Source: APXvYqzanEsCHYgN6ChHqJF1LmTkEoNSTo+9Gyq2P+euIofGGYu9abx/xIveUmPQLvCRXgC5r9O3U8qgxIthy2setfg=
X-Received: by 2002:aca:f511:: with SMTP id t17mr2363558oih.115.1556181866282;
 Thu, 25 Apr 2019 01:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190424175306.25880-1-changbin.du@gmail.com>
In-Reply-To: <20190424175306.25880-1-changbin.du@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Apr 2019 10:44:14 +0200
Message-ID: <CAJZ5v0i3iEyn1vBjPkA0X=8h_UrSeTNV_JduJq9qfYpgCOAPjQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/23] Include linux ACPI docs into Sphinx TOC tree
To:     Changbin Du <changbin.du@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.On Wed, Apr 24, 2019 at 7:54 PM Changbin Du <changbin.du@gmail.com> wrote:
>
> Hi All,
> The kernel now uses Sphinx to generate intelligent and beautiful documentation
> from reStructuredText files. I converted all of the Linux ACPI/PCI/X86 docs to
> reST format in this serias.
>
> The hieararchy of ACPI docs are based on Corbet's suggestion:
> https://lkml.org/lkml/2019/4/3/1047
> I did some adjustment according to the content and finally they are placed as:
> Documentation/firmware-guide/acpi/

I'd like to queue up this series, but it is missing a patch to create
Documentation/firmware-guide/acpi/index.rst.

Care to provide one?
