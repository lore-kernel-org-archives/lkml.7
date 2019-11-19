Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FECC43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3968E222D1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbfKSOq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:46:29 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:53513 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfKSOq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:46:28 -0500
Received: from mail-qt1-f172.google.com ([209.85.160.172]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MiIhU-1ht5ev1Ys2-00fP8b; Tue, 19 Nov 2019 15:46:27 +0100
Received: by mail-qt1-f172.google.com with SMTP id p20so24864316qtq.5;
        Tue, 19 Nov 2019 06:46:27 -0800 (PST)
X-Gm-Message-State: APjAAAUYO7AmvoilwFNaZ4eHUBwJx4CBw4GEW5GCsqcfPHJmZmQ3ACie
        CPuqHI1qTndYL7yKi8BzqWhJyH8HNNM9BdEIRDM=
X-Google-Smtp-Source: APXvYqyZthyLNHmwLrvGE3UI0NVhTMLNX0GD/xv+616jGA+AJH2A6naRt3YGzH0AczzOYwHYd6VDdgQ8yfjqRnWYRW4=
X-Received: by 2002:ac8:1908:: with SMTP id t8mr32535797qtj.18.1574174786183;
 Tue, 19 Nov 2019 06:46:26 -0800 (PST)
MIME-Version: 1.0
References: <20191114114525.12675-1-orson.zhai@unisoc.com> <20191114114525.12675-2-orson.zhai@unisoc.com>
 <CAK8P3a23jcNgFErik1PFr=tG6n8kc8Pj9fARw47n=ou8t8iV+Q@mail.gmail.com> <20191118083952.GB6039@spreadtrum.com>
In-Reply-To: <20191118083952.GB6039@spreadtrum.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 Nov 2019 15:46:09 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2d2=BejX=R0jmw0zt64mPF-rjKSi1Eh5Koz1cqku-nRA@mail.gmail.com>
Message-ID: <CAK8P3a2d2=BejX=R0jmw0zt64mPF-rjKSi1Eh5Koz1cqku-nRA@mail.gmail.com>
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
X-Provags-ID: V03:K1:SjwzpAUsg1VI3ER4QUyL0Fd5YUZOgF6BGz6sNVf4D9LH8gXEEO8
 YODOQcph9RGmtUTtgP5OdwIDMeJoiMOBxxnvVpKprlkVAwCY7fG8ZIKLU7HeG0WlDFblQS7
 codUWH2Z65XBciJmw9/e2RlAUG79bEefqQte1f+P3SbVm7NyiJ5wuD7KtPeJkPCQKodB3GV
 ShSnKDp7w78PaBCzdGCKw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ecSILaxw7Tg=:tYzpVdFLNU9thDNNE+4o1x
 4+q2F2fFPtLc+Aeq4KUKiufr+C6ERYgY8ttQGY4c9MZiyPd4l5KZjFcNg9dIugEM86g9VCRZy
 /USSSBcraVNwctOCrR1LDDH6of1INvHdCWF1yZMqeSRjBfN4OY6SCTyf825ZpVD1Rq/2KmC/D
 VSTL6qnYm4Y46dVowuzGCUz/TlQ6D//lU/VlT/e4SmzXOAsVLIleNbBFjn8W5WlQayUlHnBvm
 rtJ3UlNgtqfhAjtsqipMzLLXAGpdEiWK0b2ccMakAZU12fXTEFTFFlpvo9lk3C/ZHbc45GihP
 bxWNwCkLLpMRBGazWQpXLgprlvzGztJJEIoozHBo0ii5sQ7WJnZj2Cb7YuJ/vO9Pp8037BtXU
 Y9okOKWQx+D6RPhbQa0JB8Rx09LSgeRWWa/I9xK90cLHieAukbSHhEILZNSE1tYkw+o57SKx3
 vUeLCkyCCDsOov15+BYiuD/NGgbEA9a72PMVEIRR3cl8UhjVevfXqT672E353aE3HW+L5yUV4
 aegnKxMeeYFiAxQO0R/6szbtTzPYmVDsqsTQTd6HMZisvTLyR+YjCyfLJFRDY7PLjwo+y0wBh
 g7mic+5oHmVua1KLgZ+oIMiiWwL+AImlJU8KRSVAIyafSxbBoU9zOY6CeE50mKAbKKVKtlE6t
 fMVZGxFUqbFdEjXNnug+DPv+wj04VY1MSxjI4hak1Z70xnMdrk62IUJ+p1s4HGuui74/FujXK
 lq6fR6XX14MYZrZKwwc5HMjQs563p7TA5fO96YEizQ5xd+lXsv7EbL0HIWWac7VRYMsWhorNA
 6ozju9EbVXyZpbknCbx4No7VuT8OKUIt/T+BZNKl9WcMKLhOVmw5A+FrbQMp77g+ZK2MhAF68
 fuwr4r96tpwVC1uRUKAQ==
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
