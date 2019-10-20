Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD71CA9EA9
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 05:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7960C222C2
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 05:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="GVKXu4v/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfJTFqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 01:46:38 -0400
Received: from mout.web.de ([217.72.192.78]:38055 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfJTFqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 01:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1571550363;
        bh=x7uTnJsRgEJVyfO+7N1P8ScHIbumAeuC8K7dMT+Hyj8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=GVKXu4v/SiIevPmdVBS7Rfm4yORg5lcFF8xjkU5OmMot2DCYZ+jqj47GTZMlvgG6D
         MoQV4vdARwGFzE67LZTbV00ymLx1hVJcFDFGb/FpLsSPF+uDfwGiCMUndPKZnVS3ag
         s1aOtKCTMYHhyhnS1gDAbnS5F+ImsLNMcvNqwpGc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.112.181]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LpO4v-1hrvsk0ef7-00fBcn; Sun, 20
 Oct 2019 07:46:03 +0200
Subject: Re: coccinelle: api/devm_platform_ioremap_resource: remove useless
 script
To:     Marc Zyngier <maz@kernel.org>, kernel-janitors@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>
Cc:     Himanshu Jha <himanshujha199640@gmail.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        YueHaibing <yuehaibing@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <e895d04ef5a282b5b48fcb21cbc175d2@www.loen.fr>
 <693a3b68-a0f1-81fe-40ce-2b6ba189450c@web.de> <868spgzcti.wl-maz@kernel.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <36f29ea7-7d08-fde4-daa9-e75675191e50@web.de>
Date:   Sun, 20 Oct 2019 07:45:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <868spgzcti.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IciyEKuuswWa2NT0frFoyIuRhO2K1QyMc8LxqHO4MZK7TJH1/dL
 A4qN/Ybt/pboksbF9tT+Ihqz1oXHRlcKF1L7K3FIlthexVcSO7yjvkt63GWwyVFJok7pqab
 xXJb3rHzHuMXDLjRQ2f1KZVT+UNHhFmWn5abevQf0brP4nsCFgZqLlKbjzZLnshDEnR/TXm
 6a8akdypiafqM0SDo9nSg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xOHEacZFLho=:CLAXTGNUUBIBB5DWSUbC7k
 GNVCgBR6VoumUpG7s0VtNvuKTXwiOLAX3umokRf6iRVGAVPcxOn7i+Vkbm1CjRDNaACqydOGa
 nLZMWsOStk5cJLCHvNgjqrGKB8hnCGEAguJYpP5r5tDCgnue428l5m9w4CtrGM7h5BJp52Zww
 4tMM69wLahV1d7QUoQuYKP9v8hnNwr/OTFnw0Q0Tpa+qv7N3dOjHm0f/VvZrTVekFFnpVmg+S
 ZNyMfdxtSfXkPrTpxdAZ2IgCI8bYQmEtOf5c4pE1m6eZE3iHovB/H+Tlu+F0k/uyd3qqOEhUn
 uGukebR0Jc/eyoRNCszk4Axs243F6Vnlq4qvFVQPROQhKqBi0ycpd5wkikFEu8NhEahVV1RBy
 v6llC8435ab947kuY4XMubx19opaaLvPuimr6eQAIysAHghRjHCxjpPf+9Z9UnlllcDMsNKl4
 vDi1gFwGgeujLB5Qh6TfVG9crQ9Cu22JHFxU5uYOdNeb5AlLlLlmS7aD6zhVXNrZHjQHKv5Im
 W/e5/tM+KdUm5XYZfJhyfrOUii1bAZv/tjk9fUDlBrOK2LEl/yfFVl4wjTW7jgD6IU/IQdHkw
 71yY6tG+QHsQAAQZku8LHkaInCJx1CziCAZXEpilG4y0VDW8MMy05wE/DEv8qKh9cFU6O6P+U
 UVAlw1uNZ9q+pXmgVMdFNS13q0n92WEl5zSxpfLflCDW2PXS9bsvRCcI8B4kICCsl04ZCy10B
 vecIaaqBHiOOdzH3qBMPhQcynNyh1AWOKvxN4IXaV7XG94JFvaAwpc5jQ2LF1HDcYsKokdQJ9
 ng4wpDUCh6HwJDEjhKO0v5DIscufZk4V311/1vwJGj/HDm6M2MpWktvqWoKYsQEPRojefvBeD
 MJx+AdSOBbbj3jYOgL2wjuFjovscKbdWiwFdHNauo4JZQ5ojags5z2eDW/sT2xHeRWlI/qfQf
 3912M4yokXLWXeQq6S5GlWv9ITuGxKONy1BZPNjbgBf2FtlMqHGVaw5MNy9igBHZXaDykPaiG
 gAvNH0IQXRXmmUOapCpl/744w6ZG4JlgNMMg3C9IB/5/zuVR/U0QY15CTK2+qQyjhTMbl73KW
 kppyh1i/FxiWbr+6giCQo43285fzQzzGISrCDiBTbHsfv8Jg+ZnYo7luAMa4LpsJF22VlEagY
 30QEAWST9EMqSiJaG7rrhb0BeWyiUq2mP3ifcj1Y8d1fBNLRRKE/Qwb1xcZPZAbldxFDwJPd6
 bCocDD/byIL/ms01huKrI+3l0B8VHb+9azuoHaSpQugAtQh8axpHHOD/jAEc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> I think part of the issue is that the script reports a WARNING

Would anybody like to change this category to =E2=80=9CINFO=E2=80=9D?


>> How much does this information influence really the stress tolerance
>> and change resistance (or acceptance) for the presented collateral evol=
ution?
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/=
scripts/coccinelle/api/devm_platform_ioremap_resource.cocci
>
> -ENOPARSE.

* Automated processes can trigger also big amounts of possible adjustments=
.

* The software development capacity will vary for affected components
  during the years.

* Implementing changes is a recurring project management task, isn't it?


>>> for something that is definitely correct code,
>>
>> Can related software improvement possibilities be taken into account
>> again under other circumstances?
>
> These patches provide no improvement whatsoever.

* Do you find information from the description of a corresponding
  commit 7945f929f1a77a1c8887a97ca07f87626858ff42
  ("drivers: provide devm_platform_ioremap_resource()") reasonable?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/d=
rivers/base/platform.c

* How do you think about to compare any differences with
  software build results?


> As pointed out, they mostly introduce bugs.

Would you like to check any error statistics in more detail?


> Providing Coccinelle scripts that scream about perfectly valid code is p=
ointless,

They usually point opportunities out for further collateral evolution,
don't they?


> and the result is actively harmful.

You might not like some changes for a while.


> If said script was providing a correct semantic patch

I got the impression that this can also happen often enough.
Would you like to check the concrete transformation failure rate once more=
?


> instead of being an incentive for people to churn untested patches
> that span the whole tree, that'd be a different story.

Various developers got motivated to achieve something (possible improvemen=
ts?)
also by the means of available software analysis tools.
Mistakes can then happen as usual during such adjustment attempts.


> But that's not what this is about.

I guess that your software development concerns can be clarified a bit mor=
e.

Regards,
Markus
