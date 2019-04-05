Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B8CC282DC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60EF02173C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731458AbfDERQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:16:12 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:60870 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730565AbfDERQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:16:11 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-196-T46Uki1XMeawGrKiJ4RDjA-1; Fri, 05 Apr 2019 18:16:08 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 5 Apr 2019 18:17:15 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 5 Apr 2019 18:17:15 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Josh Poimboeuf' <jpoimboe@redhat.com>
CC:     'Luis Ressel' <aranea@aixah.de>,
        Peter Zijlstra <peterz@infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] objtool: Don't use -Werror
Thread-Topic: [PATCH] objtool: Don't use -Werror
Thread-Index: AQHU68meTsW4XthB40qs85GeKW+DmKYtvJfg///yOYCAABLlUP//+1mAgAAR8yA=
Date:   Fri, 5 Apr 2019 17:17:15 +0000
Message-ID: <d24e8040cc8c47a48d1f85a5f06436a7@AcuMS.aculab.com>
References: <20190405110151.2461-1-aranea@aixah.de>
 <20190405123909.tupbgueie4czg2dd@treble>
 <20190405142443.rgpwbgyym76xizad@vega.skynet.aixah.de>
 <20190405143926.wmrkjsazlheeg6qs@treble>
 <20190405160550.62arkmvj67zm6oc2@vega.skynet.aixah.de>
 <a9dfc08702044b3db89c0584c0f79229@AcuMS.aculab.com>
 <20190405162109.4hv6lqpd6manzjju@treble>
 <d3cb290b12974f1895ea235680f90ead@AcuMS.aculab.com>
 <20190405171207.jmi7zehu37ksg5a4@treble>
In-Reply-To: <20190405171207.jmi7zehu37ksg5a4@treble>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: T46Uki1XMeawGrKiJ4RDjA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBIbSwgSSBkb24ndCBzZWUgdGhhdCBpbiBjbWRfb2JqdG9vbCwgb3IgYW55IGNvbW1pdHMgZnJv
bSB5b3UgaW4NCj4gc2NyaXB0cy9NYWtlZmlsZS5idWlsZC4NCg0KTm90IHN1cmUgSSByZW1lbWJl
ciBhY3R1YWxseSBjb21taXR0aW5nIHRoZW0uDQpNYXliZSAnZ2l0IGRpZmYnIGlzbid0IGRvaW5n
IHdoYXQgSSBleHBlY3QgOi0pDQpJIGhhdGUgZ2l0Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJl
ZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXlu
ZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

