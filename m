Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0102C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 12:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980BF233A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 12:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566478381;
	bh=+LmgaaxC2q4cxo4sEZL7ZYhCTTPgbmk76IWMitzQV7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y3RlTBz5NWA1OAELDsyxEHOuteMwsFDwhBkF9xUp/DA3a0HYxGvmShOBqa4IN8q8S
	 d3+DBuwRTIMsgnhlj4BwZ/OKKP9yMQBSIeDpTuJOLzHsArkE9CSqEW8pAhSjyyv6Az
	 YJn2Wrm385gy3bC/8m1WFHZUgRcp3fl2Ab82xEF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388726AbfHVMxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 08:53:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfHVMxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 08:53:00 -0400
Received: from localhost (unknown [171.61.89.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2891C2089E;
        Thu, 22 Aug 2019 12:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566478378;
        bh=+LmgaaxC2q4cxo4sEZL7ZYhCTTPgbmk76IWMitzQV7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ExFlLSbYtm/2Llz1BRoI92FThaGkZH2k+tlxLgAIVzZKvlRuovRg8nUyOkBREh5Oi
         dl1qW/GikXIQJenVO6JiXLZq90qVM/NhwFK/GYaTIzM8zOAKH/vBekoIi7G8wITIe7
         3h/zMO1pb4zF7dtYSqo2+lMDJYzjLUDSqFbb9s+E=
Date:   Thu, 22 Aug 2019 18:21:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Patrick Lai <plai@codeaurora.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: soundwire: add slave bindings
Message-ID: <20190822125145.GO12733@vkoul-mobl.Dlink>
References: <20190809133407.25918-1-srinivas.kandagatla@linaro.org>
 <20190809133407.25918-2-srinivas.kandagatla@linaro.org>
 <20190821214436.GA13936@bogus>
 <0272eafd-0aa5-f695-64e4-f6ad7157a3a6@linaro.org>
 <CAL_JsqJJCJB9obR_Jn3hmn4gq+RQjY-8M+xkdYA185Uaw0MHcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJJCJB9obR_Jn3hmn4gq+RQjY-8M+xkdYA185Uaw0MHcw@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-08-19, 07:36, Rob Herring wrote:
> On Thu, Aug 22, 2019 at 5:12 AM Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
> >
> >
> >
> > On 21/08/2019 22:44, Rob Herring wrote:
> > > On Fri, Aug 09, 2019 at 02:34:04PM +0100, Srinivas Kandagatla wrote:
> > >> This patch adds bindings for Soundwire Slave devices that includes how
> > >> SoundWire enumeration address and Link ID are used to represented in
> > >> SoundWire slave device tree nodes.
> > >>
> > >> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > >> ---
> > >>   .../devicetree/bindings/soundwire/slave.txt   | 51 +++++++++++++++++++
> > >>   1 file changed, 51 insertions(+)
> > >>   create mode 100644 Documentation/devicetree/bindings/soundwire/slave.txt
> > >
> > > Can you convert this to DT schema given it is a common binding.
> > >
> >
> > I will give that a go in next version!
> >
> > > What does the host controller look like? You need to define the node
> > > hierarchy. Bus controller schemas should then include the bus schema.
> > > See spi-controller.yaml.
> >
> > Host controller is always parent of these devices which is represented
> > in the example.
> >
> > In my previous patches, i did put this slave bindings in bus.txt, but
> > Vinod suggested to move it to slave.txt.
> >
> > Are you suggesting to add two yamls here, one for slave and one for bus
> > Or just document this in one bus bindings?
> 
> One. Like I said, see spi-controller.yaml.
> 
> > >> diff --git a/Documentation/devicetree/bindings/soundwire/slave.txt b/Documentation/devicetree/bindings/soundwire/slave.txt
> > >> new file mode 100644
> > >> index 000000000000..201f65d2fafa
> > >> --- /dev/null
> > >> +++ b/Documentation/devicetree/bindings/soundwire/slave.txt
> > >> @@ -0,0 +1,51 @@
> > >> +SoundWire slave device bindings.
> > >> +
> > >> +SoundWire is a 2-pin multi-drop interface with data and clock line.
> > >> +It facilitates development of low cost, efficient, high performance systems.
> > >> +
> > >> +SoundWire slave devices:
> > >> +Every SoundWire controller node can contain zero or more child nodes
> > >> +representing slave devices on the bus. Every SoundWire slave device is
> > >> +uniquely determined by the enumeration address containing 5 fields:
> > >> +SoundWire Version, Instance ID, Manufacturer ID, Part ID
> > >> +and Class ID for a device. Addition to below required properties,
> > >> +child nodes can have device specific bindings.
> > >> +
> > >> +Required properties:
> > >> +- compatible:        "sdw<LinkID><VersionID><InstanceID><MFD><PID><CID>".
> > >> +              Is the textual representation of SoundWire Enumeration
> > >> +              address along with Link ID. compatible string should contain
> > >> +              SoundWire Link ID, SoundWire Version ID, Instance ID,
> > >> +              Manufacturer ID, Part ID and Class ID in order
> > >> +              represented as above and shall be in lower-case hexadecimal
> > >> +              with leading zeroes. Vaild sizes of these fields are
> > >> +              LinkID is 1 nibble,
> > >> +              Version ID is 1 nibble
> > >> +              Instance ID in 1 nibble
> > >> +              MFD in 4 nibbles
> > >> +              PID in 4 nibbles
> > >> +              CID is 2 nibbles
> > >> +
> > >> +              Version number '0x1' represents SoundWire 1.0
> > >> +              Version number '0x2' represents SoundWire 1.1
> > >
> > > This can all be a regex.
> > >
> > >> +              ex: "sdw0110217201000" represents 0 LinkID,
> > >> +              SoundWire 1.0 version slave with Instance ID 1.
> > >> +              More Information on detail of encoding of these fields can be
> > >> +              found in MIPI Alliance DisCo & SoundWire 1.0 Specifications.
> > >> +
> > >> +SoundWire example for Qualcomm's SoundWire controller:
> > >> +
> > >> +soundwire@c2d0000 {
> > >> +    compatible = "qcom,soundwire-v1.5.0"
> > >> +    reg = <0x0c2d0000 0x2000>;
> > >> +
> > >> +    spkr_left:wsa8810-left{
> > >> +            compatible = "sdw0110217201000";
> > >> +            ...
> > >> +    };
> > >> +
> > >> +    spkr_right:wsa8810-right{
> > >> +            compatible = "sdw0120217201000";
> > >
> > > The normal way to distinguish instances is with 'reg'. So I think you
> > > need 'reg' with Instance ID moved there at least. Just guessing, but
> > > perhaps Link ID, too? And for 2 different classes of device is that
> > > enough?
> >
> > In previous bindings ( https://lists.gt.net/linux/kernel/3403276 ) we
> > did have instance-id as different property, however Pierre had some good
> > suggestion to make it align with _ADR encoding as per MIPI DisCo spec.
> >
> > Do you still think that we should split the instance id to reg property?
> 
> Assuming you could have more than 1 of the same device on the bus,
> then you need some way to distinguish them and the way that's done for
> DT is unit-address/reg. And compatible strings should be constant for
> each instance.

That does make sense, we can use unit-address/reg as instance id.

Thanks
-- 
~Vinod
