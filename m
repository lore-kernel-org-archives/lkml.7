Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660FBC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43019214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbfLKNz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:55:59 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:45259 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbfLKNz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:55:58 -0500
Received: from mail-qk1-f173.google.com ([209.85.222.173]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Md6ZB-1i6Wvn3d47-00aFjS for <linux-kernel@vger.kernel.org>; Wed, 11 Dec
 2019 14:55:57 +0100
Received: by mail-qk1-f173.google.com with SMTP id d71so11713286qkc.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 05:55:56 -0800 (PST)
X-Gm-Message-State: APjAAAUuOFK1t2HOUhkNkriQn9ta52MJfHTSbbEhT1fnCzjE68uqyuXw
        UCCLUEbPsbPh2wdM4JjJSXGcMtFc00KgJpVSshw=
X-Google-Smtp-Source: APXvYqwkj0Y4telhppR+31EJzP7jTUrHkTicjXfvcF9Du+7uGaWNouHVD8hkPwz30lcWbjG9P0TUbZveEDCO79FmoTk=
X-Received: by 2002:a37:4e4e:: with SMTP id c75mr2897643qkb.3.1576072555791;
 Wed, 11 Dec 2019 05:55:55 -0800 (PST)
MIME-Version: 1.0
References: <1576037311-6052-1-git-send-email-orson.zhai@unisoc.com>
In-Reply-To: <1576037311-6052-1-git-send-email-orson.zhai@unisoc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 11 Dec 2019 14:55:39 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0244jKrEop2rHVyJZ57h4A9+mqb-5g-wLUSfR2G1svwg@mail.gmail.com>
Message-ID: <CAK8P3a0244jKrEop2rHVyJZ57h4A9+mqb-5g-wLUSfR2G1svwg@mail.gmail.com>
Subject: Re: [PATCH v3] mfd: syscon: Add arguments support for syscon reference
To:     Orson Zhai <orson.zhai@unisoc.com>
Cc:     Rob Herring <robh@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        baolin.wang@unisoc.com, kevin.tang@unisoc.com,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        liangcai.fan@unisoc.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:z+tgDU1td1bvn/8N9qw0Vs2R48lNvgdZS7SscmRfo5/3bYZHor4
 pbnVLcbf6I0YSVcw7JafbopyV6PFHMkKHBFuPV7tJm1/U2+l/004gkBIaliY3blyisQSo0U
 UipJAD+K2c2q0Djk4WkZCRg8n9sAbFY2mHbdlZ37chPUYoK4wGDbjBXj4fRWepTTWc7LTH/
 EFG1xNo8GkBtz1CtJt8tg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nHFyenSwp6U=:TIJpytRAAzXljDNffvMUFC
 HSpovx8Y9BVaPxYHhPS9WP69MedJknD8i/lkTmUHiDr1L6D50EnfxS1mgF1NYxBlZ0ClGwSSS
 Ne0QcS+aJIlTvGKn9hnd8jx0oof2psj7u+EW+8+Uk+tIcr12pQyOpgazsQDEdEhwpXPtTaSml
 k6MbS+91fz4Vs+3Ofny8Yq3cEYY8KCa8Uu7qUpDs8Sb+4sTp0VW8bpviz89/vE0ZWSWxq0D96
 VRGYKPq4NMo0AQHpRx+NLvE6ksr8at5nB4WCCCNnV4h2KU13XGY1/aTXSGLvIM2NG5UOmVzi/
 7jUDkZmS4PKtPJUuI2C/LuZvjLE+Gyv8yAqnqRK/ZiBze4MmSnIASa6S03Bra9OthjKxwhPAh
 roTWmuexpBIM31Z8/LEq5d+ckK+Ld337KdaxU2kasRmZ1GT0hHS4EkJDsGGSB+nScvZxVPdAE
 rycIaa9vdWO7/uTIYI8yMz9u5tfXik96nswU9j2knV6r1p480OmkIj7V0HOuOrv6eF3f9WfBn
 sAyZ4dYigDj8xpWvS1hIGI6lNdinP4npwHLBPC72aHvixmpK+LbH4W0StocyGQzp9RJCImWHg
 6qii+6AYVangDjXCM+yWWUNYeS1xyBATpKfe4QO1qQOdFlT6d2jmd4C/1tlP3a1d/e6vz8XeN
 y6aL7gK3fbnUVTLU8xRVtlvXM88VI++jEQHQ4UGs5uQZCk6QlWZkJXnZBVRBVOJJFlloK5u8F
 IXsiME85xdq8pwnAQiVb13fTKpGVLYLUHWgXWG668d/ApMLBoAh9ycHdFwDO/wPBGJe7Z4RfK
 XmAPaSddxp3tmaSEVFuHAOf0UeINxTprmpo9lAIVXnOB3KNVSgx8B+uKChMhTHKx3sEuyckw2
 I9z5mqFoxZp4Yk/xIw8A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 5:09 AM Orson Zhai <orson.zhai@unisoc.com> wrote:
>
> There are a lot of similar global registers being used across multiple SoCs
> from Unisoc. But most of these registers are assigned with different offset
> for different SoCs. It is hard to handle all of them in an all-in-one
> kernel image.
>
> Add a helper function to get regmap with arguments where we could put some
> extra information such as the offset value.
>
> Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
> Tested-by: Baolin Wang <baolin.wang@unisoc.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
