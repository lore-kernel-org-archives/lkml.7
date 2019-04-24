Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83529C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A212148D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="kUzbEMkI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbfDXIez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:34:55 -0400
Received: from onstation.org ([52.200.56.107]:38056 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbfDXIez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:34:55 -0400
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 208CD3EE68;
        Wed, 24 Apr 2019 08:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1556094894;
        bh=oG6nGt0VsAOuuCRhtJ1q8ApXNZja86wEDxxyUIdKdW4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kUzbEMkI+qp5n8h2Nfcrsu3dHTRAD0P25RRITQmWfbj3dhFN1TWjOg4p4pnKD4jby
         4q1DlTfRZExJGut0BLD4cYA9oKZ1Frj4V4HIs39ipNgE0qFfSNwpUv2zARNR9EpFsO
         ZuZT7qmW5GBfAj4N+IcHETR7+0B6/4UeouglgYyk=
Date:   Wed, 24 Apr 2019 04:34:53 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: tsl2772: convert bindings to YAML
 format
Message-ID: <20190424083453.GA13924@basecamp>
References: <20190416084552.1538-1-masneyb@onstation.org>
 <20190422135238.27b9892d@archlinux>
 <CAL_JsqJo4jA=_dLJ7QJ-LOhSYrXDAcVN01119do0a+y4odpFng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJo4jA=_dLJ7QJ-LOhSYrXDAcVN01119do0a+y4odpFng@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 08:34:13PM -0500, Rob Herring wrote:
> On Mon, Apr 22, 2019 at 7:52 AM Jonathan Cameron <jic23@kernel.org> wrote:
> > > diff --git a/Documentation/devicetree/bindings/iio/light/tsl2772.yaml b/Documentation/devicetree/bindings/iio/light/tsl2772.yaml
> > > new file mode 100644
> > > index 000000000000..b3ac182288d2
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/light/tsl2772.yaml
> > > @@ -0,0 +1,85 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> 
> Do you have the rights on the original file to add BSD license?

Yes, I'm the only contributor to the original file.

> > > +    maxItems: 1
> > > +
> > > +  led-max-microamp:
> > > +    description: Current for the proximity LED
> 
> This device only has proximity LEDs, right?

Yes

The other feedback makes sense. Thanks for the review!

Brian
