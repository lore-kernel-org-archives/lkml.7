Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47076C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 042E120851
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388779AbfCAPbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 10:31:51 -0500
Received: from mga07.intel.com ([134.134.136.100]:61603 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbfCAPbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 10:31:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Mar 2019 07:31:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,428,1544515200"; 
   d="scan'208";a="278950603"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga004.jf.intel.com with ESMTP; 01 Mar 2019 07:31:41 -0800
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 1 Mar 2019 07:31:41 -0800
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 FMSMSX112.amr.corp.intel.com (10.18.116.6) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 1 Mar 2019 07:31:40 -0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.163]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.158]) with mapi id 14.03.0415.000;
 Fri, 1 Mar 2019 23:31:38 +0800
From:   "Li, Philip" <philip.li@intel.com>
To:     Axel Lin <axel.lin@ingics.com>, lkp <lkp@intel.com>
CC:     Keerthy <j-keerthy@ti.com>, Mark Brown <broonie@kernel.org>,
        "kbuild-all@01.org" <kbuild-all@01.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: RE: [kbuild-all] [PATCH] regulator: lp87565: Convert to use
 regulator_set/get_current_limit_regmap
Thread-Topic: [kbuild-all] [PATCH] regulator: lp87565: Convert to use
 regulator_set/get_current_limit_regmap
Thread-Index: AQHU0CKM8DTfQ8y6yE6yVHYF3u6bQKX2UWKAgACV3sA=
Date:   Fri, 1 Mar 2019 15:31:37 +0000
Message-ID: <831EE4E5E37DCC428EB295A351E6624951E47265@shsmsx102.ccr.corp.intel.com>
References: <20190301062432.2322-1-axel.lin@ingics.com>
 <201903011929.WkN8JU5R%fengguang.wu@intel.com>
 <CAFRkauDMAeEaptv5UZBGND=-58q-E0ssMaZjVw5XOUYZ2gTsrQ@mail.gmail.com>
In-Reply-To: <CAFRkauDMAeEaptv5UZBGND=-58q-E0ssMaZjVw5XOUYZ2gTsrQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNmNiZmFmMmYtZjI3Ni00MGQxLWFmOWItOTUyNTU5Y2MxN2UwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWWhnU1BROWJTbHZnS2J3cHd2TU51RFJmMCtRY21PajJyYW53ZU5KbktISXI2SGVqZGhWa1VCcTdlZ2VtWVpHSSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW2tidWlsZC1hbGxdIFtQQVRDSF0gcmVndWxhdG9yOiBscDg3NTY1OiBD
b252ZXJ0IHRvIHVzZQ0KPiByZWd1bGF0b3Jfc2V0L2dldF9jdXJyZW50X2xpbWl0X3JlZ21hcA0K
PiANCj4ga2J1aWxkIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+IOaWvCAyMDE55bm0M+aciDHm
l6Ug6YCx5LqUIOS4i+WNiDc6MzLlr6vpgZPvvJoNCj4gPg0KPiA+IEhpIEF4ZWwsDQo+ID4NCj4g
PiBUaGFuayB5b3UgZm9yIHRoZSBwYXRjaCEgWWV0IHNvbWV0aGluZyB0byBpbXByb3ZlOg0KPiA+
DQo+ID4gW2F1dG8gYnVpbGQgdGVzdCBFUlJPUiBvbiByZWd1bGF0b3IvZm9yLW5leHRdDQo+ID4g
W2Fsc28gYnVpbGQgdGVzdCBFUlJPUiBvbiBuZXh0LTIwMTkwMjI4XQ0KPiA+IFtjYW5ub3QgYXBw
bHkgdG8gdjUuMC1yYzhdDQo+ID4gW2lmIHlvdXIgcGF0Y2ggaXMgYXBwbGllZCB0byB0aGUgd3Jv
bmcgZ2l0IHRyZWUsIHBsZWFzZSBkcm9wIHVzIGEgbm90ZSB0byBoZWxwDQo+IGltcHJvdmUgdGhl
IHN5c3RlbV0NCj4gDQo+IFRoaXMgcGF0Y2ggbmVlZHMgcGF0Y2gxIGFuZCBwYXRjaDIgb2YgaHR0
cHM6Ly9sa21sLm9yZy9sa21sLzIwMTkvMi8yOC80ODINCnRoYW5rcyBmb3IgeW91ciBraW5kIGlu
Zm8uDQoNCj4gDQo+IEkgc2VudCBpdCB0b2RheSBiZWNhdXNlIEkgdGhpbmsgS2VlcnRoeSBjYW4g
cmV2aWV3IGFuZCB0ZXN0IGl0IHRvZ2V0aGVyDQo+IHdpdGggbXkgYW5vdGhlciBmaXggZm9yIGxw
ODc1NjUuDQo+IEkgZGlkbid0IHJlYWxpemUga2J1aWxkIHdpbGwgcGljayB1cCB0aGUgcGF0Y2gg
YXV0b21hdGljYWxseS4NCj4gSSBzaG91bGQgd2FpdCB1bnRpbCB0aGUgcmVxdWlyZWQgcGF0Y2hl
cyBnZXQgbWVyZ2VkIHRoZW4gc2VuZCB0aGlzDQo+IHBhdGNoLiBTb3JyeSBmb3IgdGhlIG1lc3Mu
DQo+IA0KPiBSZWdhcmRzLA0KPiBBeGVsDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fDQo+IGtidWlsZC1hbGwgbWFpbGluZyBsaXN0DQo+IGtidWlsZC1h
bGxAbGlzdHMuMDEub3JnDQo+IGh0dHBzOi8vbGlzdHMuMDEub3JnL21haWxtYW4vbGlzdGluZm8v
a2J1aWxkLWFsbA0K
