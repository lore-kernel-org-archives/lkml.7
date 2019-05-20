Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E6EC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 16:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94252173B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 16:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558370116;
	bh=WkKYuXUL2gLsPfbYGFQuRw/mKBt8NSDLNpNkhJa3VC4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BcBxFIifru2fff66JS3huUqiCECznl4zJ5/VvNAdTWJqO0nMhcF/TPHdnmi1rF6ZO
	 bTicKq4JDG+6f+5PSMW3qntqgYyrBn8DQ5NuKzg1VVcOnxyFg/ZWgCMUYC2hw4PbKY
	 uIvo7V7LrC7km4SgTuqHQnXWAW/U57f7bpl8BbDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391092AbfETQfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 12:35:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731223AbfETQfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 12:35:15 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0C4620815;
        Mon, 20 May 2019 16:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558370115;
        bh=WkKYuXUL2gLsPfbYGFQuRw/mKBt8NSDLNpNkhJa3VC4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Azz4EMJkiygLkJQTD6RVusJ+S0S6QN6iLIkczRSblkzbUrbP1IDPH9sbs+y17hDL7
         OFrX984BdRJ15/iOwelSkpX5yzDPkWm8U+bGd98xaRTLsZPFHvfZEUwUylATbpzvFy
         DHv56SEAt2dn23clwaljqmtV2pEVxlOxsTZjgK4Y=
Received: by mail-qt1-f182.google.com with SMTP id t1so16991759qtc.12;
        Mon, 20 May 2019 09:35:14 -0700 (PDT)
X-Gm-Message-State: APjAAAX408fT+alWjlCj+X1uAPpxJFM/dsehoAz1tUtitz218fFHDJjH
        pHx5W/PYfkEaQy65B0AXau7jg9XAhpP6rj0D+A==
X-Google-Smtp-Source: APXvYqyZWfKMiyYH8rE8Bh/vHtUqEGAV1Ozyan9cCleeWVphZPaYGBUuaYl9I3XjYlUvUCdzeQNKVniN9jpl92TwoVU=
X-Received: by 2002:ac8:7688:: with SMTP id g8mr36711968qtr.224.1558370114191;
 Mon, 20 May 2019 09:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190510194018.28206-1-robh@kernel.org> <20190520131846.tqx7h7sjyw6sgka5@flea>
In-Reply-To: <20190520131846.tqx7h7sjyw6sgka5@flea>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 20 May 2019 11:35:01 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLbuuO9YHYwTXV5ZEGOjzZHgVsWD=TCYk4cYpm0v1zHkQ@mail.gmail.com>
Message-ID: <CAL_JsqLbuuO9YHYwTXV5ZEGOjzZHgVsWD=TCYk4cYpm0v1zHkQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Convert vendor prefixes to json-schema
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 8:18 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Hi Rob,
>
> On Fri, May 10, 2019 at 02:40:18PM -0500, Rob Herring wrote:
> > Convert the vendor prefix registry to a schema. This will enable checking
> > that new vendor prefixes are added (in addition to the less than perfect
> > checkpatch.pl check) and will also check against adding other prefixes
> > which are not vendors.
> >
> > Converted vendor-prefixes.txt using the following sed script:
> >
> > sed -e 's/\([a-zA-Z0-9\-]*\)[[:space:]]*\([a-zA-Z0-9].*\)/  "^\1,\.\*\":\n    description: \2/'
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > As vendor prefix updates come in via multiple trees, I plan to merge
> > this before -rc1 to avoid cross tree conflicts.
>
> I just tried this with the 5.2-rc1 release, and this very
> significantly slows down the validation.
>
> With a dtbs_check run on (arm's) sunxi_defconfig, on my core-i5 with 4
> threads, I go from 1.30 minutes to more than 12.

Indeed. 6 min to 45 min for allmodconfig. However, it's only 5 min to
run checks with only this file. I'd expect a more linear hit. Maybe
we're exceeding some cache size and thrashing.

> Should we improve the dt-validate tool before merging this patch?

How? I've looked at optimizing things some and implemented areas I
found (primarily, saving the fixed-up schema and not printing line
numbers (of the yaml encoded DT)).

I've been wanting to have some way to categorize checks, so we can
split rules from pedantic guidance. Maybe we can add a level keyword
in select or something.

Short term, I'm fine with just disabling this one by default with
'select: false'.

Rob
