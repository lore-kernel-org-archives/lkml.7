Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87DAC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 15:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0AFE20717
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 15:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568389043;
	bh=vc7KhWIUVNe7MVt+eKAw6RT3WhN3MFYOyzVs9iVzfb0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=OG8FDSXdmHzOkqBiN42qOEAOSbkw+0hF9tLoYUrtRz9AKbPjBEeEvz8kxpkevMzpx
	 CyLbOIvU+8C4Z7JEYKTSpTHqi5JYuniQ44kUCWUrOwdupZ+jOOihovV1A2qqVi2ieZ
	 zGmTl1zL5q+f4Q5abEjxrPRE+G9xKrOQTdqWj78o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391235AbfIMPhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 11:37:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53672 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbfIMPhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 11:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=C+bQZ7OsAJqgd02njLeMk4sII7e61xhtzjvOa7XtD9U=; b=LkfSSVWwb7TycH4MxAFooZ+0j
        oeUvu5zjwy2Yiys7K395tUgogQVaDKlSwq1AGTdPzzL6TWWbNMUt+kyY8N18KFI1McXNOYJbGhnW0
        0/SGEJVdGCxkKYkqfKqrFMDdPxcgV43kqxfdjznJ5VARwRai2ZYe1Sx3Ev/lZ0odSuK8Z7Q04kdcG
        QEkaYOtAEZmyyMa4h2xzjL0J9IN58sBNihZb9aUgbBVTk6ktsoyYLP4uRe8ejHAk8D4oskKC7UrNN
        8dtpPqur1rOd/G2wlkxT2GsubNaeEb9cOk6WKBr90R/WH+irQPankJzEtRDBueYae9XTqsJXoMXAQ
        yJYL1cscQ==;
Received: from 177.96.232.144.dynamic.adsl.gvt.net.br ([177.96.232.144] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i8ndR-0004rG-8P; Fri, 13 Sep 2019 15:37:21 +0000
Date:   Fri, 13 Sep 2019 12:37:17 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-kernel@vger.kernel.org, vishal.l.verma@intel.com,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-nvdimm@lists.01.org
Subject: Re: [Ksummit-discuss] [PATCH v2 1/3] MAINTAINERS: Reclaim the P:
 tag for Maintainer Entry Profile
Message-ID: <20190913123717.31d5b470@coco.lan>
In-Reply-To: <156821692805.2951081.1395288717170089573.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
        <156821692805.2951081.1395288717170089573.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 11 Sep 2019 08:48:48 -0700
Dan Williams <dan.j.williams@intel.com> escreveu:

> Fixup some P: entries to be M: and delete the others that do not include an
> email address. The P: tag will be used to indicate the location of a
> Profile for a given MAINTAINERS entry.
> 
> Cc: Joe Perches <joe@perches.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  MAINTAINERS |   12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 

...

>  MEDIA INPUT INFRASTRUCTURE (V4L/DVB)
>  M:	Mauro Carvalho Chehab <mchehab@kernel.org>
> -P:	LinuxTV.org Project
>  L:	linux-media@vger.kernel.org
>  W:	https://linuxtv.org
>  Q:	http://patchwork.kernel.org/project/linux-media/list/
> @@ -13452,7 +13450,6 @@ S:	Maintained
>  F:	arch/mips/ralink

Acked-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Thanks,
Mauro
