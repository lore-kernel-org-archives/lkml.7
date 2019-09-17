Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036E3C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 18:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF3A206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 18:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfIQSDd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 14:03:33 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:36209 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfIQSDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 14:03:32 -0400
Received: from [192.168.1.162] ([37.4.249.90]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MAOVx-1iLaDT11kB-00BtYg; Tue, 17 Sep 2019 20:03:12 +0200
Subject: Re: [PATCH v5 0/4] Raspberry Pi 4 DMA addressing support
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Matthias Brugger <mbrugger@suse.com>, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     f.fainelli@gmail.com, phil@raspberrypi.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190909095807.18709-1-nsaenzjulienne@suse.de>
 <5a8af6e9-6b90-ce26-ebd7-9ee626c9fa0e@gmx.net>
 <3f9af46e-2e1a-771f-57f2-86a53caaf94a@suse.com>
 <09f82f88-a13a-b441-b723-7bb061a2f1e3@gmail.com>
 <2c3e1ef3-0dba-9f79-52e2-314b6b500e14@gmx.net>
 <4a6f965b-c988-5839-169f-9f24a0e7a567@suse.com>
 <48a6b72d-d554-b563-5ed6-9a79db5fb4ab@gmx.net>
 <2fcc5ad6-fa90-6565-e75c-d20b46965733@suse.com>
 <3163f80b-72e5-5da8-0909-a8950d3669f7@gmx.net>
 <a5073e16-c017-216c-72b4-0e861102c4e8@gmail.com>
 <c7e6ab89-aaae-debc-5f63-2e091efcf76f@gmx.net>
 <197ebc29-2e4d-fa2c-7ad4-1a83ce3f3eb4@gmail.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Openpgp: preference=signencrypt
Autocrypt: addr=stefan.wahren@i2se.com; keydata=
 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 AQ==
Message-ID: <5870dc40-331b-d4f1-3eef-e7c08d5326c5@i2se.com>
Date:   Tue, 17 Sep 2019 20:03:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <197ebc29-2e4d-fa2c-7ad4-1a83ce3f3eb4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Provags-ID: V03:K1:6y0DZe1kUadHoxS5LysJaS/RIJsVaAQGfjhvLJeUSkcB5w9m7cN
 rLuRJGt1aDHj0VrPLbfdT8NrvFe71gkxVNUGOk4g/LhB8v8W7LcBAgnesvyo2YXOMzNuQFf
 gq4Swzu4eune2aIb8ybJzxHi+Ys2eFtOzv8/6iiP0MjGMQA6iSiyVpz8JEry31NitBp9BVZ
 09nikX9yO7OxWKMji11xQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3QeQE75DKZ4=:6Y9gj8JpU6AZhEW9L9AuzQ
 dso+qKp7F1oqyLimvFgv2OQGamvafPKp1507sedSO19NLYZT7cCbVH1Mw/VSsQ5l8l/P2yviH
 AbIXcUtxbfGc7v4q0TVwNBZousQeRATFQ5Y1EZy9ZdFH+9udfGoexaXyW1jW7Chrb6iKzwktJ
 uGizE50LYsI9dIxtSuK1OaGQCxNbo1o9XOY2rgNMKnbCHaHTxnNRWn8p7US5HRGGges05BxV9
 M8kL/DjAxBvJeK1129npeSy6cfhDD7yt0UpS3LydxL2eJW5rWxoQBiVBa6PgSZkQbFCDwDvWM
 NO7hYJpduSlFkWrvmNhamQfpCpNIlB1v0sFgZ472VChZe2fDXYZJlXvAgf7RzFxe64cbQDzTD
 O8uTMg64FsZI9JA0fHKV6xE18ZI7Gya2w348nbI+jg25eUhUBU4p501TcORm7Lt1zvEcXqH4r
 70LdKLbbSNoz3q5boivl1mlxgBVcx1qJS30akVOXTEGteZDfkJ7hCt5gqrgU9KD6InO1EO+Ru
 l+i1feyzKQ9brlr7t2rEyOAw4Hh/AMhW5rvwWU2a31dZExELQ1gNcTHun2qAQ1y9NRUMXcRjC
 K77waq7gBt6lyFrh6waKuUzLcpd4/ehKvSVd8bPzUkTgg6zaZa5ns/15qLUxfy52QPHZ2mE6X
 Z6G0aaJNx63jfcVT2y4DaP22MWm4/6hscG1MDY7H5MdKjudHXBGYGnGJ1uQGdKbaMx+N8leYr
 +H0U9bboVIMApXUk6qJossuwK84ax/x27EpVbjjX8smhtR78FhDMRBK5X8F77EA1l20OLG4TL
 2xXzAcxKOacx5i+G327b3tvFEwTXUM4DQWDR+yoavvIPhDnKghzDkeobbjQ2gUibT4bq5rD6h
 eHEixDjW07u83Bwi1DYVEsGD9vqsjRBr8zENIXWxw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

Am 17.09.19 um 11:04 schrieb Matthias Brugger:
>
> On 16/09/2019 21:19, Stefan Wahren wrote:
>> Hi Matthias,
>>
>> [drop uninvolved receiver]
>>
>> Am 13.09.19 um 12:39 schrieb Matthias Brugger:
>>>>>>>  If you talk about the
>>>>>>> downstream kernel, I suppose you mean we should change this in the FW DT blob
>>>>>>> and in the downstream kernel. That would work for me.
>>>>>>>
>>>>>>> Did I understand you correctly?
>>>>>> Yes
>>>>>>
>>>>>> So i suggest to add the upstream compatibles into the repo mentioned above.
>>>>>>
>>>>>> Sorry, but in case you decided as a U-Boot developer to be compatible
>>>>>> with a unreviewed DT, we also need to make U-Boot compatible with
>>>>>> upstream and downstream DT blobs.
>>>>>>
>>>>> Well RPi3 is working with the DT blob provided by the FW, as I mentioned earlier
>>>>> if we can use this DTB we can work towards one binary that can boot both RPi3
>>>>> and RPi4. On the other hand we can rely on the FW to detect the amount of memory
>>>>> our RPi4 has.
>>>>>
>>>>> That said, I agree that we should make sure that U-Boot can boot with both DTBs,
>>>>> the upstream one and the downstream. Now the question is how to get to this. I'm
>>>>> a bit puzzled that by talking about "unreviewed DT" you insinuate that bcm2711
>>>>> compatible is already reviewed and can't be changed. From what I can see none of
>>>>> these compatibles got merged for now, so we are still at time to change them.
>>>> Stephen Boyd was okay with clk changes except of a small nit. So i fixed
>>>> this is as he suggested in a separate series. Unfortunately this hasn't
>>>> be applied yet [1].
>>>>
>>>> The i2c, pinctrl and the sdhci changes has been applied yet.
>>>>
>>>> In my opinion it isn't the job of the mainline kernel to adapt to a
>>>> vendor device tree. It's the vendor device tree which needs to be fixed.
>>>>
>>> I agree with that. But if we can make this easier by choosing a compatible which
>>> fits downstream without violating upstream and it makes sense with the naming
>>> scheme of the RPi, I think that's a good argument.
>> i spend a lot of my spare time to prepare these patch series in order to
>> get a clean solution.
>>
>> Either mixing bcm2711/bcm2838 or changing everything to bcm2838 in the
>> upstream tree has the following drawbacks:
>>
>> - additional review time and delay of the Raspberry Pi 4 support
>> - harder to understand for developer/reviewer without RPi knowledge
> On the other hand it get's confusing that the SoC for RPi4 is called bcm2711
> while all the others are named bcm283x.
one could argue this is a complete new SoC. But i got your point.
>  Anyway if the majority prefers bcm2711
> so shall it be and let's get forward instead :)
>
>> Btw currently u-boot only uses bcm2711, so it would be nice to keep that.
>>
> Yes that's true. We already identified the compatible we'll need to add to
> U-Boot to also boot with the upstream DTS. I'll send a patch to the U-Boot
> mailinglist.
Since the upstream DTS isn't completely stable yet, maybe you better
wait until it has been accepted.
>
>> So my suggestion is to add bcm2711 compatibles in the downstream tree.
>>
> Ok, can you take care of it, or shall I send a pull request/open a bug?

I'll send a send a pull request and hope the RPi guys are happy with it.

Btw the clk changes has been applied.

Stefan


