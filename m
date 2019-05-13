Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02666C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 08:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9AE22146F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 08:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="NkxlSAj3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbfEMI7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 04:59:24 -0400
Received: from mout.web.de ([217.72.192.78]:54227 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbfEMI7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 04:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1557737944;
        bh=UE+2FKqrv92g/rPKtyy4eMWvESNWG2N1LkFCK3GsKfc=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=NkxlSAj338EL0YmM5me+CxYd8yBl5+NSC4LzY//SG4KquLEq6KRmJCM4l9BxmcwZM
         KM0SEw2AZzcP+DMu4OkKuQurjQMcYeACM1pw+beFOjO02MV5NugRiZnovTKu/mf1kg
         N0b29t/9ERjHkWVfs9pnM3yehqFNsn+tWd3IPedg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.135.147.80]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Ljrq1-1goa3N2kWX-00brCs; Mon, 13
 May 2019 10:59:04 +0200
Subject: [PATCH 1/5] Coccinelle: put_device: Adjust a message construction
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
Message-ID: <308f5571-68f3-7505-d5ad-59ee68091959@web.de>
Date:   Mon, 13 May 2019 10:59:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e34d47fe-3aac-5b01-055d-61d97cf50fe7@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rwJwv4ETxr7FEwe200tk23kZPzjDIQpQf8O3ORayMX9Lzegsw9A
 TWNA/OBByvmoiAAmB8ZR/roAgooG67en2nU8ceRGXeJMcSywHwJKXG9Si8cL0WDH/trBwDZ
 y1/1oixRHrn+M85h+s81rwXTLXC7CqinrGmuXSeJWgqKf65k47qMt/DfiTkISSnMit67YgD
 BwckAbzPm1vQuGNawgxqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z2PTme9SsVI=:yAtGzHwM2mVWkVnNDTz5mv
 XLXP5+Hneka94/vRVbH9+PSkXODwnqTCz6wYqnL9hIcw2Xka4YgUs57fuX/X6+EQYjzie/ERj
 n9VG5Ya3u9EqEOkLi+/RrjfTysNkL1sM9mal2UDJphHtptNgRgbjbt+LbskrPATmHIzabHWJN
 FZzPf1r0oJhTs8Dqdf5kjMfUb0OUyOjpkaxlpaUuXqeDY9QyuE8e7qmy4AkNcbFmvheaDrYvQ
 zRtvGhWe69PUkm5oj4iGEBoo+9N3Ut3VQO3LhRUoxyTr8YxSraSgmfWTj9IsQXBktfVvjX5+Z
 y5QbCbhiLpDcrXrrWORdJbEubSg3wIk75/8O90IabTzWCrBBuG/QhmaAceNgVhYX6yJQtAFtY
 rsnaOixrFL0PystBAOp0gvTGN/YDdGvnxIFcignfFfgM3smLMFGgqDSAYKX5v2/YlSajtGgIN
 IOujir5CEjSNXftQmm/MmV1sS45hM00ewgnHj1ySKsHMUL+0lSEF5uapjB02piDc/FH3j+qD1
 x7f7BGNhhKIdMIWXFQQoU1y2/glKEmcW2/cofcBj6f5winIfxtB0S3oWkJY5NN+eFm0j4lHPh
 Bh35qOEedUMUGrDvxXvH8OeQn6MLEp0y7ntB596xVuBMSOej9leCucNy3cJWvR/Hl+aLCmYqe
 zyWqVmUCw/9YvZ92IXns0ixQK3JGhDSIfSvLqjLBJp7RtibKUWdLzbIxNmHxnUIM3tDzWavWP
 QRUg/CWt0XGKabGYuWvtPcNI/pTNrfGW0PQ8wNjEI91/XlUQOkFrvYq3dQdZXbDfc+GfRcdia
 9RvPvFRyubw791sQFl9Vxtpt+GnGymUQnqDG+u5e9RKoaUcMFZQm//jfQqgNkPfh8Oi4w3ZFL
 4Ber35kQYEl1vKHJIMAQKK7KPHBEQvzU/XwYv4FgeJJerfNj+9fzyxqwhrxvk4kz2sI9UpVpo
 EVY2g9WpnCA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 7 May 2019 11:20:48 +0200

The Linux coding style tolerates long string literals so that
the provided information can be easier found also by search tools
like grep.
Thus simplify a message construction in a SmPL rule by concatenating text
with two plus operators less.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 scripts/coccinelle/free/put_device.cocci | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/scripts/coccinelle/free/put_device.cocci b/scripts/coccinelle=
/free/put_device.cocci
index c9f071b0a0ab..3ebebc064f10 100644
=2D-- a/scripts/coccinelle/free/put_device.cocci
+++ b/scripts/coccinelle/free/put_device.cocci
@@ -42,11 +42,10 @@ p1 << search.p1;
 p2 << search.p2;
 @@

-coccilib.report.print_report(p2[0], "ERROR: missing put_device; "
-			      + "call of_find_device_by_node on line "
-			      + p1[0].line
-			      + ", but without a corresponding object release "
-			      + "within this function.")
+coccilib.report.print_report(p2[0],
+                             "ERROR: missing put_device; call of_find_dev=
ice_by_node on line "
+                             + p1[0].line
+                             + ", but without a corresponding object rele=
ase within this function.")

 @script:python depends on org@
 p1 << search.p1;
=2D-
2.21.0

