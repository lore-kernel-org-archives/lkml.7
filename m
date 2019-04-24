Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4D6C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C485120652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556129570;
	bh=nGGyZgZBVhScOIBiInD39BpFQIeHbyUIU7fQOOiFh9g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=W4cfQBPvrY9SM3/SBzNuc6tt4DegxLDxz6F9AOc9oUW5Z/XCTohk8BuEnBEagtT7S
	 46vK0eKjsLXA5nq6YecRrgMTcWzGr49Jknd2POqo7gRAap5X9AKsKWE2H5oUhyYLFP
	 srFwXnucEeLR5s6nrYLeWHxfMPRwfl7WtjAOpek0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388406AbfDXSMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:12:49 -0400
Received: from casper.infradead.org ([85.118.1.10]:48988 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387726AbfDXSMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ojgIGtqBjKZ94rG62AN3WAggUWCZ+hJ6m5woSpGnwUc=; b=O1/F2Qpu51GO8rXz1zY6kYk99L
        XrZlPd3IlyXTDjPoqKWGkQ5L9ocnA+I/P9bunB/fSk9vhEPYRAZEeNbp8uderR2zg3eMU4Um449UQ
        JDiIDpo4Y/nvTg9W5eMOQW4SVXC4xvq+GLXJzJzNtdosM6b0r2bRoOiynVZDK9eu2ZpBQyEI2tzzn
        2+Hq0uDmIVrzTNK1UXukkg/kMtNzFd2MEIvgNbLYOdakf1WdML/JmeoL6fYbGbSyagrhuUE2/qLwk
        2nZ2nuZANyvKzCUoyn/QXq9V9RbcfqO/Yq09GKoeR4BYNCqOMXCJke1on90Pix4qUKL0knXOa1JYy
        iBqFTp0w==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJMNt-000219-Pf; Wed, 24 Apr 2019 18:12:42 +0000
Date:   Wed, 24 Apr 2019 15:12:36 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     rjw@rjwysocki.net, Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v5 20/23] Documentation: ACPI: move cppc_sysfs.txt to
 admin-guide/acpi and convert to reST
Message-ID: <20190424151236.776d9678@coco.lan>
In-Reply-To: <20190424175306.25880-21-changbin.du@gmail.com>
References: <20190424175306.25880-1-changbin.du@gmail.com>
        <20190424175306.25880-21-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 25 Apr 2019 01:53:03 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  .../acpi/cppc_sysfs.rst}                      | 71 ++++++++++---------
>  Documentation/admin-guide/acpi/index.rst      |  1 +
>  2 files changed, 40 insertions(+), 32 deletions(-)
>  rename Documentation/{acpi/cppc_sysfs.txt => admin-guide/acpi/cppc_sysfs.rst} (51%)
> 
> diff --git a/Documentation/acpi/cppc_sysfs.txt b/Documentation/admin-guide/acpi/cppc_sysfs.rst
> similarity index 51%
> rename from Documentation/acpi/cppc_sysfs.txt
> rename to Documentation/admin-guide/acpi/cppc_sysfs.rst
> index f20fb445135d..a4b99afbe331 100644
> --- a/Documentation/acpi/cppc_sysfs.txt
> +++ b/Documentation/admin-guide/acpi/cppc_sysfs.rst
> @@ -1,5 +1,11 @@
> +.. SPDX-License-Identifier: GPL-2.0
>  
> -	Collaborative Processor Performance Control (CPPC)
> +==================================================
> +Collaborative Processor Performance Control (CPPC)
> +==================================================
> +
> +CPPC
> +====
>  
>  CPPC defined in the ACPI spec describes a mechanism for the OS to manage the
>  performance of a logical processor on a contigious and abstract performance
> @@ -10,31 +16,28 @@ For more details on CPPC please refer to the ACPI specification at:
>  
>  http://uefi.org/specifications
>  
> -Some of the CPPC registers are exposed via sysfs under:
> -
> -/sys/devices/system/cpu/cpuX/acpi_cppc/


> -
> -for each cpu X

Yeah, there it is: you're removing those two lines.

> +Some of the CPPC registers are exposed via sysfs under::
>  
> ---------------------------------------------------------------------------------
> +  /sys/devices/system/cpu/cpuX/acpi_cppc/

As per my reply to v4.

Thanks,
Mauro
