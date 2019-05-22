Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB73C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 17:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E398720879
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 17:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558547897;
	bh=INW20+ikZwugtd34smfJ8t4TPEcl7sqNQVMpnXYKjng=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JYi8tMATkZV3BxSz0gcPFFdkV1QrGMqljSyeKRugGFPhiHLcmadQsCecVCo5YkTZk
	 el7LdZmWaCe75WPUqC6n9pvAf3xXWklGz7GFfAELlIgGPG8uxw/zhGjX2DPay7rc+k
	 hTFmBRP3k4fk9uPbYfwO4ATiwkUOvZgkDuPiDjtc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbfEVR6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 13:58:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbfEVR6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 13:58:15 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EFC520879;
        Wed, 22 May 2019 17:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558547894;
        bh=INW20+ikZwugtd34smfJ8t4TPEcl7sqNQVMpnXYKjng=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CWwwoMPrOQQqyB9NHaCXz7vkV9LltxZxYY8+qUjM5nAG29Cxr6Mz5BZZNy9MptT9D
         fMP6wwm1MukOrCzn9fIZi7r9hZ68DIkiAlZSDqIYy1JameMpqzyxTT7C9W66a8fTb7
         jGDjS7idQrVYqVqj0DQzp3L8E5H3AMZM763Lo42A=
Received: by mail-qt1-f169.google.com with SMTP id j53so3443383qta.9;
        Wed, 22 May 2019 10:58:14 -0700 (PDT)
X-Gm-Message-State: APjAAAVxtz5v1F0TIUJIZLdl4zccucthwV74rpsexWM1WaZq80+Gy/Y7
        SN+kk6KmQhbzt70JaKd3Rnx8ZyaRLyTant0L/Q==
X-Google-Smtp-Source: APXvYqylnJxhtwHVEWUGDZrgq7EJJLVJ6f3T95DdKNmDWAXJ34MG+yGATgDFrKtubelaMl8Dl0Vu3vC7T0LebZIo/Sc=
X-Received: by 2002:ac8:2d48:: with SMTP id o8mr75886909qta.136.1558547893390;
 Wed, 22 May 2019 10:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190522151238.25176-1-robh@kernel.org> <2b4878de1404e71d3085ee4832a5abc3526f2cdf.camel@perches.com>
In-Reply-To: <2b4878de1404e71d3085ee4832a5abc3526f2cdf.camel@perches.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 22 May 2019 12:58:01 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLQ6jEU1JR05cxim6zwDM_acmA8z3CvcjhDAnZ276NDrQ@mail.gmail.com>
Message-ID: <CAL_JsqLQ6jEU1JR05cxim6zwDM_acmA8z3CvcjhDAnZ276NDrQ@mail.gmail.com>
Subject: Re: [PATCH] checkpatch.pl: Update DT vendor prefix check
To:     Joe Perches <joe@perches.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 12:16 PM Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2019-05-22 at 10:12 -0500, Rob Herring wrote:
> > In commit 8122de54602e ("dt-bindings: Convert vendor prefixes to
> > json-schema"), vendor-prefixes.txt has been converted to a DT schema.
> > Update the checkpatch.pl DT check to extract vendor prefixes from the new
> > vendor-prefixes.yaml file.
> >
> > Fixes: 8122de54602e ("dt-bindings: Convert vendor prefixes to json-schema")
> > Cc: Joe Perches <joe@perches.com>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  scripts/checkpatch.pl | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index bb28b178d929..073051a4471b 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -3027,7 +3027,7 @@ sub process {
> >                       my @compats = $rawline =~ /\"([a-zA-Z0-9\-\,\.\+_]+)\"/g;
> >
> >                       my $dt_path = $root . "/Documentation/devicetree/bindings/";
> > -                     my $vp_file = $dt_path . "vendor-prefixes.txt";
> > +                     my $vp_file = $dt_path . "vendor-prefixes.yaml";
> >
> >                       foreach my $compat (@compats) {
> >                               my $compat2 = $compat;
> > @@ -3042,7 +3042,7 @@ sub process {
> >
> >                               next if $compat !~ /^([a-zA-Z0-9\-]+)\,/;
> >                               my $vendor = $1;
> > -                             `grep -Eq "^$vendor\\b" $vp_file`;
> > +                             `grep -oE "\\"\\^[a-zA-Z0-9]+" $vp_file | grep -q "$vendor"`;
>
> I think this does't work well as it loses the -
> in various vendor prefixes:
>
>   "^active-semi,.*":
>   "^asahi-kasei,.*":
>   "^ebs-systart,.*":
>   "^inside-secure,.*":
>   "^multi-inno,.*":
>   "^netron-dy,.*":
>   "^si-en,.*":
>   "^si-linux,.*":
>   "^tbs-biometrics,.*":
>   "^u-blox,.*":
>   "^x-powers,.*":

Ah, indeed.

> Perhaps the grep should be something like: (untested)
>
>         `grep -Eq "\\"\\^\Q$vendor\E,\\.\\*\\":" $vp_file`;

That works. Thanks.

Rob
