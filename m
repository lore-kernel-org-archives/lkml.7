Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33274C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3E221925
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="UML5kkxX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfKLIqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 03:46:17 -0500
Received: from mout.web.de ([212.227.15.3]:59145 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727104AbfKLIqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 03:46:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573548315;
        bh=/69UOQg6AJRBn5Y5kan0J7mFNy7LzuCtg2qizG07W3U=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UML5kkxXSQPAC3OwZZutICKLn+FTlBAPrBk//cS1ZT4ZWWzvksaLdWQ1xPIV2O5BJ
         6cHONpjgmJRjSTsQ6/aRwiiQtwanyJHgLEJp8mU6yB6697Kdhxag+yN2DzcI1el1ua
         HjLlCcLwr2IsbVO+dzSdj7nY5uy9FNrsNHSHexkY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.43.108] ([89.204.137.77]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MeBEk-1iFWlw0uZ4-00Ptgl; Tue, 12
 Nov 2019 09:45:15 +0100
Subject: Re: [PATCH 3/3] arm64: dts: rk3399: Add init voltage for vdd_log
To:     Markus Reichl <m.reichl@fivetechno.de>,
        Kever Yang <kever.yang@rock-chips.com>, heiko@sntech.de
Cc:     Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Andrius_=c5=a0tikonas?= <andrius@stikonas.eu>,
        linux-kernel@vger.kernel.org, Alexis Ballier <aballier@gentoo.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Andy Yan <andyshrk@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Pragnesh Patel <Pragnesh_Patel@mentor.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Nick Xie <nick@khadas.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Vivek Unune <npcomplete13@gmail.com>,
        Akash Gajjar <akash@openedev.com>
References: <20191111005158.25070-1-kever.yang@rock-chips.com>
 <20191111005158.25070-3-kever.yang@rock-chips.com>
 <ef8830f3-10d1-7b71-0e18-232f2eaeef2d@web.de>
 <1eaef5d5-c923-da56-b9c4-48d517b3c969@rock-chips.com>
 <acbab893-9e9a-cfe1-67bf-a9e2b2e50114@fivetechno.de>
From:   =?UTF-8?Q?S=c3=b6ren_Moch?= <smoch@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=smoch@web.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <88ad7dc9-5299-791b-e285-7775ddf885ba@web.de>
Date:   Tue, 12 Nov 2019 09:44:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <acbab893-9e9a-cfe1-67bf-a9e2b2e50114@fivetechno.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
X-Provags-ID: V03:K1:P631vcNOXvn80kQFRh1MMqhKnqdMniiDSlzA/Fe9ZdqNLhl8aCJ
 BGfLB3CLAOIg3h4IKI2AqTKLVWFdsJuWJp5XMHKOvhHv53IcSZjaMF9kGYt7QAEN5dl3R91
 6/ai5G0iT9esdi0xHryc6hzLrXlTGJSvLEN0irVF8Vw6uB38l3eBeGTLsvp2c+M6KiF+mjF
 02UMB5GIgAPFQNp+z4ong==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V7EFa0VgYFk=:up85voY2VnOyzIdfyyo6IE
 0+AxbvxswgC6NdAkjATdDYjZDn+++svhfS622taimZfRlhcL58A51FuO7UU4u/U7yDoWJk9Jp
 3dSsBhEapbjqKWBeCoylXLYcmGMWDsyJSTJVl08YBiszXsWmbESlFicbg7GAawySikatr/uKj
 uu6Lgj2VxqzFjWdwLq+lZI8U1m2zp+ZRTCMzqp+mLcB81P2b3KbQLPC4M8Mak2rvFcPGJrUcT
 MWQxWQEC72m2MDtbi+mDSfeO+WBg5oCVFHvjCZLKGd+pBh0XVghmxAKg/0HHKHm+xuQjuoJhn
 K9aZwME7GW2Hzb26D8ZyUthBmKQr2/xLXRxrXUzaTRRHPvE5u+J4JURdzftgCdeEvJqZbvNTE
 Y9BK4H7wr8hFpHiWar/h4ZHx9GZnCJ4dppnT7C/a8aeT/ar/T/FeV5zSre/JwzLztILlWEv86
 6eQJwi+UqvizmbCsCFa2YPK3jN6muYInepcpk13QxO++hWH+x35uKvPJHB4WMK/PbH/hEJ1XM
 HdNEdyoRC1cQC3X61/+M2JR+6FdXUpDY5LBnxDBziI2TGgr65C6EsjvwHnsZf68NDRpyAufO0
 pZZ7sieAT5G72vlxd6lgj+2+0HuS8r4VnPBfaKPn6dAby7/A9yEK8XT76HDmYD0CJqH2hkj0Q
 nu3/FmkKGQocdk3lDhhdkQonRUbgjO3ly+WrdORBPTnJBNsg6c1jGDTkQWpQxsfQfdIufFN5R
 9Oi+QAXFHhvXSbwp4r/MShTV85jCVNZwNtUW/PTmsJni1kKmu2bs7CheDUOGuNeb+IUs+j8Bj
 /pZNoJhfpGSNYDgiwenesDgg1MzhjZs+C56dXYMgIFyNM8Sp8tyvgFfnOSCpg3FcE9HqVXOSa
 UsldmW7Nhu4eiLfp+eJvxyEvN6tuKYeVVSz5gtf+LqANpUR03+vf9uc6fYFZQwgTdv9vzXuTu
 ibiTMKcM61mLnTDHb+CxwVaB6S7i7uHR+hRNnuv8bUtXr9DUsMcTV5NO1DLZq1HTNiiZqSITj
 XhgAH/KbNKmFPagA1APc8uMmjCLRQ18ppkJH+HFPErC5dHa3yBLs3nI7Ogxl09uP/lOAzIWSy
 tRSrslI7qOH9aDNu2BPWQchoZUzbFn7DwHBlbiqP2FsR2khAjBCqfiCmCDBqPNvyTjY9Z531R
 LnQutdEAATT4GxloeN74zTP5ZVky2706OMrvQBc3geTz8tTP+/ahfQNvLO4ea7THZYl7LZtim
 tYOuK8tL7LfNvW0sBvJU4dtUAiYUPwUYm6ehaog==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.11.19 09:16, Markus Reichl wrote:
> Hi Kever,
>
> have a rk3399-roc-pc running mainline U-Boot and kernel and vdd_log is
> showing 1118 mV.
> Is this a danger for the board?
I think yes. What I read vdd_log on rk3399 must not exceed 1.0V.
> How to fix it?
You probably need to do something like [1].

[1] https://patchwork.kernel.org/patch/11173465/

Gru=C3=9F,
S=C3=B6ren
> Btw. vin-supply for this pwm-regulator is ignored and I could not find i=
t
> in bindings doc.
>
> Gru=C3=9F,

