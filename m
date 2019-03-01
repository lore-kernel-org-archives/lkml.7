Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57183C10F03
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3120B2085A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388033AbfCANmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 08:42:38 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:37697 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387620AbfCANmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 08:42:37 -0500
Received: from localhost ([2.174.161.193]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MowOm-1hLFf72OA2-00qQiG; Fri, 01 Mar 2019 14:41:59 +0100
Date:   Fri, 1 Mar 2019 14:41:57 +0100
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
Subject: [PATCH v2 1/4] dt-bindings: Add vendor prefix for MaxBotix
Message-ID: <20190301134155.ujtl434di6eb7jir@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:75e/5Tm4BWTq1RGra3A/n6mGDAWe8jFpRltMSHDgiLVVzUAROTl
 rgFVwsliNxo6Q5Y7sPhW4joG4K9oCGju4Sr/s1jg+Rjz8uKMEJX2CI5Rt3OXP4U2uhBtuS6
 zGzq2SmYIwj9DccZ0dg9WsBbFqmd3ZDy615JGJjfehKtQUiJMxnq+sgqRgg7tVoW/n/RiH0
 WoTHOiynh4yQJgJIo3foA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JqxHs4zEXU0=:YnylV5qb9C8683SOqiXuIl
 GD2/U9iD9MIS+dDMl5lHV0YZJ3hwDHYlEPbkD0wzpQ+COaf9MlZ8Zk1nx/ymKNMuDgAeNX8tR
 3VZdzinPyTvOvKek2DT5nh7DpHhjs5xRHtfHXPCK1wfgaHxxJbsKmVETqKITws7kiy50b69op
 NyzUXLMOT6mSWIbaY37H1M3eTXgrr61PkM62gx49LQKMGBbgI96tWrthgNf/p/+Ry5R3ocL1y
 9PT77C1Zw5wndpiOYMA5pn1gvpTIMx1pKt6oRuXgdYHkLVFwP8yff1EjHycRW72WCTnF/OlAw
 KFth3FamBlkp2vL/IhRmBve5x2EZ6pY3G3gSNqlIcUz7Yw8uskXYU/iGyIikv/cZkAMKXyJIJ
 V5vkj7nmVjm+Yu0rpJ1qNyKJo5UjuLYtpURrjmvw2/eJWi8Gh7pJAqNCeVYJbESpokVaN/QsQ
 MYiziyj3loj+DhD0tRKlYwrjTReWg3vneaGgVKrMX3B18rLzjdDpHN6yrrhgjzfuqbpl70bxI
 ENywGrPPbpPANK3c9IBLlTvPlSst80PkAt9KadIkXaqSzGh//hTK8gZHXj9qQft7ek3ZfAtKS
 GrKdaD/K8fAygOE1CB5dZmLpJNL46v7HQoIbusOIQGNANC0efG6oieaFW0zVD3kHmjvabTBI+
 V3UKfPcv3E4yigKiw3RMMgR2H1igs/BRUFJOC5Ig/1W/rGkXQKIdJAEjELIeqa6cX8PwMjbhM
 EWJWDcOh/fTZm31eXmm24u9nYx04vd36FNlXtw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MaxBotix, which is a vendor of ultrasonic rangers in different
varieties and interfaces.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 389508584f48..added54a1108 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -225,6 +225,7 @@ lsi	LSI Corp. (LSI Logic)
 lwn	Liebherr-Werk Nenzing GmbH
 macnica	Macnica Americas
 marvell	Marvell Technology Group Ltd.
+maxbotix	MaxBotix Inc.
 maxim	Maxim Integrated Products
 mbvl	Mobiveil Inc.
 mcube	mCube
-- 
2.11.0
