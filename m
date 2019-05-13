Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BCEC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 13:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37ED6205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 13:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557752543;
	bh=H9yflkxj6PKD3OyDhgd0M9qzd9BvjS5peXo1ZDL6l7o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xxZ5vlYEAF5OGnUOzc7gQZ+5XG49kDwW9FauKarGwWLJh+7Mu7e8HLQAqfBiwUApF
	 Ikuui0Ctnng3fV9ZrF6SReUlj71NotwBa0o37WKWdtR+UWr2pJKuEsJygaiE2CHewO
	 S/lOhzwYxufG0ZxR9GqPCJzMbehTAmkQtROanZ0g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbfEMNCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 09:02:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728743AbfEMNCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 09:02:22 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1891208C3;
        Mon, 13 May 2019 13:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557752541;
        bh=H9yflkxj6PKD3OyDhgd0M9qzd9BvjS5peXo1ZDL6l7o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fvzr6fUmh5VMDX6ruMe4cbLAvHv03i5G5cVHFraNC/aZJ47xCJ13rb7mHBPvNG7Mx
         C2QVc5k4JzxKeVL3gLJ2mPKbp2FictiN4mWXiPLPyQTKXcxTon2WvIOsBGcs8dbn9D
         TTJ6EI14yYDXi4ST7r3KfKC+n6MPtGuzjo48bgtg=
Received: by mail-qt1-f178.google.com with SMTP id y22so11107430qtn.8;
        Mon, 13 May 2019 06:02:20 -0700 (PDT)
X-Gm-Message-State: APjAAAXloS57HCBZliTfJ+NcUOohhFkHPq6EhBkCNxtPupf1vjW2qqO6
        FJp5UbAyb2jbV0zU1yig9ChIcTKFyUnQ3nGYYw==
X-Google-Smtp-Source: APXvYqyKtJigwpzlH1zaVYXjJKjImDYRZk+VXVQe9W4bQI+I+tbYntkvZc73VPfXham9aA16TsN6xQ+Ys5v8TZJww/o=
X-Received: by 2002:ac8:641:: with SMTP id e1mr23421622qth.76.1557752540205;
 Mon, 13 May 2019 06:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190510194018.28206-1-robh@kernel.org> <20190511181753.GA2444@t60.musicnaut.iki.fi>
In-Reply-To: <20190511181753.GA2444@t60.musicnaut.iki.fi>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 13 May 2019 08:02:08 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK_pTxYd0iq=-yKTexWKueVqBSyNfOrfek9k-8pg3YE9w@mail.gmail.com>
Message-ID: <CAL_JsqK_pTxYd0iq=-yKTexWKueVqBSyNfOrfek9k-8pg3YE9w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Convert vendor prefixes to json-schema
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2019 at 1:23 PM Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
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
> [...]
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > deleted file mode 100644
> > index e9034a6c003a..000000000000
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> > +++ /dev/null
> > @@ -1,476 +0,0 @@
> > -Device tree binding vendor prefix registry.  Keep list in alphabetical order.
> [...]
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > new file mode 100644
> > index 000000000000..be037fb2cada
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > @@ -0,0 +1,975 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>
> Is there a license change as well?

It is, as we're trying to dual license schema files when possible. I
have permission from Grant who was the primary author. Also, given
that the file is 235 different authors with most being 1-2 lines, I
don't think that really meets the threshold of being copyright
holders.

Rob
