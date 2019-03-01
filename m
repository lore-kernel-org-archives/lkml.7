Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66924C10F03
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344EA20643
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388146AbfCANoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 08:44:00 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:50309 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387818AbfCANn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 08:43:59 -0500
Received: from localhost ([2.174.161.193]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MlNl5-1hOqZs2iOz-00lljb; Fri, 01 Mar 2019 14:43:25 +0100
Date:   Fri, 1 Mar 2019 14:43:23 +0100
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
Subject: [PATCH v2 4/4] MAINTAINERS: add maintainer for maxbotix ultrasonic
 driver
Message-ID: <20190301134322.p5pouwmiw6lp5unh@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:u7c8+X6C5BbZ1f+dPgIkhqzrldouxoiWZ7FcG2+F/3PtDLCXZY7
 o8KZxpHG9pxEpL6tMRUdKN8T4ACc4Dg07EGPBmUj5m5cBpNqqbxYaDbGUzL+/hvLi+tL1Ua
 /+6HCpNq60dmgfdvDL0EXnr2R5LHx1k2wtxA4AzbAc/bqUlc0i/u2EdrsbihvbZAo0KXF1Z
 XphHhrMZi3OT7g48mb3Lg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zOHRZKVGvZY=:AUYG9SpOrB2yxBLLi6gBRT
 GjfAt8syEbVQUmH4th2ybx7Lm98sTj8qEgkS9E054JCF+PwxKeWZOQgEXp1sJb4q9p5bURg0V
 MJvwkdZGGRqaMAXvvoA+85pBt7URLjLUpEIUbE//eMdDOvxL8S0ZW2j/NOPIIGneCBDWtJgP2
 0emDDdEBSnq6cS/xbkOT9Yz9rDu6TULlZS4svlRSZwKvjexZ0+sNqoV5QRgF8bvSJJuyS/Xyi
 wqsEqf/XIqjV2s3mfBF3QwV/ZtdFVHVAdqTqEDlTsyW3FPGz8qlDdMxbA2gvtNKSIVdFixqBP
 nR+vpwFo4bOsF2zAyFlakIPGgHDfnNdTzRHywExQoicLqSJMqOPZaFDtG+5uED+KRtzmo8q0o
 QtypD4bNDDcuh38QJesBX0lZd4TwlCthTKQ44dxDSPEmcag8N0k0e1KFukugDtvFbsF6Qo2C7
 uNSZT3c3d7eb9BHhb2rtYvHqu9sRqzr9XAhJ3AvIfzhKLFttT/Qpk5eIdSUMrKY4shP125ckG
 Op+WZL/6AUwtlgjT+qxh6bCNnagjT9UIYN9ipLmHCiDLKHdUOC1ILSchUXYImor4vFsv2fU5L
 Tp+t9glBqA+FLAHBlLI4wK9UoMdFZBiItj32rxWLSzk7fZbYo5yjbkbzAapTFZ1GsaYqKPugU
 GsATKKluFljbV8Jw6cSNM5GJ7moF5aLw2QXLPuaTBZZdNG718nzuVjqt9AK5tSmDJurE1eqqT
 Jn1X7mjw89zUub4wt5fpmilCQrCPOPLazZcbEA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add a maintainer for the newly created ultrasonic driver family of maxbotix

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9919840d54cd..0807d9239e1a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9226,6 +9226,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/max9860.txt
 F:	sound/soc/codecs/max9860.*
 
+MAXBOTIX ULTRASONIC RANGER IIO DRIVER
+M:	Andreas Klinger <ak@it-klinger.de>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/proximity/maxbotix,i2cxl.txt
+F:	drivers/iio/proximity/mb12x2.c
+
 MAXIM MAX77802 PMIC REGULATOR DEVICE DRIVER
 M:	Javier Martinez Canillas <javier@dowhile0.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.11.0
