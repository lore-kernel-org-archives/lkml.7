Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E71C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 19:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253242081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 19:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556826950;
	bh=V7SLX8kT8f+Coj+JLODWfRBedGS77wjm5ruMdiO7oH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vJCQnS/VgE2WH+RikOOdedgivEvM6GDht5vO/ludpOywj7cC1f2sjUmy8cXIvoGE4
	 4D/hUEZhyXJKrTc/tN18DomllI6AIxq/UK4LZ39a8AQhHJ3n9H0PcRzPHjyqafLooU
	 TuYLic98ogr97wLPNaxHCbkl0vv9R7WXJTfTVBH0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfEBTzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 15:55:49 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33474 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfEBTzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 15:55:48 -0400
Received: by mail-ot1-f68.google.com with SMTP id s11so3284001otp.0;
        Thu, 02 May 2019 12:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dfR3x3hstUPTqdrAbnZLIHv3xXGIWPlsZu8Q4UGru+0=;
        b=lQGePnslo5AsBbp4Ke12zFlgQWJ4FbEYf05DZ86J2wo5pyBP9mwBHfaZF6/TBZqSP9
         +SBQL9hyNXRBxRiw9gDHDIXcelKUz6Vz4ib10tesDou3wyIiNLtkgi7W/vbca0/MqqFu
         x+y1mGhs4WGYgLT6EN1nKTYDrLed2jzcP+Xi1fLGvv35PRtd75wbaU+CokH1hyiY06bM
         Aw9lNIuQQ6eFmZ1o/Am2eER946hudoM1VIB7QNhfWoAbebWG5KP5Wpa7z00CuHYYBsil
         ToOT+KmJQWGHVcWeT470NQMYBI3j2F32VHlGCZcqzf24kNSk8AzkmmXInfVgWmJeoZ7W
         u1FQ==
X-Gm-Message-State: APjAAAXAMDgXFdQFSgwYz9oNfTr2BeSXH6PDFZRON/qrTsQrIciAUN3s
        56UjUdlRpp/yu4ZB5x96J4UoW5w=
X-Google-Smtp-Source: APXvYqyJ46V/sup1mO2TC0Nk8Rr1keP20TQdh2EDygYMpUGVsCUg35clCqSiDOMw/AQC+4zVwSHhtQ==
X-Received: by 2002:a05:6830:12:: with SMTP id c18mr4135762otp.26.1556826947997;
        Thu, 02 May 2019 12:55:47 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n11sm2499369otk.4.2019.05.02.12.55.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 12:55:47 -0700 (PDT)
Date:   Thu, 2 May 2019 14:55:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        linux-arm-msm@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pinctrl: Fix spelling of bias-pull-up
Message-ID: <20190502195546.GA24769@bogus>
References: <20190428150822.13935-1-j.neuschaefer@gmx.net>
 <2683948.V7X3pFLLSZ@debian64>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2683948.V7X3pFLLSZ@debian64>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 11:32:17PM +0200, Christian Lamparter wrote:
> On Sunday, April 28, 2019 5:08:22 PM CEST Jonathan Neuschäfer wrote:
> > The property is spelled 'bias-pull-up', as documented in
> > pinctrl-bindings.txt.
> > 
> 
> I also sent out a patch for that... back in 2017:
> 
> https://patchwork.ozlabs.org/patch/763151/
> 
> It's marked Accepted and Archived.
> 
> @rob ?

No idea what happened besides a problem between the screen and keyboard.

Let me try again...

Rob
