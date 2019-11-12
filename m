Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAF8C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA2F5206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="GQMA3WZ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfKLKWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 05:22:12 -0500
Received: from mout.web.de ([212.227.15.4]:33679 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbfKLKWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 05:22:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573554084;
        bh=zKVb9WMuQ7zRQYv1GZLrzWxEJS3VRLzbpd64rrU9ml8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=GQMA3WZ0htXxLWCRbHaT+ovKpkoJXAZLw7lNKlSZKtjbRw6nkBHzIlwI20F6wbWRF
         QUdd2+2+k6s4YXXHIPaiCs3p9Oqfi9E+v4wfHe9yyxVanEvj+VgiPp/c54D/S0HgFy
         g9e3sNtem/DrGXg8yzEY318FXh/dJvQ3K/sq3MEI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.43.108] ([89.204.137.77]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MDgPG-1ig4gE0LSY-00H9Ox; Tue, 12
 Nov 2019 11:21:24 +0100
Subject: Re: [PATCH 3/3] arm64: dts: rk3399: Add init voltage for vdd_log
To:     Kever Yang <kever.yang@rock-chips.com>,
        Markus Reichl <m.reichl@fivetechno.de>, heiko@sntech.de
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
 <17e14b30-02ee-2379-8891-088677924479@rock-chips.com>
From:   Soeren Moch <smoch@web.de>
Message-ID: <fd9ee2bc-9dfb-1aa2-f00f-add9b3069876@web.de>
Date:   Tue, 12 Nov 2019 11:19:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <17e14b30-02ee-2379-8891-088677924479@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
X-Provags-ID: V03:K1:dSsn12ZY5BPyYvsi5lOeFhAuWonqE2SikhTXUxedBa/QOws+FOu
 Lwoaiezl4xgI1mVpEmVtCXu1r3/IWm0Mpa/jX8cRphuYEKuHOBLd3Ln5wP3NL9qZQH3xQ5E
 So6xWNQ6sErfO9qtb+M64aJo8Qk8imKVclSLc97xLYfJrlZHzDePPQQkF/Z/xys1w5ZsA/a
 XDJ43CAYOO5lvaP7IR8HA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5EQWttFTmDM=:qJoFYz3j6+rrHIP6xKcCbw
 lyeBNDtYnHGEdflRx485fK62HpSetwKZJQQ3ekkZUa54Ns/0w0tSn+kqF3VwGdWI6RgCkHeZu
 03zi/kescrofXmpoivIBLGZcvjVCDCERWlU/CFySNqaW77h5iouLdI6qYNgH/74daUX1tl79P
 w8dcKCYro9U5aDOEddlDYh9jvBG4lKkIhpvEdECq8kk+MhcQBN3F0d39MU4q+hnYdzU6QSdI3
 aqemPF/yeQBppecWxMQ1UKbYFj97jV2nbqvjjBnen5tHVNTzjiiqfWH7j6SGfFzBR66Gr0iwH
 hI7tay6LdtVSF3LdVmWQdqwIa5hyB/pRt0KOJTZPU7bozzysxPChhFu43ZSxOebMRmhNZwMxq
 LsNR1oeEF62hKkKDrVwkHmrPxJwRAkc9nc3+Ofxu25gq2VSSot4+KJr6qpFtyymC5iqOouD/w
 JjkcCxo4F2ys/AYJ2uNqsyUxpoU5Yl5pJNzA2p4GGkBVVXcmEfGI48EPshPCnYIJNNo4GnSte
 ilOHKD0WZNzGK4VGPyHjvs7t7p3+zeDVzE1K31g+T2z4jbwozdoINE8GRDgnkZ7DZN5cQ80As
 96W/pK2mIMi3KuXHzm/KC3DwYbuveyKETwcVl5n/CXwe3SQ8k6s2rbiAnIX993dJuxy1H8CLx
 v1bmywB6M4tKYcfzJRNpqSoEvB3Ugqnuf0358tb8k68k437613Z+GJrAeoQWfg3PvcZxHdSU8
 DTdewZoKa1bFYSuz2j5IvJi7aSobR6uL4rvsRXWwnG6zlBUfyHHv3wse1PHuvJ0YYIU3dj2lq
 o3S4MZII0VdgraP30qyyS8sm639JGZXTKt1xlfjEblv0ebgK3WI92Bqkd+YZnCo4vr3+m0EhY
 l03RmljYfur6RVV8rOyy+ablaZI/PO4mJgElizmGH4t0mFC4S5baQu0CsT6oX0HYqFBej9AKb
 qGFml6yNutJNA78HtPXRknRODANzFzDKywfuM4E3dKawHQk6G4a0yt8V2B/zN3u7dTUDp9DA8
 roLuO8FL+NACkTlysHVHPfiIUoz1eG1e+PiT8Qxw2D1f8wGm7SX+HklutniawQ26s7pOw/RkK
 oxHlZWvDovRMtVRRg3s2rkBntZLiUOQN3/FkTNYKJRf9Lu+s8tGBhBmqsbILTb7wPRpHnpL9i
 nxbZgpy2HMUWKEPqiHdsXG4PEn36I2g6JICQv/VWbys1USOK8ULlUXGPERWtedBD6EWDYjUhh
 kX2CKVcV2/19i74gmCW1yWaIvvK9J+nuy7/naHA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.11.19 11:02, Kever Yang wrote:
> Markus,
>
>
> On 2019/11/12 =E4=B8=8B=E5=8D=884:16, Markus Reichl wrote:
>> Hi Kever,
>>
>> have a rk3399-roc-pc running mainline U-Boot and kernel and vdd_log is
>> showing 1118 mV.
>
> The rk3399-roc-pc have the same vdd_log circuit in schematic, so it
> should like the patch 1/3 of
>
> this patch set.
>
> I don't understand who is setting this value, maybe the default value
> without pwm regulator enabled?
>
>> Is this a danger for the board?
>> How to fix it?
>
> The best way is to set correct min/max microvolt of the
> regulator(measure with PWM output low and high),
I didn't look into the schematic of this board, but if it is similar to
RockPro64, setting the pwm regulator to the max voltage of 1.7V will
probably kill the rk3399 immediately. So I recommend not to do this...

Regards,
Soeren
>
> (note that if=C2=A0 no driver touch the regulator, the PWM is default
> input, not output;)
> to
> and set a init-microvolt for U-Boot driver, and I think no kernel
> driver touch this regulator now.
>
>
> Thanks,
>
> - Kever
>
>> Btw. vin-supply for this pwm-regulator is ignored and I could not
>> find it
>> in bindings doc.
>>
>> Gru=C3=9F,
>
>

