Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28077C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 20:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD142087C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 20:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfCQUfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 16:35:06 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:42401 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfCQUfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 16:35:06 -0400
Received: from localhost ([46.189.28.64]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MbBQU-1gU4oK0k7U-00bZJh; Sun, 17 Mar 2019 21:34:32 +0100
Date:   Sun, 17 Mar 2019 21:34:27 +0100
From:   Andreas Klinger <ak@it-klinger.de>
To:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        afaerber@suse.de, arnd@arndb.de, davem@davemloft.net,
        gregkh@linuxfoundation.org, johan@kernel.org, khilman@baylibre.com,
        knaack.h@gmx.de, lars@metafoo.de, linux-kernel@vger.kernel.org,
        martin.blumenstingl@googlemail.com, mchehab+samsung@kernel.org,
        m.othacehe@gmail.com, nicolas.ferre@microchip.com,
        pmeerw@pmeerw.net, robh@kernel.org, songqiang1304521@gmail.com,
        treding@nvidia.com, techsupport@maxbotix.com
Subject: [PATCH v3 0/4] add MaxBotix I2CXL ultrasonic iio driver
Message-ID: <20190317203230.rm7zdtobjda36awz@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:JzBHQMzxZhj+22bdGMCnwzeGmw5ETItywczzfTvmFvpty7UZdR1
 NDMLplOoYTAeYtWH6gzWIvLwETioHTvCpOYogAIi76VQ+VQB9s01RBzpgaXNoJz4jaCviLW
 41xygvHANMoHDsvYKVOGjKItXyrYPEXTLgsE/akM0jPuqcCCS75eduxy8WhsVwx5AgfY3nI
 7o8IWar6ugXY/taoo2fJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9mwikf3KvGw=:ipnsEQ+ol340y+f07TvDVB
 AQsxu1NmjV/3CDOLA7mtAlf4UUOQK4LTSVGNwAb3Mj7KUnMdo2gLouwmG3m7MYIUP+Ik5/Txy
 uNweqEwDciSMYP6T9ZkHoNjfupFfcDLBTQAx33oYvhdf0RmkAImKYx7nPTcDcLl7PgHM8Aqpg
 MMCNhURmWRpaBXOYKMBA42w+46yzXK6ecjxYDMksYSKspDbe5GkAWtp5iW11IIa1UvFQ/hDXy
 uDSeIhKqeR2J4vEMm/KLWNVH2SDSc4EUt9QyZ/zID351DlMSRfjNJt8oy0fiIQIn/1T0T/Akh
 eeWUcZPnRbjC/dpy1UgpxI6iNyjD6IVUHj3GKdpoScwAIFH3oYj+hU3YClg7LO55nqtyNGRIu
 0ZzQujokKWy6Y2GU2uHJdXzdGqAoOvNLZ8JhMb0tMf0bS4KIsBlREs4YLnuj6A/EGFSfT/zyj
 OifqBicmookG3uZaIO2yuiRAfjzvAPvYnMgCD9X44CAIBQwDRVnh8lI2vbDMcbuCha3bB2b/Q
 2IQF7cj1a0c+/phH9/gjmPRKNHE8T7PFiKcJxIihIO741qZLDrwZKPix+S14AjtVLZUXGNqYs
 diIflZ0lh4xaByWwDkVPfErfcXLmHeYbzKm2mLwdEHjsS2iYJpMX4eDZEbbxzRlG7TM05qRDl
 rrOJQN0IQW2X4BD88UJdL6gxphdmppq7nEitp0xW6XMySNLgsSB9wktjGnjcRqDfvaeAWdVi5
 aueKtm0C9Y5vUYaghTu/VeXu/0wv6CJchpg6wQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for I2CXL-MaxSonar ultrasonic distance
sensors with i2c interface of vendor MaxBotix

Supported types are:
mb1202, mb1212, mb1222, mb1232, mb1242, mb7040, mb7137
    
Implemented and tested functionality:
- reading the distance via in_distance_raw
- buffered mode with trigger
- make use of irq to announce completion of ranging

Changes in v3:
Thanks to the review of Julia, Jonathan, Rob and Peter there are some
changes:
- fix missing mutex_unlock() in mb1232_read_distance()
- change file and function names to the tested type mb1232
- list all supported types in {of,i2c}_device_id as well as in Kconfig
- reduce former status gpio to pure interrupt for announcement of finished
  read cycle

Changes in v2:
Thanks to the review of Andreas and Peter there are a couple of changes:
- rename type wildcard mb12x2 to i2cxl in dt binding
- split changes in vendor list and dt doc into two patches
- merge driver source and Kconfig/Makefile change into one patch
- reword dt documentation
- use directly __be16 datatype to read directly from i2c
- use s16 as return value from mb12x2_read_distance()

Andreas Klinger (4):
  dt-bindings: Add vendor prefix for MaxBotix
  dt-bindings: maxbotix,mb1232: Add MaxBotix i2c ultrasonic rangers
  mb1232.c: add distance iio sensor with i2c
  MAINTAINERS: add maintainer for maxbotix ultrasonic driver

 .../bindings/iio/proximity/maxbotix,mb1232.txt     |  31 +++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 MAINTAINERS                                        |   7 +
 drivers/iio/proximity/Kconfig                      |  12 +
 drivers/iio/proximity/Makefile                     |   1 +
 drivers/iio/proximity/mb1232.c                     | 274 +++++++++++++++++++++
 6 files changed, 326 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.txt
 create mode 100644 drivers/iio/proximity/mb1232.c

-- 
2.11.0
