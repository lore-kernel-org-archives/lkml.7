Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED2EC10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 13:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9ED218D3
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 13:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555247318;
	bh=Ous3TJ2A8CyI2IyxcCeZuYfuS/4bhsf41rEoMYt86Vo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=fGduuvKPsKG3XhxbiS1xFuYw6Nja2eb53e3YWWnvwKmEV7VU5j9hFmJJsNlynj+km
	 FyuJjOWP9Q8sDo6y0hmX5Sti0XvtIHBskSk1JrybnFzrVrIzttNCtCN+dQO/mx/a1D
	 sXgGkJ3CfJ22fYa5lG+yAblPaT4sqpHplNE79Rao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfDNNIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 09:08:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbfDNNIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 09:08:37 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E84FB2148E;
        Sun, 14 Apr 2019 13:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555247316;
        bh=Ous3TJ2A8CyI2IyxcCeZuYfuS/4bhsf41rEoMYt86Vo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aE7GJFVLlL65Qoxc9vwpBDG++u9ksMQ5UQ7k9MmJQZtMR/gEy3Mu5hUmYcMxpBzAI
         Wtw1RXjUdcG+Pq9aXxCa3FCNZUNBu/PWtbwCcztNo32Tmh3Zsk1ef+8NF94ct5fck9
         DIjSKw7FxGgyGIFMITM9hN788T8MjgijcLWwtevw=
Date:   Sun, 14 Apr 2019 14:08:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Andreas Klinger <ak@it-klinger.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Song Qiang <songqiang1304521@gmail.com>,
        Mathieu Othacehe <m.othacehe@gmail.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] devantech-srf04.yaml: add Maxbotix ultrasonic iio
 proximity sensors
Message-ID: <20190414140829.5c4dfcbb@archlinux>
In-Reply-To: <CAL_Jsq+k+JDsm=3cX6UeRCyD4k1YnWxbkoYm49GMO5mOgsGoqg@mail.gmail.com>
References: <20190409191054.va6y2l5lyhyoo5p4@arbad>
        <CAL_Jsq+k+JDsm=3cX6UeRCyD4k1YnWxbkoYm49GMO5mOgsGoqg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Apr 2019 16:08:02 -0500
Rob Herring <robh+dt@kernel.org> wrote:

> On Tue, Apr 9, 2019 at 2:11 PM Andreas Klinger <ak@it-klinger.de> wrote:
> >
> > add compatibles for Maxbotix ultrasonic iio sensor types to yaml
> > documentation
> >
> > Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> > ---
> >  .../bindings/iio/proximity/devantech-srf04.yaml    | 25 ++++++++++++++--------
> >  1 file changed, 16 insertions(+), 9 deletions(-)  
> 
> In the future, 'dt-bindings: iio: ...' for the subject please.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied and subject tidied up.

Thanks,

Jonathan
