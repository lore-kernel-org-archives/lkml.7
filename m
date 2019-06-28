Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6F1C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B1D2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="euILTCyx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfF1JjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:39:02 -0400
Received: from mout.web.de ([212.227.17.11]:53049 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbfF1JjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1561714711;
        bh=X1NmCSQThd+O2SZ2IzSV6paT2T9+3Ex8V1ddhoygkv0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=euILTCyx5cbIXEHEU8xbTD7+27ovIKpnLhRmsurxRk1S9NeiApERBipV6zRz5tevn
         aLPeE53Q8IX4GHpRWXoB0BAAM4dTRcBlgwhgriDY/vAvJvQoypzqxTSPmLjKDvhI7e
         2EAXjAbNXY/XHNTpIJA/obDZfCOpml/vI6w4NUOk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.53.73]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M7snk-1iT0Gl2h0q-00vOW3; Fri, 28
 Jun 2019 11:38:31 +0200
Subject: Re: [PATCH v2] coccinelle: semantic code search for missing
 of_node_put
To:     Wen Yang <wen.yang99@zte.com.cn>, linux-kernel@vger.kernel.org
Cc:     Yi Wang <wang.yi59@zte.com.cn>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        cocci@systeme.lip6.fr
References: <1561690732-20694-1-git-send-email-wen.yang99@zte.com.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <904b9362-cd01-ffc9-600b-0c48848617a0@web.de>
Date:   Fri, 28 Jun 2019 11:38:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1561690732-20694-1-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZAqQbMT5bEKu8+I1Q4zEJ6RRfCsIviuOjgjr0Rvd1mOihub0d5g
 ATAjPS6sHNqG0KXY7SfOa+Qn8n1W9dUmGTuPxl/vdkt+vdEtMWOaS+LWkuSfHF4LTGSsJ9L
 RK5dTY4Uwd6/EtLO2Ir1Noc8dLZpF7H+DnGcv4alNKLUpErhbuHvRSd8cfzqli0BzQ9UNl4
 v8c9KJJgauIcWuIPsmeHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0kbCw1qZQ8k=:HEpecMbyg5rWz4ZLTPdd7E
 VMNi9XSE3k3+9gm7o7Qb9IZZJQuIpzaNpj7pj6qa92MZRt9iQWQ/evvyc0R1PTQN+F51oHMVH
 yiKE1GjjqzE3CQJ904z1er8f0LglSstGiskqAPXaoKVeiP2c+xvHuCaCS47j+bHXqToig/kgn
 1KwW0eaPvZpocdB7j7wjOjZxqiFZuVipxEon96Qe51O1F/Kp0dLgAPt4sGCeQgLjMa3JqEKeY
 5ZIYFYvw1tXeIzJAbJHwDI7uQJlLt/AKWpENzXy5DgbPUm+FwkDRw9DJaHAqpwB4jCtyiBExG
 jg1nOKBecK9sruMt9BLYiACP5It9A3lCDMiIv6DPF2XQ3J0BPaCeSH6sxRsJtQMrt3rnGh1B5
 Hoj0DYYJUjRyQdqdWg4ViGr71NtSwCtyAaPT/gJjfOZXP8uamZYQrpfbAGP43MRQgJRh0Xp3W
 Ng/pZk/O4hGGBdRUyt8rzFB20i3qfM3UVvq5XrnMSjSPHbP3j9WMXkXb9eb8TBiny87iluQoj
 M7mBCX7sWwEJ0bL5+0tX9XkEcjrtb+qE71AkqqEqW4j1K53QD8CQqzUCYL1FNt6oWbrfWF6K4
 JDkJVcdVxlp/PtgZ3VMo7EC6ZxqdYi2o9VoQL9amXg5e0sZlOMPjLpMFJV0bITl9qD+rsTOOE
 NdeAhfRfH1wCdorlKHWBQsspelj4g8iZGcSq7ZheSjqrCYpyMd6B/wKivHLjuRaIwnk8576pW
 O3yUtSyVE/V5keAjQenMncZZheUXuXbT7Ng0nk/4AB1Xt46Xz6uXWRdkXq1CYbxCSEjR16evC
 DHISpjs2VWAGHPLC2U3EL/P0wZe6yY8tgdt7TT7E+2mHF7IWYDDEJGstkHTlXZV7K+Qa+/190
 EbafCyoJ+tADizzIlINs3xMyvyuunmGS+Q/lSRYgxSDEZ+scS4fScWYK1HiF3NdeKWwjGQZmo
 rEA/FttDDXKU6uLrBBYe3ZFethqOwUZAWav9XmlW4+A/BFs4y0cdoO/N4ysE62oJvxrWPWIUU
 NwiKlGalbu/p87joAAdBSfy1BJSed6/ShNcPcObggdNjQi3mlyvk8yXjT0D7d4opvS26btg3K
 iuuGQayThd82dEe7TgZQtZmGQYWzML7t+Th
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The counter must be decremented after the last usage of a device node.

Thanks for your next try to improve the software situation
also in this area.


> We find these functions by using the following SmPL:

Would it be nicer to use the word =E2=80=9Cscript=E2=80=9D also here?


> <SmPL>
> @initialize:ocaml@
> @@

How do you think about to describe the chosen algorithm
in a way for contributors who might not be so familiar with
this programming language?

Will any information from previous discussions become relevant
for a better commit description?


> let relevant_str =3D "use of_node_put() on it when done"

Will such a literal need further development and software documentation co=
nsiderations?


> let contains s1 s2 =3D
>     let re =3D Str.regexp_string s2
>     in
>         try ignore (Str.search_forward re s1 0); true
>         with Not_found -> false
>
> let relevant_functions =3D ref []
>
> let add_function f c =3D
>     if not (List.mem f !relevant_functions)
>     then
>       begin
>         let s =3D String.concat " "

I find such a concatenation suspicious after the space character
is used also for a string splitting before.
Can this delimiter be omitted for the combination?


>           (
>             (List.map String.lowercase_ascii
>               (List.filter
>                 (function x ->
>                   Str.string_match
>                   (Str.regexp "[a-zA-Z_\\(\\)][-a-zA-Z0-9_\\(\\)]*$")
>                 x 0) (Str.split (Str.regexp "[ .;\t\n]+") c)))) in
>              if contains s relevant_str

I would prefer to use the string constant in the called function directly
instead of passing it as another parameter.


>              then
>                Printf.printf "Found relevant function: %s\n" f;
>                relevant_functions :=3D f :: !relevant_functions;
>       end

I find your choice for an output format unclear at the moment.
I imagine that the corresponding data processing of these function names
will need fine-tuning.
I am missing the software component for the conversion of this
identifier list into a disjunction for the SmPL rule =E2=80=9Cr1=E2=80=9D.


> And this patch also looks for places where an of_node_put()

Does a patch or a script perform an action?


> call is on some paths but not on others.

Let us look at mentioned implementation details.


> +@initialize:python@
> +@@
> +
> +seen =3D set()
> +
> +def add_if_not_present (p1, p2):

It seems that you would like to use iteration functionality.
https://github.com/coccinelle/coccinelle/blob/99e081e9b89d49301b7bd2c5e5aa=
c88c66eaaa6a/docs/manual/cocci_syntax.tex#L1826

How will it matter here?


> +def display_report(p1, p2):
> +    if add_if_not_present(p1[0].line, p2[0].line):
> +       coccilib.report.print_report(p2[0],
> +                                    "ERROR: missing of_node_put; acquir=
ed a node pointer with refcount incremented on line "
> +                                    + p1[0].line
> +                                    + ", but without a corresponding ob=
ject release within this function.")
> +
> +def display_org(p1, p2):
> +    cocci.print_main("acquired a node pointer with refcount incremented=
", p1)
> +    cocci.print_secs("needed of_node_put", p2)

Can it be helpful to specify SmPL dependencies for these functions
according to the applied operation mode?


> +x =3D @p1\(of_find_all_nodes\|

I would find this SmPL disjunction easier to read without the usage
of extra backslashes.

+x =3D
+(of_=E2=80=A6
+|of_=E2=80=A6
+)@p1(...);


Which sort criteria were applied for the generation of the shown
function name list?


> +if (x =3D=3D NULL || ...) S
> +... when !=3D e =3D (T)x
> +    when !=3D true x =3D=3D NULL

I wonder if this code exclusion specification is really required
after a null pointer was checked before.


> +|
> +return x;
> +|
> +return of_fwnode_handle(x);

Can a nested SmPL disjunction be helpful at such places?

+|return
+(x
+|of_fwnode_handle(x)
+);


> +    when !=3D v4l2_async_notifier_add_fwnode_subdev(<...x...>)

Would the specification variant =E2=80=9C<+... x ...+>=E2=80=9D be relevan=
t
for the parameter selection?


> +&
> +x =3D f(...)
> +...
> +if (<+...x...+>) S
> +...
> +of_node_put(x);

You propose once more to use a SmPL conjunction in the rule =E2=80=9Cr2=E2=
=80=9D.
How does it fit to the previous exclusion specification =E2=80=9Cwhen !=3D=
 of_node_put(x)=E2=80=9D?

Regards,
Markus
