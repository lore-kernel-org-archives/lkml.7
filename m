Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAE3FA3730
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB7C20869
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404158AbfJQJVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 05:21:09 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2432 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731152AbfJQJVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 05:21:09 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 3EA592D8AD9CA59F8AAD;
        Thu, 17 Oct 2019 17:21:07 +0800 (CST)
Received: from DGGEMM423-HUB.china.huawei.com (10.1.198.40) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 17 Oct 2019 17:21:06 +0800
Received: from DGGEMM527-MBX.china.huawei.com ([169.254.6.34]) by
 dggemm423-hub.china.huawei.com ([10.1.198.40]) with mapi id 14.03.0439.000;
 Thu, 17 Oct 2019 17:21:01 +0800
From:   huangdaode <huangdaode@hisilicon.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
        "nm@ti.com" <nm@ti.com>, "t-kristo@ti.com" <t-kristo@ti.com>,
        "ssantosh@kernel.org" <ssantosh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: =?gb2312?B?s7e72DogW1BBVENIXSB1c2UgZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291?=
 =?gb2312?Q?rce()_for_irqchip_drivers?=
Thread-Topic: [PATCH] use devm_platform_ioremap_resource() for irqchip
 drivers
Thread-Index: AdWEzDCnTEOo/fABek625E0pBMISbQ==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date:   Thu, 17 Oct 2019 09:21:00 +0000
Message-ID: <E20AE017F0DBA04DA661272787510F9813D297BF@DGGEMM527-MBX.china.huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.61.13.197]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aHVhbmdkYW9kZSC9q7O3u9jTyrz+obBbUEFUQ0hdIHVzZSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBf
cmVzb3VyY2UoKSBmb3IgaXJxY2hpcCBkcml2ZXJzobGhow==
