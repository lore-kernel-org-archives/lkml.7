Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2F0ECE58E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2820120673
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbfJHJVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 05:21:01 -0400
Received: from spam01.hygon.cn ([110.188.70.11]:48501 "EHLO spam2.hygon.cn"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728866AbfJHJVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 05:21:01 -0400
Received: from MK-FE.hygon.cn ([172.23.18.61])
        by spam2.hygon.cn with ESMTP id x989K3o9097526;
        Tue, 8 Oct 2019 17:20:03 +0800 (GMT-8)
        (envelope-from fanjinke@hygon.cn)
Received: from cncheex01.Hygon.cn ([172.23.18.10])
        by MK-FE.hygon.cn with ESMTP id x989K0OS047992;
        Tue, 8 Oct 2019 17:20:01 +0800 (GMT-8)
        (envelope-from fanjinke@hygon.cn)
Received: from cncheex01.Hygon.cn (172.23.18.10) by cncheex01.Hygon.cn
 (172.23.18.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Tue, 8 Oct 2019
 17:20:02 +0800
Received: from cncheex01.Hygon.cn ([172.23.18.10]) by cncheex01.Hygon.cn
 ([172.23.18.10]) with mapi id 15.01.1466.003; Tue, 8 Oct 2019 17:20:02 +0800
From:   Jinke Fan <fanjinke@hygon.cn>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        Wen Pu <puwen@hygon.cn>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "kim.phillips@amd.com" <kim.phillips@amd.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH RFC] rtc: Fix the AltCentury value on AMD/Hygon
 platform
Thread-Topic: [RESEND PATCH RFC] rtc: Fix the AltCentury value on AMD/Hygon
 platform
Thread-Index: AQHVcoGjCyOhamu5sEuRhSd244BfD6dI346AgAcocgA=
Date:   Tue, 8 Oct 2019 09:20:02 +0000
Message-ID: <dab321b4-c271-dc8e-65a5-63333aef837d@hygon.cn>
References: <20190924024108.51286-1-fanjinke@hygon.cn>
 <20191003200127.GM575@piout.net>
In-Reply-To: <20191003200127.GM575@piout.net>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.23.18.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <35EB820229B9264DAB3372E3FDDCFB67@Hygon.cn>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MAIL: spam2.hygon.cn x989K3o9097526
X-DNSRBL: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS8xMC80IDQ6MDEsIEFsZXhhbmRyZSBCZWxsb25pIHdyb3RlOg0KPiBPbiAyNC8wOS8y
MDE5IDEwOjQxOjA4KzA4MDAsIEppbmtlIEZhbiB3cm90ZToNCj4+IFNpZ25lZC1vZmYtYnk6IEpp
bmtlIEZhbiA8ZmFuamlua2VAaHlnb24uY24+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9ydGMvcnRj
LW1jMTQ2ODE4LWxpYi5jIHwgOSArKysrKysrLS0NCj4+ICAgaW5jbHVkZS9saW51eC9tYzE0Njgx
OHJ0Yy5oICAgIHwgMiArKw0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkNCj4+DQo+IEFwcGxpZWQsIHRoYW5rcy4NCg0KSGkgQWxleGFuZHJlLA0K
DQpTb21lIGNvbXBpbGUgZXJyb3JzIG9uIHNwYXJjNjQvYWxwaGEgd2VyZSByZXBvcnRlZCBieSBr
YnVpbGQNCnRlc3Qgcm9ib3Q8bGtwQGludGVsLmNvbT4uIEkgd29uZGVyIHdoZXJlIGNvdWxkIEkg
Z2V0IHRoZSBhcHBsaWVkDQpicmFuY2gsIHdoaWNoIG5lZWQgYSBmaXggcGF0Y2guDQoNCi0tIA0K
QmVzdCBSZWdhcmRzLA0KSmlua2UgRmFuDQo=
