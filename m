Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B353C33C9B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 09:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6899321734
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 09:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgAFJyh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 04:54:37 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:50663 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgAFJyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 04:54:37 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 414202000D;
        Mon,  6 Jan 2020 09:54:33 +0000 (UTC)
Date:   Mon, 6 Jan 2020 10:54:32 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: display: Add Satoz panel
Message-ID: <20200106105432.0621bc86@xps13>
In-Reply-To: <20200104000957.GA17750@bogus>
References: <20191224141905.22780-1-miquel.raynal@bootlin.com>
        <20191224141905.22780-2-miquel.raynal@bootlin.com>
        <20200104000957.GA17750@bogus>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Rob Herring <robh@kernel.org> wrote on Fri, 3 Jan 2020 17:09:57 -0700:

> On Tue, Dec 24, 2019 at 03:19:04PM +0100, Miquel Raynal wrote:
> > Satoz is a Chinese TFT manufacturer.
> > Website: http://www.sat-sz.com/English/index.html
> > 
> > Add (simple) bindings for its SAT050AT40H12R2 5.0 inch LCD panel.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> > 
> > Changes since v2:
> > * None.
> > 
> > Changes since v1:
> > * New patch
> > 
> >  .../display/panel/satoz,sat050at40h12r2.yaml  | 27 +++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/panel/satoz,sat050at40h12r2.yaml  
> 
> Note that this may become obsolete if we move all simple panels to a 
> single schema.

Absolutely.

> 
> > 
> > diff --git a/Documentation/devicetree/bindings/display/panel/satoz,sat050at40h12r2.yaml b/Documentation/devicetree/bindings/display/panel/satoz,sat050at40h12r2.yaml
> > new file mode 100644
> > index 000000000000..567b32a544f3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/panel/satoz,sat050at40h12r2.yaml
> > @@ -0,0 +1,27 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/panel/satoz,sat050at40h12r2#  
> 
> Missing '.yaml'
> 
> Run 'make dt_binding_check' which will check this and other things.

Right, corrected.

> 
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Satoz SAT050AT40H12R2 panel
> > +
> > +maintainers:
> > +  - Thierry Reding <thierry.reding@gmail.com>
> > +
> > +description: |+
> > +  LCD 5.0 inch 800x480 RGB panel.  
> 
> Any public spec for this panel?

Unfortunately, no. I mentioned it in the v3.

> 
> > +
> > +  This binding is compatible with the simple-panel binding, which is specified
> > +  in simple-panel.txt in this directory.
> > +
> > +allOf:
> > +  - $ref: panel-common.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    contains:  
> 
> Drop 'contains'. It must be exactly the below string, not the below 
> string and *any* other strings.

Ok.

> 
> > +      const: satoz,sat050at40h12r2
> > +
> > +required:
> > +  - compatible
> > -- 
> > 2.20.1
> >   

Thanks,
Miquèl
