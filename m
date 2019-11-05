Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA5ACA9EC7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 06:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A69720818
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 06:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbfKEGDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 01:03:17 -0500
Received: from mga03.intel.com ([134.134.136.65]:4876 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730152AbfKEGDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 01:03:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 22:03:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,270,1569308400"; 
   d="scan'208";a="200702984"
Received: from kmsmsx157.gar.corp.intel.com ([172.21.138.134])
  by fmsmga007.fm.intel.com with ESMTP; 04 Nov 2019 22:03:14 -0800
Received: from pgsmsx108.gar.corp.intel.com ([169.254.8.51]) by
 kmsmsx157.gar.corp.intel.com ([169.254.5.204]) with mapi id 14.03.0439.000;
 Tue, 5 Nov 2019 14:03:08 +0800
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        "Zavras, Alexios" <alexios.zavras@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [alsa-devel] [PATCH] ASoC: bdw-rt5677: enable runtime channel
 merge
Thread-Topic: [alsa-devel] [PATCH] ASoC: bdw-rt5677: enable runtime channel
 merge
Thread-Index: AQHVeQDQJxSKmeHo60W0FoozADL3CqdkfMRQgAADboCAF8XX4A==
Date:   Tue, 5 Nov 2019 06:03:07 +0000
Message-ID: <CF33C36214C39B4496568E5578BE70C74032F8BA@PGSMSX108.gar.corp.intel.com>
References: <1570007072-23049-1-git-send-email-brent.lu@intel.com>
 <CF33C36214C39B4496568E5578BE70C74031B9FD@PGSMSX108.gar.corp.intel.com>
 <63da3995-b807-f9e6-6f09-a90e6b8e8e53@linux.intel.com>
In-Reply-To: <63da3995-b807-f9e6-6f09-a90e6b8e8e53@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNmEwZTU0MjEtYWI3NS00MTc3LWE1NGItMjA0M2RiZmRhZGZiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVXFLMjJZZFd4WURZVTJsS2daTHZvNUVtclwvRzZhekNtWVNrRmE2d2ozQlMyMWplMDA3UWtDa1JMSjFFazNcL0FiIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [172.30.20.206]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+PiBJbiB0aGUgREFJIGxpbmsgIkNhcHR1cmUgUENNIiwgdGhlIEZFIERBSSAiQ2FwdHVyZSBQ
aW4iIHN1cHBvcnRzDQo+ID4+IDQtY2hhbm5lbCBjYXB0dXJlIGJ1dCB0aGUgQkUgREFJIHN1cHBv
cnRzIG9ubHkgMi1jaGFubmVsIGNhcHR1cmUuIFRvDQo+ID4+IGZpeCB0aGUgY2hhbm5lbCBtaXNt
YXRjaCwgd2UgbmVlZCB0byBlbmFibGUgdGhlIHJ1bnRpbWUgY2hhbm5lbCBtZXJnZQ0KPiBmb3Ig
dGhpcyBEQUkgbGluay4NCj4gPj4NCj4gPg0KPiA+IEhpIFBpZXJyZSwNCj4gPg0KPiA+IFRoaXMg
cGF0Y2ggaXMgZm9yIHRoZSBzYW1lIGlzc3VlIGRpc2N1c3NlZCBpbiB0aGUgZm9sbG93aW5nIHRo
cmVhZDoNCj4gPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzExMTM0MTY3Lw0K
PiA+DQo+ID4gV2UgZW5hYmxlIHRoZSBydW50aW1lIGNoYW5uZWwgbWVyZ2UgZm9yIHRoZSBETUlD
IERBSSBpbnN0ZWFkIG9mIGFkZGluZw0KPiA+IGEgbWFjaGluZSBkcml2ZXIgY29uc3RyYWludC4g
SXQncyB3b3JraW5nIGdvb2Qgb24gY2hyb21lJ3MgMy4xNCBicmFuY2gNCj4gPiAod2hpY2ggcmVx
dWlyZXMgc29tZSBiYWNrcG9ydCBmb3IgdGhlIHJ1bnRpbWUgY2hhbm5lbCBtZXJnZSBmZWF0dXJl
KS4NCj4gPiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgdGhpcyBpbXBsZW1lbnRhdGlvbiBpcyBjb3Jy
ZWN0IGZvciB0aGUgRkUvQkUgbWlzbWF0Y2gNCj4gcHJvYmxlbS4NCj4gDQo+IFNvcnJ5LCBJIGRv
bid0IGZ1bGx5IHVuZGVyc3RhbmQgeW91ciBwb2ludHMsIGFuZCBpdCdzIHRoZSBmaXJzdCB0aW1l
IEkgc2VlIGFueW9uZQ0KPiB1c2UgdGhpcyAuZHBjbV9tZXJnZWRfY2hhbiBmaWVsZCBmb3IgYW4g
SW50ZWwgcGxhdGZvcm0uDQo+IA0KPiBJZiBJIGxvb2sgYXQgdGhlIGNvZGUgSSBzZWUgdGhhdCB0
aGUgY29yZSB3b3VsZCBsaW1pdCB0aGUgbnVtYmVyIG9mIGNoYW5uZWxzIHRvDQo+IHR3by4gQnV0
IHRoYXQgY29kZSBuZWVkcyB0aGUgQ1BVX0RBSSB0byB1c2UgMiBjaGFubmVscywgd2hpY2ggSSBk
b24ndCBzZWUuDQo+IFNvIGlzIHRoaXMgcGF0Y2ggc2VsZi1jb250YWluZWQgb3IgZG8gd2UgbmVl
ZCBhbiBhZGRpdGlvbmFsIGNvbnN0cmFpbnQgb24gdGhlDQo+IEZFPw0KPiANCj4gVGhhbmtzDQo+
IC1QaWVycmUNCg0KSGkgUGllcnJlLA0KDQpXZSBkb24ndCBuZWVkIGNvbnN0cmFpbnQgb24gRkUg
YmVjYXVzZSBkcGNtX3J1bnRpbWVfbWVyZ2VfY2hhbigpIG1vZGlmaWVzDQp0aGUgY2hhbm5lbCBu
dW1iZXIgb2Ygc25kX3BjbV9oYXJkd2FyZSBzdHJ1Y3R1cmUgZGlyZWN0bHkuIFRoZSBzdHJ1Y3R1
cmUgd2lsbA0KYmUgdXNlZCB0byBpbml0aWFsaXplIHRoZSBzbmRfcGNtX2h3X2NvbnN0cmFpbnRz
IHN0cnVjdHVyZSBsYXRlciBpbiB0aGUNCnNuZF9wY21faHdfY29uc3RyYWludHNfY29tcGxldGUo
KSBmdW5jdGlvbi4gU2luY2UgdGhlIGNoYW5uZWwgbnVtYmVyIGlzIGFscmVhZHkNCm1vZGlmaWVk
LCB3ZSBkb24ndCBuZWVkIGEgY29uc3RyYWludCB0byBpbnN0YWxsIGFuIGV4dHJhIHJ1bGUgZm9y
IGl0Lg0KDQpUaGUgcmVzdWx0IG9mIHVzaW5nIGRwY21fbWVyZ2VkX2NoYW4gZmxhZyBhbmQgbWFj
aGluZSBkcml2ZXIgY29uc3RyYWludCBzaG91bGQNCmJlIHRoZSBzYW1lIHdoZW4gdXNlciBzcGFj
ZSBwcm9ncmFtcyBjYWxsaW5nIEhXX1JFRklORSBpb2N0bCBjYWxsIGJ1dCBJIHRoaW5rIHRoZQ0K
ZmxhZyBpcyBtb3JlIGVsZWdhbnQgZm9yIG1hY2hpbmUgZHJpdmVyIGNvZGUuDQoNCg0KUmVnYXJk
cywNCkJyZW50DQo=
