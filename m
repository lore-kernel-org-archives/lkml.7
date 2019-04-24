Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DD7C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB47B2077C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730983AbfDXN6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:58:25 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:59056 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728834AbfDXN6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:58:23 -0400
Received: from dggemi404-hub.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id C7678300891640C89A9C;
        Wed, 24 Apr 2019 21:58:16 +0800 (CST)
Received: from DGGEMI530-MBX.china.huawei.com ([169.254.7.146]) by
 dggemi404-hub.china.huawei.com ([10.3.17.142]) with mapi id 14.03.0399.000;
 Wed, 24 Apr 2019 21:58:11 +0800
From:   weizhenliang <weizhenliang@huawei.com>
To:     Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <christian@brauner.io>
CC:     "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "colona@arista.com" <colona@arista.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Re: [PATCH v4] signal: trace_signal_deliver when
 signal_group_exit
Thread-Topic: Re: [PATCH v4] signal: trace_signal_deliver when
 signal_group_exit
Thread-Index: AdT6pZq+JbWp9SySQA2a3wwIc2YMvg==
Date:   Wed, 24 Apr 2019 13:58:10 +0000
Message-ID: <AF4D908CC0E2A24EB308A26962C8C3BDEB1A2B@DGGEMI530-MBX.china.huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.40.99.192]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDQvMjQsIE9sZWcgd3JvdGU6DQo+T24gMDQvMjQsIENocmlzdGlhbiBCcmF1bmVyIHdyb3Rl
Og0KPj4NCj4+IE9uIFdlZCwgQXByIDI0LCAyMDE5IGF0IDA4OjUyOjM4UE0gKzA4MDAsIFpoZW5s
aWFuZyBXZWkgd3JvdGU6DQo+Pg0KPj4gPiBSZXZpZXdlZC1ieTogT2xlZyBOZXN0ZXJvdiA8b2xl
Z0ByZWRoYXQuY29tPg0KPg0KPlllcywgYnV0IC4uLg0KPg0KPj4gPiBSZXBvcnRlZC1ieToga2J1
aWxkIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+DQo+SG1tLCByZWFsbHk/DQoNClllcywg
dGhlIGtidWlsZCB0ZXN0IHJvYm90IHNheXMgdGhhdCBpZiBJIGZpeCB0aGUgcHJvYmxlbSB3aXRo
IHRoZSB0aGlyZCBwYXJhbWV0ZXIgdHlwZSwgDQpJIHNob3VsZCBhZGQgdGhpcyB0YWcuIFdoYXQg
aXMgd3Jvbmcgb3IgbWlzc2luZz8NCg0KV2VpLg0K
