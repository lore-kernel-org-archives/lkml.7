Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FE7C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 15:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A652081E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 15:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578411474;
	bh=pqPPjKFVviC1ZDxprol38uvzIjRb/TMF9PGgoRxsJ50=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=I/4wusbdq/t9kdqi5eSSfWfB5eFXu1yto0cBwH84DzKS1dmetU6bzfgOEmsTSywA3
	 p2FJnCsTH0BfcZ552udOypmj4yiVMnKIDy25CrHUMfo/+/Gvk1zp9035c118LrAhcd
	 rOmrGj9h8ck+4JOP5CDFmn9rL715SGDxNLAh8mMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbgAGPhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 10:37:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:52416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727559AbgAGPhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 10:37:53 -0500
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D9EC2081E;
        Tue,  7 Jan 2020 15:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578411473;
        bh=pqPPjKFVviC1ZDxprol38uvzIjRb/TMF9PGgoRxsJ50=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZEnk98MF6Let7Naoomjgu67d3EflqTQeR9sl1sllMgNg2wWQsJFHBhSo2j8sSziH6
         HLJ1i3fHFS+TA1ElTwIn7saV2h8Fk/J0//649HsOyLAui+Zbjqxo2PQZpudFGhufOa
         49pkDSBlL7lTsFsq9LNQNRIrRxDDKSDbljgUEy58=
Received: by mail-qk1-f174.google.com with SMTP id a203so43355303qkc.3;
        Tue, 07 Jan 2020 07:37:53 -0800 (PST)
X-Gm-Message-State: APjAAAVSFZtMkS/aDC1zbb5x4bRcrVCoNTcq41NFDU9tME5bjYF3y5SS
        ENzYT2y+Lp+940gjslDE6YpSZlumGpQmtOObyA==
X-Google-Smtp-Source: APXvYqxzQ7EtsnHx8bSgdHMPK8iuI+AMdvJ2pr4P0z5FS0WVqQr22E6f5KDIikRZBJYQ5FXVmp8tkt8f5GQikJV85fk=
X-Received: by 2002:a05:620a:1eb:: with SMTP id x11mr89916918qkn.254.1578411472258;
 Tue, 07 Jan 2020 07:37:52 -0800 (PST)
MIME-Version: 1.0
References: <20191227111235.GA3370@localhost.localdomain> <20200107130155.GK14821@dell>
In-Reply-To: <20200107130155.GK14821@dell>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 7 Jan 2020 09:37:40 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJzaS1G-ODb4A5QGdhhJ+SXXYPY0nXvKfJnZKoRP+WmAA@mail.gmail.com>
Message-ID: <CAL_JsqJzaS1G-ODb4A5QGdhhJ+SXXYPY0nXvKfJnZKoRP+WmAA@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: bd718x7: Yamlify and add BD71850
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 7, 2020 at 7:01 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Fri, 27 Dec 2019, Matti Vaittinen wrote:
>
> > Convert ROHM bd71837 and bd71847 PMIC binding text docs to yaml. Split
> > the binding document to two separate documents (own documents for BD71837
> > and BD71847) as they have different amount of regulators. This way we can
> > better enforce the node name check for regulators. ROHM is also providing
> > BD71850 - which is almost identical to BD71847 - main difference is some
> > initial regulator states. The BD71850 can be driven by same driver and it
> > has same buck/LDO setup as BD71847 - add it to BD71847 binding document and
> > introduce compatible for it.
> >
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > ---
> >
> > changes since v1:
> > - constrains to short and long presses.
> > - reworded commit message to shorten a line exceeding 75 chars
> > - added 'additionalProperties: false'
> > - removed 'clock-names' from example node
> >
> >  .../bindings/mfd/rohm,bd71837-pmic.txt        |  90 -------
> >  .../bindings/mfd/rohm,bd71837-pmic.yaml       | 236 ++++++++++++++++++
> >  .../bindings/mfd/rohm,bd71847-pmic.yaml       | 222 ++++++++++++++++
> >  .../regulator/rohm,bd71837-regulator.txt      | 162 ------------
> >  .../regulator/rohm,bd71837-regulator.yaml     | 103 ++++++++
> >  .../regulator/rohm,bd71847-regulator.yaml     |  97 +++++++
>
> Can you split these out per-subsystem, so that I can apply the MFD
> changes please?

That's not going to work any more. The MFD binding references the
child bindings and the complete example(s) resides in the MFD binding.

Rob
