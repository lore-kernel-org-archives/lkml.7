Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC50CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 20:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B2320659
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 20:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="cRBzJcDF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfJ3UvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 16:51:23 -0400
Received: from mout.web.de ([212.227.15.14]:42727 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbfJ3UvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 16:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1572468620;
        bh=awYX94K/3Ef/IkgRJzU4vUFsU8ft/ilecpb3Nwonm9Q=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=cRBzJcDFRBy7tdgPLy+IzMmnVBwqCw+RTNcN90pEfAOODemmynGj2NRIFX8btHrOC
         MWe+NGsEutjd2HpVH+82PAycT6SPq7YaEDeMdq+BZN9xFrSDae5pxwBzyeFrsqgFky
         Cgb+WtrxFtkmirDycNJ0zyZt+HeSSlVeUo9ZvHsc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.104.79]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lfipe-1hbgfp3kCo-00pPoH; Wed, 30
 Oct 2019 21:50:20 +0100
Subject: Re: drivers/phy/tegra: Completion for exception handling in probe
 functions with SmPL?
From:   Markus Elfring <Markus.Elfring@web.de>
To:     linux-tegra@vger.kernel.org, Coccinelle <cocci@systeme.lip6.fr>
Cc:     JC Kuo <jckuo@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Thierry Reding <treding@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        YueHaibing <yuehaibing@huawei.com>
References: <fe6868a4-01f5-2832-9081-7643be0ab4a1@web.de>
 <3e3f40db-2422-c64d-3825-35f8c2471eb7@web.de>
 <161bbb97-09d9-f128-bd25-ef9348534144@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <205e2b3a-2934-f5d0-6b12-59beee0d58fa@web.de>
Date:   Wed, 30 Oct 2019 21:50:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <161bbb97-09d9-f128-bd25-ef9348534144@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T65/O15SDHXdx23PrZy6oljaIBK8YZdtQ/lTQkgK3BJRP5lcjCi
 Swyb/bojLr1ULUOof3qlqgp3cmahJeR3Nn+8pYYupdOfnFyIRVIpMQMXHRsZLgrouZOEFoy
 QwUborX5BDzipL3qgMRIW/h9lCLfQ8aw5H+Q3da7ySDm7xZ9Kqeh0RiPRX47jEyQ1Ata97P
 jfo1Xc2HasJt20xzgIfRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TzC8nlXS5AA=:MErmcLQ8bfDxaTJUo3mXTJ
 feVEUnLbKQQvBKGEf70IcAueT53rA8jivlV5PrZKCiQnKIIO2rTKGZBGPVYYJPmjxxzo6uDhE
 sebzXSPMVMXLBm9G1vtgxC7VKH8AtFnZqDX+7VPd7rWbsgSp/U/BvR34dwzHF81INSi2VPrnK
 4oUod/V1G82N6YFp9GzD6VQSqqgmbX2X0SKNoa+v+hm0dY+vWwAarzMK0DYyR/osC0GBzkn9F
 O7k90bbs585RnHVjxpBMMMbjy+loD3KlwHGMTax3O93UbCJpbhL3PmIC2vyzuK9yIVGs2RfmY
 tUViR+0VoZhX83QHQM8ypy+t+m+LOZoE3Ae7titKZx21lkmmwIlMJRWCyOmEmsNFOwrVJTQ1Z
 JsDl0rbOxUop0OLgC/BPb+aukjM0WrRRWnOnUMFTH+Ju+62bbzAQSqGGMAIkJ7hV67aqsdTiq
 vZMcTN/Z1LvVYZQlA6hIXp/XBr49X+u7GTkXzXzyFMI6xW7f7lz3iFuZ8xFMhkjZZBO9wSOXT
 9n+T4IBU2nvgRA69P5KOYyComb+8JEIEpeKyjouEX/bcD+ez3DGVo/DF+w5VvIDIxRHYx3oSj
 W7kt6q5SyVh6jyItSS2Es/35VI1h+8y24hkO6eZXztgEnVItjGJLl+ukJsbBHeZ3OV977hu/G
 pefBnDS6yUtB7yB6UOt7PMeNHRtzjyXnDpX1qaqBfwXeO9Iv3ADw38hi14dsS+ousROJjcX2A
 zag4jlp9CcKyfDcEeTwY/6o4JAUr5jPIEiAyBNU/xD/e6wWS9PUkz7NkOebEmBCuGDWjeRdat
 ZBLzoKyaV2zWSGziVYAnEgyz+5bmEW8trAV4/OpxjVk7U7oURV1eOXPmxwsLbFshks+rk0U0X
 HhrztKHhYtCZCzDbQgmng7CHD7seq8z1mRPGkq9xcDqtso4RMG4EhrZ9YI6H7M5fGI0TCFV8a
 MAnJQAw6iXATiXVjuOBb90+iF97nqzSramKVZ1TDnX8TbACxWsDV0GkjhPP9FZUc5Ee8En8Bf
 wXZodSawLH8JX7HQRwM9SrGY25Hv9snLLfazcpRRwPeqjJrynRP5dVlx0aoZ9c9iwvooJWHCv
 wu8J4CKuMVqkG3mGafHPRT+Qw6Rdc3IlrDAN3kxXEqzMz8EmbCgiJftmG3bh/oN8+PhqWuGSx
 A6pKYFnIFaKC2CNmD2ODDRIE9Bphwx9G9K7dg1hrbS1t5fylA5etoaxXsJ0LmYjYqwWyUIcSF
 GP6s1ZIOVqpGoGi4PqwwONlKcdmCo6q2SY623wwn7WPO7oMzhenNPKiq57Co=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> But I stumble on another unexpected test result.

I got more promising results by the following transformation approach.

@adjustment exists@
expression object;
identifier exit;
@@
 object =3D kzalloc(...)
 ...
 if (...)
-{  kfree(object);
    goto
-        exit
+        release_memory
    ;
-}
 ... when any
 device_unregister(...);
-exit
+release_memory
 :
+kfree(object);
 return ERR_PTR(...);


The scope property of such a SmPL rule occasionally needs also more
software development attention.
https://github.com/coccinelle/coccinelle/blob/ed1eb8e06f800739d3992158d369=
45c0c4c6f0c7/docs/manual/cocci_syntax.tex#L860

I observe that the pretty-printing for the generated source code will need
further improvements (according to the Linux coding style).

Example:

elfring@Sonne:~/Projekte/Linux/next-patched> spatch drivers/phy/tegra/xusb=
-tegra186.c ~/Projekte/Coccinelle/janitor/complete_exception_handling_in_p=
robe_functions6.cocci
=E2=80=A6
@@ -461,10 +461,8 @@ tegra186_usb2_pad_probe(struct tegra_xus
 	pad->soc =3D soc;

 	err =3D tegra_xusb_pad_init(pad, padctl, np);
-	if (err < 0) {
-		kfree(usb2);
-		goto out;
-	}
+	if (err < 0)
+		goto release_memory;

 	priv->usb2_trk_clk =3D devm_clk_get(&pad->dev, "trk");
 	if (IS_ERR(priv->usb2_trk_clk)) {
@@ -483,7 +481,8 @@ tegra186_usb2_pad_probe(struct tegra_xus

 unregister:
 	device_unregister(&pad->dev);
-out:
+release_memory :
+kfree(usb2);
 	return ERR_PTR(err);
 }
=E2=80=A6


How reasonable do you find the presented update suggestion?

Regards,
Markus
