Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D68C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98AB424651
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbfLEJUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 04:20:24 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:43899 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfLEJUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 04:20:23 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MvbOA-1hnRVS2dXy-00shdj; Thu, 05 Dec 2019 10:20:20 +0100
Received: by mail-lj1-f182.google.com with SMTP id k8so2695296ljh.5;
        Thu, 05 Dec 2019 01:20:20 -0800 (PST)
X-Gm-Message-State: APjAAAV5fJCBQXZGa/IyaFH1RzLYZJgyw45LQ0+GYyESR3MfQ/uX7fSG
        RloKZTcZ4teIBZnAPPV5BSvOjksQ+Q7vbm6Jd9c=
X-Google-Smtp-Source: APXvYqyjJLPJbK8gwXSDuvn3GZ/tree67o/t4z3NDcf0HoGomQWms/b0prq6/vhw/St4hu+Hv06T5yJlSqWATXj9jKs=
X-Received: by 2002:a2e:2e14:: with SMTP id u20mr4891260lju.120.1575537620116;
 Thu, 05 Dec 2019 01:20:20 -0800 (PST)
MIME-Version: 1.0
References: <20191120154148.22067-1-orson.zhai@unisoc.com> <20191120154148.22067-2-orson.zhai@unisoc.com>
 <20191204163830.GA25135@bogus> <CAK8P3a3_r6z6Qk133=4gUzJ0rYmMH7sDDqpEF8ZVXS_bc3OtkQ@mail.gmail.com>
 <20191204192639.GA15786@bogus>
In-Reply-To: <20191204192639.GA15786@bogus>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 5 Dec 2019 10:20:03 +0100
X-Gmail-Original-Message-ID: <CAK8P3a165hqB=5LmMiTPGJxvsSJqrbFf5EC9WnqtFRYFok+xKw@mail.gmail.com>
Message-ID: <CAK8P3a165hqB=5LmMiTPGJxvsSJqrbFf5EC9WnqtFRYFok+xKw@mail.gmail.com>
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
X-Provags-ID: V03:K1:LHz0yH4fdO9sf3twMuV5zLykz0PPjw4OhPwNV/ocUK8cbH44pbc
 +UQAT3sBdZmlDaV/3hRN8+E15Onvoi1eIG4LRjeIqYb5B5zQLVO1QQYNsE7cs0jxameqfeL
 k4mZ3mbU4xPz6Ofyx2OcwEY+WxO30ZhyfMuPXWvWDfLE/WWpDRsJNp+Pn10TS4x3MlOM+f3
 DINPeZRLUZe1mmJbcJWvg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4U2sAcSyTeU=:7oWJh6/Qw25sxA27ghOnLx
 vfcpBA7ZHIQwD489ALQCwkxxhNsoLyYJxeeYNTf132hGGkyXJYdHTuA1107sO0QoUahCKW1NK
 H6V7TnuCzXxfUNk7aO54vaoqnXBLGWDttJZykrwuaOsLBR908Hn9H7z8Wd1TMdECS8N6en9cc
 njWmrtNk2k7R+yLtJzkqmN1hkp0fSaJjIuUT3IzY+8kEgeCYG0DNx/ULiOOim4DDigDOrF3AQ
 zxqaW82ckqVg/jUwHFvO6y9kDrIzBxOQwX+q8SEH+uEl/Kllwfo7Y3kslqYt2UTKhzML3Lviw
 qyI6/z1DpVwaLkgaGh896wbgByxqSId2ox7bFaCVitySDKiIhVB9wMO0Gta83jGBGwXBIrzv9
 vh9Utvq1QpCvXAIs/IJGTZgEn4k7t+Qlbneyz2rAJV21gb3d9czekugGKbIXB8CBIRMPkPbeY
 nHTuCapiJ+GUYRgS8r+rcHRglY515G86U9jP/NLBUw4iYewdCIJI0AU/r1WeKnuufG8aUab6n
 kVsNwRYDLWpt/iL21brTfSil0H4ynmmuvcWSYDjfCKQ0ZRWDZmUusMEj9/xDST1/7sFX2Bryc
 b4qHZ50H3GdaTVh8TTihW9kbeSdj8Lc1rpFKMDFEtTs/lKnW2rozBMlYMpMIexGFynuBj4ZMA
 eRhOs9gmxbmGF4/vdu8F4C9UNd16P4AfS0oyVXGqtJj0pD8XdkM0v+g6Qd4jJR/sF2/0qYq74
 CkDHFKd89UM87JKgWygkDYtKa1CK/v2pe3nHhjoDtvpW9QV4U4eYGzCTEbIqzo4gkEucFloEN
 qzJA55FWIHm+4t1QhqWnJHF6kYizaJiKp6PwvNtT1xarDrip8j4a0kTvA5lyi5qd80HXYWX49
 QjDyGpiHstVy0cYFqM5A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 4, 2019 at 8:26 PM Rob Herring <robh@kernel.org> wrote:
> On Wed, Dec 04, 2019 at 06:00:17PM +0100, Arnd Bergmann wrote:
> > On Wed, Dec 4, 2019 at 5:38 PM Rob Herring <robh@kernel.org> wrote:

> > I think generally speaking this would be useful for random registers that
> > logically belong to one device but are grouped with other unrelated
> > registers in a syscon, and that are in a different register offset for
> > each chip that has them. Using named properties instead of a list
> > of phandle/arg tuples with names is clearly a simpler alternative
> > and more like we do it today, but I can also see some API simplification
> > with Orson's patch without the binding getting out of hand.
>
> I understand when a phandle to a syscon is used. That's nothing new.
> What's special about Unisoc SoC that needs something new/different?
> I saw there's a large number of syscons, but I don't understand what's
> in them.
>
> If the API is this:
>
> struct regmap *syscon_regmap_lookup_by_name(struct device_node *np,
>                                        const char *name,
>                                        int arg_count, __u32 *out_args)
>
> How is 'name' being an entry in syscon-names simpler than just being the
> property name? The implementation for the latter would certainly be
> simpler.
>
> It also makes the property unparseable without knowledge outside of the
> DT (i.e. in the driver). I suppose if the number of cells for each entry
> is fixed, we could count the number of syscon-names entries to figure
> out the stride. But then if one entry needs a lot of cells, then they
> all have to have padding cells.

Good point. The syscon_regmap_lookup_by_name() interface would
work just as well when passing a property name compared to
a name listed in another property, and this would still be more in
line with what we do on other SoCs.

The only advantage I can see in having a list of phandle/arg tuples
rather than a set of properties is that it is a slightly more compact
representation in source form, but otherwise they should be equivalent
and agree about this being harder to parse in an automated way.

Orson, do you see any other reason for the combined property?
If not, could you respin the series once more with
syscon_regmap_lookup_by_name() replaced by something like:?

struct regmap *
syscon_regmap_lookup_args_by_phandle(struct device_node *np,
                                        const char *property,
                                        int arg_count, __u32 *out_args)

         Arnd
