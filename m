Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A9CC2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB62205ED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbfLDRAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 12:00:38 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:49579 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728388AbfLDRAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 12:00:38 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MCska-1iTiJI2YF6-008vVh; Wed, 04 Dec 2019 18:00:36 +0100
Received: by mail-qk1-f182.google.com with SMTP id c124so620287qkg.0;
        Wed, 04 Dec 2019 09:00:36 -0800 (PST)
X-Gm-Message-State: APjAAAV92IBGwtXPI7tNil5GVxY6Zl1hErhGDWZFwLN5fGXVoeRTBaDv
        3mGmJFfYxJLsGs7kW78u9/1YRJ5R0cK9BEgcbaU=
X-Google-Smtp-Source: APXvYqyju4yYkK00mL/AsNtNlWm+YmNdlZuI5KYTs+RGpdQmIhVd7rRwq31u5YA40lcBh9xqo7sNWsOElixbKEUtbUw=
X-Received: by 2002:a37:84a:: with SMTP id 71mr3947065qki.138.1575478835330;
 Wed, 04 Dec 2019 09:00:35 -0800 (PST)
MIME-Version: 1.0
References: <20191120154148.22067-1-orson.zhai@unisoc.com> <20191120154148.22067-2-orson.zhai@unisoc.com>
 <20191204163830.GA25135@bogus>
In-Reply-To: <20191204163830.GA25135@bogus>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 4 Dec 2019 18:00:17 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3_r6z6Qk133=4gUzJ0rYmMH7sDDqpEF8ZVXS_bc3OtkQ@mail.gmail.com>
Message-ID: <CAK8P3a3_r6z6Qk133=4gUzJ0rYmMH7sDDqpEF8ZVXS_bc3OtkQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] dt-bindings: syscon: Add syscon-names to refer to
 syscon easily
To:     Rob Herring <robh@kernel.org>
Cc:     Orson Zhai <orson.zhai@unisoc.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kevin.tang@unisoc.com, baolin.wang@unisoc.com,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:r3y+zLBOHRQgdfAtqoipBPFk9rDdEY3DswcS7DxPYiywq28rt5x
 KiNnTg0N94OtxOciKlyn2WECD0LfoK7rbllL8vxWPlKQ/NBelQNeG7pVmr9VzBQIicvWcdz
 eFR0JRWT4gR4I8kNMgLU4XCTpvKw88MiSeNZM+0nL3TuElEdqZibbfaTbOJmqpA41Mm9Rx7
 PyU5HnuzEp7MSCMrdjFSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:I9DA6lRZ5js=:+AZx6ppjpOQjuQ9CSM5rZr
 S9s6uNN0Sm7NqQOJ1r6gWiJdREfJbgmO/2uZuOGQzwX0XVhw53QUqDDk3oJhwNJRPpOJpAek0
 ZA1BB0F6ap+I2FSMMncb+evQLhJQ3pM9pLIAJADfQieLx0DMk/K86aYLzwkv34K+socqPOMJX
 KRSkWBr1cQR0fg/YAySmbIGwQwdR4JAItXjuSpMk/RBEULbS0yUAm0fRs035c4E1VvlxQ9KxX
 qPhnblcuZLfjgTZSFMK/qiOkeFlzkD/rogD5tWEr5D+/gIR3N8iWwzQG5yIc9E/+/NbDyBJod
 d78LRyPVR0m5jcAF5a5AEy5cGP8+0njblnalbihdm/LPZ6lTLj39Pah/owoaZ067Ez7UN3eY3
 lfIRmWuua6jVlLrf+PP7DvppfkyYOUPd/t4Ws5rpyVcWfEQcl89GFJj281x76igtkn3Q6mFJw
 gF8hXfTcy8d4jHSWHQ7rEfq3WEAjaxdiGjpiRKno0FSa84UqQHGKHYFqefmUks6pV/0Zfp3d4
 vVwkFSmwLr/R7ISlU5RNgc1FB47H4udaIs47YTpcEPcXSLLtA1QR/oG3itCf59MBLDqxVQnTE
 s65aypf01eB9HX1yhlA/8T29bs4MA7XVOtN/0iDoDq+W5DaZhoeAQBUBwKSA0AY7aldppB3fg
 86NyspZ0jPrRkfvaT8MvQsIVFMXRrjp3IiF/hnUdXcz6vqC2W5g1uVPhHm9TMjfEPRM8cOAVL
 RBASl+VPrCKNSWlh7qPmqqKRk3voVrA8p1OC6/1CtaehNPdmiywVXW9FCUu2FPjEJj2NRCcsJ
 Ha3wdbdpblgFgdFYOdkxRqvFY4CXjkTVwEQTcI/wkNTHfSkvF9oqP/CJEX6Swv/z3rClwD4/l
 BFSeueTPbBrATLXF0ZgA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 4, 2019 at 5:38 PM Rob Herring <robh@kernel.org> wrote:
> On Wed, Nov 20, 2019 at 11:41:47PM +0800, Orson Zhai wrote:
> > Make life easier when syscon consumer want to access multiple syscon
> > nodes with dozens of items.
> > Add syscon-names and relative properties to help to manage different
> > cases when accessing more than one syscon node even with arguments.
> >
> > Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
> > ---
> >  .../devicetree/bindings/mfd/syscon.txt        | 43 +++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/syscon.txt b/Documentation/devicetree/bindings/mfd/syscon.txt
> > index 25d9e9c2fd53..4c7bdb74bb0a 100644
> > --- a/Documentation/devicetree/bindings/mfd/syscon.txt
> > +++ b/Documentation/devicetree/bindings/mfd/syscon.txt
> > @@ -30,3 +30,46 @@ hwlock1: hwspinlock@40500000 {
> >         reg = <0x40500000 0x1000>;
> >         #hwlock-cells = <1>;
> >  };
> > +
> > +
> > +
> > +==Syscon Name==
> > +
> > +Syscon name is a helper to be used in consumer nodes who refer to system
> > +controller node. It provides a way to refer to syscon node by names with
> > +phandle args in syscon consumer node. It will help people who have a lot
> > +of syscon references to be managed. It is not a must feature and has no
> > +effect to syscon node itself at all.
> > +
> > +Required properties:
> > +- syscons: List of phandles and any number of arguments if needed. Arguments
> > +  is specific to differnet vendors and its usage should be described at each
> > +  vendor's bindings. For example: In Unisoc SoCs, the 1st arg will be treated
> > +  as register address offset and the 2nd is bit mask.
> > +
> > +- syscon-names:        List of syscon node name strings sorted in the same order as
> > +  what it represents in property syscons.
> > +
> > +Optional property:
> > +- #.*-cells: Represents the number of arguments in single phandle in syscons
> > +  list. ".*" is vendor specific. If this property is not set, default value
> > +  will be 0.
>
> This breaks the normal pattern of how '#.*-cells' works. While Arnd
> suggests removing it, I don't think that works well either with having a
> generic 'syscons' property. That means every syscon in a system has to
> have the same number of cells.
>
> I don't really want to see syscon binding expanded. Really, I'd like
> 'syscon' to go away. It's nothing more than a flag to create a regmap.

Not expanding the syscon binding is the point about not having a #*-cells:
In the examples that Orson listed, the cell count would always be
specific to the user of the syscon regmap, and not interpreted by the
syscon itself.

> I think it is better to keep the property names specific to exactly what
> the functionality is for each syscon phandle rather than a generic
> binding.
>
> What are the eamples of where you want to use this?

I think generally speaking this would be useful for random registers that
logically belong to one device but are grouped with other unrelated
registers in a syscon, and that are in a different register offset for
each chip that has them. Using named properties instead of a list
of phandle/arg tuples with names is clearly a simpler alternative
and more like we do it today, but I can also see some API simplification
with Orson's patch without the binding getting out of hand.

> Keep in mind that
> this sort of connection should *only* be used for things that have no
> other binding and kernel subsystem.

+1

       Arnd
