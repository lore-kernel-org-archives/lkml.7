Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E48C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B43218AE
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554533630;
	bh=j6gl2UUN9KnI8j8esIjaFByayMdjKnM0EdtIC/dLZ5s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tv7VVIWQJy1heW58Ba+dlpjcLZjKn7q9mGsloWCyhPNLFlgL7AiMMHX2vsWOr4pRf
	 ez+/sl/SvmPhigz4qj5KgcH7vUMbQqIfm8/usgLCAC27wim1EVMtzCPddIbU0T08AX
	 HvslgDswinzqslwokbEA6adrKShWd3TvRZPd56Nk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfDFGx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 02:53:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfDFGx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 02:53:27 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FE2B218D4
        for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2019 06:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554533606;
        bh=j6gl2UUN9KnI8j8esIjaFByayMdjKnM0EdtIC/dLZ5s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PxUjRMl7IwNEdP4BqNtoJDT/9xEHevdtqHzPTvolPAvml3SitFbCj5LJTFdzSyGNN
         rXmBbn3oly8BupZ6dyAURa0wYnmsb/SG6MGXaGRrLgvnZgoJdevLcQTlEsUkKIbq1l
         vKD1CYZQl9hCt0Ph17/sYWQW0pbCrWuX4fHC/cUU=
Received: by mail-oi1-f179.google.com with SMTP id n187so6697149oih.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 23:53:26 -0700 (PDT)
X-Gm-Message-State: APjAAAV4QpkeTCp5r87gFIqKzR8FJVfWF2KrRDkJHlyig6depokyuBgD
        9DNo/DrcHlzHGzZd4XJPvU85AOq8pTXi8xJjPMBE3A==
X-Google-Smtp-Source: APXvYqyBZ3LY7qOX5PFsl1DdYHfItcmrmsjcO4jzOLeYvkonepun//0cABk40qTnlgEqCKuZSh1jzPbXeNRmCFV6Uw4=
X-Received: by 2002:aca:d90a:: with SMTP id q10mr9759152oig.65.1554533605624;
 Fri, 05 Apr 2019 23:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190406062538.31325-1-paul.walmsley@sifive.com>
In-Reply-To: <20190406062538.31325-1-paul.walmsley@sifive.com>
From:   Rob Herring <robh@kernel.org>
Date:   Sat, 6 Apr 2019 01:53:14 -0500
X-Gmail-Original-Message-ID: <CABGGisyGzP0nOoGms7YxXaNKaJ7Ho2KtohMp=nc0D5Z9A3TdDA@mail.gmail.com>
Message-ID: <CABGGisyGzP0nOoGms7YxXaNKaJ7Ho2KtohMp=nc0D5Z9A3TdDA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: arm: fix YAML whitespace in cpus.yaml
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     devicetree@vger.kernel.org, Paul Walmsley <paul@pwsan.com>,
        Sugaya Taichi <sugaya.taichi@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 6, 2019 at 1:26 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> Running 'make dt_binding_check' fails for
> Documentation/devicetree/bindings/arm/cpus.yaml.  This is due to tabs
> used for indentation:

You're the 3rd fix. :( We're waiting on arm-soc folks to apply it.

Rob
