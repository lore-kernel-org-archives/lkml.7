Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFA4C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 20:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 627AF215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 20:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Y7vfM7kp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388197AbfJDUjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 16:39:36 -0400
Received: from mout.web.de ([212.227.15.14]:39335 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388107AbfJDUjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 16:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570221557;
        bh=51r0tcZ8GeAH/PWLpQq89bWWuD+TiQD1bIq9cOY1PQk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Y7vfM7kp1kOeqnuttFTsfsKkkq5Ol8jOdxpGd5aUxMVfCsjsI4UQoLBjUSFPDR7fn
         1EmyBg71r6r/PzGd+KfL+XWY81weZCQZ1lBI2BAvu2uaTx9/vECVgujopYAZLSzbbt
         th2/kyhbo2vFKX7/khyg6EhgnCn6blRndmqgIIFU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.27] ([77.191.3.29]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M6gdA-1htKjI3po4-00wWe7; Fri, 04
 Oct 2019 22:39:17 +0200
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_3/3=5d_arm64=3a_dts=3a_rockchip=3a_fix_Roc?=
 =?UTF-8?B?a1BybzY0IHNkbW1jIHNldHRpbmdz44CQ6K+35rOo5oSP77yM6YKu5Lu255SxbGlu?=
 =?UTF-8?Q?ux-rockchip-bounces+shawn=2elin=3drock-chips=2ecom=40lists=2einfr?=
 =?UTF-8?B?YWRlYWQub3Jn5Luj5Y+R44CR?=
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20191003215036.15023-1-smoch@web.de>
 <e4aaddc2-441b-b835-380e-374a3d935474@web.de>
 <c180ec58-083b-5730-a188-58eb6100b7b6@web.de> <2162187.GalWoky0CO@phil>
From:   =?UTF-8?Q?S=c3=b6ren_Moch?= <smoch@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=smoch@web.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a5514bb4-472e-b697-27a4-54e30d5679bd@web.de>
Date:   Fri, 4 Oct 2019 22:39:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2162187.GalWoky0CO@phil>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
X-Provags-ID: V03:K1:3VkLq02MP3n3NDObe4FtrpHioWHHtcccvbg0vzgDwmPbBx3nUlr
 lDZY11tHDCCGA3L4JRbTXXmeSNjQwGDaI5dVUpKAhhZYAc53NkjY+5JxUTQO9dGdqifmxo5
 Ip0l9j7s37QSuGN1vqPErylQwnoNLxITejVESavZ6un/d4HD7cougZF9mlSSZldNDdmxSmD
 vmRKOJ0L1VSFwgKVc8BeQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yNeFNjnYnto=:ASmQsArBEHpMhOepwramr+
 HmwnKo5lRapkhEGwlrshnL0B7PuD0ALM4n3CVKtR0dhBmDbIafjGB6+a18aFiA4r/E5tH0L8S
 rtmAKahpO7fATIDFFm1swwlu5L/BEdfHQTlja4Y8J1FybCwRvaYpdRnYwQr30fWLawK5hi7nC
 Y6XErWCLsTLgpUSpUYP1sm1i9/RA9riaYCGPs9ocqamiC/6Sm5gI6KpFiseTRxB7strEhoeEj
 8zrROX8VuvgO1kjLY1hdE2fnLqwaxEbBWWbRaskUwFFAVG2qfunUizwhOieYe3UmXz0e+c8IO
 /v+MnC2cUVfO99/+1ocyba3iJllitndW33OvzamX5pdO6NdVtIg/cA5pkCEEGHdhFCi2Y2htS
 R1oX9c0bzBGqZBxkSh/tiy6ETKkXePNgZZwaA+k10HamuEwxcJcUWKR+CvCSrfGwrIA9TYZFe
 x34XLp8Aa9sk8itC6/atOiTC/O+231XnJmAQLbU+N08+RCQckhisrISvJNLRZ8kj7EqBCdzWE
 cH0uP9oMF/EJoK8KYTlTUTiQeYFZ/lKlYY2TWgxrNlpdeR7SiRJgoG0m6aR3f6h17U/zAuFOo
 moL7kPv4Se+68E9YtlQ+BG+zhcgiKdnxHwI+Huc49W/wUsaHCJJpXWlyvatt3BHaMvBxYjAUA
 cdHEsCgWAWTI5jOUwHK7/3Fc53oh2Sc6wSPp43D2H/sbcchxwWSltZJ05J3Ty3jlipDPgnGnn
 jjY309+ncEAdprpNCLePl+YQUijKOgOh5K3dzXST8QCLpn2NqiZesT9Z3qBgdXJu2S3Bol+pC
 eHIkd18Y+FIIcPb7q5y/q1lPkf7ZE2s3wtcm3w1DHHbSoYLUR7RuxNjrG3XS/B4mVfuE+db2t
 9xy4KWpwwK7YwEQMsTsWJhqwFwMs5jruxuYui9nWZhtqIDFLieZwBjAgVXYSKHQOXBby2d65S
 gZy6QlVoqy/zI74NNzhPCfCMOe86nrQFa2ddRPojrc0RRrz6+46Udbm8NUGs04BkrXR58cz+r
 +6z7ElRlbFS5Gr9o6H04Sbnojph+ndB5WqpdJ2rd8WEPNWNvkJcW2+Fy9/sFaPKPZ7zxtjute
 mOIe1voe6RWewypomlV8C7fu/47iQrXwh8AyWcS81EP5Aowp9ojskqWHZIQ7AtITHFc2sHrk5
 No4Ix3h/ZVQdgXI8tZ8hWjCYGP8dcGH3tUMs/gqLjh0FdexaCMrFKDX+o8GyXTe3JwoGm+GZi
 U8+wXBEqGm6J0GMmsFckeEkycAs4s004RtCqNEQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04.10.19 22:18, Heiko Stuebner wrote:
> Hi S=C3=B6ren,
>
> Am Freitag, 4. Oktober 2019, 22:15:45 CEST schrieb Soeren Moch:
>> Heiko,
>>
>> since you started to apply the first 2 Patches of this series (thanks
>> for that!), now after all the discussions here (and the heads-up for t=
he
>> implemented mode detection) I think we should leave the vcc_sdio
>> regulator settings unmodified.
> I was composing a mail about me holding off on this patch due to the
> ongoing discussion when your mail came ;-)
>
>> It still could make sense to remove the cap-mmc-highspeed property. Ar=
e
>> you OK with a V2 patch for that?
> Sure, go ahead.
>
OK, I sent a V2 patch for that.

Maybe someone can come up with a real solution for the 1.8V/3.3V
problem, which would allow to enable the uhs-sdr104 mode by default.
For now I think we have to live with sd-highspeed to be able to
(re-)boot from SD.

Thanks,
Soeren


