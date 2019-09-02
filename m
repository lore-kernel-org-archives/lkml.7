Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF3DC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B742217D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730977AbfIBJMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 05:12:38 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:32532 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730117AbfIBJMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:12:38 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-60-LjZpe51sM9OJdUKyRBlwAQ-1; Mon, 02 Sep 2019 10:12:35 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 2 Sep 2019 10:12:34 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 2 Sep 2019 10:12:34 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Randy Dunlap' <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        "Steven J. Magnani" <steve@digidescorp.com>,
        Michal Simek <monstr@monstr.eu>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: RE: [PATCH v3] arch/microblaze: add support for get_user() of size 8
 bytes
Thread-Topic: [PATCH v3] arch/microblaze: add support for get_user() of size 8
 bytes
Thread-Index: AQHVYNVekorxHLiLXE646mlyL9rWQKcYGw6A
Date:   Mon, 2 Sep 2019 09:12:34 +0000
Message-ID: <1c5b4f577ec0475bb33d4106f45796a5@AcuMS.aculab.com>
References: <5a3e440f-4ec5-65d7-b2a4-c57fec0df973@infradead.org>
In-Reply-To: <5a3e440f-4ec5-65d7-b2a4-c57fec0df973@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: LjZpe51sM9OJdUKyRBlwAQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUmFuZHkgRHVubGFwDQo+IFNlbnQ6IDAxIFNlcHRlbWJlciAyMDE5IDE1OjU2DQo+IGFy
Y2gvbWljcm9ibGF6ZS8gaXMgbWlzc2luZyBzdXBwb3J0IGZvciBnZXRfdXNlcigpIG9mIHNpemUg
OCBieXRlcywNCj4gc28gYWRkIGl0IGJ5IHVzaW5nIF9fY29weV9mcm9tX3VzZXIoKS4NCg0KVWdn
Li4uLg0KDQpVc2UgZ2V0X3VzZXIoKSBmb3IgNCBieXRlcyB0d2ljZSBhbmQgY29tYmluZSB0aGUg
cmV0dXJuZWQgdmFsdWVzLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2Vz
aWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVL
DQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

