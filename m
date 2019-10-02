Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B29C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 07:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42ADA20640
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 07:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Weo8VMer"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfJBHJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 03:09:37 -0400
Received: from mout.web.de ([212.227.15.4]:54643 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfJBHJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 03:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570000151;
        bh=jxkw9Dh7kqPf1Ul6WSUMtMcrYG7eDvxoRVQBHmzvbaw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Weo8VMerVCxPosIIW9hQg7h1FQOEpGLIIy65d/z5HNwFZGARAkdaTAjX6udt/qLcB
         y8zW0Sl8xW7nlEmfm5xA1yMSzFEz3L3rN6YgnmF//tnI6A+OcqKzdi2ydl0l7Kx6lw
         Dq/CVo4TpfXq8XzTcOsvD7L0zU1HR5NLT1uRPbgk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.73.205]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MVLsk-1idBFp2PoE-00YiI4; Wed, 02
 Oct 2019 09:09:11 +0200
Subject: [PATCH 0/2] Coccinelle: Extend directory hierarchy
To:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Martijn Coenen <maco@android.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Maennich <maennich@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Yue Haibing <yuehaibing@huawei.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        kernel-janitors@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20190928094245.45696-1-yuehaibing@huawei.com>
 <7664d59f-78cf-7644-0ee8-304b3d78d752@web.de>
 <alpine.DEB.2.21.1909291840280.3346@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <d8c97f0a-6ce2-0f5a-74a9-63366c17f3a6@web.de>
Date:   Wed, 2 Oct 2019 09:09:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909291840280.3346@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:U3XGd4SxYMzU8Uy7GzlssdCppS9Def/s8ccinIEu6H2jb5+G9uz
 X9LhgpK4FssjAqedqAgxcdFez/Xwkg7Xwpme5b2Iy0FhZpJmN9tnvE/S3zSrB1Q85+ZvVo0
 SKUCaOd7m+hw9KkCz1xIhlohYfJgjPDOJSlawgYcwdVCJJuxaUvBAWChgsnKrKjqxrnoUYN
 xb4up5h7LuJxDHGporg0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qgk1VE63eFU=:QsOFnh9PWLU6tNZpDfA8XU
 /lBnIrZzqaQ9siv/f0vE5GpPtZnAanjhVxg/Khn0mS4/5y6UXObAjTl2s1B/mfcA4t7PrLcgB
 TKXylQO29/Z8gN9NuK9cFCjvu4YL2T8mpo4C421NtxP9Mc/AA5HWxX6RzCGuEx2yEj/EV753e
 RuWLt1GMA6GQZdicMERhN+4FiknQCLE80/UAsv21JT/zwgCH+N9F3bRnhc0UMiZvXX+DXl+aw
 lIqeUM99lLHB92IM9wPHqgw0/lL1JzXMjpvZ7bEcvBXYaEqg8gfZ5S9AGV9wHLzN3Hh4yqlSE
 gLvWznpWRryDH59uhPKGmnVhf95QZVcx2hoi6X9EOoFYNNm1BhOlonPh30IhyR019W1mMCzNc
 xlqEgWYn3Wyb77hyYJX/fA9CUMPZkvA+XgqtFjidBBTtVR+hV0CVaOZ74KlFbk7M9M3dIyPsT
 ftPsEdN3dpoJXLfhMcfSmg26C2k8Sz78nkRT9SSP7uACnBOCSJoPmTlWRZkYo/S4UpLby21wy
 7Hww0hTzVb/B+lDD3vp8LjwK5BKFlG5zBMHz2++IlwgrCOLNEa/9T3B9O6QeInNKMjWYPwEJ7
 mF7N2kGiTYZFYQbHfrPPAOMF+rcSkae5fd+pQV0nadOHU3Vf/9V9UtDMn7+LylT9zeIROzxrw
 n+VWd3USG31qUZVPg0xXct6v3qgBKMxACz19SeU6EGWcnpO4MJuxiwsi9Sy7TCd1vPlPMiY/I
 /KPI+bowuX9yNaNB8briiS2Su93ZITckBq1Mc83oi4n87O0k/lky7C/tfMjXUOr4TiX5+t+t6
 BcUVTUv5CF5tK4agqftoFhOLQV/Q3SCorKwPHZAMWls8vx/qS9951LmqABhlx2ACewu03XkCJ
 x4waGTDqVkI9OoNw8/m6OMH4RFq4wlPQDabTXX8lR0IyPxmXWNjsGx4bYysfYDxt/oFehEIgH
 m2cPacidwHBnOueuGYjHfSDjU5t6ViS/k9Vj+J+deYOtRqfZJswxm8KqMjeqc2px3nUNAIR2B
 OEeMcATNUA5VByEhhyyBj9ufongXtn1DBMU0hH7+zxoEdrpxt6trKu3BmRg2QxoPk43eAW7PF
 uTo6VMUKLHozCxskgdUMdT44eOk2dEfVTAJFKnB7r8ukrDJ2z6o3Es7BrhDnnxCJtDyPois7y
 1BS6boIydMhCKQi4OmCj3t58Pg8/PUqn/9lGwLE/TkfBZ3JRrQ+Zjf3uach/alk0JrUfi24yU
 AqjttPBz+0+bqcFX26up34NSM2Bm7ZeglhbNAuz3JPFh+px5GxAqBUGIGdng=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 2 Oct 2019 09:05:09 +0200

Introduce a specific directory structure as a fix for a recently added
script for the semantic patch language. Pick this opportunity up
for another collateral evolution.

Markus Elfring (2):
  Move the SmPL script =E2=80=9Cadd_namespace.cocci=E2=80=9D into a new di=
rectory
  Move coccicheck directories into a new subdirectory

 scripts/coccicheck                                              | 2 +-
 .../{ =3D> coccicheck/default}/api/alloc/alloc_cast.cocci         | 0
 .../{ =3D> coccicheck/default}/api/alloc/pool_zalloc-simple.cocci | 0
 .../{ =3D> coccicheck/default}/api/alloc/zalloc-simple.cocci      | 0
 .../{ =3D> coccicheck/default}/api/atomic_as_refcounter.cocci     | 0
 .../{ =3D> coccicheck/default}/api/check_bq27xxx_data.cocci       | 0
 .../coccinelle/{ =3D> coccicheck/default}/api/d_find_alias.cocci  | 0
 .../default}/api/debugfs/debugfs_simple_attr.cocci              | 0
 .../default}/api/devm_platform_ioremap_resource.cocci           | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/api/err_cast.cocci  | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/api/kstrdup.cocci   | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/api/memdup.cocci    | 0
 .../coccinelle/{ =3D> coccicheck/default}/api/memdup_user.cocci   | 0
 .../{ =3D> coccicheck/default}/api/platform_get_irq.cocci         | 0
 .../{ =3D> coccicheck/default}/api/platform_no_drv_owner.cocci    | 0
 .../coccinelle/{ =3D> coccicheck/default}/api/pm_runtime.cocci    | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/api/ptr_ret.cocci   | 0
 .../coccinelle/{ =3D> coccicheck/default}/api/resource_size.cocci | 0
 .../coccinelle/{ =3D> coccicheck/default}/api/simple_open.cocci   | 0
 .../coccinelle/{ =3D> coccicheck/default}/api/stream_open.cocci   | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/api/vma_pages.cocci | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/free/clk_put.cocci  | 0
 .../coccinelle/{ =3D> coccicheck/default}/free/devm_free.cocci    | 0
 .../coccinelle/{ =3D> coccicheck/default}/free/ifnullfree.cocci   | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/free/iounmap.cocci  | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/free/kfree.cocci    | 0
 .../coccinelle/{ =3D> coccicheck/default}/free/kfreeaddr.cocci    | 0
 .../{ =3D> coccicheck/default}/free/pci_free_consistent.cocci     | 0
 .../coccinelle/{ =3D> coccicheck/default}/free/put_device.cocci   | 0
 .../default}/iterators/device_node_continue.cocci               | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/iterators/fen.cocci | 0
 .../coccinelle/{ =3D> coccicheck/default}/iterators/itnull.cocci  | 0
 .../{ =3D> coccicheck/default}/iterators/list_entry_update.cocci  | 0
 .../{ =3D> coccicheck/default}/iterators/use_after_iter.cocci     | 0
 .../coccinelle/{ =3D> coccicheck/default}/locks/call_kern.cocci   | 0
 .../coccinelle/{ =3D> coccicheck/default}/locks/double_lock.cocci | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/locks/flags.cocci   | 0
 .../coccinelle/{ =3D> coccicheck/default}/locks/mini_lock.cocci   | 0
 .../coccinelle/{ =3D> coccicheck/default}/misc/array_size.cocci   | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/misc/badty.cocci    | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/misc/boolconv.cocci | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/misc/boolinit.cocci | 0
 .../coccinelle/{ =3D> coccicheck/default}/misc/boolreturn.cocci   | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/misc/bugon.cocci    | 0
 .../{ =3D> coccicheck/default}/misc/cond_no_effect.cocci          | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/misc/cstptr.cocci   | 0
 .../coccinelle/{ =3D> coccicheck/default}/misc/doubleinit.cocci   | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/misc/ifaddr.cocci   | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/misc/ifcol.cocci    | 0
 .../coccinelle/{ =3D> coccicheck/default}/misc/irqf_oneshot.cocci | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/misc/noderef.cocci  | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/misc/of_table.cocci | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/misc/orplus.cocci   | 0
 .../coccinelle/{ =3D> coccicheck/default}/misc/returnvar.cocci    | 0
 .../coccinelle/{ =3D> coccicheck/default}/misc/semicolon.cocci    | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/misc/warn.cocci     | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/null/badzero.cocci  | 0
 .../coccinelle/{ =3D> coccicheck/default}/null/deref_null.cocci   | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/null/eno.cocci      | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/null/kmerr.cocci    | 0
 .../{ =3D> coccicheck/default}/tests/doublebitand.cocci           | 0
 .../coccinelle/{ =3D> coccicheck/default}/tests/doubletest.cocci  | 0
 .../coccinelle/{ =3D> coccicheck/default}/tests/odd_ptr_err.cocci | 0
 .../default}/tests/unsigned_lesser_than_zero.cocci              | 0
 scripts/coccinelle/{misc =3D> direct}/add_namespace.cocci         | 0
 scripts/nsdeps                                                  | 2 +-
 66 files changed, 2 insertions(+), 2 deletions(-)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/api/alloc/alloc_cast=
.cocci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/api/alloc/pool_zallo=
c-simple.cocci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/api/alloc/zalloc-sim=
ple.cocci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/api/atomic_as_refcou=
nter.cocci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/api/check_bq27xxx_da=
ta.cocci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/api/d_find_alias.coc=
ci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/api/debugfs/debugfs_=
simple_attr.cocci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/api/devm_platform_io=
remap_resource.cocci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/api/err_cast.cocci (=
100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/api/kstrdup.cocci (1=
00%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/api/memdup.cocci (10=
0%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/api/memdup_user.cocc=
i (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/api/platform_get_irq=
.cocci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/api/platform_no_drv_=
owner.cocci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/api/pm_runtime.cocci=
 (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/api/ptr_ret.cocci (1=
00%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/api/resource_size.co=
cci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/api/simple_open.cocc=
i (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/api/stream_open.cocc=
i (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/api/vma_pages.cocci =
(100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/free/clk_put.cocci (=
100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/free/devm_free.cocci=
 (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/free/ifnullfree.cocc=
i (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/free/iounmap.cocci (=
100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/free/kfree.cocci (10=
0%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/free/kfreeaddr.cocci=
 (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/free/pci_free_consis=
tent.cocci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/free/put_device.cocc=
i (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/iterators/device_nod=
e_continue.cocci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/iterators/fen.cocci =
(100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/iterators/itnull.coc=
ci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/iterators/list_entry=
_update.cocci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/iterators/use_after_=
iter.cocci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/locks/call_kern.cocc=
i (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/locks/double_lock.co=
cci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/locks/flags.cocci (1=
00%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/locks/mini_lock.cocc=
i (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/misc/array_size.cocc=
i (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/misc/badty.cocci (10=
0%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/misc/boolconv.cocci =
(100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/misc/boolinit.cocci =
(100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/misc/boolreturn.cocc=
i (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/misc/bugon.cocci (10=
0%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/misc/cond_no_effect.=
cocci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/misc/cstptr.cocci (1=
00%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/misc/doubleinit.cocc=
i (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/misc/ifaddr.cocci (1=
00%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/misc/ifcol.cocci (10=
0%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/misc/irqf_oneshot.co=
cci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/misc/noderef.cocci (=
100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/misc/of_table.cocci =
(100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/misc/orplus.cocci (1=
00%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/misc/returnvar.cocci=
 (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/misc/semicolon.cocci=
 (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/misc/warn.cocci (100=
%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/null/badzero.cocci (=
100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/null/deref_null.cocc=
i (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/null/eno.cocci (100%=
)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/null/kmerr.cocci (10=
0%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/tests/doublebitand.c=
occi (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/tests/doubletest.coc=
ci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/tests/odd_ptr_err.co=
cci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/tests/unsigned_lesse=
r_than_zero.cocci (100%)
 rename scripts/coccinelle/{misc =3D> direct}/add_namespace.cocci (100%)

=2D-
2.23.0


