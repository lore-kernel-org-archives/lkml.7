Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77900C04AA9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 09:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D23420873
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 09:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfEBJKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 05:10:50 -0400
Received: from foss.arm.com ([217.140.101.70]:42536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbfEBJKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 05:10:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D42CB374;
        Thu,  2 May 2019 02:10:48 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00C993F5AF;
        Thu,  2 May 2019 02:10:46 -0700 (PDT)
Date:   Thu, 2 May 2019 10:10:44 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     Rob Herring <robh@kernel.org>, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        mark.rutland@arm.com, Sachin Ghadi <sachin.ghadi@sifive.com>
Subject: Re: [PATCH 1/2] RISC-V: Add DT documentation for SiFive L2 Cache
 Controller
Message-ID: <20190502091044.GD12498@e107155-lin>
References: <1556171696-7741-1-git-send-email-yash.shah@sifive.com>
 <1556171696-7741-2-git-send-email-yash.shah@sifive.com>
 <20190425101318.GA8469@e107155-lin>
 <CAJ2_jOEBqBnorz9PcQp72Jjju9RX_P8mU=Gq+0xCCcWsBiJksw@mail.gmail.com>
 <20190426093358.GA28309@e107155-lin>
 <CAJ2_jOEoD=Njp+L+H=jG59mA-j9SnwzyNmz7ECogWmbvei_f5Q@mail.gmail.com>
 <20190502004130.GA20802@bogus>
 <CAJ2_jOETZa_oC-xSwfQVw-9Q6OivRG2R0rKMhwCk1knbxWJQVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ2_jOETZa_oC-xSwfQVw-9Q6OivRG2R0rKMhwCk1knbxWJQVw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 10:50:12AM +0530, Yash Shah wrote:
> On Thu, May 2, 2019 at 6:11 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, Apr 30, 2019 at 09:50:45AM +0530, Yash Shah wrote:
> > > On Fri, Apr 26, 2019 at 3:04 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > >
> > > > On Fri, Apr 26, 2019 at 11:20:17AM +0530, Yash Shah wrote:
> > > > > On Thu, Apr 25, 2019 at 3:43 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > > > >
> > > > > > On Thu, Apr 25, 2019 at 11:24:55AM +0530, Yash Shah wrote:
> > > > > > > Add device tree bindings for SiFive FU540 L2 cache controller driver
> > > > > > >
> > > > > > > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > > > > > > ---
> > > > > > >  .../devicetree/bindings/riscv/sifive-l2-cache.txt  | 53 ++++++++++++++++++++++
> > > > > > >  1 file changed, 53 insertions(+)
> > > > > > >  create mode 100644 Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
> > > > > > >
> > > > > > > diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
> > > > > > > new file mode 100644
> > > > > > > index 0000000..15132e2
> > > > > > > --- /dev/null
> > > > > > > +++ b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
> > > > > > > @@ -0,0 +1,53 @@
> > > > > > > +SiFive L2 Cache Controller
> > > > > > > +--------------------------
> > > > > > > +The SiFive Level 2 Cache Controller is used to provide access to fast copies
> > > > > > > +of memory for masters in a Core Complex. The Level 2 Cache Controller also
> > > > > > > +acts as directory-based coherency manager.
> > > > > > > +
> > > > > > > +Required Properties:
> > > > > > > +--------------------
> > > > > > > +- compatible: Should be "sifive,fu540-c000-ccache"
> > > > > > > +
> > > > > > > +- cache-block-size: Specifies the block size in bytes of the cache
> > > > > > > +
> > > > > > > +- cache-level: Should be set to 2 for a level 2 cache
> > > > > > > +
> > > > > > > +- cache-sets: Specifies the number of associativity sets of the cache
> > > > > > > +
> > > > > > > +- cache-size: Specifies the size in bytes of the cache
> > > > > > > +
> > > > > > > +- cache-unified: Specifies the cache is a unified cache
> > > > > > > +
> > > > > > > +- interrupt-parent: Must be core interrupt controller
> > > > > > > +
> > > > > > > +- interrupts: Must contain 3 entries (DirError, DataError and DataFail signals)
> > > > > > > +
> > > > > > > +- reg: Physical base address and size of L2 cache controller registers map
> > > > > > > +
> > > > > > > +- reg-names: Should be "control"
> > > > > > > +
> > > > > >
> > > > > > It would be good if you mark the properties that are present in DT
> > > > > > specification and those that are added for sifive,fu540-c000-ccache
> > > > >
> > > > > I believe there isn't any property which is added explicitly for
> > > > > sifive,fu540-c000-ccache.
> > > > >
> > > >
> > > > reg and interrupts are generally optional for normal cache and may be
> > > > required for cache controller like this. DT specification[1] covers
> > > > only caches and not cache controllers.
> > >
> > > Are you suggesting something like this:
> > >
> > > Required Properties:
> > > --------------------
> > > Standard Properties:
> >
> > I don't think we need this separation.
>
> Ok. Won't include this "Standard/Non-standard properties" separation
> in the next revision of this patch.
>

Sorry if I created confusion. I just wanted a note saying all the properties
in ePAPR/DeviceTree specification applies for this platform. That would
help me check if the standard cacheinfo infrastruction works as is or not.

--
Regards,
Sudeep
