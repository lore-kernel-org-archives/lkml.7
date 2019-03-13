Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AA1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7262146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfCMUM3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:12:29 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41402 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbfCMUM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:12:28 -0400
Received: by mail-oi1-f195.google.com with SMTP id k8so2515133oik.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 13:12:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iI8a6LJ4CW9r1pdJ3NyV/ChlC2LdijtQmINha9gU4os=;
        b=AMlSCTGWzaoKeCwpu92sUaYDEDXQ54Qdy5yEHIyPp+9iWB8SqVJKExZaSG5okrr0QS
         XQQdcl/I+evwODUlfKQW360ZgN+qV2jZMGlWPqoD03d9D9kXcIVO4U6pbQwXQIu0QiDU
         vU/KsI6gUeffJqEjsm5yWbjBOkRfoYgN94lOvDicNL/owOh8R0rRSOY218rtLLw/bQeK
         gM9DHfSsJ2y55hT5uHzCUSD5Vp2GR3j8B61X3PsYiLQhJGv00dMdLGJXJK/xyJRdzLIF
         8YlthfpYzu8eOBPS2atgs/ysZAkbvvEwEiEiWstUxGjcCxbVQjytflY2LUTY9NKDQCBB
         mBIA==
X-Gm-Message-State: APjAAAUTqtWz23AXQ7pNog5W6SWqu4t/lxRR0M1QLvpNvBfcnmR7iAH8
        KnKU4UQIZck6RGcf928VlvZfPQ3sEpeWh3sJg+w=
X-Google-Smtp-Source: APXvYqyC2OAQypyh5sX6ij0BneoZE29K00fYlhe4ZnHfUd3DAFnMmh2UITcwkT7CBecyFQRW34dGhjDQ9SzThbYvO3M=
X-Received: by 2002:aca:3e8a:: with SMTP id l132mr253458oia.107.1552507947168;
 Wed, 13 Mar 2019 13:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190312202008.29681-1-malat@debian.org> <57a0d93c-8784-d6af-a5fb-75e31455ae57@c-s.fr>
 <CA+7wUsyA698UtNLni7wi3=cKjbCd1V71YA0sxDtMD=MmQvQxTQ@mail.gmail.com> <94d90740-c970-01b0-c430-bafc2e9eecd3@c-s.fr>
In-Reply-To: <94d90740-c970-01b0-c430-bafc2e9eecd3@c-s.fr>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Wed, 13 Mar 2019 21:12:15 +0100
Message-ID: <CA+7wUsw+pmeS-oG5MMMjKB34R98vqHf1jxT=Fmx5oxiGLnYzBQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: sstep: Mark variable `rc` as unused in function 'analyse_instr'
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 10:26 PM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
>
>
> Le 12/03/2019 à 22:12, Mathieu Malaterre a écrit :
> > On Tue, Mar 12, 2019 at 9:56 PM Christophe Leroy
> > <christophe.leroy@c-s.fr> wrote:
> >>
> >>
> >>
> >> Le 12/03/2019 à 21:20, Mathieu Malaterre a écrit :
> >>> Add gcc attribute unused for `rc` variable.
> >>>
> >>> Fix warnings treated as errors with W=1:
> >>>
> >>>     arch/powerpc/lib/sstep.c:1172:31: error: variable 'rc' set but not used [-Werror=unused-but-set-variable]
> >>>
> >>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> >>> ---
> >>>    arch/powerpc/lib/sstep.c | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> >>> index 3d33fb509ef4..32d092f62ae0 100644
> >>> --- a/arch/powerpc/lib/sstep.c
> >>> +++ b/arch/powerpc/lib/sstep.c
> >>> @@ -1169,7 +1169,7 @@ static nokprobe_inline int trap_compare(long v1, long v2)
> >>>    int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
> >>>                  unsigned int instr)
> >>>    {
> >>> -     unsigned int opcode, ra, rb, rc, rd, spr, u;
> >>> +     unsigned int opcode, ra, rb, rc __maybe_unused, rd, spr, u;
> >>
> >> I think it would be better to enclose 'rc' inside a #ifdef CONFIG_PPC64
> >
> > Hum odd, I would have bet you would have suggested me to use
> > IS_ENABLED with some crazy scheme (I was not able to mix it with the
> > switch case nicely).
>
> Well I guess yes, you could also get rid of the #ifdef __powerpc64__ and
> instead add the following just after the 'case 4:'
>
> if (!IS_ENABLED(CONFIG_64))
>         break;
>
> That's less uggly than adding two #ifdef/#endif

So you mean changing:

#ifdef __powerpc64__
  case 4:
    if (!cpu_has_feature(CPU_FTR_ARCH_300))
      return -1;

into:

  case 4:
    if (!IS_ENABLED(CONFIG_PPC64))
      break;
    if (!cpu_has_feature(CPU_FTR_ARCH_300))
      return -1;

So suddenly case label '4' becomes visible for ppc32, is that really
what you wanted ?

> Christophe
>
> >
> > Anyway I'll try your suggestion and post a v2.
> >
> >> Christophe
> >>
> >>>        unsigned long int imm;
> >>>        unsigned long int val, val2;
> >>>        unsigned int mb, me, sh;
> >>>
