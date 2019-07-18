Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88546C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 12:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C382173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 12:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="fHAwCNhP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390104AbfGRMzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 08:55:09 -0400
Received: from mout.web.de ([212.227.17.11]:35523 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbfGRMzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 08:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1563454476;
        bh=Pr3yCBSMC/eDqRyfZblnMBsouognLzOFVijXQGgUyBw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fHAwCNhPejNmRTH0XE6YCYQH9iVaylgX//BySZP5S0JqcukmOrW/7kxOPb/odcLur
         C5wvUlimYQFwlB3n/ehp76kiEJJRegQHNFzBd0OQOMSilrp4hGd3NAkrMUhC3ERyNQ
         LD+TvcPttGvFXvs+YJQe7AQMWTbhHdajcJ8OksJY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.59.79]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MFt8s-1hcWgk0OSE-00Ev28; Thu, 18
 Jul 2019 14:54:36 +0200
Subject: =?UTF-8?Q?Re=3a_=5bv3=5d_Coccinelle=3a_semantic_code_search_for_?=
 =?UTF-8?B?4oCcdXNlIGFmdGVyIOKApuKAnQ==?=
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
Message-ID: <184a9193-dd65-6413-9e36-f11a8a603ed7@web.de>
Date:   Thu, 18 Jul 2019 14:54:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1563246347-7803-1-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MiU/qVEIINA3DNRYsw7EBqOnNsVgQrd/ilVP0mpKcwqsxsoLIKy
 3ANrGbBmhf2BJySr63f1nAaBhD0nQL7gVG+CAUh3aE8Xc6pqVptGISS827aTP5SPq7xvWqh
 PrCwFDkBe4RTyGoKcPTCntcseUjOVGmU6BZx000edO3vA9RWJEXoosry41iKUHOYfjiIUF/
 KYao/tyY2neg/JrHIqdLw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eh4EFja4ro8=:bJ93WKL+5hmlJ3i1E+TtxO
 5IsB9LbrRXUito+f+wvKoEs53PkWa0AwY/mJ/upVxAgcMtvb48CKt0660W+Xij76z7mpxBJDK
 YvXYDdd39RkWreHLdU3zJjxp3PyiwMCSBtgXjrMc8SsZXAq9Ay/wDjR/p2RpN8BQBVS6gecUM
 MQ84y0dZPbik015+LTpummDzV/pzHyQ6oRwfT49bunsospgWGuF+f0yjlcJUPEQ8JNxSoxS14
 64KbYEeyvzlSJiXsEEgsmJ53PawJjLoo8LqGnzThFAPP5BqjbZv5AVk9HdiBOY+HGc8qezDHX
 WJpOzwOzU6RDSfn87cv+8ZtayO/ZlCRt2joaFVBmZKV6Rok0RRlFeSCJa7Vw3dvFcL8YobK5M
 Aj+LADxyBmuk17UjdM5ZJ4/8uxE6oNoLgwQRt+zAlOH0RJ00UhMftxLw2yT8K/snk53CweulK
 BZFuekc16Zkq6OFS5FGRW449UBr5YaZtpGsp1fVbOqlo/ny8S4OTkNYoorDjp0zckXgywIqrw
 6nhTavqF3Exd4n15NqF+egwFLJvg+ehRSIatB3QulCqTHK1jiZz+Fu++kLoqNrECbXL6G6ckt
 TOuTSZu4SkbR2LREzzRV4OTl0v51gBgzd6Zgt19CyGQBE994DWecjo6NW8KiwIZVg/k+1Qfx+
 lRmKpTedL48UEOnm+u/ZzBL/Hm+fsIy1WcF5VAgJcWt+ZO7b+5uYVql+y2Md2FFnA8rYVBpc3
 zWCfIzexwGBVlQSawe5W2eE872tTod8iGJYut5fLS4FM03LsmUIMU9+n4xti9MwZvSfQfNH5d
 p9GylMmPKIfAjrBTx4kc6gnHMF9T3ywJ/1n4TccpuCrXG4p6bSAdOSvCfM+aei1YpEFiT+sT5
 E9PIPr88SOh4MMaPTcoY0CpY525GfXMqy+1V0UGNgqbDCG84wPoodg4/jYw1KmedP7j34pVhM
 gbTzdjNyuwv6fs94lU5R6WXjdUCsmm4cBkVsXsYUzpiEKbSVlpdjdYfFF+/O4sPPlLPnMnDtO
 ibWBSjv1V1UwrrS2aOpx2gb48fx/W8DIAFAja38ASw9lT45buZVK2qdpcm/vu0tHaXS2jmcJ5
 HlhhCzeImtRyuMFynsqKMlvx0+CTtUJsSDU
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Finally, this patch finds use-after-free issues for a node.
> (implemented by the r_use_after_put rule)

I suggest to take another look also at information from a clarification at=
tempt
on a topic like =E2=80=9CChecking statement order for patch generation wit=
h SmPL support=E2=80=9D.
https://systeme.lip6.fr/pipermail/cocci/2017-September/004483.html
https://lore.kernel.org/cocci/alpine.DEB.2.20.1709071519240.3168@hadrien/

Under which circumstances will it become safer to develop SmPL script vari=
ants
for such source code search patterns?

Regards,
Markus
