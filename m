Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC652C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 12:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C51C72064A
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 12:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570711497;
	bh=YMmXtb2JLA8hWzDQQfOgQycNtJFOok7eUnehOSyP+pA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aqzg2oDIUpCPw+qnd9IrPK3OJl+bbkP/C99rSi8UO/UgxQltqb+gbSPe+ll8rmxeu
	 QzDGYtoxenr0C1lXrGHKUfC2OcstO3lHg57k5ofTw+jTUi4DQuVXcOORy2MExHpj90
	 j00JZwFKlNgi/5LC0xnWnnPEo8MXywMCzXPE9CxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387962AbfJJMo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 08:44:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733191AbfJJMo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 08:44:56 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90E2220B7C;
        Thu, 10 Oct 2019 12:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570711495;
        bh=YMmXtb2JLA8hWzDQQfOgQycNtJFOok7eUnehOSyP+pA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LriOz2qFhwWE9p03RxfAw5yzayh07CQZffd0SfcdLfaXfS1Hb+hO+G+Ur4d8nIH2U
         YUi80UntVX2mzkp6yJoMMQACXHvwShAcvMC9S+12N4YJh/0pHQreeOohE4Q6wtkfZl
         DVaHHWkcbwGe2dd3mvLAoEPm1Dt2tS+Te6oBNxKI=
Received: by mail-qt1-f178.google.com with SMTP id c21so8416191qtj.12;
        Thu, 10 Oct 2019 05:44:55 -0700 (PDT)
X-Gm-Message-State: APjAAAWlJkM4VLHaTcCORsHsZm3X8OWfzZb/ex5imGi+ufwn7x2xELFT
        bAIfhqmGxtako1nHMXQ7cVVDu042JoIiNGnNdg==
X-Google-Smtp-Source: APXvYqwNvmWSytFEH52LryQ2mgDyEBuHBeeq3gQeZfuuroZ1Dr7vv+ZkYoV5zzwGc/l367nh1bLcdlmGVo4hk6usLJc=
X-Received: by 2002:a0c:e606:: with SMTP id z6mr9343421qvm.135.1570711494582;
 Thu, 10 Oct 2019 05:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191009234648.2271-1-robh@kernel.org> <alpine.DEB.2.21.9999.1910091657240.11044@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1910091657240.11044@viisi.sifive.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 10 Oct 2019 07:44:43 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK==+6QPrx3NDobYfWQwRg9m-t0LZgL=KzqfhAfbu+xTg@mail.gmail.com>
Message-ID: <CAL_JsqK==+6QPrx3NDobYfWQwRg9m-t0LZgL=KzqfhAfbu+xTg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: riscv: Fix CPU schema errors
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 9, 2019 at 7:08 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> On Wed, 9 Oct 2019, Rob Herring wrote:
>
> > Fix the errors in the RiscV CPU DT schema:
> >
> > Documentation/devicetree/bindings/riscv/cpus.example.dt.yaml: cpu@0: 'timebase-frequency' is a required property
> > Documentation/devicetree/bindings/riscv/cpus.example.dt.yaml: cpu@1: 'timebase-frequency' is a required property
> > Documentation/devicetree/bindings/riscv/cpus.example.dt.yaml: cpu@0: compatible:0: 'riscv' is not one of ['sifive,rocket0', 'sifive,e5', 'sifive,e51', 'sifive,u54-mc', 'sifive,u54', 'sifive,u5']
> > Documentation/devicetree/bindings/riscv/cpus.example.dt.yaml: cpu@0: compatible: ['riscv'] is too short
> > Documentation/devicetree/bindings/riscv/cpus.example.dt.yaml: cpu@0: 'timebase-frequency' is a required property
> >
> > The DT spec allows for 'timebase-frequency' to be in 'cpu' or 'cpus' node
> > and RiscV is doing nothing special with it, so just drop the definition
> > here and don't make it required.
>
> The RISC-V kernel code does in fact parse it and use it, and we currently
> rely on it being under /cpus:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/riscv/kernel/time.c#n19
>
> The RISC-V user ISA specification also constrains the timebase-frequency
> to be the same across all CPUs, in section 10.1:
>
>   https://github.com/riscv/riscv-isa-manual/releases/download/draft-20190608-f467e5d/riscv-spec.pdf
>
> So the right thing is to require 'timebase-frequency' at /cpus, and forbid
> it in the individual CPU nodes.

Yes, but this schema only deals with 'cpu' nodes and we can't check
/cpus here. We'd need to write another schema matching on a child cpu
node having a RiscV compatible.

I can change this to 'timebase-frequency: false' to ban it here. That
doesn't add too much as any undefined name is still allowed such as
'timbase-frequency'. There's a way to address this in json-schema
draft8 with 'unevaluatedProperties', but that's not ready yet.

Rob
