Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9DFC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 12:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9D0214AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 12:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="X1IDdAFQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbfGAMlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 08:41:36 -0400
Received: from mout.web.de ([217.72.192.78]:49405 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727128AbfGAMlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 08:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1561984859;
        bh=LQ55hwCCQ2FoTP2QGEKErwY6kt8vAGzxOs6SmA7nYGY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=X1IDdAFQKzi660dsrJWh3D3Jv2tvygD2nAQ3tDG4Y0VzPbnR2WlM+RCy5ATkVqdbl
         RqfrCSFNIgzdPwtYFG6wm5hfybpcA/nNVJNncaHjP3s6JXStXQL/rBWdqqe/8kZtLp
         /Y2r7sOgX/Cjrw0OWr8DwQEHJ/AgL/ShtTgEF5d4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.131.202]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MDP6H-1hkt5q1wp3-00Gs1X; Mon, 01
 Jul 2019 14:40:59 +0200
Subject: Re: [v2] Coccinelle: Suppression of warnings?
To:     Enrico Weigelt <lkml@metux.net>, kernel-janitors@vger.kernel.org
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Ding Xiang <dingxiang@cmss.chinamobile.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>
References: <05d85182-7ec3-8fc1-4bcd-fd2528de3a40@web.de>
 <2744a3fc-9e67-8113-1dd9-43669e06386a@web.de>
 <0b48a5c5-0814-6414-39ba-beb1b8b5253a@metux.net>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <eb95005d-e685-0a8f-416c-1a30ad3fbaa0@web.de>
Date:   Mon, 1 Jul 2019 14:40:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <0b48a5c5-0814-6414-39ba-beb1b8b5253a@metux.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:ydQQuOaMKrrPNBxNI2I3+74fCb+1kGiptO3tfChLT3ZEQoyulwE
 VCAhoo7BuKMDByeQQJ8Hvs8+EjynWyypzMnUAPY2okMsOi5DZ45xQ5kuRK3/DVoUtcEBLsS
 FD35tiIas8jC6ROLqfXfJl2bAWohcL6o8dBtjOsMIEHnDuoKtsDuJcNPjza6Dm7dN1Ipd7y
 bh1K9lH0NdGX8ht1KzT3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0AOVUaSr0H4=:8k9UO0GwcaGwlcFRU3/amX
 cMXTxKW9vzZsrOrw7CYOEu6zvoMVLtWRz2cQ8DaAwf2qjjKK7TG6jG/pJ6nH1cxm87rVmm3BD
 9iHKhXvzcFNfVrbfHGZzvrbY6gwAZAj5CMX64OIDEQdtv7AXS2c4CHHZyjPjmQj42wjfBDC4D
 0gZOS2A9ZoOmG43nNh56S72moP5CFgCSkhJBUoWl5Bu/ZPvbh5KfJvURFMjw7cMcfDl4JrO8r
 SC/CYzl6V8O0X1ikiAVprASYWFG98wMimf6Cfs4dt1kRP/OEDlPnqvRCZqKzrYHElUWY8b6Xe
 fG5b/l3xjq1GJzDQ6ofYNZPeL6tb2SBWcfsVIa1GXtWrw1KrCye/gwEV0tbGkFDDWln54mWJi
 x5NKD/p2QRXbeKvmzHSznZCTIbuPRRJ4P3dtEWDw5+ZXE4aYZn2bbl552RNZd/VfnFiLOmr6D
 e+GI2868ERZRmISjAL/asWEmpF7Ap7kqg8/AXCILnpeRhC82QpnmmhvCxuk5rex9Sfq533GdY
 k1SFZtbSN+1fogKoFs+oE65Z9RXKj2mvbJM90Ls22wJd3N9sMyKjn37FbWRrHc1Pz40juzq0C
 mzJVsbBX3twJw+OiVNpFr/vbAELaDksrZ4bmzrhb6bv91lHn0LgT+5TL/LAf+DQ70367LaUsA
 B4FoO4kafZPRPsgQKh2r5pLHnef5396Bbcf6Vt55ivgrdXKewPn+htDlg2LEg+kzhfbK/LOeB
 jz4WV6szhnzPiQDgFXPMNMi1aleJ4aFfxLVxTl/99jpOmz5d8rwzffV16BalPdouNHU/OXi6N
 fHU6YZI0FmUfmVoVTiqqEdEDG5mbZHQwSdWYMBs2YiSWT7RNpTPVxuzViiUc86ILv/MmnLQwV
 FQPA9tPS1hY7MxZpMWJ7LHSJJbwv14ZOzL7XyAVFCZ6ky5jqL2J+dd8IfGx4sDbtIfvs/qMCG
 w0jdW/t4tcp1kjlLZxtBqkd42tvkCsjubO0j0AcqdyEhTXO2DRZ0DiZM5H3cCGbCNd4KKmACM
 ka/XR4CppLOkKidMUyGRLtnbk4Syz6A6e4BRhrxds3AY67B5v58It4CdlOhpLAQxG3BX/rXJc
 aFx9EHnP+L4PFxAjkewM4127Pfcu7Eie7rF
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> By the way: do we have any mechanism for explicitly suppressing
> individual warnings (some kind of annotation),

I do not know such an accepted specification interface
(for the handling together with SmPL scripts) so far.
How would you identify possibly unwanted messages in a safe way?


> when the maintainer is sure that some particular case is a false-positive ?

Do you know any specific source code places already where you would get
concerned about the confidence and relevance of the provided information?

Regards,
Markus
