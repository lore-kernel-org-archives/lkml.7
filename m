Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74118C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 13:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5088D218DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 13:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfIINcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 09:32:36 -0400
Received: from foss.arm.com ([217.140.110.172]:50188 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbfIINcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 09:32:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4238D28;
        Mon,  9 Sep 2019 06:32:34 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2C2C3F59C;
        Mon,  9 Sep 2019 06:32:32 -0700 (PDT)
Date:   Mon, 9 Sep 2019 14:32:30 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: mailbox: add binding doc for the
 ARM SMC/HVC mailbox
Message-ID: <20190909143230.48b1143f@donnerap.cambridge.arm.com>
In-Reply-To: <CABb+yY2t-oz6KqvCTsOJZqcMAUaR9Cbj014m7dCFXSBAMCojww@mail.gmail.com>
References: <1567004515-3567-1-git-send-email-peng.fan@nxp.com>
        <1567004515-3567-2-git-send-email-peng.fan@nxp.com>
        <CABb+yY2tRjazjaogpM7irqgTD+PdwsfqCxk5hP-_czrET3V5xQ@mail.gmail.com>
        <AM0PR04MB4481785CABB44A8C71CFB8D788BD0@AM0PR04MB4481.eurprd04.prod.outlook.com>
        <CABb+yY2TREpO7+TFcGgsgQrkmMWwFAgtuJ4GnLPPQ+GEBuh07w@mail.gmail.com>
        <AM0PR04MB448161C632722DF10989008088BD0@AM0PR04MB4481.eurprd04.prod.outlook.com>
        <CABb+yY2SrMF8e1iLyLqb-rJyBx4ajA0hZ6D=LFtuMNtXYjgccA@mail.gmail.com>
        <AM0PR04MB448133D1F4C887A82C679CEB88BD0@AM0PR04MB4481.eurprd04.prod.outlook.com>
        <CABb+yY2t-oz6KqvCTsOJZqcMAUaR9Cbj014m7dCFXSBAMCojww@mail.gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2019 03:12:29 -0500
Jassi Brar <jassisinghbrar@gmail.com> wrote:

Hi,

> On Fri, Aug 30, 2019 at 3:07 AM Peng Fan <peng.fan@nxp.com> wrote:
> >  
> > > Subject: Re: [PATCH v5 1/2] dt-bindings: mailbox: add binding doc for the ARM
> > > SMC/HVC mailbox
> > >
> > > On Fri, Aug 30, 2019 at 2:37 AM Peng Fan <peng.fan@nxp.com> wrote:  
> > > >
> > > > Hi Jassi,
> > > >  
> > > > > Subject: Re: [PATCH v5 1/2] dt-bindings: mailbox: add binding doc
> > > > > for the ARM SMC/HVC mailbox
> > > > >
> > > > > On Fri, Aug 30, 2019 at 1:28 AM Peng Fan <peng.fan@nxp.com> wrote:
> > > > >  
> > > > > > > > +examples:
> > > > > > > > +  - |
> > > > > > > > +    sram@910000 {
> > > > > > > > +      compatible = "mmio-sram";
> > > > > > > > +      reg = <0x0 0x93f000 0x0 0x1000>;
> > > > > > > > +      #address-cells = <1>;
> > > > > > > > +      #size-cells = <1>;
> > > > > > > > +      ranges = <0 0x0 0x93f000 0x1000>;
> > > > > > > > +
> > > > > > > > +      cpu_scp_lpri: scp-shmem@0 {
> > > > > > > > +        compatible = "arm,scmi-shmem";
> > > > > > > > +        reg = <0x0 0x200>;
> > > > > > > > +      };
> > > > > > > > +
> > > > > > > > +      cpu_scp_hpri: scp-shmem@200 {
> > > > > > > > +        compatible = "arm,scmi-shmem";
> > > > > > > > +        reg = <0x200 0x200>;
> > > > > > > > +      };
> > > > > > > > +    };
> > > > > > > > +
> > > > > > > > +    firmware {
> > > > > > > > +      smc_mbox: mailbox {
> > > > > > > > +        #mbox-cells = <1>;
> > > > > > > > +        compatible = "arm,smc-mbox";
> > > > > > > > +        method = "smc";
> > > > > > > > +        arm,num-chans = <0x2>;
> > > > > > > > +        transports = "mem";
> > > > > > > > +        /* Optional */
> > > > > > > > +        arm,func-ids = <0xc20000fe>, <0xc20000ff>;
> > > > > > > >  
> > > > > > > SMC/HVC is synchronously(block) running in "secure mode", i.e,
> > > > > > > there can only be one instance running platform wide. Right?  
> > > > > >
> > > > > > I think there could be channel for TEE, and channel for Linux.
> > > > > > For virtualization case, there could be dedicated channel for each VM.
> > > > > >  
> > > > > I am talking from Linux pov. Functions 0xfe and 0xff above, can't
> > > > > both be active at the same time, right?  
> > > >
> > > > If I get your point correctly,
> > > > On UP, both could not be active. On SMP, tx/rx could be both active,
> > > > anyway this depends on secure firmware and Linux firmware design.
> > > >
> > > > Do you have any suggestions about arm,func-ids here?
> > > >  
> > > I was thinking if this is just an instruction, why can't each channel be
> > > represented as a controller, i.e, have exactly one func-id per controller node.
> > > Define as many controllers as you need channels ?  
> >
> > I am ok, this could make driver code simpler. Something as below?
> >
> >     smc_tx_mbox: tx_mbox {
> >       #mbox-cells = <0>;
> >       compatible = "arm,smc-mbox";
> >       method = "smc";
> >       transports = "mem";
> >       arm,func-id = <0xc20000fe>;
> >     };
> >
> >     smc_rx_mbox: rx_mbox {
> >       #mbox-cells = <0>;
> >       compatible = "arm,smc-mbox";
> >       method = "smc";
> >       transports = "mem";
> >       arm,func-id = <0xc20000ff>;
> >     };
> >
> >     firmware {
> >       scmi {
> >         compatible = "arm,scmi";
> >         mboxes = <&smc_tx_mbox>, <&smc_rx_mbox 1>;
> >         mbox-names = "tx", "rx";
> >         shmem = <&cpu_scp_lpri>, <&cpu_scp_hpri>;
> >       };
> >     };
> >  
> Yes, the channel part is good.
> But I am not convinced by the need to have SCMI specific "transport" mode.

Why would this be SCMI specific and what is the problem with having this property?
By the very nature of the SMC/HVC call you would expect to also pass parameters in registers. However this limits the amount of data you can push, so the option of reverting to a memory based payload sounds very reasonable.
On the other hand *just* using memory complicates things, in case you have a very simple protocol. You would need a memory region shared between firmware and OS, which is not always easily possible on every platform. Also this doesn't scale easily with multiple mailboxes and channels. Passing parameters via registers is also naturally consistent, as there would be no races and no need for synchronisation with other cores or other users of the mailbox.

So I clearly see the benefit of specifying *both* ways of payload transport. Given that this driver should be protocol agnostic, it makes a lot of sense to introduce both methods *now*, so in the future users can just use the register method, without extending the binding in a incompatible way later (earlier kernels would have the driver, but wouldn't know how to deal with this parameter).

Cheers,
Andre.
