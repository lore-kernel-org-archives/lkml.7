Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24975C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB9DF20850
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="inf+nl8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfENQsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 12:48:42 -0400
Received: from mout.web.de ([212.227.17.11]:59027 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbfENQsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 12:48:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1557852500;
        bh=qPRDclKWLr4lyBo4BDHe8YC1/qFNclCth5wfnoNSOSA=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=inf+nl8j2dH/j2pQX1wEdcE//KPuXDNYBiifeiiylPH3lL5J5o7Vc5uHcuTc9QyBT
         sTsIMBYjcV7GZdyeo/OX0ccRSnMIXd6klT1rRKlW/e3rVqXAixzLb4lIeWC0RrrNdg
         8LIxDvVYNkd6MRbqf7aVKfW7DB7NxdzhQgaiHmco=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.122.180]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MbQOe-1hA1eS0vYa-00IhvQ; Tue, 14
 May 2019 18:48:20 +0200
Subject: [PATCH 1/3] Coccinelle: pci_free_consistent: Use formatted strings
 directly in SmPL rules
From:   Markus Elfring <Markus.Elfring@web.de>
To:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Wen Yang <wen.yang99@zte.com.cn>
Cc:     Coccinelle <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Yi Wang <wang.yi59@zte.com.cn>
References: <e30b9777-6440-b041-9df9-f1a27ce06c6c@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <a91f9a9b-57be-59a8-1755-37936512ff20@web.de>
Date:   Tue, 14 May 2019 18:48:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e30b9777-6440-b041-9df9-f1a27ce06c6c@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QRBx1IBclryj4Qq+8nzvCHNrTNzgL3iA9Tq3fVJ8slY/WF989bS
 HEVGWOw0X/WfmbruvCyIv+XyqSoWOWn5Efyc+gBmShbTCJ910rQTXHUf4/s4FQu7Kh8r3jp
 8eOXkNIbD/GJ9kLHjODAAnUadEjTA00D9kVoJYySwHxhsG5f1G9XtgcH7PbMBGIY3i3W5+7
 JzwrCC/De1fffX2f3o1fA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aDcyGZmwSOY=:ftrzw8FyBsz6XW6XOwkdEo
 3KJX+5VUcYNTh8qgox3SusotVQ/h4EYHPb0DUvLTC6JnsY9UH5LOQJxFKGrXuG4k0eXr/ljqN
 DcRWfxtnQ9HXaiAaj5YL4NSGro13No1pP4nfqFUJ+Vov0DKYGfGVQAyXtU+CJu1Hs+zgpJ/nG
 ADuhBXH0+hExa0xN9kHeHv3ISR0bt29I2qAGXqgaazqRcM2tflm7tqJ9jLmQyiUjL/xIyKfAQ
 j1ERTcHUwAplnAg21VnQf7pQLr9sjfj87VTAKAMv3SqQC6EOdgnIQVdwQ3h4LAoMLQ2coixNj
 mOQ84Hz6XKQptpSg7auZPId84enLSY4nu2X/W0IDG5KGFHgHv6rHfLH7gabP6f/Rt6fDqvtzU
 dqrq1SX2EedjeTiNjD/E463bzrquyfMKgqHwrvz4gMEbNL0Qw7LJfxNE74UcXJdP7HGW9kDwH
 kuLcfedlY9JnqcsKPQznL4ReqSk40eJeEpjjjsjxtUQRymZtdq0lB3HY48iyuUZxLCcz6mUB3
 4+NM8vcGFsUpE/oUcsfhZoucvuGx6Knx3+Ps12o/AokhzA0R5p8eHlwDim45YTqP+saOCSMfM
 F3ErJ5YBpRH8a/BcD+jMUspwDGpKQi+k985Dgpb85roJhLQYeFkk5C+eJRf2WN5jULKk8GTO8
 x9MNqCpD/wKHmkE72TCzLOyg7q7WToApUgSuL7f6u4CQZ/DjDrW/s+YfI2d8Y98JE/6tX95ap
 aHTa56COk/8FQw0X78Lk79lJ1rhfAGVQvWLPzkfuynRU0dXnSS3MWR2Qgi5XI2biQ2YLpK2DW
 rty9FybEYoe2yB0aA1YZDBsr+vPmoTww854zBMWTINysqfDhqEynNRZPvtGVSFfca8isuy9z9
 SondxUJXlLTaLPkxJoY1Q48hoVBKOi7JYOVHbcwgEVI5BuLUqu/SQDbdn0iGJIg+JC09Tfgdf
 z5AvtWSQVEA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 14 May 2019 16:54:40 +0200

Formatted strings were always assigned to the Python variable =E2=80=9Cmsg=
=E2=80=9D
before they were used in two rules of a script for the semantic
patch language.
Delete these extra variables so that the specified string objects
are directly used for the desired data output.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 scripts/coccinelle/free/pci_free_consistent.cocci | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/coccinelle/free/pci_free_consistent.cocci b/scripts/c=
occinelle/free/pci_free_consistent.cocci
index 43600ccb62a8..2056d6680cb8 100644
=2D-- a/scripts/coccinelle/free/pci_free_consistent.cocci
+++ b/scripts/coccinelle/free/pci_free_consistent.cocci
@@ -38,15 +38,15 @@ return@p2 ...;
 p1 << search.p1;
 p2 << search.p2;
 @@
-
-msg =3D "ERROR: missing pci_free_consistent; pci_alloc_consistent on line=
 %s and return without freeing on line %s" % (p1[0].line,p2[0].line)
-coccilib.report.print_report(p2[0],msg)
+coccilib.report.print_report(p2[0],
+                             "ERROR: missing pci_free_consistent; pci_all=
oc_consistent on line %s and return without freeing on line %s"
+                             % (p1[0].line,p2[0].line))

 @script:python depends on org@
 p1 << search.p1;
 p2 << search.p2;
 @@
-
-msg =3D "ERROR: missing pci_free_consistent; pci_alloc_consistent on line=
 %s and return without freeing on line %s" % (p1[0].line,p2[0].line)
-cocci.print_main(msg,p1)
+cocci.print_main("ERROR: missing pci_free_consistent; pci_alloc_consisten=
t on line %s and return without freeing on line %s"
+                 % (p1[0].line,p2[0].line),
+                 p1)
 cocci.print_secs("",p2)
=2D-
2.21.0

