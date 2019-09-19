Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC584C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 09:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B74D21924
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 09:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388502AbfISJGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 05:06:51 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:20327 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388194AbfISJGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 05:06:51 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-14-DMNrQgy8M0icP929vxXc6Q-1; Thu, 19 Sep 2019 10:06:48 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 19 Sep 2019 10:06:47 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 19 Sep 2019 10:06:47 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Tim Chen' <tim.c.chen@linux.intel.com>,
        Parth Shah <parth@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        "subhra mazumdar" <subhra.mazumdar@oracle.com>,
        Valentin Schneider <valentin.schneider@arm.com>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "morten.rasmussen@arm.com" <morten.rasmussen@arm.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "pjt@google.com" <pjt@google.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "quentin.perret@arm.com" <quentin.perret@arm.com>,
        "dhaval.giani@oracle.com" <dhaval.giani@oracle.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "qais.yousef@arm.com" <qais.yousef@arm.com>
Subject: RE: Usecases for the per-task latency-nice attribute
Thread-Topic: Usecases for the per-task latency-nice attribute
Thread-Index: AQHVbkTSM6YLBttm/EC+XVA86Ey6ZKcytOww
Date:   Thu, 19 Sep 2019 09:06:47 +0000
Message-ID: <9e705d2d22d040f4a170839466b38f5b@AcuMS.aculab.com>
References: <3e5c3f36-b806-5bcc-e666-14dc759a2d7b@linux.ibm.com>
 <426c0513-4354-e085-5a5d-8073ab035030@linux.intel.com>
In-Reply-To: <426c0513-4354-e085-5a5d-8073ab035030@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: DMNrQgy8M0icP929vxXc6Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogVGltIENoZW4NCj4gU2VudDogMTggU2VwdGVtYmVyIDIwMTkgMTg6MTYNCi4uLg0KPiBT
b21lIHVzZXJzIGFyZSBydW5uaW5nIG1hY2hpbmUgbGVhcm5pbmcgYmF0Y2ggdGFza3Mgd2l0aCBB
Vlg1MTIsIGFuZCBoYXZlIG9ic2VydmVkDQo+IHRoYXQgdGhlc2UgdGFza3MgYWZmZWN0IHRoZSB0
YXNrcyBuZWVkaW5nIGEgZmFzdCByZXNwb25zZS4gIFRoZXkgaGF2ZSB0bw0KPiByZWx5IG9uIG1h
bnVhbCBDUFUgYWZmaW5pdHkgdG8gc2VwYXJhdGUgdGhlc2UgdGFza3MuICBXaXRoIGFwcHJvcHJp
YXRlDQo+IGxhdGVuY3kgaGludCBvbiB0YXNrLCB0aGUgc2NoZWR1bGVyIGNhbiBiZSB0YXVnaHQg
dG8gc2VwYXJhdGUgdGhlbS4NCg0KV2lsbCAob3IgY2FuKSB0aGUgc2NoZWR1bGVyIHByZS1lbXB0
IGEgbG93IHByaW9yaXR5IHByb2Nlc3MgdGhhdCBpcyBzcGlubmluZw0KaW4gdXNlcnNwYWNlIGlu
IG9yZGVyIHRvIGFsbG93IGEgaGlnaCBwcmlvcml0eSAob3IgbG93IGxhdGVuY3kpIHByb2Nlc3Mg
cnVuDQpvbiB0aGF0IGNwdT8NCg0KTXkgc3VzcGljaW9uIGlzIHRoYXQgdGhlIHByb2Nlc3Mgc3dp
dGNoIGNhbid0IGhhcHBlbiB1bnRpbCAoYXQgbGVhc3QpIHRoZQ0KbmV4dCBoYXJkd2FyZSBpbnRl
cnJ1cHQgLSBhbmQgcG9zc2libHkgb25seSBhIHRpbWVyIHRpY2sgaW50byB0aGUgc2NoZWR1bGVy
Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJv
YWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24g
Tm86IDEzOTczODYgKFdhbGVzKQ0K

