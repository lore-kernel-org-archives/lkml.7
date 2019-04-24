Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764E8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 478EE20684
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556129432;
	bh=cQNzVi2vJ2cQmXFDeXXqFETe/LEfvO7+TCvxwPjyA4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=phvN1hz3Unmpj/1dIlYxxjLtWRycGpR743LxCfM9dBODyVXl06aNdX8k7qEv1xUuQ
	 +C+KDEdBWG2jUlA2ULIN29r3VEIpfoSmBoFf/vYFbxYQipbg1zaOnvdVK5maCesYyL
	 9ZEiqaBvKxR2SrY0mo5I4mF8Cicui4clzIrn5Pek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389218AbfDXSKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:10:31 -0400
Received: from casper.infradead.org ([85.118.1.10]:48756 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388807AbfDXSK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:10:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=d+dDVPR0m38MbRKD/xgSDYv2iaJ3D1TOHrXAP3UsC/0=; b=VtZaOJBUNkTV4G6Vvt5H2TOwxv
        eZOXu6uG9Y6Lfow92VCRCJmn7xHGmlMkdeK4zTGYEJuqhutf09DboYU8kJ8+bp3qS7zSuNVW89YKg
        8iNVzHiSHQUBAcWguL6QBTiYCM2N3hdor0YzuiP+OwafWYbAH7HfIHyx6v6K7bn0M32BITb2BsKOt
        7tkA6nuQSIC+mhR7JnOkprersSvXWJFtheAGxJneU8QP7pvng8MjbUw02Y8hWyysb5a4aAz3ZC16j
        hKx7XIyKKwNTmqvW9+gQx0oKp7OB80sgLvsu8/i0JuRU8/ROIXNHLfeICc8KcM4kCToZvCF83Hkdf
        PTATqA4A==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJMLh-0001wh-EO; Wed, 24 Apr 2019 18:10:26 +0000
Date:   Wed, 24 Apr 2019 15:10:20 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     rjw@rjwysocki.net, Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v5 14/23] Documentation: ACPI: move
 dsd/data-node-references.txt to firmware-guide/acpi and convert to reST
Message-ID: <20190424151020.406b81ef@coco.lan>
In-Reply-To: <20190424175306.25880-15-changbin.du@gmail.com>
References: <20190424175306.25880-1-changbin.du@gmail.com>
        <20190424175306.25880-15-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 25 Apr 2019 01:52:57 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  .../acpi/dsd/data-node-references.rst}        | 36 ++++++++++---------
>  Documentation/firmware-guide/acpi/index.rst   |  1 +
>  2 files changed, 21 insertions(+), 16 deletions(-)
>  rename Documentation/{acpi/dsd/data-node-references.txt => firmware-guide/acpi/dsd/data-node-references.rst} (71%)
> 
> diff --git a/Documentation/acpi/dsd/data-node-references.txt b/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
> similarity index 71%
> rename from Documentation/acpi/dsd/data-node-references.txt
> rename to Documentation/firmware-guide/acpi/dsd/data-node-references.rst
> index c3871565c8cf..1351984e767c 100644
> --- a/Documentation/acpi/dsd/data-node-references.txt
> +++ b/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
> @@ -1,9 +1,12 @@
> -Copyright (C) 2018 Intel Corporation
> -Author: Sakari Ailus <sakari.ailus@linux.intel.com>
> -
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: <isonum.txt>
>  
> +===================================
>  Referencing hierarchical data nodes
> ------------------------------------
> +===================================
> +
> +:Copyright: |copy| 2018 Intel Corporation
> +:Author: Sakari Ailus <sakari.ailus@linux.intel.com>
>  
>  ACPI in general allows referring to device objects in the tree only.
>  Hierarchical data extension nodes may not be referred to directly, hence this
> @@ -28,13 +31,14 @@ extension key.
>  
>  
>  Example
> --------
> +=======
>  
> -	In the ASL snippet below, the "reference" _DSD property [2] contains a
> -	device object reference to DEV0 and under that device object, a
> -	hierarchical data extension key "node@1" referring to the NOD1 object
> -	and lastly, a hierarchical data extension key "anothernode" referring to
> -	the ANOD object which is also the final target node of the reference.
> +In the ASL snippet below, the "reference" _DSD property [2] contains a
> +device object reference to DEV0 and under that device object, a
> +hierarchical data extension key "node@1" referring to the NOD1 object
> +and lastly, a hierarchical data extension key "anothernode" referring to
> +the ANOD object which is also the final target node of the reference.
> +::
>  
>  	Device (DEV0)
>  	{
> @@ -75,15 +79,15 @@ Example
>  	    })
>  	}
>  
> -Please also see a graph example in graph.txt .
> +Please also see a graph example in :doc:`graph`.
>  
>  References
> -----------
> +==========
>  
>  [1] Hierarchical Data Extension UUID For _DSD.
> -    <URL:http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf>,
> -    referenced 2018-07-17.
> +<http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf>,
> +referenced 2018-07-17.
>  
>  [2] Device Properties UUID For _DSD.
> -    <URL:http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf>,
> -    referenced 2016-10-04.
> +<http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf>,
> +referenced 2016-10-04.
> diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
> index f81cfbcb6878..6d4e0df4f063 100644
> --- a/Documentation/firmware-guide/acpi/index.rst
> +++ b/Documentation/firmware-guide/acpi/index.rst
> @@ -9,6 +9,7 @@ ACPI Support
>  
>     namespace
>     dsd/graph
> +   dsd/data-node-references
>     enumeration
>     osi
>     method-customizing



Thanks,
Mauro
