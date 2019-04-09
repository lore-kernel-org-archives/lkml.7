Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28138C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 19:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14BD2084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 19:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfDITKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:10:18 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:50973 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfDITKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 15:10:17 -0400
Received: from localhost ([2.171.41.193]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N0o3X-1gzili0fHJ-00wq1T; Tue, 09 Apr 2019 21:09:55 +0200
Date:   Tue, 9 Apr 2019 21:09:53 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        songqiang1304521@gmail.com, robh@kernel.org, m.othacehe@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 0/3] add Maxbotix ultrasonic iio sensors with gpio bitbanging
Message-ID: <20190409190952.ctgf6mbx47nwvfs5@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:oLDrv2vUe65wSNNOj+WAnoBAZfWXRM/9VxVaT2QQiXaXAQkl2SF
 HNgoODS4Faml75nd2WY1wOyxVfpPFmDKf33gMpUrgIOz9f4LR3rUpKq9tJUWzxKlVflEoO7
 qtYOgQTyiZb2jjXPcjBFEDhjnVBuc9QfxtnVoPBBNAlXeMrECZ317aVV1JmmthiUi9sT4iK
 8EUT7BMo+WY2J7sHuAyQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iCWDEXaU3v8=:cZSlNIy1ZBeuxkq7Vf/LyL
 Rj49oZmWABpYWJcSfCq8Ky7PDeMHR+EXBMMs6bS+TUgIG9xfFOeOKKrlWHr2nazL7t3+AsPOQ
 6cRWnTFsTlLdSZ2oB9JbqlqWamdUhBgfX7cTBbc70M3rfj4/8heIMcFCdY4XCVSJ8Wsn7tiv7
 OTggZGM1JgXgPYRGyV1ZZzzsKVJgZ7wSVSM3ocn1PqsuUbE6WwAXyp2w36NgT2hx1DYx8Rcsx
 4cz1rg1igWpnIO3HhDaStGZaia892/n5MsVca9zkKFk2+63HtNKkPGnn5vU/iJ3ZH/bESOyej
 lDaekDYU1o4KIzz/3xu+rq4nUClZRTrBwVD1nJWl2lZjxIwQsh07F3Lr45Hb4VW4PaNsiPtHk
 LhmIgGAvVgmoctTZSoOGVTzF5tKE1AMM4cSDEDBEAnm/34qukW7VcNwrx1CGqqWBZOad7qpIE
 HPEMSQN8Hls8JiHaOWgl33FvkEf0LGQvXGdi4Pd9U941X/arikBOmncGlCW3xvHfK1tEDRMMG
 SVSf4mylD8SKs24zvrRGEEMOq8QacnLVzlmQal0hff1tuBIPe3BimDhHTkg/1ncGDUILwrN/G
 wordfefZMq7b8RcbYLsE7lC3nclJqE9mLgqPPZTBKVq8rUH5Yfo3FQacoosfqL8wHr/KcUVaM
 CkGPtduTzTJpR3hMfGIZq30sqWmG6aZT3clQwKD+ZhZmbFV3bwnrbzq8U9rGthqdGUUFG8dnR
 /sGnEpGTs8DJDXtzVKdzPoV1du8tvQuufHnfRA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for Maxbotix ultrasonic iio sensors with
gpio bitbanging protocol.

These sensors are quite similiar to the existing srf04. This is why the
existing one was changed to support a driver specific configuration
containing the differences between the different types.

This patch series needs the formerly submitted 
"[PATCH v2] devantech-srf04.yaml: transform DT binding to YAML" 
because it relies on the yaml documentation of devantech-srf04.yaml

Andreas Klinger (3):
  srf04.c: add maxbotix ultrasonic sensors
  devantech-srf04.yaml: add Maxbotix ultrasonic iio proximity sensors
  Kconfig: change configuration of srf04 ultrasonic iio sensor

 .../bindings/iio/proximity/devantech-srf04.yaml    | 25 +++++++++-----
 drivers/iio/proximity/Kconfig                      | 11 +++++--
 drivers/iio/proximity/srf04.c                      | 38 +++++++++++++++++-----
 3 files changed, 54 insertions(+), 20 deletions(-)

-- 
2.11.0
