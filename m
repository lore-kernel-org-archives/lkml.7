Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD5FC2D0DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 06:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C32215A4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 06:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgABGsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 01:48:05 -0500
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:54864 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgABGsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 01:48:05 -0500
X-AuditID: c0a8fbf4-183ff70000001fa6-8b-5e0d92239272
Received: from smtp.reu.rohmeu.com (will-cas001.reu.rohmeu.com [192.168.251.177])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 98.D9.08102.3229D0E5; Thu,  2 Jan 2020 07:48:03 +0100 (CET)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS001.REu.RohmEu.com ([fe80::d57e:33d0:7a5d:f0a6%16]) with mapi id
 14.03.0439.000; Thu, 2 Jan 2020 07:47:59 +0100
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "axel.lin@ingics.com" <axel.lin@ingics.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: bd70528: Remove .set_ramp_delay for
 bd70528_ldo_ops
Thread-Topic: [PATCH] regulator: bd70528: Remove .set_ramp_delay for
 bd70528_ldo_ops
Thread-Index: AQHVwEqUU274yDAdXUmbzUTRoKdhqafW384A
Date:   Thu, 2 Jan 2020 06:47:58 +0000
Message-ID: <356b68fe844846c7fa1e6b7cefae93220508e4b0.camel@fi.rohmeurope.com>
References: <20200101022406.15176-1-axel.lin@ingics.com>
In-Reply-To: <20200101022406.15176-1-axel.lin@ingics.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.255.186.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5BCE6607F285D840A05ACA5BA2B275DD@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsVyYMXvjbrKk3jjDE78tLA4Mucrs8XUh0/Y
        LL5d6WCyuLxrDpsDi8fOWXfZPdp+lnlsWtXJ5vF5k1wASxS3TVJiSVlwZnqevl0Cd0Z3xxbm
        gkvsFV0ff7E0MO5g72Lk5JAQMJFY/6QHyObiEBK4yigx/dVJJgjnOKPEz0OP2boYOTjYBGwk
        um6CNYgIxEj8WfIeLMwsUCAx84wuSFhYIFTi7uzrzBAlYRKHth1mhLCNJC4/XssKUs4ioCJx
        77cGSJhXwE/i2/3tYOVCAhYSTSumsYDYnAKWEk9+TwZrZRSQlehseMcEYjMLiEtsevadFeJk
        AYkle84zQ9iiEi8f/4OKK0ns/fmQBeIyTYn1u/QhWh0k/q7+zAZhK0pM6X7IDnGCoMTJmU9Y
        JjCKzUKyYRZC9ywk3bOQdM9C0r2AkXUVo0RuYmZOemJJqqFeUWqpXlF+Ri6QSs7P3cQIib0v
        Oxj/H/I8xMjEwXiIUZKDSUmUd4UDV5wQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd7yQN44Id6U
        xMqq1KJ8mJQ0B4uSOK/6w4mxQgIgu7JTUwtSi2CyMhwcShK873uBGgWLUtNTK9Iyc0oQ0kwc
        nCDDuaREilPzUlKLEktLMuJBiSO+GJg6QFI8QHt9JoDsLS5IzAWKQrSeYtTmmPBy7iJmjiNz
        ly5iFmLJy89LlRLn3QdSKgBSmlGaB7foFaM4B6OSMC/HRKAsDzAJw815BbSCCWjF97+cICtK
        EhFSUg2MXM1fvP7qHzltJ8rwz6P9tEzX42CvoFKBg0XfTidFuN/dkS68kn2Z7uOV+u99irKb
        JBc+keSSM9wktrMzY35XOGviK2b2htqU5s8/uH4ci9r6bkVPq+VT+fdrH8/dujhCMDk72qHx
        4Ili8aotyyymneZ/b1hdN3fPhveMup2SN867LNs85cQvJZbijERDLeai4kQAmMJA538DAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gQXhlbCwNCg0KT24gV2VkLCAyMDIwLTAxLTAxIGF0IDEwOjI0ICswODAwLCBBeGVsIExp
biB3cm90ZToNCj4gVGhlIC5zZXRfcmFtcF9kZWxheSBzaG91bGQgYmUgZm9yIGJkNzA1MjhfYnVj
a19vcHMgb25seS4NCkluZGVlZCEgT25seSB0aGUgYnVja3Mgb24gQkQ3MDUyOCBjYW4gY2hhbmdl
IHRoZSByYW1wLWRlbGF5LiBUaGFuayB5b3UNCmZvciBmaXhpbmcgdGhpcyEgTWF5IEkgYXNrLCBo
b3cgZGlkIHlvdSBub3RpY2UgdGhpcyBwcm9sZW0/DQoNCj4gU2V0dGluZyAuc2V0X3JhbXBfZGVs
YXkgZm9yIGZvciBiZDcwNTI4X2xkb19vcHMgY2F1c2VzIHByb2JsZW0NCj4gYmVjYXVzZQ0KPiBC
RDcwNTI4X01BU0tfQlVDS19SQU1QICgweDEwKSBvdmVybGFwcyB3aXRoIEJENzA1MjhfTUFTS19M
RE9fVk9MVA0KPiAoMHgxZikuDQo+IFNvIHNldHRpbmcgcmFtcF9kZWxheSBmb3IgTERPcyBtYXkg
Y2hhbmdlIHRoZSB2b2x0YWdlIG91dHB1dCwgZml4IGl0Lg0KPiANCj4gRml4ZXM6IDk5ZWEzN2Jk
MWU3ZCAoInJlZ3VsYXRvcjogYmQ3MDUyODogU3VwcG9ydCBST0hNIEJENzA1MjgNCj4gcmVndWxh
dG9yIGJsb2NrIikNCj4gU2lnbmVkLW9mZi1ieTogQXhlbCBMaW4gPGF4ZWwubGluQGluZ2ljcy5j
b20+DQoNCkFja2VkLWJ5OiBNYXR0aSBWYWl0dGluZW4gPG1hdHRpLnZhaXR0aW5lbkBmaS5yb2ht
ZXVyb3BlLmNvbT4NCg0KQnIsDQoJTWF0dGkNCg==
