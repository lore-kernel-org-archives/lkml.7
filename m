Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC1BC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 12:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853642089C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 12:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbfJLMSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 08:18:32 -0400
Received: from pindarots.xs4all.nl ([82.161.210.87]:60534 "EHLO
        pindarots.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfJLMSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 08:18:32 -0400
Received: from surfplank2.hierzo (localhost.localdomain [127.0.0.1])
        by pindarots.xs4all.nl (8.15.2/8.14.5) with ESMTPS id x9CCITNa006639
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO)
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 14:18:30 +0200
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Udo van den Heuvel <udovdh@xs4all.nl>
Subject: 5.3.6: nvme pagefault
Autocrypt: addr=udovdh@xs4all.nl; prefer-encrypt=mutual; keydata=
 mQINBFTtuO0BEACwwf5qDINuMWL9poNLJdZh/FM5RxwfCFgfbM29Aip4wAUD3CaQHRLILtNO
 Oo4JwIPtDp7fXZ3MB82tqhBRU3W3HVHodSzvUk2VzV0dE1prJiVizpPtIeYRRDr4KnWTvJOx
 Fd3I7CiLv8oTH9j5yPTMfZ58Prp6Fgssarv66EdPWpKjQMY4mS8sl7/3SytvXiACeFTYPBON
 1I2yPIeYK4pKoMq9y/zQ9RjGai5dg2nuiCvvHANzKLJJ2dzfnQNGaCTxdEAuCbmMQDb5M+Gs
 8AT+cf0IWNO4xpExo61aRDT9N7dUPm/URcLjCAGenX10kPdeJP6I3RauEUU+QEDReYCMRnOM
 +nSiW7C/hUIIbiVEBn9QlgmoFINO3o5uAxpQ2mYViNbG76fnsEgxySnasVQ57ROXdEfgBcgv
 YSl4anSKyCVLoFUFCUif4NznkbrKkh7gi26aNmD8umK94E3a9kPWwXV9LkbEucFne/B7jHnH
 QM6rZImF+I/Xm5qiwo3p2MU4XjWJ1hhf4RBA3ZN9QVgn5zqluGHjGChg/WxhZVRdBl8Un3AY
 uixd0Rd9jFSUhZm/rcgoKyeW6c1Vkh8a2F+joZ/8wzxk6A8keiWq/pE00Lo9/Ed2w5dVBe1p
 N7rNh2+7DjAqpCSshYIsHYs0l5Q2W+0zYfuPM1kRbUdQF1PK0wARAQABtCVVZG8gdmFuIGRl
 biBIZXV2ZWwgPHVkb3ZkaEB4czRhbGwubmw+iQJiBBMBAgBMJhpodHRwOi8vcGluZGFyb3Rz
 LnhzNGFsbC5ubC9wb2xpY3kudHh0AhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAUCVkiW
 pwIZAQAKCRCOFcDCBOMObsjdD/oDH+DvcAFakVThGdFi00o1W0j7fFcPhrP34Ulf+5idkgJm
 RzarJrz7Av7L6fwCS3JtrzfEJ+qoP84ONxnhNhj5ItHpVUlxyRWPBisklNlGJWK277Naw3BT
 mql2edPRIcR5Ypd8O7DBXIypG0CigjOVWfWLspjLmEGlinqpjHWuv4/LJ3qwSbbpW0rXpb44
 xSWB+u605pfrO3vDox5ORGCLktN8IXWISm9mS6vSXAi797KHwVX55OsiKqCbNkSM3bl6XfHh
 CPUpbOHXHzZXvP7JTINZfSfTPJx0iWCn3KArcsy7MzSwpUpUpDizrWwVRW1XySQydb8m+lnl
 8IVpJFiXiFEYGhFYU9HbUFSNGku134O5tf3VurfpOXmxGyeoyXWt4m9l7fcSaBAZq21iJT+S
 VCSmsI0JfhxMHjMbwdghPQ3UYK4q95TOcVRUkH0h+b2cZPirol4htc+ZCSzPKI++AGjXWIc5
 ZyQbthmFesrYGGttNIFFWsj3RUkyB58toDE7gXmarkhBg74tsSGbCyJp8/foy5hrci5sSi5P
 cygZxEDytCTNw1Dno/EAHUOpI2lJsVN8ACws16a6vh/UgQnBPsVFgVd0HSnlEX9XLO65lHlX
 aXo0zXomy+DDYD1sKARt8sKJk/H/VGs3SMRH3QtSBtWcUQKyJXMafWP/8A1Bz7kCDQRU7bjt
 ARAAwdK6VLsLLfyqYuA2/X+agquHh3U44IVxuRGAjQ7NSec9il+ENpbsaK6QGFBlyaWHkqcL
 e2u7DWTmG1uBqU9XqXGgeQJiOY8aof0rMsOVd1yYZsQO7+t2yfMOuS9+eRDxxj5l8gZXOKl3
 eQ5akqlKIWJy4G4D5pwCKuA5XFphpikPLm84Fb4V8IgRuiHaeHjeZyfkwYhKqxiyneGZ387b
 S3r4pMKprXlvFzWTr+x2TxexAECP3Tjg9ZakOIaVmgvFtl8L12ib6YJke7HxY/a3P3Glt+Zl
 5r/qcbWQoqyKBX+flWAjCPw+9EbdQNjBnIes3sPTTZ4YP4s2qC9rd/afeTSy3iUJhjGrEF+5
 d0AB1F+ZipmnZkGFF7tlvu6T/66JzsndOiEaLBYUa4VqJ+T0pvgX+MkbueYaQlsDl9eB24sC
 HTwfexUnvK5sUKnFFn5ZYZoIein2XHXb8EjbiT1G3G0Yj/q/DrRH1T7EiP6JPIIFdVVccnth
 j6rinWVJPiXRC8Gby/uSZP8t7HmQRYKV+xCESfRb4ZEfZqVm1/3wo3wYL5ek71yLEZC57+Hb
 RWgjaZuQg7Pn59Bh+M6cx5xTdyQ3PSeR14uXWLvMnVO2yF5pd6Ou2ySWatgtqmeTd77MpJ9+
 mPZTSG/lDGXpL2s1P6GiroiY0g3aicCgObwzr/MAEQEAAYkCRgQYAQIAMAUCVO247SYaaHR0
 cDovL3BpbmRhcm90cy54czRhbGwubmwvcG9saWN5LnR4dAIbDAAKCRCOFcDCBOMObqXID/9+
 lT7u4VJlreAFpSXOxwRlAtN88rzap3sZyQ1Z4YCxEZLHg4Ew2X0xS8w6t5jM4atOiuUW6fHY
 nI5KiYV7GARWWhZe/zsTjSs/tZVC68Q9qNwE1Ck+tuBV7d59l8qLBgQITsl6HCiYBaGJR2BF
 RdhP8a/aC6i3MWP8umK0yLJrV7gvP0sL8EKuz1zBARL5WuvzgsTA72QsilEQ/ZGYXwWnPOiI
 vTrGxZHD9apKOacSoY+CT+W+xe+tAKT0I8k4Ejda/hg6jMnaNNONX6rtiQEoUxv3R+iRhnaA
 NIsdTpUoZAbvFwStnRWgn+LgIMvKa5uW0Mjk0ynd14UxFluPs7J3saUukF4jXJGiWS2APD2K
 nNc7sAZraeSk/JFy0Y0WFCCr/UHzVLZnwdWpdw3inoIQeKtN2jWpuPP2l+4fgLybHJVnrDAs
 jujgAUTyaLDYoUryBiodY8G8gdZxTZvXk0RA9ux2TnFJJvdw8rR1sej5Lax1CZnQYwXNLvIi
 OcFUtIrTXnUj2uK2teab0RBIE4QedGoTGGHPuua8WqFpvVzC9iCIQlVtfGw6CVvq92icqbdz
 QYrlFbsVCXOM9TvO5ppqJowfdKmqFUjQPAsO40bwbphkt1NBalgZaxMCinpqEggVm/rGqbj2
 JjyRAfO8kEkwCkTZ6/Mnrxsunx9VNLGDEw==
Organization: hierzo
Message-ID: <ee2b23a3-5c93-466b-eb5a-29b768132df3@xs4all.nl>
Date:   Sat, 12 Oct 2019 14:18:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

After installing some fresh nvme drives in the system I noticed these in
dmesg:

[   87.866255] fuse: init (API version 7.31)
[  380.017552]  nvme0n1: p1 p2
[  381.101504]  nvme0n1: p1 p2
[  492.177525]  nvme0n1: p1 p2
[  527.965910]  nvme1n1: p1 p2
[  529.041589]  nvme1n1: p1 p2
[  651.030525] md/raid1:md9: not clean -- starting background reconstruction
[  651.030531] md/raid1:md9: active with 2 out of 2 mirrors
[  651.031343] md9: detected capacity change from 0 to 249924026368
[  651.031451] md: resync of RAID array md9
[  685.749937]  md9: p1 p2
[  686.919996]  md9: p1 p2
[  689.511685]  md9: p1 p2
[  728.589949] nvme 0000:03:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xfb679000 flags=0x0000]
[  728.589968] nvme 0000:03:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xfb679080 flags=0x0000]
[  904.523579] nvme 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xf5e7b000 flags=0x0000]
[  904.523595] nvme 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xf5e7b080 flags=0x0000]
[  904.536579] nvme 0000:03:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xfc279000 flags=0x0000]
[  904.536588] nvme 0000:03:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xfc279080 flags=0x0000]
[  904.558575] nvme 0000:03:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xd5979000 flags=0x0000]
[  904.558586] nvme 0000:03:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xd5979080 flags=0x0000]
[  904.671450] nvme 0000:03:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xf5e7b000 flags=0x0000]
[  904.671462] nvme 0000:03:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xf5e7b080 flags=0x0000]
[  904.687539] nvme 0000:03:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xfd340000 flags=0x0000]
[  904.687551] nvme 0000:03:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xfd340080 flags=0x0000]
[  904.696274] nvme 0000:03:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xf4f74000 flags=0x0000]
[  904.696287] nvme 0000:03:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xf4f74080 flags=0x0000]
[  904.701882] nvme 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xd56be000 flags=0x0000]
[  904.701896] nvme 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xd56be100 flags=0x0000]
[  904.701907] nvme 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xd56be080 flags=0x0000]
[  904.705788] AMD-Vi: Event logged [IO_PAGE_FAULT device=03:00.0
domain=0x0000 address=0xffc71000 flags=0x0000]
[  904.705799] AMD-Vi: Event logged [IO_PAGE_FAULT device=03:00.0
domain=0x0000 address=0xffc71080 flags=0x0000]
[  904.790813] nvme 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xf4f6b000 flags=0x0000]
[  904.839323] AMD-Vi: Event logged [IO_PAGE_FAULT device=03:00.0
domain=0x0000 address=0xfc296000 flags=0x0000]
[  904.839335] AMD-Vi: Event logged [IO_PAGE_FAULT device=03:00.0
domain=0x0000 address=0xfc296080 flags=0x0000]
[  904.897439] nvme 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xf5237000 flags=0x0000]
[  904.897463] nvme 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xf5237100 flags=0x0000]
[  904.897477] nvme 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xf5237080 flags=0x0000]
[  904.906138] nvme 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xffc03000 flags=0x0000]
[  904.906157] AMD-Vi: Event logged [IO_PAGE_FAULT device=09:00.0
domain=0x0000 address=0xffc03100 flags=0x0000]
[  904.906168] AMD-Vi: Event logged [IO_PAGE_FAULT device=09:00.0
domain=0x0000 address=0xffc03080 flags=0x0000]
[  904.915102] AMD-Vi: Event logged [IO_PAGE_FAULT device=09:00.0
domain=0x0000 address=0xfb4e1000 flags=0x0000]
[  904.972415] AMD-Vi: Event logged [IO_PAGE_FAULT device=03:00.0
domain=0x0000 address=0xd57fe000 flags=0x0000]
[  904.974739] AMD-Vi: Event logged [IO_PAGE_FAULT device=03:00.0
domain=0x0000 address=0xffcad000 flags=0x0000]
[  904.974750] AMD-Vi: Event logged [IO_PAGE_FAULT device=03:00.0
domain=0x0000 address=0xffcad100 flags=0x0000]
[  948.578151] amd_iommu_report_page_fault: 13 callbacks suppressed
[  948.578157] nvme 0000:03:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xfeade000 flags=0x0000]
[  948.582041] amd_iommu_report_page_fault: 12 callbacks suppressed
[  948.582047] nvme 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xf5251000 flags=0x0000]
[  948.582061] nvme 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xf5251100 flags=0x0000]
[  948.582072] nvme 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xf5251080 flags=0x0000]
[  948.595189] nvme 0000:03:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xfd7d9000 flags=0x0000]
[  948.601252] nvme 0000:03:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xfe37c000 flags=0x0000]
[  948.601265] nvme 0000:03:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xfe37c080 flags=0x0000]
[  948.693727] nvme 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xd597d000 flags=0x0000]
[  948.693742] nvme 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xd597d080 flags=0x0000]
[  948.711415] nvme 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xff5f7000 flags=0x0000]
[  948.711430] nvme 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xff5f7080 flags=0x0000]
[  948.747491] nvme 0000:03:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xd57e8000 flags=0x0000]
[  948.754866] nvme 0000:03:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xd5932000 flags=0x0000]
[  948.802522] nvme 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xd57d2000 flags=0x0000]
[  948.859149] nvme 0000:03:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xd597d000 flags=0x0000]
[  948.859162] nvme 0000:03:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xd597d080 flags=0x0000]
[  948.891216] nvme 0000:03:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xf5107000 flags=0x0000]
[  948.891229] nvme 0000:03:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xf5107100 flags=0x0000]
[  948.891238] amd_iommu_report_page_fault: 15 callbacks suppressed
[  948.891240] AMD-Vi: Event logged [IO_PAGE_FAULT device=03:00.0
domain=0x0000 address=0xf5107080 flags=0x0000]
[  948.929609] nvme 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xff4a7000 flags=0x0000]
[  948.929622] nvme 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0xff4a7080 flags=0x0000]
[  948.982983] AMD-Vi: Event logged [IO_PAGE_FAULT device=09:00.0
domain=0x0000 address=0xd593e000 flags=0x0000]
[  949.013114] AMD-Vi: Event logged [IO_PAGE_FAULT device=03:00.0
domain=0x0000 address=0xd591e000 flags=0x0000]
[  949.025346] AMD-Vi: Event logged [IO_PAGE_FAULT device=03:00.0
domain=0x0000 address=0xf52a5000 flags=0x0000]
[  949.152360] AMD-Vi: Event logged [IO_PAGE_FAULT device=03:00.0
domain=0x0000 address=0xfd19c000 flags=0x0000]
[  949.187747] AMD-Vi: Event logged [IO_PAGE_FAULT device=03:00.0
domain=0x0000 address=0xff5fe000 flags=0x0000]
[  949.187760] AMD-Vi: Event logged [IO_PAGE_FAULT device=03:00.0
domain=0x0000 address=0xff5fe080 flags=0x0000]
[  949.215317] AMD-Vi: Event logged [IO_PAGE_FAULT device=09:00.0
domain=0x0000 address=0xf5e6b000 flags=0x0000]
[  949.215331] AMD-Vi: Event logged [IO_PAGE_FAULT device=09:00.0
domain=0x0000 address=0xf5e6b100 flags=0x0000]
[  949.215342] AMD-Vi: Event logged [IO_PAGE_FAULT device=09:00.0
domain=0x0000 address=0xf5e6b080 flags=0x0000]
[ 1004.919321] EXT4-fs (dm-13): mounted filesystem with ordered data
mode. Opts: (null)
[ 1038.778793] EXT4-fs (dm-14): mounted filesystem with ordered data
mode. Opts: (null)


Are these serious? Harmless? Known? Or how to handle these?
Please let me know.

Kind regards,
Udo
