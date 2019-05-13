Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C94C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10732146F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="pDdjZShU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbfEMJBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:01:54 -0400
Received: from mout.web.de ([217.72.192.78]:47381 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbfEMJBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1557738091;
        bh=96bUbooF3B+8sxLuYsK0EdpTwFO/C05prC37Xuu/ldo=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=pDdjZShUPUb2gQTjw4buTsUbRVN4s/tQ89LefGeHVyRlNNI6nN9WOr5x3YCMOo9Bh
         J9SaxhkJ5uUq1YSijXNJCeWdq0SzPWKnvUF87rK8iaU58ECgcqm6ga3v238cxym7EG
         ZTIa8WilYareBbwhWlqZfsvxF6fwyMZ+uYdkLBJY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.135.147.80]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MOAnY-1hMnSJ2y0q-005YJW; Mon, 13
 May 2019 11:01:31 +0200
Subject: [PATCH 2/5] Coccinelle: put_device: Add a cast to an expression for
 an assignment
From:   Markus Elfring <Markus.Elfring@web.de>
To:     Julia Lawall <julia.lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Wen Yang <wen.yang99@zte.com.cn>
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        Yi Wang <wang.yi59@zte.com.cn>
References: <1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn>
 <e34d47fe-3aac-5b01-055d-61d97cf50fe7@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <07e17d87-09ff-311f-015c-d201df053f56@web.de>
Date:   Mon, 13 May 2019 11:01:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e34d47fe-3aac-5b01-055d-61d97cf50fe7@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Vo1rukVlSGnUbTQVJ3lRvPy0SUDu7tTrElvBlW1phdO7awQu0SJ
 l0VOuqvgcUWZx+wZMH9hxPyiThpJSRRfykY/BK+95vofZ1PweZj/UAYndLr16t7ToPrek+D
 N5ns2tzQFwHFqTN4nlnTJu2BKHpl2wna3fNRjE9Cpw2lFWWdFxqlfMBezr/2FDoa63PUWtC
 pQeQZCeIHrmfnvYpgG5AA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NKbfPHAGwVg=:8y3nQkjzAz8Xup55iVwCgv
 mMOcm3xi+OokDga40dIlZ9yDMmkxVxCbL5x6OfBrBkVpWlErPHWT6ic6gPHUdaogfbC9S5oHu
 ZChMlPVOJbScW8LNk/Jf47bZQ8+TpeQmfknIvqV9RjM6S3d5pGpQkoYMxSSH+QMgtbllIrpf4
 qxS3IqE93r0EQIJwuuisO597KA27jV6pZ2paB4RALLc0h+0bCenztkRyRAsxRNfwRQ9uvdOEn
 bchK2WQH2UQb6h6n9b1XN88rc5RpMxKxlKSOjRdAxmN9DPVAVVK4uzblnUG9nEWg3u6subn5W
 yH3rUQAzGCMbZDDQOyOph7ggpPtwXlM6v2Do2L2oxb0WdXN0K6ot9mA8+FCNf7JQbacvJRoZX
 zQCqRG+iMEOhN1UifVoQGKBMVkSUJw26lihdEimdCwAfquds2BSbz1uWFqM9USjPlCTjiqImC
 gUu3tDsAmsGJ+oTBK45EZBDHr9ZceN+OPjlpE1Lnh0AZAVwkic8QdjzGicMjZ//wGmNlSXaFH
 J+seXShlNaUQRERn5fdsPZLiMHHXvUzWojf/fjzi5KIrpeFPa6rsnlbbqtVkKJk8xQ+uMh7fl
 HqCsLb2Xvf89Yq9JKJGkzFN//wUksJMukZp4kF0jZ5UpT8BA0I7FhE9z/m/p/I4A4l4Qj8DGB
 uVaZSp9ZtLussBLL36uc7kvPA3XdVKobOUxgfobKdIfCDARhD6JqlVSy0CFKecA5h4UdHZmIc
 x3oT4xTPgCumNrmtLexUcRETs6lhiil+TPgW+UKHj9B0ccX6HIhFPau4fX/VB/y31bMpuRUsn
 fPFlapxny4urR4CuP6snL8weaYb1q49hUhRNl9N1E3WUIEgfBvEmfrwGm3gAFqpSiXM2GJ3Cy
 sgvCdWbgPsEtnaHsjsCfGoO4/AfpaDZnA0pvaCXxq+50nVpcwMiXpjH7JzGyFZd1d2oMVtJvi
 g60HGIaVGVw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 8 May 2019 13:50:49 +0200

Extend a when constraint in a SmPL rule so that an additional cast
is optionally excluded from source code searches for an expression
in assignments.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Suggested-by: Julia Lawall <Julia.Lawall@lip6.fr>
Link: https://lore.kernel.org/lkml/alpine.DEB.2.21.1902160934400.3212@hadr=
ien/
Link: https://systeme.lip6.fr/pipermail/cocci/2019-February/005592.html
=2D--
 scripts/coccinelle/free/put_device.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/free/put_device.cocci b/scripts/coccinelle=
/free/put_device.cocci
index 3ebebc064f10..120921366e84 100644
=2D-- a/scripts/coccinelle/free/put_device.cocci
+++ b/scripts/coccinelle/free/put_device.cocci
@@ -24,7 +24,7 @@ if (id =3D=3D NULL || ...) { ... return ...; }
     when !=3D of_dev_put(id)
     when !=3D if (id) { ... put_device(&id->dev) ... }
     when !=3D e1 =3D (T)id
-    when !=3D e1 =3D &id->dev
+    when !=3D e1 =3D (T)(&id->dev)
     when !=3D e1 =3D get_device(&id->dev)
     when !=3D e1 =3D (T1)platform_get_drvdata(id)
 (
=2D-
2.21.0

