Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499F8C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 23:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1008722464
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 23:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Y2D3pqRK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfLPXaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 18:30:23 -0500
Received: from mout.web.de ([212.227.15.3]:49927 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbfLPXaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 18:30:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1576539011;
        bh=T33zj+Q8o1ca1lKFKadu4ur84PQkmWBSsKv2IObMR+c=;
        h=X-UI-Sender-Class:From:Subject:To:Cc:References:Date:In-Reply-To;
        b=Y2D3pqRK5YD462THyvD9j9NJanlruny4ciGapaDzX8GuVqAXXhmJ8fBUws8+do105
         1AeJS/1392c9eZ1RJ43bt2cQWsy6LXK6osYSPzmjejEK3y06cDpV1C+nFflz01LnuA
         L0kxrLlbV+lHq0VYpSrnLuKHuVObv+rZ9uyhPh2w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.43.108] ([89.204.137.13]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LhvUI-1hvIjw3Qck-00nCgw; Tue, 17
 Dec 2019 00:30:11 +0100
From:   Soeren Moch <smoch@web.de>
Subject: Re: [PATCH 0/4] mfd: RK8xx tidyup
To:     Lee Jones <lee.jones@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, heiko@sntech.de,
        linux.amoon@gmail.com, linux-rockchip@lists.infradead.org,
        Daniel Schultz <d.schultz@phytec.de>
References: <cover.1575932654.git.robin.murphy@arm.com>
 <20191216111219.GB2369@dell>
Autocrypt: addr=smoch@web.de; prefer-encrypt=mutual; keydata=
 xsJuBFF1CvoRCADuPSewZ3cFP42zIHDvyXJuBIqMfjbKsx27T97oRza/j12Cz1aJ9qIfjOt5
 9cHpi+NeCo5n5Pchlb11IGMjrd70NAByx87PwGL2MO5k/kMNucbYgN8Haas4Y3ECgrURFrZK
 vvTMqFNQM/djQgjxUlEIej9wlnUO2xe7uF8rB+sQ+MqzMFwesCsoWgl+gRui7AhjxDJ2+nmy
 Ec8ZtuTrWcTNJDsPMehLRBTf84RVg+4pkv4zH7ICzb4AWJxuTFDfQsSxfLuPmYtG0z7Jvjnt
 iDaaa3p9+gmZYEWaIAn9W7XTLn0jEpgK35sMtW1qJ4XKuBXzDYyN6RSId/RfkPG5X6tXAQDH
 KCd0I2P2dBVbSWfKP5nOaBH6Fph7nxFFayuFEUNcuQgAlO7L2bW8nRNKlBbBVozIekqpyCU7
 mCdqdJBj29gm2oRcWTDB9/ARAT2z56q34BmHieY/luIGsWN54axeALlNgpNQEcKmTE4WuPaa
 YztGF3z18/lKDmYBbokIha+jw5gdunzXXtj5JGiwD6+qxUxoptsBooD678XxqxxhBuNPVPZ0
 rncSqYrumNYqcrMXo4F58T+bly2NUSqmDHBROn30BuW2CAcmfQtequGiESNHgyJLCaBWRs5R
 bm/u6OlBST2KeAMPUfGvL6lWyvNzoJCWfUdVVxjgh56/s6Rp6gCHAO5q9ItsPJ5xvSWnX4hE
 bAq8Bckrv2E8F0Bg/qJmbZ53FQf9GEytLQe0xhYCe/vEO8oRfsZRTMsGxFH1DMvfZ7f/MrPW
 CTyPQ3KnwJxi9Mot2AtP1V1kfjiJ/jtuVTk021x45b6K9mw0/lX7lQ+dycrjTm6ccu98UiW1
 OGw4rApMgHJR9pA59N7FAtI0bHsGVKlSzWVMdVNUCtF9R4VXUNxMZz84/ZcZ9hTK59KnrJb/
 ft/IEAIEpdY7IOVI7mso060k3IFFV/HbWI/erjAGPaXR3Cccf0aH28nKIIVREfWd/7BU050G
 P0RTccOxtYp9KHCF3W6bC9raJXlIoktbpYYJJgHUfIrPXrnnmKkWy6AgbkPh/Xi49c5oGolN
 aNGeFuvYWc0aU29lcmVuIE1vY2ggPHNtb2NoQHdlYi5kZT7CegQTEQgAIgUCUXUK+gIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQANCJ0qFZnBAmcQEAkMwkC8NpkNTFQ+wc1j0C
 D1zWXsI3BE+elCcGlzcK8d0A/04iWXt16ussH2x+LzceaJlUJUOs6c4khyCRzWWXKK1HzsFN
 BFF1CvoQCADVUJEklP4MK6yoxlb+/fFsPw2YBNfpstx6TB8EC7TefHY1vIe/O4i4Vf4YfR+E
 dbFRfEc1uStvd/NBOZmEZYOwXgKuckwKSEGKCDz5IBhiI84e0Je4ZkHP3poljJenZEtdfiSG
 ZKtEjWJUv34EQGbkal7oJ2FLdlicquDmSq/WSjFenfVuGKx4Cx4jb3D0RP8A0lCGMHY6qhlq
 fA4SgtjbFiSPXolTCCWGJr3L5CYnPaxg4r0G5FWt+4FZsUmvdUTWB1lZV7LGk1dBjdnPv6UT
 X9VtL2dWl1GJHajKBJp9yz8OmkptxHLY1ZeqZRv9zEognqiE2VGiKTZe1Ajs55+HAAMFB/4g
 FrF01xxygoi4x5zFzTB0VGmKIYK/rsnDxJFJoaR/S9iSycSZPTxECCy955fIFLy+GEF5J3Mb
 G1ETO4ue2wjBMRMJZejEbD42oFgsT1qV+h8TZYWLZNoc/B/hArl5cUMa+tqz8Ih2+EUXr9wn
 lYqqw/ita/7yP3ScDL9NGtZ+D4rp4h08FZKKKJq8lpy7pTmd/Nt5rnwPuWxagWM0C2nMnjtm
 GL2tWQL0AmGIbapr0uMkvw6XsQ9NRYYyKyftP1YhgIvTiF2pAJRlmn/RZL6ZuCSJRZFMLT/v
 3wqJe3ZMlKtufQP8iemqsUSKhJJVIwAKloCX08K8RJ6JRjga/41HwmEEGBEIAAkFAlF1CvoC
 GwwACgkQANCJ0qFZnBD/XQEAgRNZehpq0lRRtZkevVooDWftWF34jFgxigwqep7EtBwBAIlW
 iHJPk0kAK21A1fmcp11cd6t8Jgfn1ciPuc0fqaRb
Message-ID: <3c78d334-9110-e88c-84d0-2f41c28a6317@web.de>
Date:   Tue, 17 Dec 2019 00:30:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191216111219.GB2369@dell>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
X-Provags-ID: V03:K1:aQQt6gEvfZZSpnuGPpd2MPL5+550TSfsxGXFdGHveeQEcNHcEeH
 OPUpGN+ZJG7f08aSwh1pSIt3ckLM8ihVwuGwaN2TjcB9pdAgAp06Y6aDYILYrhBC8+LLlOT
 n7xJ+JMqosMaHDMC6zHIfEK3B9/LsFt8gSRttTxHYfBA32Yywv8rFGBjpFIAZeqiHAT76Q9
 GKjVeRnZMeO+rl2EgAc8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oAJENRqkylY=:MySoNGiB9KMAF5Zs9aBAmX
 wO/biDD9FkD0P9wxQJd4ONP68yrRac3UnLfVnpbkSHX2SBzkZO8pFL+98xzpzwGTiVUk/a89O
 VzpbBi3OEyo6P5MbPDtzINQg+7+yfJNOMa0yQBr2VpoTCb2aV445kpIOsnxgcMmKQad49eaSs
 SZnqJQxMeml0L+1nzEPBkyZF7x6dEnMMr0/e1CVso3Teets79tU5/q+uFbe7Cy5ZoEKzjCF0v
 fdqKDqq5P0Os8nkSS9HkEz4gX/eTCMMx9vh7YoqFCxLHxvKoCaIkdwgQwula6jji8YR00qq49
 huNZi/QvrAQVYyAwE5v5t65hTsYVCkHEMLgdC/2j181TEUgr4KZhN58eAIUVwmuSnvsrpSSJq
 V7QIUsLns9Joe89czsBGX/f7lxPrgJDqpqn8QyUYdD1oy+pWH/FIFI8HgDG5udDAAEEjo3IyW
 H4Egblqe6alR36xfNHj77SUbkUagbcbyA3TZ4atojg/OZEX+nxzkBCr/Z6DZXs6BUP7hGuXW/
 Mlbq/Ag99dtekzqb7CRbs0GxfHrW27SO2fl/5tSp/Wr5ZDxaNvH7dK7if80u08bhEET9uoAx3
 Qqy9oMLzgNyeRgtkPKwb/FXST3Qkatw/MxA5oPYvtKFJf96cQPpkXWJrTiKHqKCKrmtth4ZqJ
 mTiV3IcDqvIzF9a7RlsiWlQBy/VVQ+TjNjA0XRFm5lpzM5DOLbZdw9Z/FFNGB/0Ms1w3XcyDZ
 GyuDY7P2oRKVEcUhQ2SEFKINRohmWdHTV0HZrewQpcU+Vfgvp9JlYBW4rp2tcYOKiJNHj1vaw
 m8XdiSP7jQ7g651qDV5rBRWc2VtbXFxlAdPePaZjdmz19vtiv4NlsTOiTPSzhuS4Xq9ZJcDlX
 4NWV9guDiu0rYxWgPsWLcq2NKcXel3HNpGoiflf9eMnaBRVejr8DIF9Tbun6iXPSYveLaMoFU
 fUAx2uWZ+dtzTkl3jqaAZmebcksw+szMiJMQtat1bcO3UV1GEDRer/sWs5IHsfamruRhKsxME
 JcKNRjF3j8VHz2ICFOaCUq0Anv0LJ0/mQbY+C6ZhAXTpmzXR2QS9m2pv29lSlrLjhsTIK0QK8
 Y/pg97g+Aq4f3FrwFOfVkaf3DJDYFBNkOuY4Dl0XTsH992ZktkUAJzw+4Tk7vM1acWzg23fAr
 GEHwKW45rSG8pqNKig08CzIDPvcfZRNFeXZYOMoQNiz9CtnJXXhysQBz58Vh9xEvS6BgAnq67
 AyCBWX8SSgbUXBM8g3NY8ZHwI7Rkfj7lv0wwvtQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.12.19 12:12, Lee Jones wrote:
> On Tue, 10 Dec 2019, Robin Murphy wrote:
>
>> Hi all,
>>
>> In trying to debug suspend issues on my RK3328 box, I was looking at
>> how the RK8xx driver handles the RK805 sleep pin, and frankly the whol=
e
>> driver seemed untidy enough to warrant some cleanup and minor fixes
>> before going any further. I've based the series on top of Soeren's
>> "mfd: rk808: Always use poweroff when requested" patch[1].
>>
>> Note that I've only had time to build-test these patches so far, but I=

>> wanted to share them early for the sake of discussion in response to
>> the other thread[2].
>>
>> Robin.
>>
>> [1] https://patchwork.kernel.org/patch/11279249/
>> [2] https://patchwork.kernel.org/cover/11276945/
>>
>> Robin Murphy (4):
>>   mfd: rk808: Set global instance unconditionally
>>   mfd: rk808: Always register syscore ops
>>   mfd: rk808: Reduce shutdown duplication
>>   mfd: rk808: Convert RK805 to syscore/PM ops
>>
>>  drivers/mfd/rk808.c       | 122 ++++++++++++++++---------------------=
-
>>  include/linux/mfd/rk808.h |   2 -
>>  2 files changed, 50 insertions(+), 74 deletions(-)
> Not sure what's happening with these (competing?) patch-sets.  I'm not
> planning on getting involved until you guys have arrived at and agreed
> upon a single solution.
>
My understanding is like this:

The patch [1] fixes power-off to use the method requested in the
devicetree. This patch series on top of that cleans up the rk808
power-off code, which perfectly makes sense for me. I think these 2
patch series are not controversial as such.

And then we have the series [2], which is a mix of
- some clean-up
- converting the existing code to use syscon_shutdown for actual power-of=
f

Robin, Heiko, and myself agree that the shutdown method introduced in
[2] is fundamentally wrong. All syscon_shutdown methods of all
registered syscons have to run before the actual shutdown, what is
triggered in pm_power_off. This is how it works now, and what is the
right way to do it. Patch series [2] breaks this promise since it does
the actual shutdown in the middle of the chain of syscon_shutdown handler=
s.

In the discussion about series [2] Anand repeatedly talks about restart
problems. But this rk808 mfd driver is not involved in restart, also
patch series [2]=C2=A0
does not change that. So I cannot see what should be the point here.

There was an earlier attempt [3] to enhance this rk808 mfd driver for
restart. I'm not sure, however, what happened to this. For me it could
make sense to reimplement such restart functionality on top of this
"mfd: RK8xx tidyup" series.

Regards,
Soeren

[3] https://lore.kernel.org/patchwork/patch/934323/


