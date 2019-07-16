Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98925C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4338321721
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Z4GOSLSi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731852AbfGPJ00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 05:26:26 -0400
Received: from mout.web.de ([212.227.15.3]:35017 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbfGPJ0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 05:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1563269162;
        bh=ZuaXQvRTOC5ngjHr5YqwjZJIMDEoZHlEwgiQPlvoALE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Z4GOSLSiYuih1O+FCoo5v8zGB7aWkeUoAcFArhJVZp0ijEv6ZGgZpAiZo03Urb5+Y
         sL8j8vQ/8WiH6uugqu44RfzGsPzprlGIl2APwswdHhykAmtSW1h42j/JawO+OtPwbO
         aSpqPz9cTS2MUDeVbyBKovOBTlbQ97eGt1l+Wtlw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.184.87]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MIvFp-1hkpoR1b21-002W5N; Tue, 16
 Jul 2019 11:26:02 +0200
Subject: Re: [PATCH v3] coccinelle: semantic code search for missing
 of_node_put
To:     Wen Yang <wen.yang99@zte.com.cn>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Xue Zhihong <xue.zhihong@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wen Yang <yellowriver2010@hotmail.com>
References: <1563246347-7803-1-git-send-email-wen.yang99@zte.com.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <663d8141-5740-a452-1f4a-8335203e65ba@web.de>
Date:   Tue, 16 Jul 2019 11:25:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1563246347-7803-1-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XK9D1PFNNMyl4nlD0+NxHKnMhOQeaBK8wKSQIwqo7a45ayY3MBv
 j5nRSu+2FWzA74daBtHepyB1XbMzrA8aM+BbqGrQ9ZUV1cSISTyN/MDUQfeqGrWa7C0/cDL
 xfA5to6PwTLiujSn80lxRgM4LXhf9Sy9+UHJklJv926YV6S/BaEfH9k7MNm92NI/SeQuN3j
 jHfGHw/gf+gpWSX9LkF2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5bFm/zMmyF0=:THKKaLLZuQ5vLb/pBare1g
 5Qm4UI1Nq5Uyh3HrJt6mpq2DUMJtYy/DdEMfpTfb3SmX805xfjyc/9qLafQOWgHgX9hD93D/f
 8Bg7nE9MZqdBPelDKvDDVGUUOfpKHZ4gT/f7Vifj/v4AW9kAHlBykXl6hq6GfsW9zgOsXVhRx
 QNLMm2EpjOCcDSNwQluqH0ZY100TbXSz6Kj+udeoo1SbMfOTC+ldAJiPUC2IKWxrC6W9yzZpP
 YFy+sAIBvoR9SznY/LILq0Qat8TBfX41ciT2W2erLkgwE+FZhkS98YvN51yMqy9dQ12pVwbd3
 TAk2RDDCvjdlnamcMD57K3zZv1qL6i+0nEGK2g9zfPiOjNVX7Es9cak354dzyBTkNqQBqVMPc
 GC8+Zv8geu3zOcLNJTd9i7U0O546uFehwTCR0tTNIa0CwaLPb1T9yb/M4HEg+AeBZQIgkTuRc
 N1syKm1FUFS9GTtnHmfOQaNWsv1Ylkb0Zb55f1W8dxcSF9u1bH2Qj8SUKNt6Z4M3ilMXchloz
 Dc2rjhWIPJ4fVTdidwdpVmQU5dck7zJTpHLyw7RuQxSaY6z5W6hji8IgEzW7Tax8tLdw/iegG
 s2LYqSTBgWOAQTlbx7C/eYui7yPNdvjoWY9NmvAImZdm6Xgt8PMmlL3d8CDeYYl6exJavB7Of
 UKfMy2W3ibIT+bJmUu5fCZPb+RN4LepbKqFwFCiHp5jH/7AftS4yJALIDSfG8vqzvqykNorNY
 O4ynFbOeLCln/tZG/t/O9x9CEdGw5LSx0C4kxMF+6DJN5o7S91Xt3vmeRio/iJtQL1vZGamwJ
 odbWbh502C77Xu2vQjwfAPE4uNeRRjveT6tRugBIgVaLqtOyOuIwG8iNHZPLeNUElZVrrsXA1
 ooTZS4PSpiexzWKCJY96+4RuTwQ+SydFjVD0aXRYkovbmn+dRnlY4kmjdGbLtdmIXXS5KKkCH
 itnrw/XPMv5ClElSRhq6wNKIxH91kiwNpqpexaYZf1ZGsPP/N2pY7HwQLFeM0aA68Uf+l9+Eh
 6HqbjbKcd9XPG3QZnTs4G08a5+PeNa2eqjvlJU9G8On6krK2OW77EJfg2/vFIHKi1GOuQ0bQn
 z5DVTQINJt1KBmKxDnIWVICvbsYWEuRELCQ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> We find these functions by using the following script:

Why would you like to keep this SmPL code in the commit description?

I would prefer software evolution in an other direction.
https://lore.kernel.org/lkml/44be5924-26ca-5106-aa25-3cbc3343aa2c@web.de/
https://lkml.org/lkml/2019/7/4/21


> @initialize:ocaml@
> @@
>
> let relevant_str =3D "use of_node_put() on it when done"

I see further possibilities to improve this data processing approach.
https://lore.kernel.org/lkml/904b9362-cd01-ffc9-600b-0c48848617a0@web.de/
https://lore.kernel.org/patchwork/patch/1095169/#1291378
https://lkml.org/lkml/2019/6/28/326


I am missing more constructive answers for mentioned development concerns.


> And this patch also looks for places =E2=80=A6

Does a SmPL script perform an action?


> Finally, this patch finds use-after-free issues for a node.
> (implemented by the r_use_after_put rule)

This software extension is another interesting contribution.
But I imagine that a separate SmPL script can be more helpful for
this source code search pattern.


> v3: delete the global set, =E2=80=A6

To which previous implementation detail do you refer here?


> +virtual report
> +virtual org
> +
> +@initialize:python@
> +@@
> +
> +report_miss_prefix =3D "ERROR: missing of_node_put; acquired a node poi=
nter with refcount incremented on line "
> +report_miss_suffix =3D ", but without a corresponding object release wi=
thin this function."
> +org_miss_main =3D "acquired a node pointer with refcount incremented"
> +org_miss_sec =3D "needed of_node_put"
> +report_use_after_put =3D "ERROR: use-after-free; reference preceded by =
of_node_put on line "
> +org_use_after_put_main =3D "of_node_put"
> +org_use_after_put_sec =3D "reference"

If you would insist on the usage of these variables, they should be applie=
d
only for the selected analysis operation mode.
I would expect corresponding SmPL dependency specifications.
https://github.com/coccinelle/coccinelle/blob/b4509f6e7fb06d5616bb19dd5a11=
0b203fd0e566/docs/manual/cocci_syntax.tex#L559


> +@r_miss_put exists@
> +local idexpression struct device_node *x;
> +expression e, e1;
> +position p1, p2;
> +statement S;
> +type T, T1;
> +@@
> +
> +* x =3D @p1\(of_find_all_nodes\|

The usage of the SmPL asterisk functionality can fit to the operation mode=
 =E2=80=9Ccontext=E2=80=9D.
https://bottest.wiki.kernel.org/coccicheck#modes
Would you like to add any corresponding SmPL details?

Under which circumstances will remaining programming concerns be clarified
for such SmPL disjunctions?


> +... when !=3D e =3D (T)x
> +    when !=3D true x =3D=3D NULL

Will assignment exclusions get any more software development attention?
https://lore.kernel.org/lkml/03cc4df5-ce7f-ba91-36b5-687fec8c7297@web.de/
https://lore.kernel.org/patchwork/patch/1095169/#1291892
https://lkml.org/lkml/2019/6/29/193


> +    when !=3D of_node_put(x)
=E2=80=A6
> +)
> +&
> +x =3D f(...)
> +...
> +if (<+...x...+>) S
> +...
> +of_node_put(x);
> +)

You propose once more to use a SmPL conjunction in the rule =E2=80=9Cr_mis=
s_put_ext=E2=80=9D.
I am also still waiting for a definitive explanation on the applicability
of this combination.


> +@r_put@
> +expression E;
> +position p1;
> +@@
> +
> +* of_node_put@p1(E)

I guess that this SmPL code will need further adjustments.


> +@r_use_after_put exists@
> +expression r_put.E, subE<=3Dr_put.E;

I have got an understanding difficulty around the interpretation
of the shown SmPL constraint.
How will the clarification be continued?

Regards,
Markus
