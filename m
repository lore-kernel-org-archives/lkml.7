Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D55C2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 23:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091AC214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 23:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576281017;
	bh=9OF3gvIhgB4PoeGk+9abecbqLsPMubebNDgjiS1F+Jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Qq2OQ2A38ooceu8dLlMNV50vkrhOM6B+BJyW5jsIQYuGXsg1iV14mI54uAqIgebv/
	 HAebJJ/k8/pPB/miBa/LR+ejQTZPaPVriL4lByTx9+BSA+2hbmJwkNinDU3dBk/ED6
	 uYbGlgtqmqSxk3knoJAux19TE5wMf4EErhfKLc+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfLMXuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:50:16 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35392 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMXuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 18:50:15 -0500
Received: by mail-ot1-f65.google.com with SMTP id o9so1120568ote.2;
        Fri, 13 Dec 2019 15:50:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l8y7QpzQFo6LopgFPQ5NquvGTv5LeZYf4UuALbXDpoQ=;
        b=R4UgmzSLZJ5vlfUw/XNSSK95LV5BqERGdme1wFccbsg7UxYubIrPRFEFmhSsQN3oVr
         ET+pppv165CqGothU/rZNDJLpzjGSSWCg2MbGMI9M9Yw4LehkZ72EICnmGvkKnd8OxFM
         NMoaUrxjceXVYjA6mscbgBC43Vs9n0uzTWClQTtSYoBJD6vWkVsQEe7n1rIrMjWstYV+
         2I50Rjp0D5Mp9d0b7YtjdXFaovuHXf+SujsNzTVOAktLlQJv+4hx9wEJASPdbKh8pVhy
         DVuJizIzXi+FYZ4WdfKNQoUm6eQNn7u2qc0M12KHOCollqddZ2CrYXrLePNSbhmy7LL7
         z64w==
X-Gm-Message-State: APjAAAXB21OAODVlrhQzxHYXEwpapBkvP4ixc+LxNDq0Z/f72u6HlwB0
        25ljGD715n9AUbfzAPzI3Q==
X-Google-Smtp-Source: APXvYqxtodM9bQIKZwdbEKbdE53q5NTExxX8dI91cxs2SHtzlLFLgHoUMHQBXFERpwqeV0o/UPjJ0w==
X-Received: by 2002:a05:6830:1bd5:: with SMTP id v21mr18520364ota.154.1576281014805;
        Fri, 13 Dec 2019 15:50:14 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f3sm3877604oto.57.2019.12.13.15.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 15:50:14 -0800 (PST)
Date:   Fri, 13 Dec 2019 17:50:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: Re: [PATCH 1/2] dt-bindings: soc: Add binding doc for iProc IDM
 device
Message-ID: <20191213235013.GA9997@bogus>
References: <20191202233127.31160-1-ray.jui@broadcom.com>
 <20191202233127.31160-2-ray.jui@broadcom.com>
 <62254bbb-168e-c0ad-a72d-bd659a2c23fa@gmail.com>
 <0f0e965b-2e57-8b6b-0c72-1a1008497793@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f0e965b-2e57-8b6b-0c72-1a1008497793@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 05:09:34PM -0800, Ray Jui wrote:
> 
> 
> On 12/5/19 4:09 PM, Florian Fainelli wrote:
> > On 12/2/19 3:31 PM, Ray Jui wrote:
> > > Add binding document for iProc based IDM devices.
> > > 
> > > Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> > 
> > Looks good to me, it's 2019, nearly 2020, maybe make this a YAML
> > compatible binding since it is a new one?
> > 
> 
> Sorry I am not aware of this YAML requirement until now.
> 
> Is this a new requirement that new DT binding document should be made with
> YAML format?

The format has been in place in the kernel for a year now and we've 
moved slowly towards it being required. If you're paying that little 
attention to upstream, then yes it's definitely required so someone else 
doesn't get stuck converting your binding later.

BTW, I think all but RPi chips still need their SoC/board bindings 
converted. One of the few not yet converted...

> Thanks,
> 
> Ray
> 
> 
> > > ---
> > >   .../bindings/soc/bcm/brcm,iproc-idm.txt       | 44 +++++++++++++++++++
> > >   1 file changed, 44 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,iproc-idm.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,iproc-idm.txt b/Documentation/devicetree/bindings/soc/bcm/brcm,iproc-idm.txt
> > > new file mode 100644
> > > index 000000000000..388c6b036d7e
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/soc/bcm/brcm,iproc-idm.txt
> > > @@ -0,0 +1,44 @@
> > > +Broadcom iProc Interconnect Device Management (IDM) device
> > > +
> > > +The Broadcom iProc IDM device allows control and monitoring of ASIC internal
> > > +bus transactions. Most importantly, it can be configured to detect bus
> > > +transaction timeout. In such case, critical information such as transaction
> > > +address that caused the error, bus master ID of the transaction that caused
> > > +the error, and etc., are made available from the IDM device.
> > > +
> > > +-------------------------------------------------------------------------------
> > > +
> > > +Required properties for IDM device node:
> > > +- compatible: must be "brcm,iproc-idm"
> > > +- reg: base address and length of the IDM register space
> > > +- interrupt: IDM interrupt number
> > > +- brcm,iproc-idm-bus: IDM bus string

What are possible values?

> > > +
> > > +Optional properties for IDM device node:
> > > +- brcm,iproc-idm-elog: phandle to the device node of the IDM logging device
> > > +
> > > +-------------------------------------------------------------------------------
> > > +
> > > +Required properties for IDM error logging device node:
> > > +- compatible: must be "brcm,iproc-idm-elog";
> > > +- reg: base address and length of reserved memory location where IDM error
> > > +  events can be saved
> > > +
> > > +-------------------------------------------------------------------------------
> > > +
> > > +Example:
> > > +
> > > +idm {
> > > +	idm-elog {
> > > +		compatible = "brcm,iproc-idm-elog";
> > > +		reg = <0x8f221000 0x1000>;
> > > +	};
> > > +
> > > +	idm-mhb-paxc-axi {

Needs a unit-address.

> > > +		compatible = "brcm,iproc-idm";
> > > +		reg = <0x60406900 0x200>;
> > > +		interrupt = <GIC_SPI 516 IRQ_TYPE_LEVEL_HIGH>;
> > > +		brcm,iproc-idm-bus = "idm-mhb-paxc-axi";

Can't you just use the node name? Though if this is something that can 
be a standard class of h/w (i.e. EDAC), then we'd want the node name to 
be generic.

> > > +		brcm,iproc-idm-elog = <&idm-elog>;
> > > +	};
> > > +};
> > > 
> > 
> > 
