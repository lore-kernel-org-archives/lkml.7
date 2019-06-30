Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38EBC5B57E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 08:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827C92063F
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 08:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfF3IHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 04:07:31 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:47027 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfF3IHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 04:07:31 -0400
Received: from methusalix.home.lespocky.de ([92.117.55.254]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MMGZS-1i0fr21YaE-00JKk7; Sun, 30 Jun 2019 10:05:46 +0200
Received: from lemmy.home.lespocky.de ([192.168.243.176] helo=lemmy)
        by methusalix.home.lespocky.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <alex@home.lespocky.de>)
        id 1hhUqE-0003rK-PM; Sun, 30 Jun 2019 10:05:42 +0200
From:   Alexander Dahl <post@lespocky.de>
To:     linux-kernel@vger.kernel.org
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Alexander Dahl <post@lespocky.de>,
        Christoph Schulz <mail@kristov.de>
Subject: [PATCH] staging: rtl8188eu: Add 'rtl8188eufw.bin' to MODULE_FIRMWARE list
Date:   Sun, 30 Jun 2019 10:05:40 +0200
Message-Id: <20190630080540.5208-1-post@lespocky.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scan-Signature: aaba504e6e7ea76f790d1b1323b7db89
X-Provags-ID: V03:K1:6z8DdsxkdsCN9qq/jpISd91AghzPIx3L05TJ5E14JPKjCqsXCRx
 m07aGTvsFfYgmncr3U+F8BHSsBMSDm7aPcPlGxapufcWFtR9FlM1mQnQZ3nvBatVmtAGXkE
 K23uOq7k8LZnrfHKVOzhqIj+Imysdjr5bm6RH7jWld16fmPp5z1NJgx7coXhJ8SzT0PcnoM
 aJuWww+qTjHR/Y1Eot0/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pUxZunrGqYg=:ZED3yvHxFuFt9/paUAF3QP
 lOvLcas2/AeI0Krw0gjH78EVCRjicQn7ijNFghaFHBMIO+UCeXqRU+DPB06oMl6EBecly54KM
 MbakrG7VWYBi5gy2lgzMU9R6JC735nmfpzeLlSYPyS4JQoo1QFL1xKH1sbSxgI1kcqz/++4zK
 k/4G4ijmSg4g01BpIL31+vu2+7xwc+F//BghcCb15RCiNusRTeA94FrHsPW9no6HfP5GHmw0G
 9gSJuyGbBohMo2YXbCzlCk8t3PQPIUfidvsNAMTFFvGQzzFTgcPUFkdwb0w9ag8RuZDcwc5LW
 XHNnHsmlkI2howudjYF7eqKkdnMtCZwfEv1ymcKcgRAYgYSKXL4IYnejc2A6aZpZPNG53wlgy
 rlzD+hGS1rpfaQyOU9Im2p2lhGhburl2UuK3h8C7nKf2rYd0oXdV0T9rftJpmF2vPBBLWmNCf
 BxKH+O+Ii3NjCzTu6T0kGkAapa5I7VMDkoYLkCnFxTnCOtyvrSGiOlioD1ij3ntM8rrSjgcbX
 iK0H32XmlmZWP1rtx0npD0ASjFYz1yn1y0SJcqKbLwRRlhp+rwXqMKmjn9gWMiBrI8Z+/WrhL
 Guy5Eed8BVlzeBTFTQHIUyGR+mmYjTFrBtXFj4irhcqikNM+QX2i95GgVWMNhRcHkGAhhQA/X
 AzjHr7YxlrJqzbeGUvlOgkpLcVRizDQdZz2yQJAbZ9EFoEzqBlVONvCrfzvGDToxnYP3HSsvl
 Ml2hjQk9susMQ9gwpoaol8ax9yy+VEleKf+L22yLageGOLxYKmYD05aL0qE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the file loaded by the code anyway, but now you can use
'modinfo' to determine the needed firmware file for this module.

Spotted when packaging firmware files for the fli4l Linux router
distribution, where a script uses the information from 'modinfo' to
collect all needed firmware files to package.

Cc: Christoph Schulz <mail@kristov.de>
Signed-off-by: Alexander Dahl <post@lespocky.de>
---
 drivers/staging/rtl8188eu/os_dep/os_intfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8188eu/os_dep/os_intfs.c b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
index 2c088af44c8b..8907bf6bb7ff 100644
--- a/drivers/staging/rtl8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
@@ -19,6 +19,7 @@ MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Realtek Wireless Lan Driver");
 MODULE_AUTHOR("Realtek Semiconductor Corp.");
 MODULE_VERSION(DRIVERVERSION);
+MODULE_FIRMWARE("rtlwifi/rtl8188eufw.bin");
 
 #define RTW_NOTCH_FILTER 0 /* 0:Disable, 1:Enable, */
 
-- 
2.20.1

