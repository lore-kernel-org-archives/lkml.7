Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D664C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C7E208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfH1PhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 11:37:21 -0400
Received: from mga12.intel.com ([192.55.52.136]:5847 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbfH1PhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:37:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 08:37:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,441,1559545200"; 
   d="scan'208";a="185659111"
Received: from irsmsx109.ger.corp.intel.com ([163.33.3.23])
  by orsmga006.jf.intel.com with ESMTP; 28 Aug 2019 08:37:18 -0700
Received: from irsmsx108.ger.corp.intel.com ([169.254.11.50]) by
 IRSMSX109.ger.corp.intel.com ([169.254.13.11]) with mapi id 14.03.0439.000;
 Wed, 28 Aug 2019 16:37:17 +0100
From:   "Langer, Thomas" <thomas.langer@intel.com>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        "kishon@ti.com" <kishon@ti.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Kim, Cheol Yong" <cheol.yong.kim@intel.com>,
        "Wu, Qiming" <qi-ming.wu@intel.com>,
        "Liem, Peter Harliman" <peter.harliman.liem@intel.com>
Subject: RE: [PATCH v2 1/2] dt-bindings: phy: intel-sdxc-phy: Add YAML
 schema for LGM SDXC PHY
Thread-Topic: [PATCH v2 1/2] dt-bindings: phy: intel-sdxc-phy: Add YAML
 schema for LGM SDXC PHY
Thread-Index: AQHVXZ4xYyd3YPMhfE+TmW51Wrt3TqcQpsSw
Date:   Wed, 28 Aug 2019 15:37:17 +0000
Message-ID: <0DAF21CFE1B20740AE23D6AF6E54843F1FDDE99F@IRSMSX108.ger.corp.intel.com>
References: <20190828124315.48448-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190828124315.48448-2-vadivel.muruganx.ramuthevar@linux.intel.com>
In-Reply-To: <20190828124315.48448-2-vadivel.muruganx.ramuthevar@linux.intel.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMmQyNWU3NTgtOWJmNC00ZGVmLTg0ZDItMTAxNTMxNDYwNjVlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMmxiSE42K3lFclExR3BFXC9OZFBrR2NvUHdTUWlwUlJ0cDF0U0VzWW9DTVJ1VzdzZVlRa2p4XC9OVGd4QjlUTEFcLyJ9
x-originating-ip: [163.33.239.181]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmFkaXZlbCwNCg0KPiArLi4uDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvcGh5L2ludGVsLHN5c2Nvbi55YW1sDQo+IGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9pbnRlbCxzeXNjb24ueWFtbA0KPiBuZXcgZmlsZSBtb2Rl
IDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLmQwYjc4ODA1ZTQ5Zg0KPiAtLS0gL2Rldi9u
dWxsDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvaW50ZWws
c3lzY29uLnlhbWwNCj4gQEAgLTAsMCArMSwzMyBAQA0KPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogR1BMLTIuMA0KPiArJVlBTUwgMS4yDQo+ICstLS0NCj4gKyRpZDogaHR0cDovL2Rldmlj
ZXRyZWUub3JnL3NjaGVtYXMvcGh5L2ludGVsLHN5c2Nvbi55YW1sIw0KPiArJHNjaGVtYTogaHR0
cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ICsNCj4gK3RpdGxl
OiBTeXNjb24gZm9yIGVNTUMvU0RYQyBQSFkgRGV2aWNlIFRyZWUgQmluZGluZ3MNCg0KVGhpcyBz
YXlzIHRoZSBiaW5kaW5nIGlzIGZvciBlTU1DL1NEWEMNCg0KPiArDQo+ICttYWludGFpbmVyczoN
Cj4gKyAgLSBSYW11dGhldmFyIFZhZGl2ZWwgTXVydWdhbg0KPiA8dmFkaXZlbC5tdXJ1Z2FueC5y
YW11dGhldmFyQGxpbnV4LmludGVsLmNvbT4NCj4gKw0KPiArcHJvcGVydGllczoNCj4gKyAgY29t
cGF0aWJsZToNCj4gKyAgICBjb25zdDogaW50ZWwsc3lzY29uDQoNCmJ1dCB0aGlzIGlzIGEgZ2Vu
ZXJpYyBzeXNjb24sIGJlaGluZCB3aGljaCBhcmUgbWFueSByZWdpc3RlcnMsIG5vdCBvbmx5IGZv
cg0KZU1NQy9TRFhDLiBBbHNvLCB0aGUgcmVnaXN0ZXJzIHdpbGwgYmUgZGlmZmVyZW50IGZvciBl
YWNoIFNvQyBhbmQgbmVlZGVkIGZvcg0KbWFueSBkaWZmZXJlbnQgZHJpdmVycywgdGhhdCBpcyB3
aHkgaW4geW91ciBleGFtcGxlIGl0IGlzIGNhbGxlZCAiY2hpcHRvcCINCi0+IHRvcGxldmVsIHJl
Z2lzdGVycyBub3QgYmVsb25naW5nIHRvIGEgc3BlY2lmaWMgSFcgbW9kdWxlLg0KDQpSb2I6IERv
IHlvdSBhbHNvIHRoaW5rIHRoaXMgImludGVsLHN5c2NvbiIgaXMgdG9vIGdlbmVyaWM/DQogICAg
IEFuZCB0aGUgYmluZGluZyBzaG91bGQgYmUgb3V0c2lkZSB0aGUgInBoeSIgZm9sZGVyPw0KDQpX
aGF0IGlzIHRoZSB3YXkgdG8gc3VwcG9ydCBkaWZmZXJlbnQgU29DcyB3aXRoIHRoaXM/IA0KTXVz
dCB0aGUgZHJpdmVyIHJlZmVyZW5jaW5nIHRoaXMgc3lzY29uIGJlIGF3YXJlIG9mIHRoZXNlIGRp
ZmZlcmVuY2VzPw0KDQo+ICsNCj4gKyAgcmVnOg0KPiArICAgIG1heEl0ZW1zOiAxDQo+ICsNCj4g
KyAgIiNyZXNldC1jZWxscyI6DQo+ICsgICBjb25zdDogMQ0KPiArDQo+ICtyZXF1aXJlZDoNCj4g
KyAgLSBjb21wYXRpYmxlDQo+ICsgIC0gcmVnDQo+ICsgIC0gIiNyZXNldC1jZWxscyINCj4gKw0K
PiArZXhhbXBsZXM6DQo+ICsgIC0gfA0KPiArICAgIHN5c2NvbmY6IGNoaXB0b3BAZTAwMjAwMDAg
ew0KPiArICAgICAgIGNvbXBhdGlibGUgPSAiaW50ZWwsc3lzY29uIiwgInN5c2NvbiI7DQo+ICsg
ICAgICAgcmVnID0gPDB4ZTAwMjAwMDAgMHgxMDA+Ow0KPiArICAgICAgICNyZXNldC1jZWxscyA9
IDwxPjsNCj4gKyAgICB9Ow0KPiAtLQ0KPiAyLjExLjANCg0KQmVzdCByZWdhcmRzLA0KVGhvbWFz
DQo=
