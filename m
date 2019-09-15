Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCCAC4CECD
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 20:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E87021670
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 20:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PjPM9jjv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfIOUTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 16:19:34 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47770 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfIOUTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 16:19:34 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8FKJRQt043369;
        Sun, 15 Sep 2019 15:19:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568578767;
        bh=6k8f13GSiEpU1XrWlTZl99FBnH20a6Q83dMRRJWwEr4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=PjPM9jjvcPH0LiuC960E0hyyr1pFWSajGvm4UsZK3Y9jEIwdC0PtiM6a+6JhGWaGj
         txNp6U4GrXthJMUo+HbCIMaXVP/7xQc7Sh7qsdOw6B0Dql3QE1nq2greVzCTJxnDST
         zaaFhTWU/1xTlz0/btEgez7ywu4BxRM/N5ivCQBQ=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8FKJRPQ056674
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 15 Sep 2019 15:19:27 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Sun, 15
 Sep 2019 15:19:25 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Sun, 15 Sep 2019 15:19:27 -0500
Received: from ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with SMTP id x8FKJRjo111543;
        Sun, 15 Sep 2019 15:19:27 -0500
Date:   Sun, 15 Sep 2019 15:21:33 -0500
From:   Benoit Parrot <bparrot@ti.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC:     Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 3/6] media: dt-bindings: ov2659: add powerdown-gpios
 optional property
Message-ID: <20190915202133.5ijfgm4akegumbpq@ti.com>
References: <20190912130007.4469-1-bparrot@ti.com>
 <20190912130007.4469-4-bparrot@ti.com>
 <CA+V-a8vo2ddxdDEBefTErsTB43tPAFNy-94xhQN1Yhb64jr_Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CA+V-a8vo2ddxdDEBefTErsTB43tPAFNy-94xhQN1Yhb64jr_Aw@mail.gmail.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lad, Prabhakar <prabhakar.csengg@gmail.com> wrote on Sat [2019-Sep-14 11:11:02 +0100]:
> Hi Benoit,
> 
> Thank you for the patch.
> 
> On Thu, Sep 12, 2019 at 1:58 PM Benoit Parrot <bparrot@ti.com> wrote:
> >
> > Add powerdown-gpios to the list of optional properties for the OV2659
> > camera sensor.
> >
> > Signed-off-by: Benoit Parrot <bparrot@ti.com>
> > ---
> >  Documentation/devicetree/bindings/media/i2c/ov2659.txt | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/media/i2c/ov2659.txt b/Documentation/devicetree/bindings/media/i2c/ov2659.txt
> > index cabc7d827dfb..f55204cce0cd 100644
> > --- a/Documentation/devicetree/bindings/media/i2c/ov2659.txt
> > +++ b/Documentation/devicetree/bindings/media/i2c/ov2659.txt
> > @@ -12,6 +12,10 @@ Required Properties:
> >  - clock-names: should be "xvclk".
> >  - link-frequencies: target pixel clock frequency.
> >
> > +Optional Properties:
> > +- powerdown-gpios: reference to the GPIO connected to the pwdn pin, if any.
> > +  Active is low.
> > +
> as per the datasheet this should be active high with  pull-down resistor.

Ahhh, yes I'll fix that.

> 
> Cheers,
> --Prabhakar Lad
