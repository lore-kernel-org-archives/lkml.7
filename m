Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A9FC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 05:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F0D27BA4
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 05:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfFCFb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 01:31:56 -0400
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:52298 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfFCFbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 01:31:55 -0400
X-AuditID: c0a8fbf4-501ff700000014c1-4e-5cf4b0c92533
Received: from smtp.reu.rohmeu.com (will-cas001.reu.rohmeu.com [192.168.251.177])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 7F.D6.05313.9C0B4FC5; Mon,  3 Jun 2019 07:31:53 +0200 (CEST)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS001.REu.RohmEu.com ([fe80::d57e:33d0:7a5d:f0a6%16]) with mapi id
 14.03.0439.000; Mon, 3 Jun 2019 07:31:43 +0200
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: bd70528: Drop unused include
Thread-Topic: [PATCH] regulator: bd70528: Drop unused include
Thread-Index: AQHVGAVxKHCtqauchUSIjw1kB2pu76aJSbiA
Date:   Mon, 3 Jun 2019 05:31:42 +0000
Message-ID: <d3beff0caa9326f937cf948eb1a4ce8be1dde499.camel@fi.rohmeurope.com>
References: <20190531230608.7361-1-linus.walleij@linaro.org>
In-Reply-To: <20190531230608.7361-1-linus.walleij@linaro.org>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.255.186.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <12CDB735314091408BED96B098A5093F@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLKsWRmVeSWpSXmKPExsVyYMXvjbonN3yJMTh5Q8xi6sMnbBbfrnQw
        WUz5s5zJ4vKuOWwOLB47Z91l99i0qpPN4861PWwenzfJBbBEcdskJZaUBWem5+nbJXBn3LyU
        UdDEUrHj6hzmBsYvzF2MnBwSAiYS2w4dZuti5OIQErjGKLHg3XcWCOc4o8T+ibOBqjg42ARs
        JLpusoPERQQmM0ps23uaFaSbWcBR4vbet0wgtjBQzapph8DiIgK2Eife7meGsI0kVv15Dmaz
        CKhInH93hx3E5hXwk+g/cY0NxBYC6m36dJ0RxOYE6t1/7i+YzSggK9HZ8I4JYpe4xKZn31kh
        rhaQWLLnPNQHohIvH/+DiitJ7P35kAXkZmYBTYn1u/QhWh0k/izZyAxhK0pM6X4IdYKgxMmZ
        T1gmMIrNQrJhFkL3LCTds5B0z0LSvYCRdRWjRG5iZk56YkmqoV5RaqleUX5GLpBKzs/dxAiJ
        wC87GP8f8jzEKMDBqMTDG7DyS4wQa2JZcWXuIUZJDiYlUd7Cdx9jhPiS8lMqMxKLM+KLSnNS
        iw8xSnAwK4nwrjQDyvGmJFZWpRblw6SkOViUxHl/7zoYIyQAsjk7NbUgtQgmK8PBoSTBy70e
        aI9gUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KLHEFwNTC0iKB2jvi3VA7bzFBYm5
        QFGI1lOM2hwHFj2cy8zx9uDzucxCLHn5ealS4rzCwOQpJABSmlGaB7foFaM40L/CvKtA7uAB
        pmm4Oa+AVjABrfC//QlkRUkiQkqqgXGJ75o91bzVe0756y5gULz1h+uXwaE8kTWVwtYC3n55
        wrOSo56IdG6bEX/0orObloPBgdK1jNvqmSwiDPUbuNJ38vZVV6ft1J4g7elopeEyTfh37JMX
        qya6xmtNZYrc32wfKhfgyVEkp/VluXdLWc+quSsrnk8ozf18+0V+vd3Por0b4yNjlFiKMxIN
        tZiLihMB/kla25ADAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIExpbnVzIQ0KDQpPbiBTYXQsIDIwMTktMDYtMDEgYXQgMDE6MDYgKzAyMDAsIExpbnVz
IFdhbGxlaWogd3JvdGU6DQo+IFRoaXMgZHJpdmVyIGRvZXMgbm90IHVzZSBhbnkgc3ltYm9scyBm
cm9tIDxsaW51eC9ncGlvLmg+DQo+IHNvIGp1c3QgZHJvcCB0aGUgaW5jbHVkZS4NCj4gDQo+IENj
OiBNYXR0aSBWYWl0dGluZW4gPG1hdHRpLnZhaXR0aW5lbkBmaS5yb2htZXVyb3BlLmNvbT4NCj4g
U2lnbmVkLW9mZi1ieTogTGludXMgV2FsbGVpaiA8bGludXMud2FsbGVpakBsaW5hcm8ub3JnPg0K
QWNrZWQtQnk6IE1hdHRpIFZhaXR0aW5lbiA8bWF0dGkudmFpdHRpbmVuQGZpLnJvaG1ldXJvcGUu
Y29tPg0KDQpCciwNCglNYXR0aSBWYWl0dGluZW4NCg==
