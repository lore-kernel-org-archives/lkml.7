Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0843EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77C922319
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfCKNT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:19:29 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:45667 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfCKNT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:28 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MaIvT-1hXE9y1zAT-00WFfq for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:27 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: Kconfig: Great White Handkerchief going round
Date:   Mon, 11 Mar 2019 14:17:12 +0100
Message-Id: <1552310346-7629-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:r6AmJ/dXoWUhfOy+xNieTKR0lrS7Dbbc6/xKVsI6Ip1MXJeVa4e
 SLrETwzB5v6p7voV09RDv0pW446ZzHx2mSr/NYKwwJyTA7b79aOy4GYsbcOtxFQecx+C0iH
 55gebKZQTuUDGZCP1z7coDJldNzcrmXxRrqNtNVCDrqWAATy7mHNlqMTsvsW+6uOsRmvf5u
 5Zy33sX/y5EQhw7ohRXPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qv62oDs4jmI=:DJ2ElqlpKAqLOuRZZ7RWBI
 9bZsIY3/yXuZ571y2gWks4wkJgJGiABnUXj5H/K66mKOXjWuMriVZp/tIq69/JVKA7BJIbs+Z
 TpbUaoe9XA7zAu2qhOuDXwJX0MO2hP5GKyHtCFB8YSsXWujLedsoxsaF/W3kY6iXajDaq6iPQ
 hIUfIKyvjSJldnDa8gN6Iyp4x6Z4i2tuy7eXl060ofbcCgbEX5DvuAKYmmZbbpbFWmmWfRHAD
 KJwA7bis8fZFToisXKR8G1P49V1n0+v/nEJeLJt4lu8DC+wpSYq9/i+rDaTPM+lgFqnWQIWLY
 rEnodnh8/DrCvFqVOlL02FooddSEpF8PH88U+lg0iuXi3Jf6++HHnsbz9c0ZRAPL26KKupq1W
 JH2+1C9uKEOU0VMP9Zn1IU6TIFga0hxltwV95ZZ6PsDv6SN0YYap+yd9vHNTS17wXLYTouuv+
 jfKR+POykjSoTDyQZFeap7zcFJ8Yv02EFRrHSFauGICOWXnzhglXzSiQdXzhTy5cjFnD2vWUM
 RZQGj7Qq984BLYm97VGIl69HJwOoy//NjH6i3IPWQOAOLzF1Ui31wQFefwpe9+Jp8468zGCdQ
 yW/L4ltHue5JXUnIkZ89C5ZBphF7dK8NBQ3/o2BYdscRPhIY0bhoQZyLQLKkbz3bdel3vH4cD
 yLIRClM7S2Ij4nevKXg/gR+XFX4pP/p2BEln4Qs1SHwQnMhyJyXSn+cngBVOCYPUQpiiDS8Mc
 T7Q0ZcPpH3tHmdINIDt+VDvP3AkQIyCngdKRJg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Behold, Jatravartids! The Great White Handkerchief is coming
to massacres many thousands of irregular whitespaces and tabs
that stepped too far out of line. It's first defenseless victims
are the Kconfig files ...


--mtx

