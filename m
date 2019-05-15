Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81701C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3652084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="alaIWujE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfEOMtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:49:24 -0400
Received: from mout.web.de ([212.227.15.14]:44397 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbfEOMtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 08:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1557924532;
        bh=BibXL/bw4+Gpkysah4bgldEaHhl9ZLOemLAMNjbkECI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=alaIWujE6HdLKpTK+dWu8pwtFetsKmmTWZIjUm5FfixiRnlQhgZ5Q6HR5GNtSYfCd
         Y4thboLNoQcl7ZEfU0XKX3sf4U5VIrSgEK7JRm+epREsZYOvr1AD9Fv29L7rZEYW29
         Vnia3/HWrJCQ06mBO48RjAFwA+iz5a2tEhYj92Hc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.244.73.153]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Ldn19-1h1UL10X0V-00izmL; Wed, 15
 May 2019 14:48:52 +0200
Subject: Re: [3/3] Coccinelle: pci_free_consistent: Extend when constraints
 for two SmPL ellipses
To:     Wen Yang <wen.yang99@zte.com.cn>,
        Julia Lawall <julia.lawall@lip6.fr>
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        Ma Jiang <ma.jiang@zte.com.cn>,
        Coccinelle <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>
References: <201905151043340243098@zte.com.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <e7db2c6b-645d-e82b-9d79-f64d7c5edfc5@web.de>
Date:   Wed, 15 May 2019 14:48:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <201905151043340243098@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ueQqxBLqM+qy26wITlwzI8OOJYO4FtsxYHduS0PdsRbVQYNXOQz
 /T6rk6RE3PobY1jQq9+YUE7YztNbuDpn7PE2/ghDaPpAbHpRpRD2ykcpVhaciZ1G4rMqt6A
 1CHGbkqZ9S4fJ9/JFv/4uDAHI9+q2JUgqiPM/GqZv7ypVU5UX6o0GIvEICjiI1VXlO2CTQH
 rLnrQhzhIW5YAuAB6C11g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LYi9/rCcdGQ=:9efYs156LJklRTRRDGyu9f
 pjb4a8AcL2VICFYTiaVgrVgAu5jIOtAhVO2vDZQK+O5SH3m/TRn3Sn+CZuwvvMu1Z6F1RmHcn
 Bfs4SeEu75xjAvOESenzwgj4wL9cB83S8Ub7+0HwZD7K79NPgvkem2r65qoqNByMgQtu8lWl0
 KopRY13QRj82R5mb2E7hIXuP7ytx8DPNp458rRrRfi3kMdPAkVMaBZoL6xe5lSMfWYFch6zOy
 /370x9mryK8IY0GBkNwzVdNtsuhy35d6jY6hYsOGaaKPNxmIkK0eutrdkqNOKnst715h0Fsjk
 F6vt/VUUilMUrbEKH8q1cZI+GU71p/4/mwD8s2NQmqNZPsTjG81p+rW6l+8CtitXXxSjz/jF+
 mQOe2hhk/jDU5xSRyt7J4IC7w6voN4JegbKgJNDkJwOKlFbfOgdl7uVuJwYsQ0dZc/mTcOkZ+
 Qki7+WWG0ZriEsqfyEs1XiTb9J6Lxm9BgNW9g1rrAYhD+cb7iaKQPdjIgnY6TNVo1GEqlZLhZ
 UxX9jsG0efyWeBCAImd8IrKdU4XIKDbseErqEiczN7AF7hlfqIvWzZlxB8ajvQsVs83yvO4Uo
 AABuns7FQGPgIOVqmhYCTGySz0BO/uouwwpsqCFmAb8PTwm2G8cb7v4kASaBIOvJQY4B/ey28
 PI50gfKig0oR6857O57mayDbA5yPZJo0ydCbmL8ZskPU/a2GPG0dlUwSK6YEUS1gItUyp4XFk
 YKWdJDzgHWtBNYULYydG7LGa3w9Z60rtXsoBYgW+DV+h9KwUvBWT1HR6XEP7ixjCUegVrjC4Y
 IzXFnq5WUUtRbE6uWeO7FfSEArdWsB3cxKUMftHaog7woayh6otSDoCab1R90Zw/bTycmMWFZ
 3P3dtLAAflP5PEqsb26xugzevDws2g369eXz4yYTqzfupj7hl1zwhCxInWPoWiIePtdbYL0Kz
 weTa4Pfq06Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 2,  If you really plan to add the two restrictions above,
> you may need to consider this further than simply adding a "when !=3D id=
 =3D (T2)(e)" statement.
> I constructed the flollowing code snippet as a test case:
=E2=80=A6
> Using the original SmPL, we can find a bug.
> But with your modified SmPL, we can't find the bug.

The difference is the possible exclusion of a reassignment to a local vari=
able
in which a pointer was stored for a resource allocation.

Would you like to adjust corresponding case distinctions any further?

How many script variants will become relevant here?

Regards,
Markus
