Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2ABC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9093621A49
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389671AbfIENAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 09:00:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:1366 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389616AbfIENAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 09:00:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2019 06:00:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,470,1559545200"; 
   d="scan'208";a="185436053"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga003.jf.intel.com with ESMTP; 05 Sep 2019 06:00:22 -0700
Received: from fmsmsx124.amr.corp.intel.com (10.18.125.39) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 5 Sep 2019 06:00:22 -0700
Received: from lcsmsx152.ger.corp.intel.com (10.186.165.231) by
 fmsmsx124.amr.corp.intel.com (10.18.125.39) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 5 Sep 2019 06:00:22 -0700
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.203]) by
 LCSMSX152.ger.corp.intel.com ([169.254.4.206]) with mapi id 14.03.0439.000;
 Thu, 5 Sep 2019 16:00:18 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>
Subject: RE: Could not read FW version, FW version command failed -5
Thread-Topic: Could not read FW version, FW version command failed -5
Thread-Index: AQHVYzAsGj6cSRky10KgwY5FGQQ3WacbooHw
Date:   Thu, 5 Sep 2019 13:00:18 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9DCB0429@hasmsx108.ger.corp.intel.com>
References: <857e1cae-dbcb-4a47-2f43-5e0a1aa4fe65@molgen.mpg.de>
In-Reply-To: <857e1cae-dbcb-4a47-2f43-5e0a1aa4fe65@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZDY3NWRlMzgtNTQ3ZC00Y2EzLWI4NmYtMDI5MGY2NzAzMWQ3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoic25qM1dVemwyaHpYTmxSNGR4UThid1R2T09RbHlQZFBFV21haXZsU3JcLzM3bVVZMjJiRnJwQ3FkSmpES08wVmgifQ==
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.184.70.10]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gRGVhciBUb21hcywNCj4gDQo+IA0KPiBUZXN0aW5nIEZlZG9yYSAzMCB3aXRoIExpbnV4
IDUuMi4xMSBvbiBhbiBvbGQgRGVsbCBPcHRpUGxleCA5ODAsIExpbnV4IA0KPiBsb2cgdGhlIG1l
c3NhZ2UgYmVsb3cuDQo+IA0KPiAgICAgWyAgIDE1Ljk2NDI5OF0gbWVpIG1laTo6NTUyMTM1ODQt
OWEyOS00OTE2LWJhZGYtMGZiN2VkNjgyYWViOjAxOiBDb3VsZA0KPiBub3QgcmVhZCBGVyB2ZXJz
aW9uDQo+ICAgICBbICAgMTUuOTY0MzAxXSBtZWkgbWVpOjo1NTIxMzU4NC05YTI5LTQ5MTYtYmFk
Zi0wZmI3ZWQ2ODJhZWI6MDE6IEZXDQo+IHZlcnNpb24gY29tbWFuZCBmYWlsZWQgLTUNCj4gDQo+
IFRoZSBwcmludHMgaGFwcGVuIGluIGBkcml2ZXJzL21pc2MvbWVpL2J1cy1maXh1cC5jYC4NCj4g
DQo+ICAgICAgICAgcmV0ID0gMDsNCj4gICAgICAgICBieXRlc19yZWN2ID0gX19tZWlfY2xfcmVj
dihjbGRldi0+Y2wsIGJ1Ziwgc2l6ZW9mKGJ1ZiksIDAsDQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgTUtISV9SQ1ZfVElNRU9VVCk7DQo+ICAgICAgICAgaWYgKGJ5dGVzX3Jl
Y3YgPCAwIHx8IChzaXplX3QpYnl0ZXNfcmVjdiA8IE1LSElfRldWRVJfTEVOKDEpKSB7DQo+ICAg
ICAgICAgICAgICAgICAvKg0KPiAgICAgICAgICAgICAgICAgICogU2hvdWxkIGJlIGF0IGxlYXN0
IG9uZSB2ZXJzaW9uIGJsb2NrLA0KPiAgICAgICAgICAgICAgICAgICogZXJyb3Igb3V0IGlmIG5v
dGhpbmcgZm91bmQNCj4gICAgICAgICAgICAgICAgICAqLw0KPiAgICAgICAgICAgICAgICAgZGV2
X2VycigmY2xkZXYtPmRldiwgIkNvdWxkIG5vdCByZWFkIEZXIHZlcnNpb25cbiIpOw0KPiAgICAg
ICAgICAgICAgICAgcmV0dXJuIC1FSU87DQo+ICAgICAgICAgfQ0KPiANCj4gVGhlIFdlYiBpcyBm
dWxsIG9mIHRoZXNlIG1lc3NhZ2VzLCBzbyBpdCBkb2VzIHNlZW0gbGlrZSBhIG5vcm1hbCANCj4g
Y29uZGl0aW9uIG9uIGNlcnRhaW4gZGV2aWNlcy4gRG8geW91IGtub3cgdGhlIHJlYXNvbj8gRG8g
b2xkZXIgSW50ZWwgDQo+IE1FcyBzdXBwb3J0IHRoaXM/DQoNCldvdywgdGhpcyBxdWl0ZSBhbiBv
bGQgc3lzdGVtIH4gMjAwOSwgdGhlIEZXIHZlcnNpb24gaGFzIGEgYml0IGRpZmZlcmVudCBmb3Jt
YXQgdGhlcmUsIGl0IHdhcyBvdmVybG9va2VkLCAgd2lsbCBsb29rIGF0IHRoYXQgQVNBUCwgdGhh
bmtzIGZvciB0aGUgcmVwb3J0LiANClRvbWFzDQoNCg==
