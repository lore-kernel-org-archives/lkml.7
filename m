Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D250AC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 09:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0B62173E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 09:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562060902;
	bh=1oN3fEDcJOO5WpXrtBAr0DvSdkhuKsbY+w9ryKcRLn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xXrOBiNK79VBylq3AxyjhePm22HanZuixXQqE3qJKkSli0db1g0iOxul+Qfy//bZn
	 08yFtYNWYLv+yiTRGYmxnIb76VsmREYzG13n8K9z7xzmZpbpFTot832u8g2dXvg3ku
	 +EvtVdA0LV0kT0x+GU+H5z0h/eWhe954OuSA0qnw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfGBJsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 05:48:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfGBJsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 05:48:21 -0400
Received: from localhost (unknown [49.207.58.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B151B206A2;
        Tue,  2 Jul 2019 09:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562060899;
        bh=1oN3fEDcJOO5WpXrtBAr0DvSdkhuKsbY+w9ryKcRLn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zmvf+OAfp3I0frwxgqCBlrfZzDVexs63/Uqe49HhJX70Bk7JuVZ3AxTGrKAAWNeU9
         1sn66P+Cyd3A5i0tUo3QmGPiA5tEKJuIPjIvrIluHZ99OBdDsHH+nhK70q/jS3p8yy
         v4BABf0TJvVWysjG8FGsUlWWproq+PylMFlvkDJw=
Date:   Tue, 2 Jul 2019 15:15:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        bgoswami@quicinc.com
Subject: Re: [RFC PATCH 1/5] dt-bindings: soundwire: add slave bindings
Message-ID: <20190702094510.GO2911@vkoul-mobl>
References: <20190611104043.22181-1-srinivas.kandagatla@linaro.org>
 <20190611104043.22181-2-srinivas.kandagatla@linaro.org>
 <20190701061155.GJ2911@vkoul-mobl>
 <ce1e445e-3254-1308-8752-2cb56a7e0cc6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce1e445e-3254-1308-8752-2cb56a7e0cc6@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-07-19, 09:22, Srinivas Kandagatla wrote:
> Thanks Vinod for taking time to review,
> 
> On 01/07/2019 07:11, Vinod Koul wrote:
> > On 11-06-19, 11:40, Srinivas Kandagatla wrote:
> > > This patch adds bindings for Soundwire Slave devices which includes how
> > > SoundWire enumeration address is represented in SoundWire slave device
> > > tree nodes.
> > > 
> > > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > ---
> > >   .../devicetree/bindings/soundwire/bus.txt     | 48 +++++++++++++++++++
> > >   1 file changed, 48 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/soundwire/bus.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/soundwire/bus.txt b/Documentation/devicetree/bindings/soundwire/bus.txt
> > > new file mode 100644
> > > index 000000000000..19a672b0d528
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/soundwire/bus.txt
> > 
> > The bindings are for slave right and the file is bus.txt?
> 
> I tried to follow what I have done for SLIMBus.
> Do you prefer them to be documented in slave.txt?

Would that not be better :) We should have a master.txt for bus things

> > > @@ -0,0 +1,48 @@
> > > +SoundWire bus bindings.
> > > +
> > > +SoundWire is a 2-pin multi-drop interface with data and clock line.
> > > +It facilitates development of low cost, efficient, high performance systems.
> > > +
> > > +SoundWire controller bindings are very much specific to vendor.
> > > +
> > > +Child nodes(SLAVE devices):
> > > +Every SoundWire controller node can contain zero or more child nodes
> > > +representing slave devices on the bus. Every SoundWire slave device is
> > > +uniquely determined by the enumeration address containing 5 fields:
> > > +SoundWire Version, Instance ID, Manufacturer ID, Part ID and Class ID
> > > +for a device. Addition to below required properties, child nodes can
> > > +have device specific bindings.
> > > +
> > > +Required property for SoundWire child node if it is present:
> > > +- compatible:	 "sdwVER,MFD,PID,CID". The textual representation of
> > > +		  SoundWire Enumeration address comprising SoundWire
> > > +		  Version, Manufacturer ID, Part ID and Class ID,
> > > +		  shall be in lower-case hexadecimal with leading
> > > +		  zeroes suppressed.
> > > +		  Version number '0x10' represents SoundWire 1.0
> > > +		  Version number '0x11' represents SoundWire 1.1
> > > +		  ex: "sdw10,0217,2010,0"
> > 
> > any reason why we want to code version number and not say sdw,1.0,...
> > and so on?
> 
> For consistency reasons, as other info in hex.
> 
> > 
> > > +
> > > +- sdw-instance-id: Should be ('Instance ID') from SoundWire
> > > +		  Enumeration Address. Instance ID is for the cases
> > > +		  where multiple Devices of the same type or Class
> > > +		  are attached to the bus.
> > 
> > instance id is part of the 48bit device id, so wont it make sense to add
> > that to compatible as well?
> > 
> So we could have multiple instance of same IP, so adding this to compatible
> string does not make sense! As driver has to list all the possible
> compatible strings.

Yes that makes sense.

-- 
~Vinod
