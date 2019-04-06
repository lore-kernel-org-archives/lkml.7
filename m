Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9139FC10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 16:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40962213A2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 16:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="hi1zjzDt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfDFQ5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 12:57:43 -0400
Received: from vps.xff.cz ([195.181.215.36]:36072 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbfDFQ5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 12:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1554569860; bh=dtWXX4FFPVKqFcTGB0+8akpgDZLIyFgEG8CTCnTHF/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hi1zjzDtoa8hOvzcwPe0bkp27XhfIFPWPoFQZ01qYKU3+yD4v+iEEJ3Hs+U8qHcfE
         zWLLBtSqSvMANWRez+vn9iSDt5MMW2WSbVBPpDjQcMupu4CzKRR1LsplMrLJsHiBU8
         kTUcYWY4udmNdWG7CiFzuwn0caQN5sa2JovWg+a0=
Date:   Sat, 6 Apr 2019 18:57:39 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     maxime.ripard@free-electrons.com, wens@csie.org, robh@kernel.org,
        mark.rutland@arm.com, Ziping Chen <techping.chan@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-input@vger.kernel.org, hdegoede@redhat.com
Subject: Re: [linux-sunxi] Re: [PATCH RESEND v4 1/4] input:
 sun4i-a10-lradc-keys: Add support for A83T
Message-ID: <20190406165739.bati4leqghmehi2l@core.my.home>
Mail-Followup-To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        maxime.ripard@free-electrons.com, wens@csie.org, robh@kernel.org,
        mark.rutland@arm.com, Ziping Chen <techping.chan@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-input@vger.kernel.org, hdegoede@redhat.com
References: <20190327023339.25975-1-megous@megous.com>
 <20190327023339.25975-2-megous@megous.com>
 <20190404184915.GB116898@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404184915.GB116898@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Apr 04, 2019 at 11:49:15AM -0700, Dmitry Torokhov wrote:
> On Wed, Mar 27, 2019 at 03:33:36AM +0100, megous@megous.com wrote:
> > From: Ziping Chen <techping.chan@gmail.com>
> > 
> > Allwinner A83T SoC has a low res adc like the one in Allwinner A10 SoC,
> > however, the A10 SoC's vref of lradc internally is divided by 2/3 and
> > the A83T SoC's vref of lradc internally is divided by 3/4, thus add
> > a hardware variant for it to be compatible with various devices.
> > 
> > Signed-off-by: Ziping Chen <techping.chan@gmail.com>
> > Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Applied, this and binding patch; the dts changes should go through other
> relevant trees I believe.

Thank you very much. Yes, the rest should go through the sunxi tree.

regards,
   Ondrej

> Thanks.
> 
> -- 
> Dmitry
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
