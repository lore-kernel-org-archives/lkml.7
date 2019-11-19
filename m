Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1405C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1681222DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbfKSOUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:20:32 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:58385 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfKSOUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:20:31 -0500
Received: from mail-lj1-f169.google.com ([209.85.208.169]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N3sNa-1hopfK0gXw-00zqGk; Tue, 19 Nov 2019 15:20:30 +0100
Received: by mail-lj1-f169.google.com with SMTP id n21so23476058ljg.12;
        Tue, 19 Nov 2019 06:20:30 -0800 (PST)
X-Gm-Message-State: APjAAAUkc6WIgm9AxzCxawAeIQ+EFg4xiQ6pOFIfjMgUOSy1oCOnoq2J
        iaDGceFNIJ5OrttRDv7ugoYOmAPGwBTTy3HBKGc=
X-Google-Smtp-Source: APXvYqx/FE8WiY5X/tz1XWLitpfR/xmA4LhppVd8W9Adh5iUD7UgX+9CfCZXO3qxmLKACzi8Ax0zoze3ZUjlT06f2Hs=
X-Received: by 2002:a2e:9216:: with SMTP id k22mr4251098ljg.157.1574173229541;
 Tue, 19 Nov 2019 06:20:29 -0800 (PST)
MIME-Version: 1.0
References: <20191114114525.12675-1-orson.zhai@unisoc.com> <20191114114525.12675-2-orson.zhai@unisoc.com>
 <CAK8P3a23jcNgFErik1PFr=tG6n8kc8Pj9fARw47n=ou8t8iV+Q@mail.gmail.com> <20191118083952.GB6039@spreadtrum.com>
In-Reply-To: <20191118083952.GB6039@spreadtrum.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 Nov 2019 15:20:12 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0CEgXcPE6_yXGwS8fR0n_ij0Kr2E7dys4okiuTJfF3bw@mail.gmail.com>
Message-ID: <CAK8P3a0CEgXcPE6_yXGwS8fR0n_ij0Kr2E7dys4okiuTJfF3bw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: Add syscon-names support
To:     Orson Zhai <orson.zhai@spreadtrum.com>
Cc:     Orson Zhai <orson.zhai@unisoc.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kevin.tang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:vXMbzqODOK9Gy8gjNJQaFObvxW8cU5um4AV5Y3do8MlVoNMLwYZ
 QSXwAV3lpPKXfv0hDP6JTK9TApIrUdL2bHq8tBhOtaI3lKJFmXf3a0v/kMV165WRAm1bylb
 7V4QjazEY//FWG2qaFnc3Ci/TmY9QF0lOgWJdKRmaO9mTB5STOzG/cDZXFwddrAooqyB76f
 guZN/g/aQVWXn2CuHSb4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5gWmMGTk0og=:RMAp8FsshDbOaegrptuD65
 eB6ONnQ1vU5mEoGSdFbfPZzPbmQ5IaLvujmkQaOXFzFYNuAXPYnfuamvywEwCFV0KHhM7nk9q
 elvUYV/kJQzYxCNEqnTEdrVEu8zqDt8NvQnlGqApMrtLFxr9hg2916Ij+Z2QY1RnXRUlSi6bH
 rdo8YbMln+UN8F5DlbNTFdmEePtknVMagUKXIzJYV2BgbTQgXlH1kXB0tVFlOWIj4YbWLDkAC
 SusL/RX9tXYoBUuBzSR78TqE78udrkRE+2TYCQZ2yVxti7TGi7igo20+I/Q5IWzjCzzHHEW7D
 u/Y1+1RhszozYU4XZ0W53kirsqKLzyzBtJB7Edmgveq35ilNFY3TZkplepu4xFAGLW8lf+5ja
 djCobFdhDeOMN1ASoJA8zMmi4yiR7+nsyetkmwTT5Rc5vaHbJfHtq/cOT+u80sqQxABugKNNQ
 lIRtvD+zjPu4JrZTKP/4fNz0sWhn4lU7uGzN7SMIlBlIsxExQjXNZLXSDa3p1e5kDw93JCqdq
 XH/k//KQ+Y6xgdv4P6RTeZpe0ZnwnwJ9DOoa9my/6vCnDAvr4eNaoapYpqjqfgFa+acTrlLxs
 kIW3tnLwlHgjvW9RWGNe1qNE++HVjdYffFAKYBZNkblwwdo+AXyThvvpeDUpZ4u6k0uFkbjdP
 rBm771+175sHchq/WYkUXFB4s83BvKs/kWYZ3PzkHS82QIXApB6LeFLfagTl8ClmQ884vtBmF
 3N2pK5HsJtkWeQOTgm6tOnwMJJ8Gy0Gbiw0kNwl6mKw0fCTKUWY8DuCboig8qE5sbAwWa8ObZ
 vcjZPrKZVLjjrCN1283LjOuTc28YqNDE7lepe2fydblFvtN3aCAXqKBqu+9g8e5+2qj9ULr2K
 /GFKonSOyRbsjRAebwXA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 9:42 AM Orson Zhai <orson.zhai@spreadtrum.com> wrote:
>
> Hi Arnd,
>
> On Fri, Nov 15, 2019 at 10:33:30AM +0100, Arnd Bergmann wrote:
> > On Thu, Nov 14, 2019 at 12:48 PM Orson Zhai <orson.zhai@unisoc.com> wrote:
> > >
> > >
> > > Make life easier when syscon consumer want to access multiple syscon
> > > nodes.
> > > Add syscon-names and relative properties to help manage complicated
> > > cases when accessing more one syscon node.
> > >
> > > Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
> >
> > Hi Orson,
> >
> > Can you explain why the number of cells in this binding is specific
> > to the syscon node rather than the node referencing it?
>
> The story is like this. I found there are too many global registers in
> Unisoc(former Spreadtrum) chips. Dozens of offset with dozens of modules
> were needed to be specified. So I thought the dts files would seem "horrible"
> with a big chunk of syscon-xxx (say more than 20 lines)
>
> I learned from reg-names way which might look clean to hold all these mess things.
> But to implement this, the users need to konw the cell-size if we add arguments to syscon node.
> I thought to add cell-size into every syscon consumer node is a duplicated work and
> I wanted to take advantage of of_parse_phandle_with_args.
> So the bindings were created then.

Ok, that makes sense.

> > The way would otherwise handle the example from your binding
> > would be with two separate properties in the display node, like
> >
> > syscon-enable = <&ap_apb_regs 0x4 0xf00>;
> > syscon-power = <&aon_regs 0x8>;
>
> This is an option for consumers all the time.
> Acturally my patches are not going to replace this.
> I'd like to provide another option to save people like desperate engineers in Spreadtrum :)
>
> >
> > in which case, the syscon driver does not need to know anything
>
> Whould it be better if I add syscon-cells into consumer's node?

As I see it, there is no reason to put the syscon-cells property into any node,
as this is implied by the driver binding using the syscon reference.  I would
only use the #xyz-cells style property if there are multiple interpretations
that all make sense for the same binding.

> Then I could read the cell size and use "of_parse_phandle_with_fixed_args()" instead.
> This will not involve syscon node itself at all.

This sounds better to me, yes. I had not even remembered this function
exists, but I think this is a good idea.

I can also see a point in favor of adding more infrastructure around this,
possibly naming the entries in a syscon-names property as you suggested,
combining of_parse_phandle_with_fixed_args() with a name, or
combining with syscon_regmap_lookup_by_phandle() for convenience.

This should all be possible without adding complexity to the syscon
DT binding itself, and it would give more structure to the way it
is used by drivers.

       Arnd
