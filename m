Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348B6CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 12:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD2E20862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 12:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfJaMvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 08:51:39 -0400
Received: from mga03.intel.com ([134.134.136.65]:10880 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbfJaMvj (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 08:51:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2019 05:51:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,250,1569308400"; 
   d="scan'208";a="401870089"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga006.fm.intel.com with ESMTP; 31 Oct 2019 05:51:38 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 31 Oct 2019 05:51:38 -0700
Received: from shsmsx103.ccr.corp.intel.com ([169.254.4.60]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.2]) with mapi id 14.03.0439.000;
 Thu, 31 Oct 2019 20:51:36 +0800
From:   "Liang, Kan" <kan.liang@intel.com>
To:     "Song, HaiyanX" <haiyanx.song@intel.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>
CC:     "Linux-kernel@vger.kernel.org" <Linux-kernel@vger.kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "Jin, Yao" <yao.jin@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>
Subject: RE: [PATCH v2 1/2] perf vendor events intel: Update Cascadelakex
 events to v1.05
Thread-Topic: [PATCH v2 1/2] perf vendor events intel: Update Cascadelakex
 events to v1.05
Thread-Index: AQHVj4kut8zmWi/7WEOpDQ4AwdRiOqdzcYKAgAFB1fA=
Date:   Thu, 31 Oct 2019 12:51:35 +0000
Message-ID: <37D7C6CF3E00A74B8858931C1DB2F07753BA3B3C@SHSMSX103.ccr.corp.intel.com>
References: <20191031012950.15838-1-haiyanx.song@intel.com>
 <3e3786df-ecc9-013d-1056-48c4e5ae12f9@intel.com>
In-Reply-To: <3e3786df-ecc9-013d-1056-48c4e5ae12f9@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZWE3ZGZkMDMtZDY3Yy00NzMyLThkOGYtMmFkZTI2MGNlNmNlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVWN0Mkt2MzkyTXRjblJkM3lrTnpSd1NLdWJua1c2YlV2Vko5TTRTQ0FvNldxd2puellXK0RhR21FR1BIWGoyeSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvMl0gcGVyZiB2ZW5kb3IgZXZlbnRzIGludGVsOiBV
cGRhdGUgQ2FzY2FkZWxha2V4DQo+IGV2ZW50cyB0byB2MS4wNQ0KPiANCj4gSGksDQo+IA0KPiBB
dHRhY2hlZCB0aGUgdjIgcGF0Y2ggYXMgYW4gYXR0YWNobWVudCB0b28uDQoNClRoZSBWMiBwYXRj
aCBzZXQgbG9va3MgZ29vZCB0byBtZS4NCg0KUmV2aWV3ZWQtYnk6IEthbiBMaWFuZyA8a2FuLmxp
YW5nQGxpbnV4LmludGVsLmNvbT4NCg0KVGhhbmtzLA0KS2FuDQoNCj4gVGhhbmtzIGZvciB5b3Vy
IHJldmlldyENCj4gDQo+IC0tDQo+IEJlc3QgcmVnYXJkcywNCj4gSGFpeWFuIFNvbmcNCj4gDQo+
IE9uIDEwLzMxLzE5IDk6MjkgQU0sIEhhaXlhbiBTb25nIHdyb3RlOg0KPiA+IFVwZGF0ZSBDYXNj
YWRlbGFja2V4IGV2ZW50cyB0byB2MS4wNS4NCj4gPg0KPiA+IE90aGVyIGNoYW5nZXM6DQo+ID4g
ICByZW1vdmUgZHVwbGljYXRlZCBhbmQgd2l0aG91dCBkZXNjcmlwdGlvbiBldmVudHMuDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBIYWl5YW4gU29uZyA8aGFpeWFueC5zb25nQGludGVsLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgIC4uLi9wbXUtZXZlbnRzL2FyY2gveDg2L2Nhc2NhZGVsYWtleC9jYWNo
ZS5qc29uICAgIHwgMTIwNjggKysrKysrKysrLS0tDQo+IC0tLS0tLS0NCj4gPiAgIC4uLi9hcmNo
L3g4Ni9jYXNjYWRlbGFrZXgvZmxvYXRpbmctcG9pbnQuanNvbiAgICAgIHwgICAgOTIgKy0NCj4g
PiAgIC4uLi9wbXUtZXZlbnRzL2FyY2gveDg2L2Nhc2NhZGVsYWtleC9mcm9udGVuZC5qc29uIHwg
ICA2NTYgKy0NCj4gPiAgIC4uLi9wbXUtZXZlbnRzL2FyY2gveDg2L2Nhc2NhZGVsYWtleC9tZW1v
cnkuanNvbiAgIHwgMTE0MDgNCj4gKysrKysrKysrLS0tLS0tLS0tDQo+ID4gICAuLi4vcG11LWV2
ZW50cy9hcmNoL3g4Ni9jYXNjYWRlbGFrZXgvb3RoZXIuanNvbiAgICB8ICA5NjIwICsrKysrKyst
LS0tLS0tLQ0KPiA+ICAgLi4uL3BtdS1ldmVudHMvYXJjaC94ODYvY2FzY2FkZWxha2V4L3BpcGVs
aW5lLmpzb24gfCAgMTIzNCArLQ0KPiA+ICAgLi4uL2FyY2gveDg2L2Nhc2NhZGVsYWtleC91bmNv
cmUtbWVtb3J5Lmpzb24gICAgICAgfCAgIDE5MSArDQo+ID4gICAuLi4vYXJjaC94ODYvY2FzY2Fk
ZWxha2V4L3VuY29yZS1vdGhlci5qc29uICAgICAgICB8ICAxNTg1ICsrLQ0KPiA+ICAgLi4uL2Fy
Y2gveDg2L2Nhc2NhZGVsYWtleC92aXJ0dWFsLW1lbW9yeS5qc29uICAgICAgfCAgIDMzOSArLQ0K
PiA+ICAgOSBmaWxlcyBjaGFuZ2VkLCAxOTIyOCBpbnNlcnRpb25zKCspLCAxNzk2NSBkZWxldGlv
bnMoLSkNCj4gPg0K
