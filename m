Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6BCC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 12:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6BA206A3
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 12:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="FgeZ2IwC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbfJMMBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 08:01:08 -0400
Received: from mout.web.de ([212.227.15.4]:57873 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728956AbfJMMBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 08:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570968064;
        bh=zkVikWj3rydfNcm+Xoq/QEW9TfTobJDKETVMlO8u4Qw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=FgeZ2IwCJd9As1cD1JAnVbr/K6oK0OvlPBl4hMwyAYB8/uEKrtW32heN0YQ82ZzI+
         0uhNwbk29KlW5UgQCDZAp36+ZJcSGMXzmKJDo2krTqm6BeGQ4SluwNGWnLc7qDQ0w1
         z0O3v8+KDQJFgyPP/HjPHIsWi2jLxpq00Yr8TwNU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.10] ([95.157.55.156]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MP047-1iOHWp0hYl-006Pt8; Sun, 13
 Oct 2019 14:01:04 +0200
Subject: Re: [PATCH] tools/virtio: Fix build
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <4b686914-075b-a0a9-c97b-9def82ee0336@web.de>
 <20191013075107-mutt-send-email-mst@kernel.org>
From:   Jan Kiszka <jan.kiszka@web.de>
Message-ID: <08c1e081-765b-7c3a-ed31-2059dc521fd0@web.de>
Date:   Sun, 13 Oct 2019 14:01:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191013075107-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XIC4E25Ila5IabwhKzDJLfSktbAUNiL1h/Z1laTjqOl/uSmn5ZJ
 p1+l57O65WSlab5fR9quhOrAQ8ZjI4palVMKDlX+BkFoaA3LRx/vnRI83Xsju+7jV7faovk
 7VBo8b3wSwAd5CD4eo+G4cLoWejNKDM/+y5nbZGUtPI5Z60PJMGGx+Aob+PdO65vPA9RzkI
 Z00hv1xkvK13mbcnyI0tA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q/mlyFMjhfQ=:Uba6L31Yxx0a/9byemws44
 vi/2SA1DtNqZfn1D/hbJIPJrvI7/K8H00fZmvvVi1uALVNc9RoJcJf2UOuvSvfRkRh2/LaEQv
 ZuzWVftoxI+4VpUEEMYZTLxDUt8vEZm4qVPJ+hEoq6PK8ZH55J25jP6a3zxDAKX1V1mdJdSao
 RsCA3T3a473iJNShMygTILTekaUCowy0aNJmBUhfgGb/C0MZWhtZ8gH9/o5RERagtJIT34dSX
 8bP/UEBmO7OIRAxAqf1Y5KOlGX3GEJVWr+VvA78l/IYJEEsBQkU5aYkaB/na1KP966e+otNio
 4mX3CoVaH+62eqsDdig9S3SGH1NNua7dGphc7htp7RYZ93mq269H7m4O6VuQ3W11qEswipgKD
 8mbsXgldzNL/7Evo2kGi3kvPPdaF1Y04AiRrI5TYnA5YhVpRIUEnrxtzUv/G3csv6URvH5Gh4
 GW6kVxVRoAMu0deaDTLwNcA7OCq9+6NKLw2DRYpLJS8GFBuFl9AhaCQNmJSHL+nfaF0UKjdg4
 hmVqEUgbxxkqL1jdTtUFrVQUpXy2HptfdggLOLv/WMTzzrd7U32p7ye26vPCOA3037UYMQLfj
 DxHDTZ2jiHlLfqD1WOb4XIy5CPEwpegI6gMc17I7HvaeafGYS/2mrW+y3pwX85N9NsUZLMWns
 9SdmCeTk7SlAlFrpVq9RlrLNgFKx7yEYUDPlMel7hl9dKuyK9QgJgGWpdn6OkhAuRIdqkaiDE
 UDoXztDRckdLsGZqbgAP7K28etweSvOQcRI/SKE5B0tI9STEYbxnJhA7K58wUrKj9AS+Oh4Bw
 2+JE9XA5Re0ASeP0mPbzv9fvhGbDpGP5dSfExCUq3it+yPtNI9INjOefCTNHvNNqhsAkoV71o
 oIcUUYRrufeicUCn2pZQ73f0aAOty8eMBaULe69SUWXQlCzS8RMml2z4X7UEprhxG34DU5VlO
 WVjg1rbQhybaw7Gp6PkGpJHs79HiD3lMlta5CZ1/OQ5S2LUmq7R0nbXN2YMyNkrbeRPz/OHsq
 Hw99cG0cV1QE9mVfjzXi8ckKPCblsnYNYrrlZLb3GU1yrhchH+Z9lL7BfRt6MN20n3oxxxgGI
 uTnQ42Dqoi0RtdfJ9NleGs7pZ2i8qCkWAtW9JlAHwjSw0t/C2M0jPzWTB20bPnRKlFzrP0SU7
 AZ4+ce8mILmx8kBbP4sPVgGTaAkf3picIKEDdZQx06mwL5ktwu/6Zdqw5xuAjls30Pu5ZVYDS
 ZDAWY6mEDRD7cd1zPm2v3clXxlZHOjVxt13HOFfPgmypZ2GiFlqs7ExcjQi8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.10.19 13:52, Michael S. Tsirkin wrote:
> On Sun, Oct 13, 2019 at 11:03:30AM +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Various changes in the recent kernel versions broke the build due to
>> missing function and header stubs.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>
> Thanks!
> I think it's already fixes in the vhost tree.
> That tree also includes a bugfix for the test.
> Can you pls give it a spin and report?

Mostly fixed: the xen_domain stup is missing.

Jan

> Thanks!
>
>> ---
>>  tools/virtio/crypto/hash.h       | 0
>>  tools/virtio/linux/dma-mapping.h | 2 ++
>>  tools/virtio/linux/kernel.h      | 2 ++
>>  3 files changed, 4 insertions(+)
>>  create mode 100644 tools/virtio/crypto/hash.h
>>
>> diff --git a/tools/virtio/crypto/hash.h b/tools/virtio/crypto/hash.h
>> new file mode 100644
>> index 000000000000..e69de29bb2d1
>> diff --git a/tools/virtio/linux/dma-mapping.h b/tools/virtio/linux/dma-=
mapping.h
>> index f91aeb5fe571..db96cb4bf877 100644
>> --- a/tools/virtio/linux/dma-mapping.h
>> +++ b/tools/virtio/linux/dma-mapping.h
>> @@ -29,4 +29,6 @@ enum dma_data_direction {
>>  #define dma_unmap_single(...) do { } while (0)
>>  #define dma_unmap_page(...) do { } while (0)
>>
>> +#define dma_max_mapping_size(d)	0
>> +
>>  #endif
>> diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
>> index 6683b4a70b05..ccf321173210 100644
>> --- a/tools/virtio/linux/kernel.h
>> +++ b/tools/virtio/linux/kernel.h
>> @@ -141,4 +141,6 @@ static inline void free_page(unsigned long addr)
>>  #define list_for_each_entry(a, b, c) while (0)
>>  /* end of stubs */
>>
>> +#define xen_domain() 0
>> +
>>  #endif /* KERNEL_H */
>> --
>> 2.16.4
