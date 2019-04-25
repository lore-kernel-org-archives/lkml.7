Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFECEC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 23:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D05C20717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 23:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556233652;
	bh=xs2ElDN3VlxrnapRQbm5yDFRi/V9chScs6L10QtA0Qg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rsdUQkm7f2i1dM16HYC82RzChQPJO+X45OEjtB3xg+NWCvIz9hhC4yNqq79IiO9fA
	 Mp9p8swsYA5NEyInsmEFL7YeHEm5ZRPdyDhrRz/RqImcaKE9umJJK5IzOmU+jMtfDe
	 fusiaXirwwumuSt/6oVRUzV9CIQLrrIxUTtVo4hk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbfDYXHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 19:07:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbfDYXH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 19:07:29 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4797720895;
        Thu, 25 Apr 2019 23:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556233649;
        bh=xs2ElDN3VlxrnapRQbm5yDFRi/V9chScs6L10QtA0Qg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iIlaFPmM4U5+uyj7Ix2SY+wLkcJ+vZbu7wNlO581Sv/8BHbOet/lFGz91rx/VRGMb
         8YMw1L/hbMMSqYQanICIOYXixfyLULnEDCN3xEUVfs/o07khyTeVa0hwG3XPKZNTjZ
         KXdlt9C57Ovm3eXrq3vi/G/bHTv4B/5pyqCyotPw=
Received: by mail-qk1-f170.google.com with SMTP id n81so846774qke.2;
        Thu, 25 Apr 2019 16:07:28 -0700 (PDT)
X-Gm-Message-State: APjAAAXd/lna+DOIwhjUcDTmCWID17CFYxgpceFjyUSzOO4gZcETqiLt
        9WWcEei+cgc5Ny1fYb0ZsNHY7azQvhWpvvsnhA==
X-Google-Smtp-Source: APXvYqwgrV/l589fPtDNrIOiiKybEA2Z15lcEDOd2DbfybYxAIdblzmtNQSGFcfS7BuaN+/O27X2nI2f7wuI+fKBzk4=
X-Received: by 2002:a37:4a51:: with SMTP id x78mr2024304qka.184.1556233648090;
 Thu, 25 Apr 2019 16:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <1556092536-17095-1-git-send-email-masonccyang@mxic.com.tw>
 <1556092536-17095-4-git-send-email-masonccyang@mxic.com.tw>
 <20190424212356.GA27103@bogus> <65853dc2-6f3c-1494-7e72-54877797cdd2@gmail.com>
In-Reply-To: <65853dc2-6f3c-1494-7e72-54877797cdd2@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 25 Apr 2019 18:07:16 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJDh3Z+iFn6fbkGT+jQ3HG2s4n3PT=LrmB-td++G99q_w@mail.gmail.com>
Message-ID: <CAL_JsqJDh3Z+iFn6fbkGT+jQ3HG2s4n3PT=LrmB-td++G99q_w@mail.gmail.com>
Subject: Re: [PATCH v12 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3
 RPC-IF MFD bindings
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     Mason Yang <masonccyang@mxic.com.tw>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Julien Su <juliensu@mxic.com.tw>,
        Simon Horman <horms@verge.net.au>, zhengxunli@mxic.com.tw
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 4:54 PM Marek Vasut <marek.vasut@gmail.com> wrote:
>
> On 4/24/19 11:23 PM, Rob Herring wrote:
> > On Wed, Apr 24, 2019 at 03:55:36PM +0800, Mason Yang wrote:
> >> Document the bindings used by the Renesas R-Car Gen3 RPC-IF MFD.
> >>
> >> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> >> ---
> >>  .../devicetree/bindings/mfd/mfd-renesas-rpc.txt    | 40 ++++++++++++++++++++++
> >>  1 file changed, 40 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
> >> new file mode 100644
> >> index 0000000..668b822
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
> >> @@ -0,0 +1,40 @@
> >> +Renesas R-Car Gen3 RPC-IF MFD Device Tree Bindings
> >> +--------------------------------------------------
> >
> > Looks like a SPI flash controller from the example. What makes it an
> > MFD?
>
> It supports both SPI NOR and HyperFlash (CFI-compliant flash with
> different bus interface).

Not sure that really makes it an MFD. Lee probably has an opinion.

In any case, can we get a complete binding that shows both.

Rob
