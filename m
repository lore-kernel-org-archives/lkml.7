Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D22C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1652089E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="UMm5bFrH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387588AbfGaGp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 02:45:28 -0400
Received: from mout.web.de ([212.227.17.12]:34283 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbfGaGp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 02:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1564555495;
        bh=Kc2lJglxBeibyF9vhLafDnzZiAHverCXaTrJlWT2zg4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=UMm5bFrHu1ORQExz3uo17Ww9BmCc4U8HHr6QIvXgaG+LHzR8buVSrjpne+ulNZl5/
         ziky/0ehDl+Acz561pZLiD3wUwgYXjQPuGa9C1CmYHM152lt11OQvPbkD8z/V2VWjP
         VxyMy2icuCIv9l3lzV7klKDBIy8bdNnsiaO4J7o0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.180.205]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M5fsK-1iH5nq42jA-00xaP1; Wed, 31
 Jul 2019 08:44:55 +0200
Subject: Re: patch "coccinelle: Add script to check for platform_get_irq()
 excessive" added to driver-core-next
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        kernel-janitors@vger.kernel.org, cocci@systeme.lip6.fr
References: <156455237123959@kroah.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Rob Herring <robh@kernel.org>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org
Message-ID: <00bc6fea-f505-56d2-3803-1ac0882436b7@web.de>
Date:   Wed, 31 Jul 2019 08:44:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <156455237123959@kroah.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ui++1DX+81fq8mlmhBlGylfsX9LPs3RoUHUA2iHD+YfDzOBIxrq
 5tm9WX+ZOsMTGHlOd/KKbzcOkTAtPZ8K42WI/QPCCSOnfyJutzOSgUm97ZHYsMMwjVb+GXB
 K/70N/AO3If/beWfO2ORAVA6gggXloxRKPiLmwAZiibliRefDC0KXrQntGQIe33fmxUJsnA
 1P+/YDJXjZyx232Kyd9RA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iINreL36Bv0=:9FZ7KTYEBI0TAmPt89fUWl
 P1EcC1cd6F43qNnx7gFtThai4sj2XRSLXc3LVNia/af/C2luNb/CuVzpdz8pH+bwcXpMAvDMv
 n7Spjiz6RFypxplWyI7mew96uofSIaBJ04vPKrn/9VPHJQpEWTBSKkRl/juQnVecq+sUWDNFk
 JSXaLxmvB1/6zAw1DDtBZIBWZdjPhm/qB8SxhWWt4pWWsVNq8hxuTQ8zB/G1mxgZ9KxsDi28Z
 c6nAQs7VMaryRr0DG7FbI6zMEbaygxzW6/eiYFncN8hkHTZGSoFGTWpyAaoUEFMb2uL+w+lDF
 DkdsbUy25rD5rWglniyb7p0vceI7KCghP12FIBmqEmcj1M38Kwckt+CjTnlvJVFBBoEnP4U+I
 vSwG2J8/OrL1yRNET2wU5g4pgBOD86HcRMRaJLwR+bfYR6njPVUn83MZYWujj56h7wzXjp35f
 80imUOhpO7gmTsA7OMcZi7t2ptfK7deLxV60EBqXhd+zTZ45SJChlc06mijcEthaSxbWjw0vl
 5E0RpBAJp/jk8B7mNL00Z/vrOz5tN1g4nsWKMFf4zh22PlX+sbnY3CqNsNRlm3kkuqkHcAmog
 0fRWWNrRGozaTAGooqRuAhUKO6gXbMizGmShEMlBemcV+15iX7cyDFhnXGViSvKeOhmF3ak2y
 C0K61c5TfEFmvEQzK+U1TIRDoD0uLMRbTaX7mL550tWmipUTftd52OXEdey5xFMdRD6wIkqRh
 Cfo2jYMuEmnl0aUKfvv+37nx+ZmKDnWCWwGV08QdzUOQs1qYhkgp1+bsmS3RP672+ZqdXkORI
 pESp/CW0DEd8mkmPGZ2bPPWQfaHELzq3ibMXDgqb5vkchL9adDYfEwFzA8RZ2m7HJA3IDHUph
 EZid97Ph92GYkhm5JDyupWFzn05I0RFClKXub3s85LlnpTFA/vEsKp1NtAZ+zR81qgQobeA+G
 idaVUgg7H55K5rE/omTZRwGO3Sn6QPgG4Uw7+4XFqztrPCRfCylC6dMVRzgaTLEPN/+oMKD2K
 TDZvWJGzYXMi1je50VbKY4vFRIk+X22VDteOUxP+Qn03mTcE9ny9trKVeu7K0Atx/70/F6ipu
 zm5KiekQV6+RAojvhKMc7rW2Bf8WKEOuU5e
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is a note to let you know that I've just added the patch titled
>
>     coccinelle: Add script to check for platform_get_irq() excessive
>
> to my driver-core git tree which can be found at
>     git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
> in the driver-core-next branch.

I find it interesting somehow that this version of a script for
the semantic patch language can be integrated already in this
development branch.


> The patch will also be merged in the next major kernel release
> during the merge window.

How much will questionable implementation details influence this process?

Regards,
Markus
