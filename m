Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98554C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 18:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575D42083E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 18:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="HCNZoDiy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfFESYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 14:24:23 -0400
Received: from mout.web.de ([212.227.15.4]:40279 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726606AbfFESYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 14:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1559759042;
        bh=yv68gMU0qUwkqkkR9pp87NU4A29XgHezaQlvZv3X2lM=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=HCNZoDiy5UJWmK0FUlWY5mkcrMCxu7wJoKjeNdOjKIZRfqGA4RC9x9BGUMo7cLySm
         wIsJfvD7/e/CInltOOzAz6UBXVk9bYABv1xY06igcegeio68l3i4Dp0IPEgnCrxK0R
         y1QirnCABD7bPW0xaxTc8o9eUtAzM6rq8JFYnHVM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.4] ([2.244.21.66]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MgIMg-1hEKfv3PCY-00Nlkf; Wed, 05
 Jun 2019 20:24:01 +0200
Subject: =?UTF-8?Q?Re=3a_Coccinelle=3a_Searching_for_=e2=80=9cwhen_done?=
 =?UTF-8?Q?=e2=80=9d_in_function_comments?=
From:   Markus Elfring <Markus.Elfring@web.de>
To:     Wen Yang <wen.yang99@zte.com.cn>,
        Julia Lawall <julia.lawall@lip6.fr>, linux-doc@vger.kernel.org
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
References: <201905171432571474636@zte.com.cn>
 <fa3b24ba-1c57-3115-6a01-ee98fd702087@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <1d3370e3-187e-cd4b-93fe-7c011b1eeb96@web.de>
Date:   Wed, 5 Jun 2019 20:23:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <fa3b24ba-1c57-3115-6a01-ee98fd702087@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j9AQxeIIRQDFnw9PHVC7fgQLLMioGBir01544saRIy6/bN/5FO7
 +rdddcL73ZQ+EVl31+9y7yF/5xGvmGidUUWSLAJHeP9NHp5RxNaXV5/XEHXkKiFmYZyj5Y6
 ZOrDwMFvqVgmFyH/gkjI6Hwph36dF/ylnL2IIb9xofiFuuO+Cy0wVnHJSKmbkvFyLqAsW6u
 BZJc98AqKdLf29/2M15PQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ptx137jtm7w=:datVfc+/Jzf+J1m27oxmBt
 wFA1pY/DjVCQgtNeSnGcEXEQMrOHUwNtbF14Qn3qvb5Jqs2BJDJvqCaSEmwmClJayynpZhPOP
 UTKxHOhbNlZA8xHlhtZwKah3nbW/wjEQolUv0QpbJaCjsFxhUgdzsUSAgjfydeVpzxYXg+iLp
 xVKQOcKFUiLESF4tGjqj5Cj6o5OwWW9zUP07p0cNk2AdOXBoT11jLQpjkU3oARyl0tUSvpcq/
 fQXeaWCUpVAKkaI/SNeVkhKdRqwuDVsofgWcyXvi+QW3XPk2gGHNkfehBM4r09wtDouDeX7cS
 DnmkLZ763bFlwI7HZU7qSBvkJXU5Wf8Uo2zhAmfd9gczaGWuGW9rVuaOLMgvf9GEdFdKtudpR
 viW0aM970Lvsl5bUzqVYyAcjH7ZJvyTaDKhEIHbmlS+OH1s7vrtNo99aZ9j3VN86k8FOp2Pmr
 l6eibO0Kr1bcx0eByVqxXwIHFPaXPHCd2Hwq3Lhhdac7gjDJEqNGX4dm3XTKgoT5muxZ6vqG3
 dm7d9xMdfeKsO8ZeWbo8B3+oedSvpt8VwoQpbpAkDvIoJG3U+3EMms8F8bpLLEUYMwboNX3Ur
 kHz9/JncWfz2UPwHFnCK/nE0TYakjxujVpfJSRZbVRw0B1CdR0AMBP90E+2p+I8RglKYKjIas
 e6ul38OcTHy1TxjTkQV/Vm2K5wUTTj0MJxEEUpwbdF8meJIVR75wGQvrX32qMn2G95ZmMOlFR
 2kmA0zwEOrmkHPhVw/ofbIoMQv4FiPnO1qnmgsy8lQ5mEcPylNkRU+cCUG6VQfJQvPNzGoFFK
 +LDd7S029RPR7i0M4+kAZ+t/jI7lueH5WygzAiXYVGm9LSqnhyvNv6X/x4F1m4eSjlpHMcEcO
 osDN0/qSN5n7ERDHWiJlhp9MvxCvfR4AXqucoqoymzSn2lAF4YhMy5JG1FzRW9Qe70i0cJXIV
 wUGUDDgFFZYdRwwTcVgj450Ckm4DPOtgs45+EKyIOhmccw3ZLFgVB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Does such a source code analysis approach indicate any details
> which should be improved for the affected software documentation?

I have constructed another SmPL script variant.

It can point out that the text =E2=80=9C when done=E2=80=9D occurs in comm=
ent lines before
48 function implementations which are provided by 20 source files of
the software =E2=80=9CLinux next-20190605=E2=80=9D.
Will this source code analysis result trigger further development efforts
around detection of unique wordings in these descriptions?

Regards,
Markus
