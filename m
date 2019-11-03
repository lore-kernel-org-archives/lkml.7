Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD856CA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 19:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40BB21744
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 19:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="U0Wl20M9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbfKCTac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 14:30:32 -0500
Received: from mout.web.de ([217.72.192.78]:55033 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727913AbfKCTab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 14:30:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1572809410;
        bh=VRMNp6FcxWTOLyexVDAlmVMT6DC2B/lpC9KicmUfw7o=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=U0Wl20M963zG+qRj3e43MA42Ql3tM443knYRivpEM2DOR/CJkfYvQR0y1a6Bm70V0
         Xf+TwcpdQF1yPq40gAmRXhxVNYY76iY0lygiRXUrSN7FqbA1n8Hu5ClG4kTArclh0k
         AP1PR0Z/NBh+YYx+mvE0vDWDJbt5zaLOgtX409tQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.72.216]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M89z3-1i5IUF2qTB-00vf8h; Sun, 03
 Nov 2019 20:30:10 +0100
To:     cocci@systeme.lip6.fr, kernel-janitors@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Enrico Weigelt <lkml@metux.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Thomas Gleixner <tglx@linutronix.de>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] Coccinelle: zalloc-simple: Adjust a message construction
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     LKML <linux-kernel@vger.kernel.org>
Message-ID: <042136cf-4e58-02bd-4d49-5d5055f22c65@web.de>
Date:   Sun, 3 Nov 2019 20:30:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:je4RSahO16yzLyydkp/2fMZQUZGxJJcj9rmzwYrhoLI40i32n+r
 X0VPB03AjbBqnUXGnG5UuZ1fKOC4oe2TjyFT/WVbehx3KaYwSKUeR26cbxWpMGTumQyIrO2
 M7R+hou3/v6CcX+F+g95VvRJ14HEMoO5+QhTKdpB7xoDDro2eMlL53xBO57M5kDmDGYYDkX
 JBIpRh+UviLMK2NWVTvgA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z1uZZJKFNos=:D9DpBBG/wy2pNK+7+J/qNc
 GL/HARIuXvz3Iaiu9anoIQA/P8M56RNYcmFVvFksYUT2qDKTbeTwEmRCKlx1FKnjBcYy+0zAK
 uDXTW8yunbbv2bMt+2ZBmVO8WUZuWQ6eMeQDltI41hYIL+xQ4jdwcrIgwVCQExYFgldC3xQe2
 gmaIDq2yREpQtYEFNMsP5P/QSy3p9VM86psQQKqJ7M9PUwjSq+cv0Exr8u95bLD55FemkLPW/
 QSO1AXvFJ9JOp7Z+NzPveVCXcpIkt6+ttj5FzPh/A/lKiGx0tWhI31gDZLuTUP7qH8+foFMfp
 JEWwzTDu/fa7hgN7/YbN/ASiHM2dh52h0+enPZ5atTia+FlNbbFt/N3Ao+B7D0uoTG+Jq6nLE
 OW5huBNkRB9zYI7AKrgsl0pNpCMh9HqxVYue4li6XE2T25A2q2HAu9dXK0e3jFhkpI17AbiiW
 KNsWohBqlnSZUO0AtCD9PCPQeweHpcYTpksPSXifPvd1Hb0ZjsNkeiDKgzl85O/oxjNfGionF
 SQkHB3RIQWJ32S40QUNmvLBksQCzIcY8itd6EpJigNsp2I/QY+gUl420aD9SiaWBXM2LBoNTt
 J+wQt/hREf8Rxjcfi2QMYki+ZpBkYy8ukBon2Kr8Eo6Fpp9UTbqSKl0tBPXbfS3DThLkaV5Np
 XuuaQVbjzMnhuHmCx41A7o+mxkhQkjsoIh9YqP0WEY4nxLgOzCN0/6GGiJv7wivXqImqSCvYo
 2qPFjz+ToT3SaKmE8hPLYKLGRnEukREr3nofDZnhQ6Yi0hwGNFAsUw+lK9UiIp9UC5a2ncUjt
 cXZTW1E6WnUC9T7PoFVVaxNsIJKwCqmI+v0kPtQX1a+W0xuwQA6Ngt1L6c0hq7HmAfogPNdbK
 tqJoV+XKc/s5qLfhuFScNOl13hpzi2a8mGpX6VEJW5QGvTH7rIH/816EO8hQT5SaFdgHJdEiC
 kvWfUZl8H7bmYW7SWxdkVU75nudi5cRRbTbqUJjOY7wGTs+hwuJ4tY2QJX8XdqHeSHJpkU9NS
 kfu5Lj4YcdSTCZsQ6g7Y1pCcwpmaqupCTZ6SdzeHnvB1sBtKe/o9E2ymXsPB+JIkuNYYWqW/P
 jUAV/UhS2qKPBxtOoad8FgAcBjfZ2r1Pv9ybCBE69MXE5inTTQqaT0X/tgD2EKyYCjwvTWR62
 2pjeDXbsrQMMSjjaTvpnIbk5Tg/EM2XqF3wGFdpiF8GO52EJcCaoN1B2nfbHB8Ie3aLJdIvo0
 UrI/sP+Sgt86x2BjnnZ5hsh6C19ACEx0aS3IewsnB0wLnrNy77B3R4JwIrpI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 3 Nov 2019 20:00:30 +0100

* Simplify a message construction in a Python script rule
  for the semantic patch language.

* Delete also a duplicate space character then.

Fixes: dfd32cad146e3624970eee9329e99d2c6ef751b3 ("dma-mapping: remove dma_=
zalloc_coherent()")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 scripts/coccinelle/api/alloc/zalloc-simple.cocci | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/coccinelle/api/alloc/zalloc-simple.cocci b/scripts/co=
ccinelle/api/alloc/zalloc-simple.cocci
index 26cda3f48f01..c14eae1f3010 100644
=2D-- a/scripts/coccinelle/api/alloc/zalloc-simple.cocci
+++ b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
@@ -217,8 +217,10 @@ p << r2.p;
 x << r2.x;
 @@

-msg=3D"WARNING: dma_alloc_coherent use in %s already zeroes out memory,  =
so memset is not needed" % (x)
-coccilib.report.print_report(p[0], msg)
+coccilib.report.print_report(p[0],
+                             "WARNING: dma_alloc_coherent use in "
+                             + x
+                             + " already zeroes out memory. Thus memset i=
s not needed.")

 //-----------------------------------------------------------------
 @r3 depends on org || report@
=2D-
2.23.0

