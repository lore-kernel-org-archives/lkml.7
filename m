Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B549C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88F6214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfCLPma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:42:30 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:45697 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfCLPm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:42:29 -0400
Received: from [192.168.1.110] ([77.4.190.91]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MvKGv-1gleWf3BZp-00rL9O; Tue, 12 Mar 2019 16:42:08 +0100
Subject: Re: [PATCH 38/42] drivers: gpio: vr41xx: use
 devm_platform_ioremap_resource()
To:     Thierry Reding <thierry.reding@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, andrew@aj.id.au, f.fainelli@gmail.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        hoan@os.amperecomputing.com, orsonzhai@gmail.com,
        baolin.wang@linaro.org, zhang.lyra@gmail.com,
        keguang.zhang@gmail.com, vz@mleia.com, matthias.bgg@gmail.com,
        grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org,
        robert.jarzmik@free.fr, yamada.masahiro@socionext.com,
        jun.nie@linaro.org, shawnguo@kernel.org,
        linux-gpio@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <1552330521-4276-1-git-send-email-info@metux.net>
 <1552330521-4276-38-git-send-email-info@metux.net>
 <20190312113732.GG31026@ulmo>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <e224f52a-a92b-63cd-a9ed-67672a2c7337@metux.net>
Date:   Tue, 12 Mar 2019 16:42:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190312113732.GG31026@ulmo>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:fEymrQE84X8YA4VKIn7db4UHJeguHMCEeiDadNUHJItc4Cyf4xS
 DPVJ6hS+rZ/+ievdjt6JfA6pIi71QiNcE7BA6YaXwa3m4svvnCjWjIzPQxcm+CP84hyj5qA
 MsJGBFzxD7fqIuxkvRxuTxeH76Wm8ckXk2e79f1xcV8P4AZAvng6BPIkwa1EurRK4ANnN68
 nz/3orX7Qk4FIzVVz89Zg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DyStniLx2nQ=:CrU5Ea/kakURxVSPWEtxmL
 YSiYbA49+D53a+W4GWP+4fGBmDjLKomYamau2nwrCER/QhFJipUPUBvT9qRnCwfcRyobl8Suk
 fmnf9NJTuKD1Nn5M3aoR9dV9c+27Ida4vg0/qKGizBEP5ml2Qz7YXx6lAEAf37yUp7EoErqGk
 VxSP7MMarFaNvaacPoJB1ZlHz++rs3iiFFCbxMBWtERHWU+LyMg0eqXniA+w+IRGieLJfUyUA
 zkVHOILynO1M0n3pVOjrf12STYvdKfCAapo4IGfH9CD8IEBt3Ysh66FqxuAqmltggP3+z5Y4i
 fPKt/GG96twvXhyjZ1Hb8aqeVoGP67JHpgwbO5yhWAPkHEDOvc+rpUN1Di0Vhg9PuI/wSrRZt
 VPVr8kSjqfOCAew0wnSbxGk6fM/01fqZf3jita3zXonY4PRPEZ+OB5gSIKNzopltX1YC+RVtA
 3MWgudvP/pmheSEY1u1BAFiw9GdcE3mbjnfiOFxJ1A2N9NJ2njWj2Ff0e4QZgctbZlBp6VB6j
 yq26Fwpr8dPoD0qrF0tTKpQzs5CNlnig2WBNxbtS2rWQ8L6Ud+p6wSHh19a66REeLwu6/lIIL
 EHURR8SXo6BcsnThw7+G2BBvUv+i9miHSljnpwtiQ3RILF+xqMyh6B01NpK6MofejtPGv31zz
 Yn6Y79n8Wzi2NA12Km089FUg7OaIeUPUdoIVZkMs3SKzZti9aBEdic2wncoHOFut2l3ZZ+IYw
 0LYtNalhYWKxSuaXr/8WYe6yfUuDxDxBmFL9BqmdYPw1vlXIzmyc6TjvqyU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.03.19 12:37, Thierry Reding wrote:

> The driver currently doesn't request the memory described in the
> resource, so technically you're changing behaviour here and with your
> change the driver could now fail if somebody else has already claimed
> the memory.

hmm, using w/o requesting/claiming - isn't that a bug ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
