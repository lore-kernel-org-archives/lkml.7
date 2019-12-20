Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327A0C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4532468A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfLTPux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 10:50:53 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.113]:32736 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727233AbfLTPuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 10:50:52 -0500
Received: from [85.158.142.199] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.eu-central-1.aws.symcld.net id 02/3A-12310-ADDECFD5; Fri, 20 Dec 2019 15:50:50 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRWlGSWpSXmKPExsVyU+ECq+7Nt39
  iDfYcMrW4vGsOmwOjx+dNcgGMUayZeUn5FQmsGadO7WEs+MxV0byztoHxAVcXIxeHkMA+RomP
  P2axdTFyAjlnGSWat7mB2GwCWhIztk5lBLFFBDQkXh69xQLSwCzQyShx+/UBoAQHh7CAt8T2F
  9wQNT4S7fO/QtVbSfy+OYkVpIRFQFVi9T1tkDCvgK9E45enzBCrJjBKnDzEB2JzChhKbP+2kQ
  nEZhSQlXi08hc7iM0sIC5x68l8sLiEgIDEkj3nmSFsUYmXj/+xQtgGEluX7mOBsBUlbqw+AbZ
  WQsBa4sYDfhCTWUBTYv0ufYiJihJTuh+yQ1wjKHFy5hOWCYxis5Asm4XQMQtJxywkHQsYWVYx
  WiYVZaZnlOQmZuboGhoY6BoaGuuagUi9xCrdJL3UUt3k1LySokSgrF5iebFecWVuck6KXl5qy
  SZGYHSlFLIV7mA8/vWt3iFGSQ4mJVHeJP8/sUJ8SfkplRmJxRnxRaU5qcWHGGU4OJQkeJe8Ac
  oJFqWmp1akZeYAIx0mLcHBoyTCawaS5i0uSMwtzkyHSJ1itOSY8HLuImaOg0fnAckjc5cuYhZ
  iycvPS5US5/UAaRAAacgozYMbB0tGlxhlpYR5GRkYGIR4ClKLcjNLUOVfMYpzMCoJ884EmcKT
  mVcCt/UV0EFMQAdxaP4COagkESEl1cAUuNTAYsrDqT0SmxJ7rHWahBaYi+37F5j+QrdRePcao
  Y/t7+/ZxM4rTOVYfStwfR7zH477HTEL5JleZLP4Jn6ZXTK18lTasiZ7Eyu/i9zPl2XH29xu6j
  RKeeflozT1xJljJl/eOe25VvpXZprJYqU1D60afUq1Zj2MOzRTTbo1y5ktXPfL+vPfSo7GdZe
  szeLs4n3VuvNAYLD5owfsjF/YFrOpx+zdKH50U8FKyWrWnnJmky9iXiKeXEFZ21cXvrY+W7so
  8M3flj/1MWaWyz3dvrBpyPY7R/WcX+d7/j3niRL/9Qmlcoldew6GZjvWL9O/ll3B9/NQ9eyte
  5fduanwfebj7G2X27qPuy9nrlViKc5INNRiLipOBAAIVamKwQMAAA==
X-Env-Sender: david.kim@ncipher.com
X-Msg-Ref: server-15.tower-244.messagelabs.com!1576857049!1022201!2
X-Originating-IP: [217.32.208.5]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.22; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 7996 invoked from network); 20 Dec 2019 15:50:49 -0000
Received: from unknown (HELO exukdagfar01.INTERNAL.ROOT.TES) (217.32.208.5)
  by server-15.tower-244.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 20 Dec 2019 15:50:49 -0000
Received: from exukdagfar01.INTERNAL.ROOT.TES (10.194.2.70) by
 exukdagfar01.INTERNAL.ROOT.TES (10.194.2.70) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 20 Dec 2019 15:50:48 +0000
Received: from exukdagfar01.INTERNAL.ROOT.TES ([fe80::48de:aa33:fc4c:d1f5]) by
 exukdagfar01.INTERNAL.ROOT.TES ([fe80::48de:aa33:fc4c:d1f5%14]) with mapi id
 15.00.1497.000; Fri, 20 Dec 2019 15:50:48 +0000
From:   "Kim, David" <david.kim@ncipher.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Magee, Tim" <tim.magee@ncipher.com>
Subject: RE: [PATCH 1/1] drivers: misc: Add support for nCipher HSM devices
Thread-Topic: [PATCH 1/1] drivers: misc: Add support for nCipher HSM devices
Thread-Index: AQHVtN0iUtD2ObauYk2ExPz0BKUZFqe+UyYAgATdC/A=
Date:   Fri, 20 Dec 2019 15:50:47 +0000
Message-ID: <c9104f5c0afc439385997adb9d301854@exukdagfar01.INTERNAL.ROOT.TES>
References: <20191217132244.14768-1-david.kim@ncipher.com>
 <20191217132244.14768-2-david.kim@ncipher.com>
 <20191217133234.GB3362771@kroah.com>
In-Reply-To: <20191217133234.GB3362771@kroah.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.194.37.115]
x-exclaimer-md-config: 7ae4f661-56ee-4cc7-9363-621ce9eeb65f
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIFR1ZSwgRGVjIDE3LCAyMDE5IGF0IDAxOjIyOjQ0UE0gKzAwMDAsIERhdmUgS2ltIHdy
b3RlOg0KPiA+IO+7v0Zyb206IERhdmlkIEtpbSA8ZGF2aWQua2ltQG5jaXBoZXIuY29tPg0KPiA+
DQo+ID4gSW50cm9kdWNlIHRoZSBkcml2ZXIgZm9yIG5DaXBoZXIncyBTb2xvIGFuZCBTb2xvIFhD
IHJhbmdlIG9mIFBDSWUNCj4gPiBoYXJkd2FyZSBzZWN1cml0eSBtb2R1bGVzIChIU00pLCB3aGlj
aCBwcm92aWRlIGtleQ0KPiBjcmVhdGlvbi9tYW5hZ2VtZW50DQo+ID4gYW5kIGNyeXB0b2dyYXBo
eSBzZXJ2aWNlcy4NCj4gDQo+IEEgYml0IG1vcmUgZGVzY3JpcHRpb24gb2YgZXhhY3RseSBfd2hh
dF8gdGhlc2UgZGV2aWNlcyBkbyB3b3VsZCBiZSBoZWxwZnVsLg0KPiANCj4gQWxzbywgaG93IGRv
ZXMgdXNlcnNwYWNlIGludGVyYWN0IHdpdGggdGhlIGRyaXZlcj8gIFdoYXQgYXBpKHMpIGFyZSB5
b3UNCj4gdXNpbmcvY3JlYXRpbmc/ICBXaGF0IHVzZXJzcGFjZSB0b29scyB3b3JrIHdpdGggdGhl
IGRldmljZT8NCj4gDQo+IEluIHNob3J0LCB3ZSBuZWVkIG1vcmUgdGhhbiBqdXN0IGEgb25lIHNl
bnRhbmNlIGRlc2NyaXB0aW9uIHRvIGJlIGFibGUgdG8NCj4gcHJvcGVybHkgcmV2aWV3IHRoZSBj
b2RlIGFuZCBwcm92aWRlIHRleHQgZm9yIGEgdXNlciB0byBrbm93IHdoYXQgdG8gZG8NCj4gd2l0
aCB0aGlzIGRyaXZlci4NCj4gDQo+IENhbiB5b3UgZml4IGFsbCB0aGF0IHVwIGFuZCBzZW5kIGEg
djI/DQo+IA0KDQpIaSBHcmVnLA0KDQpJJ3ZlIGp1c3Qgbm93IHN1Ym1pdHRlZCBvdXIgdjIgcGF0
Y2ggYW5kIGhvcGVmdWxseSBpdCBhZGRyZXNzZXMgYWxsIHlvdXIgaW5pdGlhbCBjb25jZXJucy4g
SSBqdXN0IHdhbnRlZCB0byBsZXQgeW91IGtub3cgdGhhdCB3ZSdsbCBiZSBhd2F5IGZvciBDaHJp
c3RtYXMgbm93IHVudGlsIHRoZSBmaXJzdCB3ZWVrIG9mIEphbnVhcnkuDQoNClRoYW5rcyBmb3Ig
eW91ciBmZWVkYmFjayBhbmQgaGF2ZSBhIGdvb2QgZW5kIG9mIHllYXIuDQoNClJlZ2FyZHMsDQpE
YXZlDQo=
