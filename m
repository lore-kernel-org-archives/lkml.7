Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21230C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E841620643
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387993AbfCANmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 08:42:07 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:49431 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387620AbfCANmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 08:42:06 -0500
Received: from localhost ([2.174.161.193]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mtfa5-1hGhMp0rGR-00v3r9; Fri, 01 Mar 2019 14:41:32 +0100
Date:   Fri, 1 Mar 2019 14:41:27 +0100
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
Subject: [PATCH v2 0/4] add MaxBotix I2CXL ultrasonic iio driver
Message-ID: <20190301134125.4zqbyzoc2exxigae@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:YIegJHTSBnCTm18ULkcHOwaQRb+8PqeJchXSMnzIv8nXC3DPZcO
 ua9OhQb01ctK0RGvHgROQ91Bw7gFXMH3WEMMycKUv6qCXHmq3fOsWFLCJN4JNAMxxq8Czck
 pfj/Lsx6Yz+6UkUgH0usFeJy2vISjcKpkS2lSSMXUZW2E6UADAN3Uv+cIZ5gvA2O2JfH0/N
 /zYVyPDVVO8BI8IUvKgkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dg7b07Dl2Pw=:h2+G2Zkf1ATk0Kx6wxpL+V
 GDLgKT94fO9W2HGBoXTougYaZ+Hx/i8KSUnHkfmYeiCCF21JQFDLHqgfTvDkH+C7pIQivrS1y
 Kqzt27x53bO+Ly7yAIFyCNZa4tPXSCA+1LVBtIC52sgCaOmV7Ch9kIhvIHv28cAhbAX3bwFil
 SKZGDUOZfcuRTnz9Jh6KSaO6cfWY9XLOgkH+V8Bcou9uB4un0ePdyDQlxuGenkjv/HFisS2ZI
 2sye8NNLu3PTsasCiR6GNTFLgOU1fWdxvOPbX0cw6BeoIoHfYK9sDn7tXTXOUoQrGIXmq/Okc
 YWxVdV1gd12H9UqIx2lihvaCw8ree3gTXR4bikt1Y+XC+mW7R6nUaIZk02IorFjflVI1+dUQe
 2btXdXURlUBUMT5Y5ixvuHLZukHKQBCeJLNFdM6RLUwrXvCFClwBCGySWwHY5HMBVzTtfbPYU
 NUQPLHjn7vVgE1fKbv5ng2ASOzM6FlnMfigKsZyfa9bUEhxxqA1VJaZuaubrF2St3+wOErDre
 6wNsyu0MAdI6I5pdJJq5JmlX0knu9K/QvZkksvL06tqgTIm25f8RWpJQzN1n/ruaUgJNvhiiV
 1rakDNwjvGb273HQpqYbkk/1AO24m4tvPMVrgwI/izF/slao/qLPXGqIxQ2OnBHJSKxwca7mL
 PERrzH5R9efM/xCExhcr/Maje/IeG8YuLbjGGa+kPXvApZ702h7UYmowPQN253HBfL/uqOwpb
 jlKse5oOhjAqzG9jKBJAC/RSU4tlRJOCZKLL/Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for I2CXL-MaxSonar ultrasonic distance
sensors of family mb12x2 using the i2c interface of vendor MaxBotix
    
Implemented and tested functionality:
- reading the distance via in_distance_raw
- buffered mode with trigger
- make use of status gpio to announce completion of ranging


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
  dt-bindings: maxbotix,i2cxl: Add MaxBotix i2c ultrasonic rangers
  mb12x2.c: add distance iio sensor with i2c
  MAINTAINERS: add maintainer for maxbotix ultrasonic driver

 .../bindings/iio/proximity/maxbotix,i2cxl.txt      |  21 ++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 MAINTAINERS                                        |   7 +
 drivers/iio/proximity/Kconfig                      |  11 +
 drivers/iio/proximity/Makefile                     |   1 +
 drivers/iio/proximity/mb12x2.c                     | 283 +++++++++++++++++++++
 6 files changed, 324 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/maxbotix,i2cxl.txt
 create mode 100644 drivers/iio/proximity/mb12x2.c

-- 
2.11.0
