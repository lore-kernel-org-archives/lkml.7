Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAD3C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 08:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C52A2175B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 08:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557478681;
	bh=YwreLhFMGY0y8sZobflmXR/vXSn2zdZ4h2mD13MTPd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Okbh/ZnuUMZpO2oF6ayhE74/RY16aXqJD6XelDNEgT/VT9Gr5vIQaUJB45H2IujGK
	 st77NHHHrjVXbKFh12T/TAm10d5CwFn0UVZGJPHiYSSmA7WjqUYvi6gKIc1QyXeQHt
	 MRejGOl3kQGH7Pb4uBUE1whhKYI4gNCjCD7Hjj/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfEJI6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 04:58:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:41300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbfEJI6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 04:58:00 -0400
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EEF3216C4;
        Fri, 10 May 2019 08:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557478679;
        bh=YwreLhFMGY0y8sZobflmXR/vXSn2zdZ4h2mD13MTPd8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KOEAwUqLzgV/gAOrxwSR/1tohVZSJIfKaP0B+xM2T5041/meEHL4sqa3KJOZ9WfNt
         FTSzfcXDpSj0K8irEpErJLabRtnkzaB/Wg72anO1vF2thZvIZmd95gabBaBav04yAB
         XZnNWYV5FDXYaky2eFUedBr7vsgLJaUGpKMoxpNM=
Date:   Fri, 10 May 2019 16:57:54 +0800
From:   Guo Ren <guoren@kernel.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     tglx@linutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V2 5/7] dt-bindings: interrupt-controller: Update csky
 mpintc
Message-ID: <20190510083546.GA27608@guoren-Inspiron-7460>
References: <1550455483-11710-1-git-send-email-guoren@kernel.org>
 <1550455483-11710-5-git-send-email-guoren@kernel.org>
 <20190218142845.4ad56ec0@why.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218142845.4ad56ec0@why.wild-wind.fr.eu.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx Marc,

On Mon, Feb 18, 2019 at 02:28:45PM +0000, Marc Zyngier wrote:
> On Mon, 18 Feb 2019 10:04:41 +0800
> guoren@kernel.org wrote:
> 
> > From: Guo Ren <ren_guo@c-sky.com>
> > 
> > Add trigger type and priority setting for csky,mpintc.
> > 
> > Changelog:
> >  - change #interrupt-cells to <3>
> > 
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > ---
> >  .../bindings/interrupt-controller/csky,mpintc.txt   | 21 +++++++++++++++++----
> >  1 file changed, 17 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
> > index ab921f1..dccd913 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
> > @@ -6,11 +6,18 @@ C-SKY Multi-processors Interrupt Controller is designed for ck807/ck810/ck860
> >  SMP soc, and it also could be used in non-SMP system.
> >  
> >  Interrupt number definition:
> > -
> >    0-15  : software irq, and we use 15 as our IPI_IRQ.
> >   16-31  : private  irq, and we use 16 as the co-processor timer.
> >   31-1024: common irq for soc ip.
> >  
> > +Interrupt triger mode:
> > + IRQ_TYPE_LEVEL_HIGH (default)
> > + IRQ_TYPE_LEVEL_LOW
> > + IRQ_TYPE_EDGE_RISING
> > + IRQ_TYPE_EDGE_FALLING
> > +
> > +Interrupt priority range: 0-255
> > +
> >  =============================
> >  intc node bindings definition
> >  =============================
> > @@ -26,15 +33,21 @@ intc node bindings definition
> >  	- #interrupt-cells
> >  		Usage: required
> >  		Value type: <u32>
> > -		Definition: must be <1>
> > +		Definition: <3>
> 
> This seem to be invalidating all existing DTs. Is this an acceptable
> thing to do? It will require an Ack from a DT maintainer.
There is no DTs upstreamed and current implementation of driver could
support old format which isn't mentioned here. We just give a complete
format here.

Best Regards
 Guo Ren
