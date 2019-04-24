Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCDAC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B467B20878
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556121056;
	bh=xyI8X/Epwpls/Yp1Hrt1fVXlUrpTNtDpT9qvaO5MohI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Z+SFUsGi+8H4I28M0fV4WJ+KbPSeHjFNdKNqbpUMexbWwD4a1u7Etkv4c68YRbzp5
	 0H5owWw4JquUd0IoyvgykeDJOAX8u1PZvQGdlJfgQRUBLTDZOwKZ2eigJRwtvdY0dY
	 j2QSSEP9GedHh7s3N1NUjBDyu/CdIo/m/dO4QDnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731774AbfDXPu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:50:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730625AbfDXPuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:50:55 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9FE121900;
        Wed, 24 Apr 2019 15:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556121055;
        bh=xyI8X/Epwpls/Yp1Hrt1fVXlUrpTNtDpT9qvaO5MohI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iJMfXyjkOhpgcSa7474tEdsBgrpjBKTLhgMr2tUtGXTRZsZTBW73L7RZ1wN8Wt4+B
         slByaIbPfAszvtl43OVgJJlApu9zDivfmb6g4BJufJyCjLhDBTrLgUdYN39sbQrUit
         6cDLSaFe/xaS1LaKTFILcEQQj4WodgqMipsdZ1yM=
Received: by mail-qk1-f175.google.com with SMTP id m137so7450962qke.3;
        Wed, 24 Apr 2019 08:50:54 -0700 (PDT)
X-Gm-Message-State: APjAAAW6HkoYMiA1gS6R7hP9DG1aibkk7jRMAsxbzGS7GrWK/uS7m/D9
        p2uK5EESAju/ljNmbbS9XMYqOLxmx60HPawqIA==
X-Google-Smtp-Source: APXvYqysXC8+8b4Gj4x4QEpSCQsC2RTybbXaiLcNEP/G+QJAtQ99sBC/b/J2/V6Qjs5tsC8P1DoWquDG8RrNpqH1/4c=
X-Received: by 2002:a37:4b92:: with SMTP id y140mr25752210qka.79.1556121054155;
 Wed, 24 Apr 2019 08:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190424092238.6381-1-masneyb@onstation.org> <20190424122648.GA15745@basecamp>
In-Reply-To: <20190424122648.GA15745@basecamp>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 24 Apr 2019 10:50:41 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLQRkBO=DxSqNaGqE=zoQq0n0EQ920pQNGGE+LnVZid5A@mail.gmail.com>
Message-ID: <CAL_JsqLQRkBO=DxSqNaGqE=zoQq0n0EQ920pQNGGE+LnVZid5A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: tsl2772: convert bindings to
 YAML format
To:     Brian Masney <masneyb@onstation.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 7:26 AM Brian Masney <masneyb@onstation.org> wrote:
>
> On Wed, Apr 24, 2019 at 05:22:37AM -0400, Brian Masney wrote:
> > Convert the tsl2772 device tree bindings to the new YAML format.
> >
> > Signed-off-by: Brian Masney <masneyb@onstation.org>
> > ---
> > Changes since v1:
> > - Dropped description from reg and interrupts properties.
> > - Dropped $ref from led-max-microamp, vdd-supply, and vddio-supply.
> > - Changed 'tsl2772@39' in example to 'proximity-sensor@39'
>
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        proximity-sensor@39 {
>
> I didn't think of this until after I sent out that patch, but I think
> this example should be 'als-proximity-sensor@39' instead of
> 'proximity-sensor@39'.

I'd just do 'sensor@39' in that case. We normally use light-sensor for
ALS devices, but we haven't been real consistent here.

Rob
