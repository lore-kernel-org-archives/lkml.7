Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C19AC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 07:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5452083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 07:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfFFHNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 03:13:22 -0400
Received: from mga12.intel.com ([192.55.52.136]:28833 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfFFHNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 03:13:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2019 00:13:21 -0700
X-ExtLoop1: 1
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jun 2019 00:13:21 -0700
Received: from fmsmsx158.amr.corp.intel.com (10.18.116.75) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 6 Jun 2019 00:13:21 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 fmsmsx158.amr.corp.intel.com (10.18.116.75) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 6 Jun 2019 00:13:21 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.10]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.6]) with mapi id 14.03.0415.000;
 Thu, 6 Jun 2019 15:13:19 +0800
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [PATCH 1/3] x86/CPU: Add more Icelake model number
Thread-Topic: [PATCH 1/3] x86/CPU: Add more Icelake model number
Thread-Index: AQHVGhI6CBhJKpTmwUOFAEOJmoUocKaNqcuAgACJ/8A=
Date:   Thu, 6 Jun 2019 07:13:18 +0000
Message-ID: <E6AF1AFDEA62A94A97508F458CBDD47F7A22F284@SHSMSX101.ccr.corp.intel.com>
References: <20190603134122.13853-1-kan.liang@linux.intel.com>
 <20190606063525.GA26146@zn.tnic>
In-Reply-To: <20190606063525.GA26146@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOWVjY2RkOTUtYmMzZi00NGMzLTk0M2ItYjdlMTQ4N2M1OTU2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWkRuZ0ZUNitFak53SkhSck9aUmgzOVdWeXB4d0p3N0t5aHloWWZsT3NtSk9xemhUZEZWUThFaU9naXVHMng5YyJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgW21haWx0bzpicEBhbGllbjguZGVdDQo+IC4uLg0KPiA+
IEZyb206IEthbiBMaWFuZyA8a2FuLmxpYW5nQGxpbnV4LmludGVsLmNvbT4NCj4gPg0KPiA+IEFk
ZCB0aGUgQ1BVSUQgbW9kZWwgbnVtYmVyIG9mIEljZWxha2UgKElDTCkgZGVza3RvcCBhbmQgc2Vy
dmVyDQo+ID4gcHJvY2Vzc29ycyB0byB0aGUgSW50ZWwgZmFtaWx5IGxpc3QuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBLYW4gTGlhbmcgPGthbi5saWFuZ0BsaW51eC5pbnRlbC5jb20+DQo+ID4g
U2lnbmVkLW9mZi1ieTogUWl1eHUgWmh1byA8cWl1eHUuemh1b0BpbnRlbC5jb20+DQo+IA0KPiBZ
b3UncmUgc2VuZGluZyB0aGlzIHBhdGNoIGJ1dCBpdCBoYXMgUWl1eHUncyBTT0IgdG9vLiBXaGF0
J3MgdGhhdCBzdXBwb3NlZCB0byBtZWFuPw0KDQpIaSBCb3JpcywNCg0KRHVyaW5nIGludGVybmFs
IGNvLXdvcmssIGJhc2VkIG9uIEthbidzIG9yaWdpbmFsIHBhdGNoLCBJIGdvdCB0aGUgIiNkZWZp
bmUiIGluIHRoZSBJY2UgTGFrZSBncm91cCBzb3J0ZWQgYnkgbW9kZWwgbnVtYmVyKHRoZSBoZWFk
ZXIgb2YgdGhlIGZpbGUgcmVxdWlyZXMgdGhlIHNvcnRpbmcpIGFuZCBhZGRlZCBteSBTT0IuIERy
b3BwaW5nIG15IFNPQiBvciBhZGRpbmcgYSB0ZXh0ICJbUWl1eHU6IEdldCB0aGUgbWFjcm9zIGlu
IHRoZSBJY2UgTGFrZSBncm91cCBzb3J0ZWQgYnkgbW9kZWwgbnVtYmVyLl0iIGF0IHRoZSBlbmQg
b2YgdGhlIGNvbW1pdCBtZXNzYWdlIC0gd2hpY2ggb25lIGlzIGJldHRlci9jbGVhciBmb3IgeW91
Pw0KDQpUaGFua3MhDQotUWl1eHUNCg0KDQo=
