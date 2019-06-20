Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA091C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1512084E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561043766;
	bh=kqza+dMOoVNjShbz0wsIGK4HV5GBcZakWICkYSesXsE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pltrwue9NqP7+QotxoL4xgcN+Z9P8JV/mbp8wPtds5dSRHveizyEkoOKg2BgWmfWe
	 dPSwXdaJFW1Qow2IdCnZ6FXhCzDto6zoeyzOIdRGMqkCjXDejcDuqGwu+5fRZ0RJ+O
	 JwcuOAw3tTq5kaVUZD23OxpnH9nw21qAjQV5fvX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732010AbfFTPQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 11:16:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbfFTPQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 11:16:04 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 841C920B1F;
        Thu, 20 Jun 2019 15:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561043763;
        bh=kqza+dMOoVNjShbz0wsIGK4HV5GBcZakWICkYSesXsE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KNzeo49v0vOTjS2EQy022uLMpxcHWlEZ8M/of+GzhByi2foYnofiszsQLaOAWX1E+
         92sv4Q3VOAyaO3X54baPuk2WiQgvWv4I8dE8Bq4BhdNlpDgRiPeh0uXFH2OKBr6Pd6
         MnyCxa39GPOFV9GQx/Rx/2+c4Qxl4v4vTwujINvc=
Received: by mail-qk1-f178.google.com with SMTP id i125so2150192qkd.6;
        Thu, 20 Jun 2019 08:16:03 -0700 (PDT)
X-Gm-Message-State: APjAAAUaVP00cy6LhlJPLD4lQOzedICyisV0KUrdG/cjOqD8E7lRFmjs
        18kKEVP7/IW7pJqgP7pKCFFPimf7Au84ULjdVw==
X-Google-Smtp-Source: APXvYqxCJPiM0PLJvXlPJ9GRTuKL8loc5/Q8qfIUqUa+TpkqcmApxW77au/op7OTbYOnqwwYfkxw+Hy2CzPIzvLxnFA=
X-Received: by 2002:a05:620a:1447:: with SMTP id i7mr11428589qkl.254.1561043762664;
 Thu, 20 Jun 2019 08:16:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190619215156.27795-1-robh@kernel.org> <20190620065508.GA24739@ravnborg.org>
In-Reply-To: <20190620065508.GA24739@ravnborg.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 20 Jun 2019 09:15:51 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJYWW3TPhWy0=tGc_x99w3jZPsSxcKzQJWuE+FrS19t2g@mail.gmail.com>
Message-ID: <CAL_JsqJYWW3TPhWy0=tGc_x99w3jZPsSxcKzQJWuE+FrS19t2g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] dt-bindings: display: Convert common panel
 bindings to DT schema
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 12:55 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Rob.
>
> Thanks for starting the conversion of panel bindings to yaml.
>
> On Wed, Jun 19, 2019 at 03:51:53PM -0600, Rob Herring wrote:
> > Convert the common panel bindings to DT schema consolidating scattered
> > definitions to a single schema file.
> >
> > The 'simple-panel' binding just a collection of properties and not a
> > complete binding itself. All of the 'simple-panel' properties are
> > covered by the panel-common.txt binding with the exception of the
> > 'no-hpd' property, so add that to the schema.
> >
> > As there are lots of references to simple-panel.txt, just keep the file
> > with a reference to panel-common.yaml for now until all the bindings are
> > converted.
> Good idea.
>
> >
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > Note there's still some references to panel-common.txt that I need to
> > update or just go ahead and convert to schema.
> Better let it point to the .yaml variant, so this patchset does not
> depend on too much other bindings to be converted.

There's only 8 files referencing panel-common.txt which was why I was
debating just converting all of them.

> Then we can start the conversion of the remaining panel bindings.
> Any tooling that helps the conversions?

I have a doc2yaml script that helps with some of the boilerplate. It's
in my yaml-bindings-v2 branch[1].

> When this hits upstream I assume all future panel bindings shall be yaml
> based - so we have a few pending contributions that need to do something.

That would be ideal, but not strictly required. For pending things, no
reason to make folks redo things. Requiring schema really depends on
whomever is applying things to run at least 'make dt_binding_check'
before accepting.

>
> For the actual conversion below:
> Acked-by: Sam Ravnborg <sam@ravnborg.org>

Thanks.

Rob

[1] https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/log/?h=yaml-bindings-v2
