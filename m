Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFA8C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 05:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD5C24BA8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 05:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfFCFcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 01:32:31 -0400
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:52322 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfFCFca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 01:32:30 -0400
X-AuditID: c0a8fbf4-501ff700000014c1-5a-5cf4b0ec1a48
Received: from smtp.reu.rohmeu.com (will-cas002.reu.rohmeu.com [192.168.251.178])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 11.E6.05313.CE0B4FC5; Mon,  3 Jun 2019 07:32:28 +0200 (CEST)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS002.REu.RohmEu.com ([fe80::fc24:4cbc:e287:8659%12]) with mapi id
 14.03.0439.000; Mon, 3 Jun 2019 07:32:18 +0200
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: bd718x7: Drop unused include
Thread-Topic: [PATCH] regulator: bd718x7: Drop unused include
Thread-Index: AQHVGAXR7go7LRHIU0iDFx/YwJgo2aaJSeKA
Date:   Mon, 3 Jun 2019 05:32:17 +0000
Message-ID: <ca81fac648894362fca07a0885c9f7cf03b0dd94.camel@fi.rohmeurope.com>
References: <20190531230851.8084-1-linus.walleij@linaro.org>
In-Reply-To: <20190531230851.8084-1-linus.walleij@linaro.org>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.255.186.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D402B9645A4984D954E435F188E42C9@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsVyYMXvTbpvNnyJMVh41Npi6sMnbBbfrnQw
        WUz5s5zJ4vKuOWwOLB47Z91l99i0qpPN4861PWwenzfJBbBEcdskJZaUBWem5+nbJXBn3Hp2
        nblgGkvF17dL2BsYO1i6GDk5JARMJCZsmcDWxcjFISRwjVGia/F8RgjnOKPErss97F2MHBxs
        AjYSXTfZQeIiApMZJbbtPc0K0s0s4Chxe+9bJhBbGKhmS8dCsKkiArYSM7acAOsVETCS6D5r
        DWKyCKhIXNjvDlLBK+An8eXdKWYQWwio8/WhVrCJnECdn47NAZvCKCAr0dnwjglik7jEpmff
        WSFuFpBYsuc8M4QtKvHy8T+ouJLE3p8PWUBWMQtoSqzfpQ/R6iDx6sB3ZghbUWJK90N2iBME
        JU7OfMIygVFsFpINsxC6ZyHpnoWkexaS7gWMrKsYJXITM3PSE0tSDfWKUkv1ivIzcoFUcn7u
        JkZI/H3Zwfj/kOchRgEORiUe3oCVX2KEWBPLiitzDzFKcjApifIWvvsYI8SXlJ9SmZFYnBFf
        VJqTWnyIUYKDWUmEd6UZUI43JbGyKrUoHyYlzcGiJM77e9fBGCEBkM3ZqakFqUUwWRkODiUJ
        Xu71QHsEi1LTUyvSMnNKENJMHJwgw7mkRIpT81JSixJLSzLiQWklvhiYWEBSPEB7X6wDauct
        LkjMBYpCtJ5i1OY4sOjhXGaOtwefz2UWYsnLz0uVEucVBqZOIQGQ0ozSPLhFrxjFgf4V5l0F
        cgcPMEnDzXkFtIIJaIX/7U8gK0oSEVJSDYwL9Q5qyTrUCjx/eUSJ7f1zr9h37ntebEmssLv6
        3fvlo5L0TaveVRzUuHjoiDTn+TvTpUvsjORDlQy8Us5n22fUTzt/fm4oC6fGLbUQvpj3Sj9e
        LUx9EduoYZqqULw0edKCG52yWpfe8RRUcGtY9ovHffX+WFtVZ3hM8qsh6751mWcmX7LxclVi
        Kc5INNRiLipOBABGbnSmjwMAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW5kIHRoYW5rcyBmb3IgdGhpcyB0b28gPSkNCg0KT24gU2F0LCAyMDE5LTA2LTAxIGF0IDAxOjA4
ICswMjAwLCBMaW51cyBXYWxsZWlqIHdyb3RlOg0KPiBUaGlzIGRyaXZlciBkb2VzIG5vdCB1c2Ug
YW55IHN5bWJvbHMgZnJvbSA8bGludXgvZ3Bpby5oPg0KPiBzbyBqdXN0IGRyb3AgdGhlIGluY2x1
ZGUuDQo+IA0KPiBDYzogTWF0dGkgVmFpdHRpbmVuIDxtYXR0aS52YWl0dGluZW5AZmkucm9obWV1
cm9wZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IExpbnVzIFdhbGxlaWogPGxpbnVzLndhbGxlaWpA
bGluYXJvLm9yZz4NCkFja2VkLUJ5OiBNYXR0aSBWYWl0dGluZW4gPG1hdHRpLnZhaXR0aW5lbkBm
aS5yb2htZXVyb3BlLmNvbT4NCg0KQnIsDQoJTWF0dGkgVmFpdHRpbmVuDQoNCg==
