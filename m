Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77577C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A9621905
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552746107;
	bh=TLmhwtGQN4VfA785J1wHBRYladJMghsxUN/gvs2WAtQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Fn3RrX9LkyfxInfep5o+LU9kME9sttAAILK5o4PV4HpW3Sj42xAcKNRvsW770dvEG
	 vGtE72cBTgnlKMF/Zqc23kLSBEDCyCkRbsLDOpxJgYmGnnMCBCzA13y9Rw3qm1TC9N
	 qwbluQa+r9QsObxlOHkINUWmy0eW4xP8kOYOK56U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfCPOVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 10:21:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:55658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfCPOVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 10:21:45 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1BB821900;
        Sat, 16 Mar 2019 14:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552746105;
        bh=TLmhwtGQN4VfA785J1wHBRYladJMghsxUN/gvs2WAtQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Fe6PdOGDhGUycaeQPVznagNh/h87ljYHfugz3ota5Azqa76QT8/MPpDUfjhpDQgAJ
         vGRKSXM/rlzMxmMBBMI1KapR7Ls9+wdihG5JPj85l7VG9Oe+RfoudoEgtydpB3oiiH
         an0VU2n8chVwD8TI3MM+GqQvpaij9B1WbhcNKUI4=
Date:   Sat, 16 Mar 2019 14:21:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Patrick Havelange <patrick.havelange@essensium.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Esben Haabendal <esben@haabendal.dk>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 4/7] dt-bindings: counter: ftm-quaddec
Message-ID: <20190316142138.65860d88@archlinux>
In-Reply-To: <20190312190952.GA18547@bogus>
References: <20190306111208.7454-1-patrick.havelange@essensium.com>
        <20190306111208.7454-5-patrick.havelange@essensium.com>
        <20190312190952.GA18547@bogus>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2019 14:09:52 -0500
Rob Herring <robh@kernel.org> wrote:

> On Wed, Mar 06, 2019 at 12:12:05PM +0100, Patrick Havelange wrote:
> > FlexTimer quadrature decoder driver.
> > 
> > Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> > Reviewed-by: Esben Haabendal <esben@haabendal.dk>
> > ---
> > Changes v2
> >      - None
> > ---
> >  .../bindings/counter/ftm-quaddec.txt           | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/counter/ftm-quaddec.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/counter/ftm-quaddec.txt b/Documentation/devicetree/bindings/counter/ftm-quaddec.txt
> > new file mode 100644
> > index 000000000000..4d18cd722074
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/counter/ftm-quaddec.txt
> > @@ -0,0 +1,18 @@
> > +FlexTimer Quadrature decoder counter
> > +
> > +This driver exposes a simple counter for the quadrature decoder mode.  
> 
> Seems like this is more a mode of a h/w block than describing a h/w 
> block. Bindings should do the latter.
The snag is that we need to dig ourselves out of the hole set by:
fsl,vf610-ftm-pwm etc.

Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
(I'm assuming these are the same IP block).

Can probably be sorted out though.  One core driver binds against the
ftm and deals with instantiating the others depending on the configuration
(note that this mode for instance does make sense in DT as it's
really reflecting the fact there is a quadrature encoder
connected to the ftm).

Fiddly though :)

J
> 
> > +
> > +Required properties:
> > +- compatible:		Must be "fsl,ftm-quaddec".
> > +- reg:			Must be set to the memory region of the flextimer.
> > +
> > +Optional property:
> > +- big-endian:		Access the device registers in big-endian mode.
> > +
> > +Example:
> > +		counter0: counter@29d0000 {
> > +			compatible = "fsl,ftm-quaddec";
> > +			reg = <0x0 0x29d0000 0x0 0x10000>;
> > +			big-endian;
> > +			status = "disabled";
> > +		};
> > -- 
> > 2.19.1
> >   

