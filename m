Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926C2CA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 01:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A10220650
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 01:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="Ffyvbloh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406381AbfJXBrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 21:47:40 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46780 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfJXBrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 21:47:40 -0400
Received: by mail-pf1-f195.google.com with SMTP id b25so3964pfi.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 18:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r+v++LJz2UtADy1cS2OkPl2XbtGtt1rFLT7PbQVU178=;
        b=FfyvblohnumehZApPiCnRaZxuyFEHdqk5OyDTBEOP+BfOTBvUjkFq6SSx4hsS/iPs1
         omQJinbl9mu6pQnGVTsqhimfp9y+eLEp1dgFM5P58PG5vQz9PKTPuIqnjJtYLtWLFVTZ
         8tAL70O/gmliWAM0nMpyEBRzzKwHsjQKI+Mso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r+v++LJz2UtADy1cS2OkPl2XbtGtt1rFLT7PbQVU178=;
        b=qpynnleXJQvPflnclpvtLZg9TWryHBuZSssuLpOnWBi53D7ZCIezPYtIMkerqjr7d6
         /lY9vi60cduFmWBgkhan3JEFrS+KO19+KqHOvpJGVoSvUfHCSmG5wpAlh7hH/CdKsmnH
         jIqyByCCCGfp4jDDMM+CgbFSInPxGhtvdgMMdQPShzzuEagSm7f+XH2w4+ja/Vx02cZX
         v4x2sLfEahYm+hiozPDQPwS9S1W8L7fktZE2tdQXiZW+6B/VtT4GLplhz5mD6j1TT1t/
         FCnFNCgFvzRlM3xkzIaDlkZnmVoqhTUacWoPkgBYyMj4X5KWGOs1ufIMLFs13uyFRebA
         of8g==
X-Gm-Message-State: APjAAAWQlczk3N8LCuSQvFascYrpbNk5LbIc410gbUdYNCv0GiZHlfeH
        f+6f6wEDZ0NS1YcgTgqTTdpAEQ==
X-Google-Smtp-Source: APXvYqzjuQPwTlwiGWQJArevnuNtf/BUZhD73XiE/Bfu4lxll4NKeL0JCsdquj30nMOYWLPGj/0JHw==
X-Received: by 2002:aa7:9105:: with SMTP id 5mr11748563pfh.245.1571881658843;
        Wed, 23 Oct 2019 18:47:38 -0700 (PDT)
Received: from goma (p1092222-ipngn200709sizuokaden.shizuoka.ocn.ne.jp. [220.106.235.222])
        by smtp.gmail.com with ESMTPSA id y138sm25464902pfb.174.2019.10.23.18.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 18:47:37 -0700 (PDT)
Date:   Thu, 24 Oct 2019 10:47:33 +0900
From:   Daniel Palmer <daniel@0x0f.com>
To:     Rob Herring <robh@kernel.org>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: arm: Initial MStar vendor prefixes and
 compatible strings
Message-ID: <20191024014731.GA3731@goma>
References: <20191014061617.10296-1-daniel@0x0f.com>
 <20191023200228.GA29675@bogus>
 <20191023224357.GA26445@goma>
 <CAL_JsqKTiieO_7gM4YNGV-BAT67Mi+PX4Gqyyd7nowZsjhnFqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKTiieO_7gM4YNGV-BAT67Mi+PX4Gqyyd7nowZsjhnFqQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 06:45:29PM -0500, Rob Herring wrote:
> > I used the sunxi file as a template and thought they had some
> > reason to do that. I'll change it to just GPL-2.0.
> 
> That wasn't a choice, but dual license it please.

Will do.

> Sounds like you want:
> 
> items:
>  - const: thingyjp,breadbee
>  - enum:
>      - mstar,infinity
>      - mstar,infinity3
> 
> If one board can do both chips. Though if the same PCB is populated
> differently beyond the SoC, then maybe 2 board compatibles makes
> sense.

You can take one chip off and swap it with the other without any PCB/component
changes but as I've been working on both chips there are a few differences
coming up that means you can't use the same DT for both configurations.
For example the ethernet phy needs to be configured differently, the i1
SoC has less instances of the DMA controller blocks and so on.

The version of the chip can be detected from a register and I had considered
patching over the differences based on that but I couldn't find an example
of doing it within the kernel. So I'm detecting the chip version in u-boot and
loading the right DT there.
 
> Why not use the part numbers (msc313...)?

I had initially done that when I thought i1 was the msc31e and i3 was the
msc313e. For the i1 the only part I have found so far is the msc313 but
the i3 is a series of around 4 or 5 different configurations of the same SoC 
with differing amounts of DDR and pins. This is like the AllWinner V3S and 
S3/S3L where the same V3 SoC is packaged differently. As there is no source
of this information that appears on a google search I've started documenting
it at http://linux-chenxing.org/

I think the only place the actual chip model will need to be used will be a
compatible string for the pinctrl driver to setup the right pin numbers.

Thanks,

Daniel
