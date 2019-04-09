Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E501C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0178220883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfDIV0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:26:42 -0400
Received: from ms.lwn.net ([45.79.88.28]:45678 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726705AbfDIV0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 17:26:40 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 88202301;
        Tue,  9 Apr 2019 21:26:39 +0000 (UTC)
Date:   Tue, 9 Apr 2019 15:26:38 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 00/24] Include linux ACPI docs into Sphinx TOC tree
Message-ID: <20190409152638.5b20c77f@lwn.net>
In-Reply-To: <CAJZ5v0gWmmNwiNW=5XgpO6EJw6cAXpwOOePOtuGmR_JzrC+64g@mail.gmail.com>
References: <20190329001135.15847-1-changbin.du@gmail.com>
        <CAJZ5v0gKX9E+U_9eKfTr7pWGH=jxMLz_Jr850-6BcbG3xBz5qg@mail.gmail.com>
        <CAJZ5v0jbCi3Jgn5YXPCP+zgs-O7z-9_3p3XZGvm40_6RDsJqkQ@mail.gmail.com>
        <20190403133613.13f3fd75@lwn.net>
        <CAJZ5v0gWmmNwiNW=5XgpO6EJw6cAXpwOOePOtuGmR_JzrC+64g@mail.gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Apr 2019 18:42:59 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> > Hardware guide  
> 
> This is more about documenting the expectations regarding the platform
> firmware, so what about firmware-guide instead?

I had imagined a slightly wider focus, but this seems OK for now.  We can
always rename it later :)

> So what about this:
> 
> - Create a new firmware-guide under Documentation and add an acpi/
> directory to it for starters.  Put the following files into it:
> 
>          acpi-lid
>          aml-debugger
>          debug (ditto)
>          DSD-properties-rules
>          gpio-properties
>          i2c-muxes
> 
> - Add an acpi/ subdirectory to Documentation/admin-guide and put the
> following files into it:
> 
>          cppc_sysfs
>          initrd_table_override
>          dsdt-override

I do wonder if, rather than creating a new directory, we shouldn't just
make a single acpi.rst and put that information into it?  

> - Add an acpi/ subdirectory to Documentation/driver-api and put the
> following files into it:
> 
>          enumeration
>          scan_handlers

...and something similar here?  I guess that would be my preference, but I
don't feel all that strongly about it if there's reasons to do otherwise.

In general the plan seems good.

Thanks,

jon
